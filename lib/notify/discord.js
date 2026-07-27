// Discord-notiser — skickar händelser (köp, inkommande mail, larm) till en
// Discord-kanal via inkommande webhook. Ren ESM, inga beroenden (fetch).
//
// Så skaffar du en webhook-URL (per kanal, tar 30 sek):
//   Discord → Serverinställningar → Integrationer → Webhooks → "Ny webhook"
//   → välj kanal → "Kopiera webhook-URL".
//
// Env (Vercel → Settings → Environment Variables). Alla är valfria — saknas de
// hoppas notisen tyst över (koden kraschar aldrig på utebliven config):
//   DISCORD_WEBHOOK_URL            — standardkanal (fallback för allt)
//   DISCORD_WEBHOOK_PURCHASES      — köp/prenumerationer (annars → default)
//   DISCORD_WEBHOOK_INBOUND        — inkommande svar/mail (annars → default)
//   DISCORD_WEBHOOK_ALERTS         — studsar/klagomål/deliverability (annars → default)
//   DISCORD_PROJECT_NAME           — visas i notisen, t.ex. "Spökkartan" (default "Spökkartan")

const DEFAULT = process.env.DISCORD_WEBHOOK_URL || '';
const PROJECT = process.env.DISCORD_PROJECT_NAME || 'Spökkartan';

// Ruttar en kategori till rätt kanal, faller tillbaka på standardkanalen.
function webhookFor(channel) {
  const map = {
    purchases: process.env.DISCORD_WEBHOOK_PURCHASES,
    inbound:   process.env.DISCORD_WEBHOOK_INBOUND,
    alerts:    process.env.DISCORD_WEBHOOK_ALERTS,
  };
  return map[channel] || DEFAULT;
}

// Lågnivå: POSTa en payload till en given webhook-URL. Returnerar {ok, skipped?}.
export async function postToDiscord(url, payload) {
  if (!url) return { ok: false, skipped: 'no webhook url' };
  try {
    const res = await fetch(url, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload),
    });
    // Discord svarar 204 No Content vid lyckad leverans.
    if (!res.ok && res.status !== 204) {
      const detail = await res.text().catch(() => '');
      return { ok: false, status: res.status, detail: detail.slice(0, 200) };
    }
    return { ok: true };
  } catch (err) {
    return { ok: false, error: String(err && err.message || err) };
  }
}

// Färger per händelsetyp (Discord embed-färg som heltal).
const COLORS = { purchase: 0x22c55e, inbound: 0x7c3aed, alert: 0xef4444, info: 0x8b83a8 };

// Högnivå: skicka en snygg embed till rätt kanal.
//   channel: 'purchases' | 'inbound' | 'alerts'
//   { title, description, fields:[{name,value,inline?}], color, url }
export async function notifyDiscord(channel, { title, description, fields, color, url } = {}) {
  const webhook = webhookFor(channel);
  if (!webhook) return { ok: false, skipped: 'no webhook configured' };

  const embed = {
    title: title ? String(title).slice(0, 256) : undefined,
    description: description ? String(description).slice(0, 4096) : undefined,
    color: color != null ? color : COLORS.info,
    fields: Array.isArray(fields)
      ? fields.slice(0, 25).map((f) => ({
          name: String(f.name).slice(0, 256),
          value: String(f.value == null || f.value === '' ? '—' : f.value).slice(0, 1024),
          inline: !!f.inline,
        }))
      : undefined,
    footer: { text: PROJECT },
    url: url || undefined,
  };

  return postToDiscord(webhook, { username: PROJECT, embeds: [embed] });
}

// Bekvämt: notis om ett köp / en prenumerationsförändring.
export function notifyPurchase({ email, tier, amount, currency, kind }) {
  const kr = amount != null ? `${(amount / 100).toFixed(0)} ${(currency || 'SEK').toUpperCase()}` : '—';
  return notifyDiscord('purchases', {
    title: kind === 'canceled' ? '🔻 Prenumeration avslutad' : '💸 Nytt köp!',
    color: kind === 'canceled' ? COLORS.alert : COLORS.purchase,
    fields: [
      { name: 'Kund', value: email || 'okänd', inline: true },
      { name: 'Nivå', value: tier || '—', inline: true },
      { name: 'Belopp', value: kr, inline: true },
    ],
  });
}

// Bekvämt: notis om inkommande mail/svar (t.ex. svar från ett företag).
export function notifyInbound({ from, to, subject, text }) {
  const preview = (text || '').replace(/\s+/g, ' ').trim().slice(0, 1500);
  return notifyDiscord('inbound', {
    title: `📨 Svar: ${subject || '(inget ämne)'}`,
    description: preview || '_(tom text)_',
    color: COLORS.inbound,
    fields: [
      { name: 'Från', value: from || '—', inline: true },
      { name: 'Till', value: to || '—', inline: true },
    ],
  });
}
