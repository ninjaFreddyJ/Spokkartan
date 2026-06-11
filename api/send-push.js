// Vercel serverless function — skickar web-push till alla prenumeranter.
//
// Anropas av admin (POST) med header  Authorization: Bearer <PUSH_ADMIN_SECRET>.
// Body (JSON): { title?, body?, url?, country? }  — country filtrerar på
// prenumerantens valda länder (tomt = alla).
//
// Env som måste sättas i Vercel:
//   SUPABASE_SERVICE_ROLE_KEY   (läser prenumerationer förbi RLS)
//   VITE_SUPABASE_URL           (finns redan)
//   VAPID_PUBLIC_KEY            (samma som VITE_VAPID_PUBLIC_KEY)
//   VAPID_PRIVATE_KEY           (HEMLIG)
//   VAPID_SUBJECT               (t.ex. mailto:hej@spokkartan.se)
//   PUSH_ADMIN_SECRET           (valfri hemlig sträng du hittar på)

import webpush from 'web-push';
import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = process.env.VITE_SUPABASE_URL || process.env.SUPABASE_URL;
const SERVICE_KEY  = process.env.SUPABASE_SERVICE_ROLE_KEY;
const VAPID_PUBLIC  = process.env.VAPID_PUBLIC_KEY || process.env.VITE_VAPID_PUBLIC_KEY;
const VAPID_PRIVATE = process.env.VAPID_PRIVATE_KEY;
const VAPID_SUBJECT = process.env.VAPID_SUBJECT || 'mailto:hej@spokkartan.se';
const ADMIN_SECRET  = process.env.PUSH_ADMIN_SECRET;

export default async function handler(req, res) {
  if (req.method !== 'POST') { res.status(405).json({ error: 'POST only' }); return; }

  const auth = (req.headers.authorization || '').replace('Bearer ', '').trim();
  if (!ADMIN_SECRET || auth !== ADMIN_SECRET) { res.status(401).json({ error: 'Otillåten (fel admin-nyckel)' }); return; }
  if (!VAPID_PUBLIC || !VAPID_PRIVATE) { res.status(500).json({ error: 'VAPID-nycklar saknas i env' }); return; }
  if (!SUPABASE_URL || !SERVICE_KEY) { res.status(500).json({ error: 'SUPABASE_SERVICE_ROLE_KEY saknas i env' }); return; }

  let body = {};
  try { body = typeof req.body === 'string' ? JSON.parse(req.body) : (req.body || {}); } catch (e) {}
  const title   = body.title || 'Spökkartan 👻';
  const message = body.body || 'Nya hemsökta platser har lagts till på kartan.';
  const url     = body.url || '/';
  const country = body.country || null;

  webpush.setVapidDetails(VAPID_SUBJECT, VAPID_PUBLIC, VAPID_PRIVATE);
  const supabase = createClient(SUPABASE_URL, SERVICE_KEY);

  const { data: subs, error } = await supabase.from('push_subscriptions').select('*');
  if (error) { res.status(500).json({ error: error.message }); return; }

  let targets = subs || [];
  if (country) {
    targets = targets.filter((s) => !s.countries || s.countries.length === 0 || s.countries.includes(country));
  }

  const payload = JSON.stringify({ title, body: message, url });
  let sent = 0, removed = 0;

  await Promise.all(targets.map(async (s) => {
    try {
      await webpush.sendNotification({ endpoint: s.endpoint, keys: { p256dh: s.p256dh, auth: s.auth } }, payload);
      sent++;
    } catch (err) {
      // 404/410 = prenumerationen är död -> rensa
      if (err && (err.statusCode === 404 || err.statusCode === 410)) {
        await supabase.from('push_subscriptions').delete().eq('endpoint', s.endpoint);
        removed++;
      }
    }
  }));

  res.status(200).json({ ok: true, sent, removed, total: targets.length });
}
