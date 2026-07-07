// Vercel serverless — backfill: hämtar ALLA aktiva Stripe-prenumeranter direkt
// från Stripe och sätter rätt tier i Supabase. Oberoende av webhooken → fixar
// alla som redan betalat men inte fått tillgång.
//
// Kör:
//   curl "https://<domän>/api/stripe-sync?key=<KEY>&dry=1"   # förhandsvisa
//   curl "https://<domän>/api/stripe-sync?key=<KEY>"          # skarpt
//
// Env: STRIPE_SECRET_KEY (sk_live_… — Stripe → Developers → API keys),
//   SUPABASE_SERVICE_ROLE_KEY, VITE_SUPABASE_URL,
//   STRIPE_SYNC_KEY (auth; annars HUNTER_ANNOUNCE_KEY / CRON_SECRET).

import { createClient } from '@supabase/supabase-js';
import { amountToTier } from './stripe-webhook.js';

export const config = { maxDuration: 60 };

const SUPABASE_URL = process.env.VITE_SUPABASE_URL || process.env.SUPABASE_URL;
const SERVICE_KEY  = process.env.SUPABASE_SERVICE_ROLE_KEY;
const STRIPE_KEY   = process.env.STRIPE_SECRET_KEY;
const AUTH_KEY     = process.env.STRIPE_SYNC_KEY || process.env.HUNTER_ANNOUNCE_KEY || process.env.CRON_SECRET;

async function stripeGet(path) {
  const r = await fetch(`https://api.stripe.com/v1/${path}`, {
    headers: { Authorization: `Bearer ${STRIPE_KEY}` },
  });
  if (!r.ok) throw new Error(`Stripe ${r.status}: ${(await r.text()).slice(0, 200)}`);
  return r.json();
}

export default async function handler(req, res) {
  if (!AUTH_KEY || (req.query.key || '').toString() !== AUTH_KEY) { res.status(401).json({ error: 'Otillåten' }); return; }
  if (!STRIPE_KEY) { res.status(500).json({ error: 'STRIPE_SECRET_KEY saknas i env' }); return; }
  if (!SUPABASE_URL || !SERVICE_KEY) { res.status(500).json({ error: 'Supabase service-nyckel saknas' }); return; }
  const dry = (req.query.dry || '') === '1';
  const supabase = createClient(SUPABASE_URL, SERVICE_KEY);

  const ACTIVE = ['active', 'trialing', 'past_due'];
  const out = { scanned: 0, updated: 0, noAccount: [], byTier: { explorer: 0, pro: 0, ultimate: 0 }, errors: [], dry };
  let startingAfter = null;

  try {
    // Bläddra igenom alla prenumerationer (expanderar kund för e-post).
    for (let page = 0; page < 50; page++) {
      const q = new URLSearchParams({ status: 'all', limit: '100' });
      q.append('expand[]', 'data.customer');
      if (startingAfter) q.set('starting_after', startingAfter);
      const data = await stripeGet(`subscriptions?${q.toString()}`);
      const subs = data.data || [];
      for (const sub of subs) {
        startingAfter = sub.id;
        if (!ACTIVE.includes(sub.status)) continue;
        const cust = sub.customer || {};
        const email = (cust.email || '').toLowerCase();
        if (!email) continue;
        const amount = sub.items?.data?.[0]?.price?.unit_amount;
        const tier = amountToTier(amount) || 'pro';
        const expires = sub.current_period_end ? new Date(sub.current_period_end * 1000).toISOString() : null;
        out.scanned++;

        if (dry) {
          out.byTier[tier] = (out.byTier[tier] || 0) + 1;
          continue;
        }
        const { data: rows, error } = await supabase.from('profiles')
          .update({ tier, stripe_customer_id: cust.id, stripe_subscription_id: sub.id, pro_expires_at: expires, updated_at: new Date().toISOString() })
          .eq('email', email).select('id');
        if (error) { out.errors.push(`${email}: ${error.message}`); continue; }
        if (rows && rows.length) { out.updated++; out.byTier[tier] = (out.byTier[tier] || 0) + 1; }
        else out.noAccount.push({ email, tier }); // betalar men saknar app-konto (kanske annan e-post)
      }
      if (!data.has_more) break;
    }
  } catch (err) {
    res.status(500).json({ error: String(err.message || err), partial: out }); return;
  }

  res.status(200).json({ ok: true, ...out });
}
