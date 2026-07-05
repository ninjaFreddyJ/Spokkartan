// Vercel serverless — nurturing-motorn. Körs av Vercel Cron (se vercel.json).
//
// Optimerad kring 100/dag-taket:
//   • SPRIDNING: skickar bara ~budget/återstående-timmar per körning, så de 100
//     fördelas jämnt över dygnet i stället för att brännas på ett par timmar.
//   • PRIORITET: trial-slut (konvertering) → nya/pågående sekvens → re-engagement
//     sist. När volymen växer svälts aldrig de värdefulla mejlen ut av massutskick.
//   • FÖNSTER: valfria NURTURE_START_HOUR/END_HOUR (UTC) för att undvika nattmejl.
//   • Inga tysta bortfall: uppskjutna re-engagement-mejl rapporteras i svaret.
//
// Env (Vercel): SUPABASE_SERVICE_ROLE_KEY, VITE_SUPABASE_URL, RESEND_API_KEY,
//   NURTURE_FROM, SITE_URL, CRON_SECRET, (valfria) PRO_CHECKOUT_URL,
//   NURTURE_DAILY_CAP=100, NURTURE_BATCH=50, NURTURE_START_HOUR, NURTURE_END_HOUR.

import { createClient } from '@supabase/supabase-js';
import { render, sendEmail, SEQUENCE, REENGAGE_VARIANTS, DAILY_CAP, BATCH_SIZE, REENGAGE_DAYS, SUNSET_SLACK } from '../lib/nurture/engine.js';

export const config = { maxDuration: 60 };

const SUPABASE_URL = process.env.VITE_SUPABASE_URL || process.env.SUPABASE_URL;
const SERVICE_KEY  = process.env.SUPABASE_SERVICE_ROLE_KEY;
const SITE_URL     = (process.env.SITE_URL || 'https://spokkartan.se').replace(/\/$/, '');
const PRO_URL      = process.env.PRO_CHECKOUT_URL || 'https://buy.stripe.com/9B614m3av07GcsJdCG3oA02';
const CRON_SECRET  = process.env.CRON_SECRET;
const START_HOUR   = process.env.NURTURE_START_HOUR != null ? Number(process.env.NURTURE_START_HOUR) : null;
const END_HOUR     = process.env.NURTURE_END_HOUR   != null ? Number(process.env.NURTURE_END_HOUR)   : null;

const addDays = (d, n) => new Date(d.getTime() + n * 86400000);
const iso = (d) => d.toISOString();

