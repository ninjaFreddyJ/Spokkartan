// Vercel serverless — bekräfta betalning direkt när kunden återvänder från
// Stripe Checkout/Payment Link. Verifierar Checkout-sessionen mot Stripe och
// sätter rätt tier på sekunden — instant aktivering, utan att vänta på webhooken.
//
// Anropas av frontend med sessionens id: /api/stripe-confirm?cs=cs_...
// Säker utan admin-nyckel: nivån ges bara om Stripe bekräftar att sessionen är
// betald, och bara till den e-post som faktiskt betalade (id går ej att gissa).
//
// Env: STRIPE_SECRET_KEY, SUPABASE_SERVICE_ROLE_KEY, VITE_SUPABASE_URL.

import { createClient } from '@supabase/supabase-js';
import { amountToTier } from './stripe-webhook.js';

const SUPABASE_URL = process.env.VITE_SUPABASE_URL || process.env.SUPABASE_URL;
const SERVICE_KEY  = process.env.SUPABASE_SERVICE_ROLE_KEY;
const STRIPE_KEY   = process.env.STRIPE_SECRET_KEY;

async function stripeGet(path) {
  const r = await fetch(`https://api.stripe.com/v1/${path}`, { headers: { Authorization: `Bearer ${STRIPE_KEY}` } });
  if (!r.ok) throw new Error(`Stripe ${r.status}`);
  return r.json();
}

export default async function handler(req, res) {
  const cs = (req.query.cs || req.query.session_id || '').toString();
  if (!cs) { res.status(400).json({ ok: false, error: 'saknar session-id' }); return; }
  if (!STRIPE_KEY || !SUPABASE_URL || !SERVICE_KEY) { res.status(500).json({ ok: false, error: 'server ej konfigurerad' }); return; }

  try {
    const q = new URLSearchParams();
    q.append('expand[]', 'customer');
    q.append('expand[]', 'subscription');
    const s = await stripeGet(`checkout/sessions/${encodeURIComponent(cs)}?${q.toString()}`);

    const paid = s.payment_status === 'paid' || s.payment_status === 'no_payment_required' || s.status === 'complete';
    if (!paid) { res.status(200).json({ ok: false, error: 'betalning ej slutförd', status: s.payment_status }); return; }

    const email = (s.customer_details?.email || s.customer?.email || s.customer_email || '').toLowerCase();
    if (!email) { res.status(200).json({ ok: false, error: 'ingen e-post på betalningen' }); return; }

    const amount = s.amount_total ?? s.subscription?.items?.data?.[0]?.price?.unit_amount;
    const tier = amountToTier(amount) || 'pro';
    const periodEnd = s.subscription?.current_period_end
      ? new Date(s.subscription.current_period_end * 1000).toISOString() : null;

    const supabase = createClient(SUPABASE_URL, SERVICE_KEY);
    const { data: rows } = await supabase.from('profiles')
      .update({
        tier,
        stripe_customer_id: (typeof s.customer === 'string' ? s.customer : s.customer?.id) || null,
        stripe_subscription_id: (typeof s.subscription === 'string' ? s.subscription : s.subscription?.id) || null,
        pro_expires_at: periodEnd,
        updated_at: new Date().toISOString(),
      })
      .eq('email', email).select('id');

    res.status(200).json({ ok: true, tier, email, matched: (rows || []).length, note: (rows || []).length ? undefined : 'betald men inget konto med den e-posten' });
  } catch (err) {
    res.status(500).json({ ok: false, error: String(err.message || err) });
  }
}
