// Vercel serverless — Resend webhook. Loggar öppningar/klick/studsar för
// mätning och deliverability-skydd (no_open_streak → långsammare cadence).
//
// Sätt webhook-URL i Resend till:  https://<din-domän>/api/email-webhook?key=<RESEND_WEBHOOK_SECRET>
// Env: VITE_SUPABASE_URL + SUPABASE_SERVICE_ROLE_KEY + RESEND_WEBHOOK_SECRET

import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = process.env.VITE_SUPABASE_URL || process.env.SUPABASE_URL;
const SERVICE_KEY  = process.env.SUPABASE_SERVICE_ROLE_KEY;
const SECRET       = process.env.RESEND_WEBHOOK_SECRET;

export default async function handler(req, res) {
  if (req.method !== 'POST') { res.status(405).json({ error: 'POST only' }); return; }
  if (SECRET && (req.query.key || '').toString() !== SECRET) { res.status(401).json({ error: 'Otillåten' }); return; }
  if (!SUPABASE_URL || !SERVICE_KEY) { res.status(500).json({ error: 'Supabase-nyckel saknas' }); return; }

  let evt = {};
  try { evt = typeof req.body === 'string' ? JSON.parse(req.body) : (req.body || {}); } catch (e) {}
  const type = evt.type || '';
  const email = evt.data?.to?.[0] || evt.data?.email || null;
  if (!email) { res.status(200).json({ ok: true, skipped: 'no email' }); return; }

  const supabase = createClient(SUPABASE_URL, SERVICE_KEY);
  const now = new Date().toISOString();

  const map = {
    'email.opened': 'open', 'email.clicked': 'click',
    'email.bounced': 'bounce', 'email.complained': 'complaint',
  };
  const kind = map[type];
  if (!kind) { res.status(200).json({ ok: true, ignored: type }); return; }

  await supabase.from('email_events').insert({ email, type: kind, template: null, meta: { via: 'resend', raw_type: type } });

  // Uppdatera kontaktens tillstånd
  const { data: rows } = await supabase.from('nurture_state').select('id,no_open_streak').eq('email', email).limit(1);
  const ns = rows && rows[0];
  if (ns) {
    if (kind === 'open' || kind === 'click') {
      await supabase.from('nurture_state').update({ last_open_at: now, no_open_streak: 0, updated_at: now }).eq('id', ns.id);
    } else if (kind === 'bounce' || kind === 'complaint') {
      await supabase.from('nurture_state').update({ status: 'bounced', unsubscribed: true, updated_at: now }).eq('id', ns.id);
    }
  }
  res.status(200).json({ ok: true, kind });
}