export default async function handler(req, res) {
  const bearer = (req.headers.authorization || '').replace('Bearer ', '').trim();
  const key = bearer || (req.query.key || '').toString();
  if (!CRON_SECRET || key !== CRON_SECRET) { res.status(401).json({ error: 'Otillåten' }); return; }
  if (!SUPABASE_URL || !SERVICE_KEY) { res.status(500).json({ error: 'Supabase service-nyckel saknas' }); return; }
  if (!process.env.RESEND_API_KEY) { res.status(500).json({ error: 'RESEND_API_KEY saknas i env' }); return; }

  const supabase = createClient(SUPABASE_URL, SERVICE_KEY);
  const now = new Date();
  const hour = now.getUTCHours();
  const out = { sent: 0, trialEnding: 0, reengage: 0, skipped: 0, errors: 0, deferred: 0 };

  // Sändningsfönster (valfritt) — undvik t.ex. nattmejl.
  if (START_HOUR != null && END_HOUR != null && (hour < START_HOUR || hour >= END_HOUR)) {
    res.status(200).json({ ok: true, note: 'utanför sändningsfönster', hour });
    return;
  }

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

  // ── Daglig cap + jämn spridning över återstoden av dygnet/fönstret ──
  const startOfDay = new Date(now); startOfDay.setUTCHours(0, 0, 0, 0);
  const { count: sentToday } = await supabase
    .from('email_events').select('*', { count: 'exact', head: true })
    .eq('type', 'sent').gte('created_at', iso(startOfDay));
  const budget = Math.max(0, DAILY_CAP - (sentToday || 0));
  if (budget <= 0) { res.status(200).json({ ok: true, note: 'daglig cap nådd', sentToday, cap: DAILY_CAP }); return; }

  const windowEnd = END_HOUR != null ? END_HOUR : 24;
  const hoursLeft = Math.max(1, windowEnd - hour);
  const smooth = Math.max(1, Math.ceil(budget / hoursLeft));   // jämnt fördelat
  let toSend = Math.min(budget, BATCH_SIZE, smooth);

  // ── Per-kontakt-hantering (skip/render/send/advance) ───────────────
  async function processOne(ns, prof) {
    const cond = { is_pro: prof?.is_pro || false };
    const step = ns.step;
    let chosen;
    if (step < SEQUENCE.length) {
      const s = SEQUENCE[step];
      if (s.send(cond)) {
        chosen = { key: s.key, reengage: false };
      } else {
        // Hoppat steg (t.ex. konverteringsmejl för PRO-kund): avancera utan utskick.
        await supabase.from('nurture_state')
          .update({ step: step + 1, next_send_at: iso(addDays(now, SEQUENCE[step + 1]?.delay ?? REENGAGE_DAYS)), updated_at: iso(now) })
          .eq('id', ns.id);
        return 'skipped';
      }
    } else {
      chosen = { key: REENGAGE_VARIANTS[ns.reengage_count % REENGAGE_VARIANTS.length], reengage: true };
    }

    const lang = ns.lang || prof?.lang || 'sv';
    const ctx = buildCtx(ns, prof);
    const mail = render(chosen.key, lang, ctx);
    if (!mail) return 'skipped';

    try {
      await sendEmail({ to: ns.email, ...mail, unsubUrl: ctx.unsubUrl });
      await logEvent('sent', ns, chosen.key, { reengage: chosen.reengage });
      const upd = { last_send_at: iso(now), updated_at: iso(now) };
      if (chosen.reengage) {
        upd.reengage_count = ns.reengage_count + 1;
        upd.no_open_streak = (ns.no_open_streak || 0) + 1; // nollställs av webhooken vid öppning
        const cadence = ns.no_open_streak >= SUNSET_SLACK ? REENGAGE_DAYS * 3 : REENGAGE_DAYS;
        upd.next_send_at = iso(addDays(now, cadence));
      } else {
        upd.step = step + 1;
        upd.next_send_at = iso(addDays(now, SEQUENCE[step + 1]?.delay ?? REENGAGE_DAYS));
      }
      await supabase.from('nurture_state').update(upd).eq('id', ns.id);
      return 'sent';
    } catch (err) {
      await logEvent('error', ns, chosen.key, { error: String(err.message || err) });
      await supabase.from('nurture_state').update({ next_send_at: iso(addDays(now, 0.25)), updated_at: iso(now) }).eq('id', ns.id);
      return 'error';
    }
  }

  // Kör en due-batch filtrerad på var i sekvensen kontakten är.
  async function runPass(kind, limit) {
    if (limit <= 0) return 0;
    let q = supabase.from('nurture_state').select('*')
      .eq('status', 'active').eq('unsubscribed', false).eq('holdout', false)
      .lte('next_send_at', iso(now));
    if (kind === 'finite')   q = q.lt('step', SEQUENCE.length);
    if (kind === 'reengage') q = q.gte('step', SEQUENCE.length);
    const { data: due } = await q.order('next_send_at', { ascending: true }).limit(limit * 3);

    const ids = [...new Set((due || []).filter((d) => d.user_id).map((d) => d.user_id))];
    const pm = {};
    if (ids.length) {
      const { data: ps } = await supabase.from('profiles').select('id,full_name,is_pro,role,referral_code,lang').in('id', ids);
      (ps || []).forEach((p) => { pm[p.id] = p; });
    }
    let sent = 0;
    for (const ns of due || []) {
      if (sent >= limit) break;
      const r = await processOne(ns, ns.user_id ? pm[ns.user_id] : null);
      if (r === 'sent') sent++;
      else if (r === 'skipped') out.skipped++;
      else if (r === 'error') out.errors++;
    }
    return sent;
  }

  // ── PRIORITET 1: trial tar snart slut → konvertera till 19 kr ─────
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
      const { data: states } = await supabase.from('nurture_state').select('*').in('user_id', ending.map((p) => p.id));
      const byUser = {}; (states || []).forEach((s) => { byUser[s.user_id] = s; });
      for (const prof of ending) {
        if (toSend <= 0) break;
        if (done.has(prof.email)) continue;
        const ns = byUser[prof.id];
        if (!ns || ns.unsubscribed || ns.status !== 'active') continue;
        const ctx = buildCtx(ns, prof);
        const mail = render('trial_ending', ns.lang || prof.lang || 'sv', ctx);
        try {
          await sendEmail({ to: ns.email, ...mail, unsubUrl: ctx.unsubUrl });
          await logEvent('sent', ns, 'trial_ending', { trial: true });
          await supabase.from('nurture_state').update({ last_send_at: iso(now), updated_at: iso(now) }).eq('id', ns.id);
          out.trialEnding++; toSend--;
        } catch (err) { await logEvent('error', ns, 'trial_ending', { error: String(err.message || err) }); out.errors++; }
      }
    }
  } catch (e) { /* trial-pass fel stoppar inte resten */ }

  // ── PRIORITET 2: linjär sekvens (nya + pågående) ──────────────────
  const finiteSent = await runPass('finite', toSend);
  toSend -= finiteSent;

  // ── PRIORITET 3: perpetuell re-engagement (lägst prio) ────────────
  const reengageSent = await runPass('reengage', toSend);
  toSend -= reengageSent;

  out.sent = finiteSent + reengageSent;
  out.reengage = reengageSent;

  // Inga tysta bortfall: hur många re-engagement var due men sköts upp?
  if (toSend <= 0) {
    const { count: reDue } = await supabase.from('nurture_state').select('*', { count: 'exact', head: true })
      .eq('status', 'active').eq('unsubscribed', false).eq('holdout', false)
      .gte('step', SEQUENCE.length).lte('next_send_at', iso(now));
    out.deferred = Math.max(0, (reDue || 0) - reengageSent);
  }

  res.status(200).json({ ok: true, ...out, perRun: smooth, sentToday: (sentToday || 0) + out.sent + out.trialEnding });
}
