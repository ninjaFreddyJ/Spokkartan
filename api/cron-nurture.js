// Vercel serverless — nurturing-motorn. Körs av Vercel Cron (se vercel.json).
//
// Varje körning: håll dig under DAILY_CAP (100/dag), skicka max BATCH_SIZE (50),
// hantera trial-slut → 19 kr-konvertering, hoppa konverteringsmejl för PRO-kunder,
// och kör perpetuell re-engagement var 30:e dag (väcker kontakter även efter 2 mån).
//
// Env som måste sättas i Vercel:
//   SUPABASE_SERVICE_ROLE_KEY   (finns redan för push)
//   VITE_SUPABASE_URL           (finns redan)
//   RESEND_API_KEY              (HEMLIG — skapa i Resend)
//   NURTURE_FROM                (t.ex. "Spökkartan 👻 <hej@spokkartan.se>")
//   SITE_URL                    (t.ex. https://spokkartan.se)
//   CRON_SECRET                 (Vercel skickar den automatiskt som Bearer)
//   PRO_CHECKOUT_URL            (valfri — annars intro-Stripe-länken)

import { createClient } from '@supabase/supabase-js';
import { render, sendEmail, SEQUENCE, REENGAGE_VARIANTS, DAILY_CAP, BATCH_SIZE, REENGAGE_DAYS, SUNSET_SLACK } from '../lib/nurture/engine.js';

const SUPABASE_URL = process.env.VITE_SUPABASE_URL || process.env.SUPABASE_URL;
const SERVICE_KEY  = process.env.SUPABASE_SERVICE_ROLE_KEY;
const SITE_URL     = (process.env.SITE_URL || 'https://spokkartan.se').replace(/\/$/, '');
const PRO_URL      = process.env.PRO_CHECKOUT_URL || 'https://buy.stripe.com/9B614m3av07GcsJdCG3oA02';
const CRON_SECRET  = process.env.CRON_SECRET;

// Ge funktionen tid att skicka en hel batch sekventiellt (undvik timeout).
export const config = { maxDuration: 60 };

const addDays = (d, n) => new Date(d.getTime() + n * 86400000);
const iso = (d) => d.toISOString();

