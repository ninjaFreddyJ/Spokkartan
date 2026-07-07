// Vercel serverless — Stripe webhook. Beviljar/nedgraderar tier automatiskt.
//
// Sätter profiles.tier (→ is_pro via DB-trigger) + pro_expires_at vid betalning,
// och tier='free' när prenumerationen sägs upp/löper ut. Det här är det som gör
// att "slutar betala → free" sker av sig självt.
//
// Stripe → Developers → Webhooks → lägg till endpoint:
//   https://<din-domän>/api/stripe-webhook?key=<STRIPE_WEBHOOK_KEY>
// Events: checkout.session.completed, customer.subscription.updated,
//         customer.subscription.deleted
//
// Env (Vercel):
//   SUPABASE_SERVICE_ROLE_KEY, VITE_SUPABASE_URL          (finns redan)
//   STRIPE_WEBHOOK_KEY        — hemlig sträng du sätter i URL:en ovan (auth)
//   STRIPE_WEBHOOK_SECRET     — valfri (whsec_…) för signaturverifiering
//   STRIPE_PRICE_EXPLORER/PRO/ULTIMATE — valfria pris-id om du vill mappa exakt
//     (annars mappas på belopp: 900/1900/4900 öre → explorer/pro/ultimate)

import crypto from 'crypto';
import { createClient } from '@supabase/supabase-js';

export const config = { api: { bodyParser: false } };

const SUPABASE_URL = process.env.VITE_SUPABASE_URL || process.env.SUPABASE_URL;
const SERVICE_KEY  = process.env.SUPABASE_SERVICE_ROLE_KEY;
const WEBHOOK_KEY  = process.env.STRIPE_WEBHOOK_KEY;
const SIGN_SECRET  = process.env.STRIPE_WEBHOOK_SECRET;

const PRICE_TIER = {
  [process.env.STRIPE_PRICE_EXPLORER || '']: 'explorer',
  [process.env.STRIPE_PRICE_PRO || '']:      'pro',
  [process.env.STRIPE_PRICE_ULTIMATE || '']: 'ultimate',
};

export function amountToTier(amount) {
  if (amount == null) return null;
  if (amount <= 1200) return 'explorer';   // ~9 kr
  if (amount <= 3000) return 'pro';         // ~19 kr
  return 'ultimate';                        // 49 kr+
}
export function priceToTier(price) {
  if (!price) return null;
  return PRICE_TIER[price.id] || amountToTier(price.unit_amount);
}

async function readRaw(req) {
  const chunks = [];
  for await (const c of req) chunks.push(typeof c === 'string' ? Buffer.from(c) : c);
  return Buffer.concat(chunks).toString('utf8');
}

function verifySignature(raw, header, secret) {
  try {
    const parts = Object.fromEntries((header || '').split(',').map((kv) => kv.split('=')));
    if (!parts.t || !parts.v1) return false;
    const expected = crypto.createHmac('sha256', secret).update(`${parts.t}.${raw}`).digest('hex');
    const a = Buffer.from(expected), b = Buffer.from(parts.v1);
    return a.length === b.length && crypto.timingSafeEqual(a, b);
  } catch (e) { return false; }
}

export default async function handler(req, res) {
  if (req.method !== 'POST') { res.status(405).json({ error: 'POST only' }); return; }
  // Auth via delad nyckel i URL:en (fungerar oavsett body-parsing).
  if (!WEBHOOK_KEY || (req.query.key || '').toString() !== WEBHOOK_KEY) {
    res.status(401).json({ error: 'Otillåten' }); return;
  }
  if (!SUPABASE_URL || !SERVICE_KEY) { res.status(500).json({ error: 'Supabase-nyckel saknas' }); return; }

  const raw = await readRaw(req);
  // Signaturverifiering om signing-secret finns (annars räcker URL-nyckeln).
  if (SIGN_SECRET && !verifySignature(raw, req.headers['stripe-signature'], SIGN_SECRET)) {
    res.status(400).json({ error: 'Ogiltig signatur' }); return;
  }

  let event;
  try { event = JSON.parse(raw); } catch (e) { res.status(400).json({ error: 'Ogiltig JSON' }); return; }

  const supabase = createClient(SUPABASE_URL, SERVICE_KEY);
  const obj = event.data?.object || {};
  const nowIso = new Date().toISOString();
  let handled = null;

  try {
    if (event.type === 'checkout.session.completed') {
      const email = obj.customer_details?.email || obj.customer_email;
      const tier = amountToTier(obj.amount_total);
      if (email && tier) {
        await supabase.from('profiles').update({
          tier,
          stripe_customer_id: obj.customer || null,
          stripe_subscription_id: obj.subscription || null,
          updated_at: nowIso,
        }).eq('email', email);
        handled = { type: event.type, email, tier };
      }
    } else if (event.type === 'customer.subscription.updated' || event.type === 'customer.subscription.created') {
      const active = ['active', 'trialing', 'past_due'].includes(obj.status);
      const tier = active ? priceToTier(obj.items?.data?.[0]?.price) : 'free';
      const expires = obj.current_period_end ? new Date(obj.current_period_end * 1000).toISOString() : null;
      const { data: rows } = await supabase.from('profiles').select('id').eq('stripe_customer_id', obj.customer).limit(1);
      if (rows && rows[0]) {
        await supabase.from('profiles').update({ tier: tier || 'free', pro_expires_at: expires, stripe_subscription_id: obj.id, updated_at: nowIso }).eq('id', rows[0].id);
        handled = { type: event.type, tier, expires };
      }
    } else if (event.type === 'customer.subscription.deleted') {
      const { data: rows } = await supabase.from('profiles').select('id').eq('stripe_customer_id', obj.customer).limit(1);
      if (rows && rows[0]) {
        await supabase.from('profiles').update({ tier: 'free', pro_expires_at: null, updated_at: nowIso }).eq('id', rows[0].id);
        handled = { type: event.type, tier: 'free' };
      }
    }
  } catch (err) {
    res.status(500).json({ error: String(err.message || err) }); return;
  }

  res.status(200).json({ ok: true, handled });
}
