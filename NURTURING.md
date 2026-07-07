# Nurturing-system — setup & drift

Automatiskt e-postflöde som konverterar nya användare över tid och väcker
inaktiva kontakter för alltid (perpetuell re-engagement var 30:e dag).

## Så funkar det

```
Ny signup ──► DB-trigger skriver in kontakten i nurture_state (+ ev. referral-trial)
                     │
Vercel Cron (varje timme) ──► api/cron-nurture.js
   • håller sig under 100/dag, skickar max 50/körning
   • Pass 1: trial tar snart slut → "behåll PRO för 19 kr"
   • Pass 2: linjär sekvens (dag 0/2/5/10/21/35) → sedan re-engagement var 30:e dag
   • hoppar konverteringsmejl för dem som redan är PRO
   • ~10% hamnar i holdout (kontrollgrupp) för att mäta verklig lyft
                     │
Resend skickar ──► email-webhook loggar öppningar/klick/studsar
```

Sekvens och mejltexter bor i `lib/nurture/engine.js` (sv + en fullt översatta;
de/no/da faller tillbaka på engelska tills de översätts).

## Env-variabler (sätts i Vercel → Project → Settings → Environment Variables)

| Variabel | Beskrivning |
|----------|-------------|
| `RESEND_API_KEY` | **Hemlig.** Skapa konto på resend.com, verifiera domän, skapa API-nyckel |
| `NURTURE_FROM` | Avsändare, t.ex. `Spökkartan 👻 <hej@spokkartan.se>` (måste vara verifierad domän) |
| `SITE_URL` | Din publika URL, t.ex. `https://spokkartan.se` (används i länkar/avreg) |
| `CRON_SECRET` | Hemlig sträng — Vercel skickar den automatiskt som Bearer till cron |
| `RESEND_WEBHOOK_SECRET` | Valfri — läggs som `?key=` på webhook-URL:en i Resend |
| `PRO_CHECKOUT_URL` | Valfri — annars intro-Stripe-länken (19 kr) |
| `SUPABASE_SERVICE_ROLE_KEY`, `VITE_SUPABASE_URL` | Finns redan (används av push) |

Finjustering (valfria, har vettiga defaults): `NURTURE_DAILY_CAP` (100),
`NURTURE_BATCH` (50), `NURTURE_REENGAGE_DAYS` (30), `NURTURE_SUNSET_STREAK` (6).

## Deploy-steg

1. **Databas:** `sql/67_NURTURE_SYSTEM.sql` körs automatiskt av `apply-db`-CI när
   detta mergas till `main`. (Idempotent — säker att köra om.)
2. **Resend:** skapa konto, verifiera avsändardomän (SPF/DKIM), skapa API-nyckel.
3. **Vercel:** lägg in env-variablerna ovan. Cron-schemat ligger i `vercel.json`
   (`/api/cron-nurture` varje timme). Cron kräver Vercel **Pro** för tim-frekvens;
   på Hobby-plan sänk till en gång/dygn.
4. **Webhook (valfritt men rekommenderat):** i Resend, peka email-events till
   `https://<din-domän>/api/email-webhook?key=<RESEND_WEBHOOK_SECRET>`.

## Referral → 7 dagar gratis PRO

- Varje profil får en `referral_code`. Delningslänk: `SITE_URL/?ref=<kod>`
  (finns i "trial_offer"-mejlet).
- När en vän registrerar sig via länken får **båda 7 dagar PRO** (app-nivå,
  inget kort). Runway är **capad till 21 dagar** — aldrig i närheten av en gratis månad.
- Frontend fångar `?ref=` och skickar med koden vid registrering. (Google-login-
  referral är en framtida förbättring — kräver en post-login-RPC.)

## Mätning

Allt loggas i `email_events` (sent/open/click/bounce). Nyckeltal att följa:
öppningsgrad, CTR per steg, PRO-konvertering, avreg-rate, och **inkrementell lyft
vs holdout-gruppen** (den viktigaste).

## Testa manuellt

```
curl "https://<din-domän>/api/cron-nurture?key=<CRON_SECRET>"
```
Svarar med `{ sent, trialEnding, skipped, errors, sentToday }`.
