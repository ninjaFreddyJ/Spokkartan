// Vercel serverless — tar emot INKOMMANDE mail (svar från företag, m.m.) och
// vidarebefordrar dem till Discord, så att du ser svaren direkt i en kanal.
//
// Kräver Resend Inbound (mottagning): i Resend → Domains → din domän → Inbound,
// aktivera mottagning och peka en webhook till:
//   https://<din-domän>/api/inbound-email?key=<INBOUND_WEBHOOK_SECRET>
// (Resend lägger till MX-poster du verifierar i din DNS.)
//
// Env: INBOUND_WEBHOOK_SECRET (auth i URL:en) + DISCORD_WEBHOOK_INBOUND
//      (eller DISCORD_WEBHOOK_URL som fallback).
//
// Tips: sätt även reply_to på dina utskick till en brevlåda du faktiskt läser,
// så att svar aldrig fastnar även om Discord-vägen skulle ligga nere.

import { notifyInbound } from '../lib/notify/discord.js';

const SECRET = process.env.INBOUND_WEBHOOK_SECRET;

// Plocka ut fält oavsett om Resend skickar {data:{...}} eller platt payload.
function pick(evt) {
  const d = evt.data || evt || {};
  const from = d.from?.address || d.from?.email || (typeof d.from === 'string' ? d.from : null) || d.sender || null;
  const toRaw = d.to;
  const to = Array.isArray(toRaw)
    ? toRaw.map((x) => x?.address || x?.email || x).filter(Boolean).join(', ')
    : (toRaw?.address || toRaw?.email || toRaw || d.recipient || null);
  const subject = d.subject || null;
  const text = d.text || d.stripped_text || (d.html ? String(d.html).replace(/<[^>]+>/g, ' ') : '') || '';
  return { from, to, subject, text };
}

export default async function handler(req, res) {
  if (req.method !== 'POST') { res.status(405).json({ error: 'POST only' }); return; }
  if (SECRET && (req.query.key || '').toString() !== SECRET) { res.status(401).json({ error: 'Otillåten' }); return; }

  let evt = {};
  try { evt = typeof req.body === 'string' ? JSON.parse(req.body) : (req.body || {}); } catch (e) {}

  const msg = pick(evt);
  if (!msg.from && !msg.subject && !msg.text) {
    res.status(200).json({ ok: true, skipped: 'inget innehåll' });
    return;
  }

  const r = await notifyInbound(msg).catch((e) => ({ ok: false, error: String(e) }));
  res.status(200).json({ ok: true, forwarded: r.ok === true, discord: r });
}
