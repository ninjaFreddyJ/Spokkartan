// Vercel serverless — engångsutskick till f.d. spökjägare om att funktionen
// pausas och att deras konto nu är ett vanligt användarkonto.
//
// Kör EN gång efter deploy (idempotent — dubbelskickar inte):
//   curl "https://<din-domän>/api/hunter-announce?key=<HUNTER_ANNOUNCE_KEY>"
//
// Env: SUPABASE_SERVICE_ROLE_KEY, VITE_SUPABASE_URL, RESEND_API_KEY, NURTURE_FROM
//      HUNTER_ANNOUNCE_KEY (auth) · HUNTER_CONTACT_EMAIL (valfri, default hej@spokkartan.se)

import { createClient } from '@supabase/supabase-js';
import { sendEmail } from '../lib/nurture/engine.js';

export const config = { maxDuration: 60 };

const SUPABASE_URL = process.env.VITE_SUPABASE_URL || process.env.SUPABASE_URL;
const SERVICE_KEY  = process.env.SUPABASE_SERVICE_ROLE_KEY;
const KEY          = process.env.HUNTER_ANNOUNCE_KEY || process.env.CRON_SECRET;
const CONTACT      = process.env.HUNTER_CONTACT_EMAIL || 'hej@spokkartan.se';
const SITE_URL     = (process.env.SITE_URL || 'https://spokkartan.se').replace(/\/$/, '');

const esc = (s) => String(s == null ? '' : s).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');

function emailFor(name, unsubUrl) {
  const hi = name ? `Hej ${esc(name)},` : 'Hej,';
  const html = `<!doctype html><html><body style="margin:0;background:#07060f;color:#f0ecff;font-family:-apple-system,Segoe UI,Roboto,Arial,sans-serif">
<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background:#07060f;padding:28px 12px"><tr><td align="center">
<table role="presentation" width="100%" style="max-width:520px;background:#12101f;border:1px solid #2a2540;border-radius:18px">
<tr><td style="padding:28px">
  <div style="font-size:34px">👻</div>
  <h1 style="font-size:21px;margin:12px 0 0;color:#f0ecff">Om din spökjägar-profil</h1>
  <div style="font-size:15px;line-height:1.65;color:#cfc8ea;margin-top:14px">
    <p style="margin:0 0 14px">${hi}</p>
    <p style="margin:0 0 14px">Tack för att du testade spökjägar-profilen — det var riktigt kul att ha dig med under testet!</p>
    <p style="margin:0 0 14px">Vi har landat i att funktionen inte var helt redo att lanseras på riktigt än, så vi pausar den ett tag och bygger vidare på den. Ditt konto är därför nu ett <b>vanligt användarkonto</b>. All din data finns kvar och du är lika välkommen som alltid på Spökkartan.</p>
    <p style="margin:0 0 14px">Men — vi vill fortfarande <b>jättegärna samarbeta</b> med dig. Vi älskar att skriva och posta om spökjägare, så hör av dig så gör vi något kul ihop: ett inlägg eller en blogg tillsammans. 👻</p>
  </div>
  <a href="mailto:${esc(CONTACT)}?subject=Samarbete%20med%20Sp%C3%B6kkartan" style="display:inline-block;margin-top:8px;background:linear-gradient(135deg,#7c3aed,#a855f7);color:#fff;text-decoration:none;font-weight:700;font-size:15px;padding:13px 24px;border-radius:12px">Kontakta oss →</a>
  <div style="padding:22px 0 0;margin-top:22px;border-top:1px solid #2a2540;font-size:11px;color:#6f688a">
    Spökhälsningar, Fredrik &amp; Spökkartan${unsubUrl ? `<br/><a href="${esc(unsubUrl)}" style="color:#8b83a8">Avsluta utskick</a>` : ''}
  </div>
</td></tr></table></td></tr></table></body></html>`;
  const text = `${hi}\n\nTack för att du testade spökjägar-profilen! Vi pausar funktionen då den inte var helt redo än, och ditt konto är nu ett vanligt användarkonto. All data finns kvar.\n\nVi vill fortfarande gärna samarbeta — hör av dig så gör vi ett kul inlägg eller en blogg ihop: ${CONTACT}\n\nSpökhälsningar, Fredrik & Spökkartan`;
  return { subject: 'Om din spökjägar-profil på Spökkartan 👻', html, text };
}

export default async function handler(req, res) {
  if (!KEY || (req.query.key || '').toString() !== KEY) { res.status(401).json({ error: 'Otillåten' }); return; }
  if (!SUPABASE_URL || !SERVICE_KEY) { res.status(500).json({ error: 'Supabase-nyckel saknas' }); return; }
  if (!process.env.RESEND_API_KEY) { res.status(500).json({ error: 'RESEND_API_KEY saknas' }); return; }

  const supabase = createClient(SUPABASE_URL, SERVICE_KEY);
  const dry = (req.query.dry || '') === '1';

  const { data: hunters } = await supabase
    .from('profiles').select('id,email,full_name').eq('was_hunter', true).limit(1000);
  if (!hunters || !hunters.length) { res.status(200).json({ ok: true, note: 'inga f.d. spökjägare hittades', sent: 0 }); return; }

  // Redan skickade (idempotens) + avregistrerade (respektera opt-out).
  const emails = hunters.map((h) => h.email).filter(Boolean);
  const [{ data: doneEv }, { data: states }] = await Promise.all([
    supabase.from('email_events').select('email').eq('template', 'hunter_pause').eq('type', 'sent').in('email', emails),
    supabase.from('nurture_state').select('email,unsub_token,unsubscribed').in('email', emails),
  ]);
  const done = new Set((doneEv || []).map((e) => e.email));
  const stateByEmail = {}; (states || []).forEach((s) => { stateByEmail[s.email] = s; });

  const out = { total: hunters.length, sent: 0, skipped: 0, errors: 0, dry };
  for (const h of hunters) {
    if (!h.email || done.has(h.email)) { out.skipped++; continue; }
    const st = stateByEmail[h.email];
    if (st?.unsubscribed) { out.skipped++; continue; }
    const unsubUrl = st?.unsub_token ? `${SITE_URL}/api/unsubscribe?u=${st.unsub_token}` : '';
    const mail = emailFor((h.full_name || '').split(' ')[0], unsubUrl);
    if (dry) { out.sent++; continue; }
    try {
      await sendEmail({ to: h.email, ...mail, unsubUrl });
      await supabase.from('email_events').insert({ email: h.email, template: 'hunter_pause', type: 'sent' });
      out.sent++;
    } catch (err) {
      await supabase.from('email_events').insert({ email: h.email, template: 'hunter_pause', type: 'error', meta: { error: String(err.message || err) } });
      out.errors++;
    }
  }
  res.status(200).json({ ok: true, ...out });
}
