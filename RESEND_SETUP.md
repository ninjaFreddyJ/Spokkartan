# Resend-konton per projekt — setup

Så skapar du och kopplar in Resend för de fyra projekten. **Ett gratis konto per
projekt** (eget konto → egen domän → egen kvot). Kompletterar `DISCORD.md`
(notiser) och `NURTURING.md` (utskicksflödet).

> ⚠️ Kontona kan bara du skapa — registrering kräver att *du* godkänner Resends
> villkor, verifierar e-post och äger kontot. Det här dokumentet gör det så
> snabbt som möjligt (~1 min/konto) och listar allt som ska in i Vercel.

## Nyckeltrick: 4 konton från en inkorg

Resend kräver en unik e-post per konto — men du behöver inte fyra brevlådor.
Använd **+alias** på din Google Workspace-adress, så landar alla
verifieringsmejl i samma inkorg. Logga in med **Google** varje gång.

## Konton att skapa

| # | Projekt | Signup-alias | Domän att verifiera | Avsändare | Vercel-projekt |
|---|---------|--------------|---------------------|-----------|----------------|
| 1 | Stadsvandring | `fredrik.lundberg+stadsvandring@grantigo.com` | `stadsvandring.io` | `hej@stadsvandring.io` | *(repo saknas — peka ut)* |
| 2 | Spökkartan | `fredrik.lundberg+spokkartan@grantigo.com` | `spokkartan.se` | `hej@spokkartan.se` | Spokkartan |
| 3 | Hauntedplaces | `fredrik.lundberg+hauntedplaces@grantigo.com` | **? (bekräfta domän)** | `hej@?` | hauntedplaces |
| 4 | Cellary | `fredrik.lundberg+cellary@grantigo.com` | `cellary.io` | `hej@cellary.io` | cellary-web |

*(Personligt konto är struket — redan löst separat.)*

## Steg per konto (~1 min)

1. [resend.com/signup](https://resend.com/signup) → **logga in med Google** (aliaset ovan).
2. **Domains → Add Domain** → skriv in projektets domän.
3. Resend visar **DNS-poster** — lägg dem i domänens DNS:
   - **SPF** (`TXT`, t.ex. `v=spf1 include:...`)
   - **DKIM** (en eller flera `TXT`/`CNAME`, unika per konto)
   - **DMARC** (`TXT` på `_dmarc`, t.ex. `v=DMARC1; p=none; rua=...`)
   - **MX** (endast om du aktiverar *Inbound* — se nedan)
4. Vänta på verifiering (grön bock), sen **API Keys → Create API Key**.
5. Klistra in nyckeln + avsändaren i rätt Vercel-projekt (env nedan).

Ingen betalning behövs — gratisnivån (3 000 mail/mån · **100/dag** · 1 domän ·
inbound ingår) räcker för utskicken. 1 000 företag ≈ 10–11 dagars utskick per
projekt vid 100/dag (vilket också är rätt tempo för deliverability).

## Env-variabler per Vercel-projekt

Sätt i **respektive** Vercel-projekt (inte globalt — varje projekt sitt konto):

| Variabel | Beskrivning |
|----------|-------------|
| `RESEND_API_KEY` | API-nyckeln från det projektets Resend-konto |
| `NURTURE_FROM` (Spökkartan) / `EMAIL_FROM` (Cellary) | Avsändare, t.ex. `Spökkartan 👻 <hej@spokkartan.se>` |
| `NURTURE_REPLY_TO` (Spökkartan) / `EMAIL_REPLY_TO` (Cellary) | Brevlåda dit svar går (säkerhetsnät utöver Discord) |
| `RESEND_WEBHOOK_SECRET` | `?key=`-värde på Resends event-webhook (öppningar/studsar) |
| `INBOUND_WEBHOOK_SECRET` | `?key=`-värde på inbound-webhooken (svar → Discord) |

Discord-variablerna (`DISCORD_WEBHOOK_URL` m.fl.) finns i `DISCORD.md`.

## Inbound (svar → Discord)

Vill du att svar från företag hamnar i Discord: i Resend → **Domains → (domän)
→ Inbound**, aktivera mottagning (lägger till **MX-poster**), och peka
inbound-webhooken till `https://<din-domän>/api/inbound-email?key=<INBOUND_WEBHOOK_SECRET>`.
Sätt även `NURTURE_REPLY_TO`/`EMAIL_REPLY_TO` så svar aldrig fastnar.

## Ett konto eller flera? (påminnelse)

Du valde **separata gratiskonton per projekt** — renast rykte/kvot/fakturering
per projekt. Alternativet (ett Pro-konto, flera domäner, ~$20/mån) är billigare
men delar kvot. Byt bara `RESEND_API_KEY` per Vercel-projekt oavsett vilket.

## Kvar att bekräfta

- **Hauntedplaces-domän** (rad 3 ovan) — säg vilken så låser jag avsändaren.
- **Stadsvandring-repo** — finns ingen bland dina; peka ut/klona den för att få samma Discord/inbound-mönster där.
