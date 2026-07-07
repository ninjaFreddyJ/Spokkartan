// Vercel serverless — engångsutskick till gamla betalande Spökkartan-kunder:
// deras gamla abonnemang stängs ner, och de får en månad gratis på nya
// Spökkartan med koden SpokkartanOldCrew.
//
// Kör EN gång efter deploy (idempotent):
//   curl "https://<din-domän>/api/oldcrew-announce?key=<HUNTER_ANNOUNCE_KEY>&dry=1"  # torrkörning
//   curl "https://<din-domän>/api/oldcrew-announce?key=<HUNTER_ANNOUNCE_KEY>"         # skarpt
//
// Mottagarna = redeem_code_emails för koden. Env: SUPABASE_SERVICE_ROLE_KEY,
// VITE_SUPABASE_URL, RESEND_API_KEY, NURTURE_FROM, SITE_URL, HUNTER_ANNOUNCE_KEY.

import { createClient } from '@supabase/supabase-js';
import { sendEmail } from '../lib/nurture/engine.js';

export const config = { maxDuration: 60 };

const SUPABASE_URL = process.env.VITE_SUPABASE_URL || process.env.SUPABASE_URL;
const SERVICE_KEY  = process.env.SUPABASE_SERVICE_ROLE_KEY;
const KEY          = process.env.HUNTER_ANNOUNCE_KEY || process.env.CRON_SECRET;
const SITE_URL     = (process.env.SITE_URL || 'https://spokkartan.se').replace(/\/$/, '');
const CODE         = 'SpokkartanOldCrew';

const esc = (s) => String(s == null ? '' : s).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');

function mail() {
  const html = `<!doctype html><html><body style="margin:0;background:#07060f;color:#f0ecff;font-family:-apple-system,Segoe UI,Roboto,Arial,sans-serif">
<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background:#07060f;padding:28px 12px"><tr><td align="center">
<table role="presentation" width="100%" style="max-width:520px;background:#12101f;border:1px solid #2a2540;border-radius:18px">
<tr><td style="padding:28px">
  <div style="font-size:34px">👻</div>
  <h1 style="font-size:21px;margin:12px 0 0;color:#f0ecff">Spökkartan byggs om — och du får en gåva</h1>
  <div style="font-size:15px;line-height:1.65;color:#cfc8ea;margin-top:14px">
    <p style="margin:0 0 14px">Hej,</p>
    <p style="margin:0 0 14px">Vi har byggt om Spökkartan från grunden. Som en del av det <b>stänger vi nu ner ditt gamla abonnemang</b> — du kommer inte att debiteras mer.</p>
    <p style="margin:0 0 14px">Som tack för att du var med från början vill vi bjuda dig på <b>en hel månad gratis</b> på nya Spökkartan. Registrera dig med samma e-postadress och lös in koden nedan under &quot;Har du en kampanjkod?&quot;.</p>
    <div style="background:#1a1430;border:1px dashed #7c3aed;border-radius:12px;padding:14px;text-align:center;margin:6px 0 16px">
      <div style="font-size:11px;color:#8b83a8;margin-bottom:4px">DIN KOD</div>
      <div style="font-size:22px;font-weight:800;letter-spacing:1px;color:#a855f7">${esc(CODE)}</div>
      <div style="font-size:11px;color:#8b83a8;margin-top:4px">30 dagar gratis · gäller din e-post</div>
    </div>
  </div>
  <a href="${esc(SITE_URL)}" style="display:inline-block;background:linear-gradient(135deg,#7c3aed,#a855f7);color:#fff;text-decoration:none;font-weight:700;font-size:15px;padding:13px 24px;border-radius:12px">Till nya Spökkartan →</a>
  <div style="padding:22px 0 0;margin-top:22px;border-top:1px solid #2a2540;font-size:11px;color:#6f688a">
    Spökhälsningar, Fredrik &amp; Spökkartan
  </div>
</td></tr></table></td></tr></table></body></html>`;
  const text = `Hej,\n\nVi har byggt om Spökkartan. Ditt gamla abonnemang stängs nu ner — du debiteras inte mer.\n\nSom tack bjuder vi på en hel månad gratis på nya Spökkartan. Registrera dig med samma e-post och lös in koden under "Har du en kampanjkod?":\n\n${CODE}  (30 dagar gratis)\n\n${SITE_URL}\n\nSpökhälsningar, Fredrik & Spökkartan`;
  return { subject: 'Spökkartan byggs om — en månad gratis till dig 👻', html, text };
}

export default async function handler(req, res) {
  if (!KEY || (req.query.key || '').toString() !== KEY) { res.status(401).json({ error: 'Otillåten' }); return; }
  if (!SUPABASE_URL || !SERVICE_KEY) { res.status(500).json({ error: 'Supabase-nyckel saknas' }); return; }
  if (!process.env.RESEND_API_KEY) { res.status(500).json({ error: 'RESEND_API_KEY saknas' }); return; }
  const dry = (req.query.dry || '') === '1';
  const supabase = createClient(SUPABASE_URL, SERVICE_KEY);

  const { data: rows } = await supabase.from('redeem_code_emails').select('email').eq('code', CODE);
  const emails = [...new Set((rows || []).map((r) => (r.email || '').toLowerCase()).filter(Boolean))];
  if (!emails.length) { res.status(200).json({ ok: true, note: 'inga mottagare (kör sql/74 först)', sent: 0 }); return; }

  const { data: done } = await supabase.from('email_events').select('email').eq('template', 'oldcrew').eq('type', 'sent').in('email', emails);
  const sentSet = new Set((done || []).map((e) => (e.email || '').toLowerCase()));

  const m = mail();
  const out = { total: emails.length, sent: 0, skipped: 0, errors: 0, dry };
  for (const email of emails) {
    if (sentSet.has(email)) { out.skipped++; continue; }
    if (dry) { out.sent++; continue; }
    try {
      await sendEmail({ to: email, ...m, unsubUrl: `${SITE_URL}` });
      await supabase.from('email_events').insert({ email, template: 'oldcrew', type: 'sent' });
      out.sent++;
    } catch (err) {
      await supabase.from('email_events').insert({ email, template: 'oldcrew', type: 'error', meta: { error: String(err.message || err) } });
      out.errors++;
    }
  }
  res.status(200).json({ ok: true, ...out });
}