export default async function handler(req, res) {
  // Auth: Vercel Cron skickar Authorization: Bearer <CRON_SECRET>. Manuellt: ?key=
  const bearer = (req.headers.authorization || '').replace('Bearer ', '').trim();
  const key = bearer || (req.query.key || '').toString();
  if (!CRON_SECRET || key !== CRON_SECRET) { res.status(401).json({ error: 'Otillåten' }); return; }
  if (!SUPABASE_URL || !SERVICE_KEY) { res.status(500).json({ error: 'Supabase service-nyckel saknas' }); return; }
  if (!process.env.RESEND_API_KEY) { res.status(500).json({ error: 'RESEND_API_KEY saknas i env' }); return; }

  const supabase = createClient(SUPABASE_URL, SERVICE_KEY);
  const now = new Date();
  const out = { sent: 0, trialEnding: 0, skipped: 0, errors: 0, capReached: false };

  const logEvent = (type, ns, template, meta) =>
    supabase.from('email_events').insert({
      nurture_id: ns?.id || null, email: ns?.email || meta?.email || null,
      step: ns?.step ?? null, template, type, meta: meta || null,
    });

  const buildCtx = (ns, prof) => {
    const code = prof?.referral_code;
    return {
      name: (prof?.full_name || '').split(' ')[0] || '',
      referralUrl: code ? `${SITE_URL}/?ref=${code}` : SITE_URL,
      proUrl: PRO_URL, siteUrl: SITE_URL,
      unsubUrl: `${SITE_URL}/api/unsubscribe?u=${ns.unsub_token}`,
    };
  };

  // ── Daglig cap ────────────────────────────────────────────────────
  const startOfDay = new Date(now); startOfDay.setUTCHours(0, 0, 0, 0);
  const { count: sentToday } = await supabase
    .from('email_events').select('*', { count: 'exact', head: true })
    .eq('type', 'sent').gte('created_at', iso(startOfDay));
  let budget = Math.max(0, DAILY_CAP - (sentToday || 0));
  let toSend = Math.min(budget, BATCH_SIZE);
  if (toSend <= 0) { res.status(200).json({ ok: true, note: 'daglig cap nådd', sentToday, cap: DAILY_CAP }); return; }

  // ── Pass 1: trial tar snart slut → konvertera till 19 kr ──────────
  try {
    const { data: ending } = await supabase
      .from('profiles').select('id,email,full_name,lang,referral_code,is_pro,pro_expires_at')
      .eq('is_pro', true).eq('trial_source', 'referral')
      .gt('pro_expires_at', iso(now)).lte('pro_expires_at', iso(addDays(now, 2)))
      .limit(toSend);
    if (ending && ending.length) {
      const emails = ending.map((p) => p.email);
      const { data: alreadySent } = await supabase
        .from('email_events').select('email').eq('template', 'trial_ending').eq('type', 'sent').in('email', emails);
      const done = new Set((alreadySent || []).map((e) => e.email));
      const userIds = ending.map((p) => p.id);
      const { data: states } = await supabase.from('nurture_state').select('*').in('user_id', userIds);
      const stateByUser = {}; (states || []).forEach((s) => { stateByUser[s.user_id] = s; });

      for (const prof of ending) {
        if (toSend <= 0) { out.capReached = true; break; }
        if (done.has(prof.email)) continue;
        const ns = stateByUser[prof.id];
        if (!ns || ns.unsubscribed || ns.status !== 'active') continue;
        const ctx = buildCtx(ns, prof);
        const mail = render('trial_ending', ns.lang || prof.lang || 'sv', ctx);
        try {
          await sendEmail({ to: ns.email, ...mail, unsubUrl: ctx.unsubUrl });
          await logEvent('sent', ns, 'trial_ending', { trial: true });
          await supabase.from('nurture_state').update({ last_send_at: iso(now), updated_at: iso(now) }).eq('id', ns.id);
          out.trialEnding++; toSend--;
        } catch (err) {
          await logEvent('error', ns, 'trial_ending', { error: String(err.message || err) });
          out.errors++;
        }
      }
    }
  } catch (e) { /* trial-pass fel ska inte stoppa resten */ }

  // ── Pass 2: linjär sekvens + perpetuell re-engagement ─────────────
  if (toSend > 0) {
    const { data: due } = await supabase
      .from('nurture_state').select('*')
      .eq('status', 'active').eq('unsubscribed', false).eq('holdout', false)
      .lte('next_send_at', iso(now))
      .order('next_send_at', { ascending: true })
      .limit(toSend * 3); // extra marginal eftersom vissa steg hoppas över

    const userIds = [...new Set((due || []).filter((d) => d.user_id).map((d) => d.user_id))];
    const profMap = {};
    if (userIds.length) {
      const { data: profs } = await supabase
        .from('profiles').select('id,full_name,is_pro,role,referral_code,lang').in('id', userIds);
      (profs || []).forEach((p) => { profMap[p.id] = p; });
    }

    for (const ns of due || []) {
      if (toSend <= 0) { out.capReached = true; break; }
      const prof = ns.user_id ? profMap[ns.user_id] : null;
      const cond = { is_pro: prof?.is_pro || false };

      // Välj steg. Hoppade steg avanceras (utan utskick) och skjuts framåt.
      let step = ns.step;
      let chosen = null;
      if (step < SEQUENCE.length) {
        const s = SEQUENCE[step];
        if (s.send(cond)) {
          chosen = { key: s.key, reengage: false };
        } else {
          const nextDelay = SEQUENCE[step + 1]?.delay ?? REENGAGE_DAYS;
          await supabase.from('nurture_state')
            .update({ step: step + 1, next_send_at: iso(addDays(now, nextDelay)), updated_at: iso(now) })
            .eq('id', ns.id);
          out.skipped++;
          continue;
        }
      } else {
        chosen = { key: REENGAGE_VARIANTS[ns.reengage_count % REENGAGE_VARIANTS.length], reengage: true };
      }

      const lang = ns.lang || prof?.lang || 'sv';
      const ctx = buildCtx(ns, prof);
      const mail = render(chosen.key, lang, ctx);
      if (!mail) { out.skipped++; continue; }

      try {
        await sendEmail({ to: ns.email, ...mail, unsubUrl: ctx.unsubUrl });
        await logEvent('sent', ns, chosen.key, { reengage: chosen.reengage });
        const upd = { last_send_at: iso(now), updated_at: iso(now) };
        if (chosen.reengage) {
          upd.reengage_count = ns.reengage_count + 1;
          // Deliverability-skydd: dra ner takten om ingen öppnat på länge.
          // no_open_streak byggs upp här och nollställs av webhooken vid öppning.
          upd.no_open_streak = (ns.no_open_streak || 0) + 1;
          const cadence = ns.no_open_streak >= SUNSET_SLACK ? REENGAGE_DAYS * 3 : REENGAGE_DAYS;
          upd.next_send_at = iso(addDays(now, cadence));
        } else {
          const nextIdx = step + 1;
          upd.step = nextIdx;
          upd.next_send_at = iso(addDays(now, SEQUENCE[nextIdx]?.delay ?? REENGAGE_DAYS));
        }
        await supabase.from('nurture_state').update(upd).eq('id', ns.id);
        out.sent++; toSend--;
      } catch (err) {
        await logEvent('error', ns, chosen.key, { error: String(err.message || err) });
        // Backoff 6h; nästa körning försöker igen.
        await supabase.from('nurture_state')
          .update({ next_send_at: iso(addDays(now, 0.25)), updated_at: iso(now) }).eq('id', ns.id);
        out.errors++;
      }
    }
  }

  res.status(200).json({ ok: true, ...out, sentToday: (sentToday || 0) + out.sent + out.trialEnding });
}
