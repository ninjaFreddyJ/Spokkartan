# Discord-notiser + inkommande mail → Discord

Så här får du **köp** och **svar på utskick** direkt i Discord, plus larm när
ett utskick börjar studsa. Allt är env-styrt — sätt inga variabler och inget
händer (koden kraschar aldrig på utebliven config).

## 1. Skapa webhook-URL:er i Discord (30 sek styck)

Discord → **Serverinställningar → Integrationer → Webhooks → Ny webhook** →
välj kanal → **Kopiera webhook-URL**. Skapa gärna en kanal per typ:

| Kanal (förslag) | Vad som hamnar där |
|-----------------|--------------------|
| `#köp`          | Nya köp och avslutade prenumerationer (från Stripe) |
| `#svar`         | Inkommande svar/mail från företag du mejlat |
| `#larm`         | Studsar och spam-klagomål (deliverability) |

## 2. Env-variabler (Vercel → Project → Settings → Environment Variables)

| Variabel | Beskrivning |
|----------|-------------|
| `DISCORD_WEBHOOK_URL` | Standardkanal — fallback för allt om de specifika saknas |
| `DISCORD_WEBHOOK_PURCHASES` | Kanal för köp (annars → default) |
| `DISCORD_WEBHOOK_INBOUND` | Kanal för inkommande svar (annars → default) |
| `DISCORD_WEBHOOK_ALERTS` | Kanal för studsar/klagomål (annars → default) |
| `DISCORD_PROJECT_NAME` | Namn i notisen, t.ex. `Spökkartan` / `Stadsvandring` / `Cellary` |
| `NURTURE_REPLY_TO` | Brevlåda dit svar går, t.ex. `fredrik@spokkartan.se` (dubbel säkerhet) |
| `INBOUND_WEBHOOK_SECRET` | Hemlig sträng — läggs som `?key=` på inbound-webhookens URL |

Det enklaste: sätt bara `DISCORD_WEBHOOK_URL` (+ ev. `NURTURE_REPLY_TO`) så
funkar köp, svar och larm i samma kanal. Dela upp senare vid behov.

## 3. Köp → Discord

Redan inkopplat i `api/stripe-webhook.js`. När Stripe-eventet
`checkout.session.completed` kommer in postas en notis med kund, nivå och
belopp. Inget mer att göra — sätt bara webhook-variabeln.

## 4. Svar/inkommande mail → Discord

1. I **Resend → Domains → (din domän) → Inbound**: aktivera mottagning.
   Resend ger dig **MX-poster** att lägga i din DNS.
2. Peka Resends inbound-webhook till:
   `https://<din-domän>/api/inbound-email?key=<INBOUND_WEBHOOK_SECRET>`
3. Sätt även `NURTURE_REPLY_TO` så att svar landar i en riktig brevlåda —
   då fastnar aldrig ett svar även om Discord-vägen ligger nere.

Handlern (`api/inbound-email.js`) läser avsändare, ämne och text och postar en
embed i `#svar`.

## 5. Studsar/klagomål → Discord

Redan inkopplat i `api/email-webhook.js` (samma Resend-webhook som loggar
öppningar). Vid `email.bounced`/`email.complained` pausas kontakten *och* en
varning postas i `#larm`.

---

## Flera projekt (Spökkartan / Stadsvandring / Cellary)

Varje projekt är en egen Vercel-deploy med **egna env-variabler**, så samma kod
ger separata Discord-kanaler och avsändare per projekt — sätt bara olika
`DISCORD_WEBHOOK_*`, `DISCORD_PROJECT_NAME`, `NURTURE_FROM` och `RESEND_API_KEY`
i respektive projekt. Den här filens filer (`lib/notify/discord.js`,
`api/inbound-email.js`) är copy-paste-bara till de andra reposen.

### Resend: ett konto eller flera?

- **Ett Resend-konto, flera domäner (Pro, ~$20/mån totalt):** billigast. Lägg
  till `spokkartan.se`, `stadsvandring.se`, `cellary.se` som separata verifierade
  domäner under samma konto. Reputation isoleras ändå per domän.
- **Separat Resend-konto per projekt (~$20/mån × antal):** dyrare, men ren
  fakturering per bolag och helt separat rykte/kvot. Välj detta om projekten är
  olika juridiska bolag eller ska bokföras var för sig.

Byt bara `RESEND_API_KEY` (+ `NURTURE_FROM`) per Vercel-projekt oavsett vilket du väljer.
