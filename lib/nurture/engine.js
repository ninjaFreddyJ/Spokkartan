// Nurturing-motor: sekvens, flerspråkiga mallar och Resend-utskick.
// Importeras av api/cron-nurture.js. Ren ESM, inga extra beroenden (fetch).
//
// Sekvensen är optimerad för att konvertera över tid: aktivering först,
// mjuk monetisering i mitten, community/identitet, sedan EVIG re-engagement
// var 30:e dag (så kontakter väcks automatiskt även långt efter 2 månader).

export const DAILY_CAP     = Number(process.env.NURTURE_DAILY_CAP || 100); // ditt tak
export const BATCH_SIZE    = Number(process.env.NURTURE_BATCH   || 50);    // per körning
export const REENGAGE_DAYS = Number(process.env.NURTURE_REENGAGE_DAYS || 30);
export const SUNSET_SLACK  = Number(process.env.NURTURE_SUNSET_STREAK || 6); // no-open innan cadence dras ner

// Linjär sekvens. delay = dagar efter FÖREGÅENDE steg. send() = villkor.
export const SEQUENCE = [
  { key: 'welcome',      delay: 0,  send: () => true },
  { key: 'activate',     delay: 2,  send: () => true },
  { key: 'trial_offer',  delay: 3,  send: (c) => !c.is_pro },   // dela → 7 dagar PRO
  { key: 'community',    delay: 5,  send: () => true },
  { key: 'value_story',  delay: 11, send: (c) => !c.is_pro },
  { key: 'social_proof', delay: 14, send: (c) => !c.is_pro },
  // index >= SEQUENCE.length  →  perpetuell re-engagement (var REENGAGE_DAYS)
];

export const REENGAGE_VARIANTS = ['reengage_new', 'reengage_scary', 'reengage_feature'];

// ── Innehåll ───────────────────────────────────────────────────────
// Två fullt översatta språk (sv, en). de/no/da faller tillbaka på en tills
// de översatts. En primär CTA per mejl (optimerar CTR).
const C = {
  sv: {
    welcome: {
      subject: '👻 Välkommen till Spökkartan',
      pre: 'Din karta över hemsökta platser är redo.',
      h: 'Välkommen, {name}!',
      body: [
        'Du har precis fått nyckeln till hundratals av världens mest hemsökta platser — spökslott, övergivna sjukhus, kyrkogårdar och prästgårdar.',
        'Börja med de tio läskigaste platserna just nu. Tänd en lampa först.',
      ],
      cta: 'Öppna kartan', tip: 'Tips: slå på notiser så pingar vi dig när en ny hemsökt plats dyker upp nära dig.',
    },
    activate: {
      subject: 'Hemsökta platser nära dig 🗺️',
      pre: 'Vi hittade några i din närhet.',
      h: 'Redo för din första spökresa?',
      body: [
        'De mest minnesvärda platserna är ofta närmare än man tror. Öppna kartan och zooma in på din region — spara dem du vill besöka i en roadtrip.',
        'Läs berättelsen bakom en plats innan du åker. Vissa historier är svårare att skaka av sig än andra.',
      ],
      cta: 'Utforska nära mig', tip: '',
    },
    trial_offer: {
      subject: '7 dagar PRO — gratis om du delar 👻',
      pre: 'Lås upp allt genom att bjuda in en kompis.',
      h: 'Dela med en vän, få 7 dagar PRO',
      body: [
        'PRO låser upp alla 308+ platser, GPS-koordinater, roadtrip-planeraren, anslagstavlan och e-bok-buildern.',
        'Dela din personliga länk med en kompis som är lika nyfiken på det övernaturliga. När de går med får ni <b>båda 7 dagar PRO gratis</b> — inget kort behövs.',
      ],
      cta: 'Dela din länk', tip: 'Ingen gratismånad, inga trick — bara sju dagar full tillgång för att ni båda bjuder in varandra i mörkret.',
      useReferral: true,
    },
    community: {
      subject: 'Bli en av spökjägarna 🔦',
      pre: 'Anslagstavlan väntar.',
      h: 'Det här är mer än en karta',
      body: [
        'Bakom Spökkartan finns en gemenskap av spökjägare som delar utrustning, tips och platser som inte finns på kartan än.',
        'Vet du en hemsökt plats vi missat? Föreslå den — vi verifierar koordinater, skriver historiken och lägger upp den.',
      ],
      cta: 'Föreslå en plats', tip: 'Vill du synas som spökjägare? Skapa en profil och logga platserna du besökt.',
    },
    value_story: {
      subject: 'Historien de flesta aldrig får läsa',
      pre: 'Full tillgång med PRO.',
      h: 'Du har bara sett halva kartan',
      body: [
        'Många av de mest skrämmande platserna är låsta bakom PRO — med exakta koordinater så du hittar hela vägen fram, även i mörkret.',
        'Prova PRO för <b>19 kr första månaden</b>, sedan 49 kr/mån. Avbryt när du vill.',
      ],
      cta: 'Lås upp allt för 19 kr', tip: '', usePro: true,
    },
    social_proof: {
      subject: 'Tusentals utforskar redan i mörkret',
      pre: 'Häng med.',
      h: 'Du är i gott (och läskigt) sällskap',
      body: [
        'Spökjägare över hela Norden använder Spökkartan för att planera nätter på hemsökta hotell, prästgårdar och övergivna platser.',
        'Redo att göra det på riktigt? PRO ger dig hela kartan för 19 kr första månaden.',
      ],
      cta: 'Bli PRO för 19 kr', tip: '', usePro: true,
    },
    trial_ending: {
      subject: 'Din PRO tar snart slut ⏳',
      pre: 'Behåll allt för 19 kr.',
      h: 'Bara några dagar kvar av din PRO',
      body: [
        'Din kostnadsfria PRO-period löper snart ut. Vill du behålla alla platser, koordinater och roadtrip-planeraren?',
        'Fortsätt för <b>19 kr första månaden</b>, sedan 49 kr/mån. Avbryt när du vill.',
      ],
      cta: 'Behåll PRO för 19 kr', tip: '', usePro: true,
    },
    reengage_new: {
      subject: 'Nya hemsökta platser sedan du var här 👻',
      pre: 'Kartan har vuxit.',
      h: 'Det har hänt saker i mörkret',
      body: [
        'Vi har lagt till nya hemsökta platser sedan ditt senaste besök. Några av dem kan ligga närmare dig än du tror.',
        'Kom tillbaka och se vad som väntar.',
      ],
      cta: 'Se de nya platserna', tip: '',
    },
    reengage_scary: {
      subject: 'Månadens läskigaste plats 🕯️',
      pre: 'Vågar du?',
      h: 'En plats du borde se',
      body: [
        'Varje månad lyfter vi fram en av de mest skrämmande platserna på kartan — komplett med historiken bakom.',
        'Den här gången är det en du inte vill läsa ensam.',
      ],
      cta: 'Öppna kartan', tip: '',
    },
    reengage_feature: {
      subject: 'Har du provat roadtrip-planeraren?',
      pre: 'Planera din nästa spökresa.',
      h: 'Bygg din perfekta spökresa',
      body: [
        'Med roadtrip-planeraren kedjar du ihop flera hemsökta platser till en rutt — perfekt för en helg i mörkret.',
        'Öppna kartan, spara dina platser och se rutten ta form.',
      ],
      cta: 'Planera en spökresa', tip: '',
    },
    footer_unsub: 'Avsluta prenumeration', footer_by: 'Spökkartan — hemsökta platser i världen',
  },

  en: {
    welcome: {
      subject: '👻 Welcome to Spökkartan',
      pre: 'Your map of haunted places is ready.',
      h: 'Welcome, {name}!',
      body: [
        'You just got the key to hundreds of the world’s most haunted places — ghost castles, abandoned hospitals, graveyards and vicarages.',
        'Start with the ten scariest places right now. Turn a light on first.',
      ],
      cta: 'Open the map', tip: 'Tip: turn on notifications and we’ll ping you when a new haunted place appears near you.',
    },
    activate: {
      subject: 'Haunted places near you 🗺️',
      pre: 'We found a few close by.',
      h: 'Ready for your first ghost trip?',
      body: [
        'The most memorable places are often closer than you think. Open the map, zoom into your region, and save the ones you want to visit as a roadtrip.',
        'Read the story behind a place before you go. Some are harder to shake than others.',
      ],
      cta: 'Explore near me', tip: '',
    },
    trial_offer: {
      subject: '7 days of PRO — free when you share 👻',
      pre: 'Unlock everything by inviting a friend.',
      h: 'Share with a friend, get 7 days of PRO',
      body: [
        'PRO unlocks all 308+ places, GPS coordinates, the roadtrip planner, the bulletin board and the e-book builder.',
        'Share your personal link with a friend who loves the paranormal. When they join, you <b>both get 7 days of PRO free</b> — no card needed.',
      ],
      cta: 'Share your link', tip: 'No free month, no tricks — just seven days of full access for inviting each other into the dark.',
      useReferral: true,
    },
    community: {
      subject: 'Become one of the ghost hunters 🔦',
      pre: 'The bulletin board awaits.',
      h: 'This is more than a map',
      body: [
        'Behind Spökkartan is a community of ghost hunters sharing gear, tips and places not yet on the map.',
        'Know a haunted place we missed? Suggest it — we verify the coordinates, write the history and add it.',
      ],
      cta: 'Suggest a place', tip: 'Want to appear as a ghost hunter? Create a profile and log the places you’ve visited.',
    },
    value_story: {
      subject: 'The story most people never get to read',
      pre: 'Full access with PRO.',
      h: 'You’ve only seen half the map',
      body: [
        'Many of the scariest places are locked behind PRO — with exact coordinates so you find your way all the way there, even in the dark.',
        'Try PRO for <b>19 kr the first month</b>, then 49 kr/mo. Cancel anytime.',
      ],
      cta: 'Unlock everything for 19 kr', tip: '', usePro: true,
    },
    social_proof: {
      subject: 'Thousands are already exploring the dark',
      pre: 'Join them.',
      h: 'You’re in good (and scary) company',
      body: [
        'Ghost hunters across the Nordics use Spökkartan to plan nights in haunted hotels, vicarages and abandoned places.',
        'Ready to do it for real? PRO gives you the whole map for 19 kr the first month.',
      ],
      cta: 'Get PRO for 19 kr', tip: '', usePro: true,
    },
    trial_ending: {
      subject: 'Your PRO is ending soon ⏳',
      pre: 'Keep everything for 19 kr.',
      h: 'Only a few days left of your PRO',
      body: [
        'Your free PRO period is about to end. Want to keep all the places, coordinates and the roadtrip planner?',
        'Continue for <b>19 kr the first month</b>, then 49 kr/mo. Cancel anytime.',
      ],
      cta: 'Keep PRO for 19 kr', tip: '', usePro: true,
    },
    reengage_new: {
      subject: 'New haunted places since you were here 👻',
      pre: 'The map has grown.',
      h: 'Things have stirred in the dark',
      body: [
        'We’ve added new haunted places since your last visit. Some may be closer than you think.',
        'Come back and see what’s waiting.',
      ],
      cta: 'See the new places', tip: '',
    },
    reengage_scary: {
      subject: 'The scariest place of the month 🕯️',
      pre: 'Do you dare?',
      h: 'A place you should see',
      body: [
        'Every month we spotlight one of the scariest places on the map — with the full story behind it.',
        'This one you don’t want to read alone.',
      ],
      cta: 'Open the map', tip: '',
    },
    reengage_feature: {
      subject: 'Have you tried the roadtrip planner?',
      pre: 'Plan your next ghost trip.',
      h: 'Build your perfect ghost trip',
      body: [
        'The roadtrip planner chains multiple haunted places into one route — perfect for a weekend in the dark.',
        'Open the map, save your places and watch the route take shape.',
      ],
      cta: 'Plan a ghost trip', tip: '',
    },
    footer_unsub: 'Unsubscribe', footer_by: 'Spökkartan — haunted places of the world',
  },
};

function pack(lang) { return C[lang] || C.en; }
const esc = (s) => String(s == null ? '' : s).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');

// ── HTML-wrapper (mörkt, mobilvänligt, en tydlig CTA) ──────────────
function wrap({ pre, h, bodyHtml, cta, ctaUrl, tip, unsubUrl, footerBy, footerUnsub }) {
  return `<!doctype html><html><body style="margin:0;background:#07060f;color:#f0ecff;font-family:-apple-system,Segoe UI,Roboto,Helvetica,Arial,sans-serif;">
<div style="display:none;max-height:0;overflow:hidden;opacity:0">${esc(pre)}</div>
<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background:#07060f;padding:28px 12px">
<tr><td align="center">
<table role="presentation" width="100%" style="max-width:520px;background:#12101f;border:1px solid #2a2540;border-radius:18px;overflow:hidden">
<tr><td style="padding:28px 28px 8px">
  <div style="font-size:34px;line-height:1">👻</div>
  <h1 style="font-size:22px;margin:12px 0 0;color:#f0ecff;font-weight:800">${esc(h)}</h1>
</td></tr>
<tr><td style="padding:8px 28px 4px;font-size:15px;line-height:1.65;color:#cfc8ea">${bodyHtml}</td></tr>
<tr><td style="padding:18px 28px 6px">
  <a href="${esc(ctaUrl)}" style="display:inline-block;background:linear-gradient(135deg,#7c3aed,#a855f7);color:#fff;text-decoration:none;font-weight:700;font-size:15px;padding:13px 24px;border-radius:12px">${esc(cta)} →</a>
</td></tr>
${tip ? `<tr><td style="padding:10px 28px 4px;font-size:12px;line-height:1.6;color:#8b83a8">${esc(tip)}</td></tr>` : ''}
<tr><td style="padding:22px 28px 26px;border-top:1px solid #2a2540;font-size:11px;color:#6f688a">
  ${esc(footerBy)}<br/>
  <a href="${esc(unsubUrl)}" style="color:#8b83a8;text-decoration:underline">${esc(footerUnsub)}</a>
</td></tr>
</table>
</td></tr></table></body></html>`;
}

// Rendera ett mejl. templateKey ∈ nycklarna i C. ctx: {name, referralUrl, proUrl, siteUrl, unsubUrl}
export function render(templateKey, lang, ctx) {
  const p = pack(lang);
  const t = p[templateKey] || pack('en')[templateKey];
  if (!t) return null;
  const name = ctx.name || (lang === 'en' ? 'ghost hunter' : 'spökjägare');
  const ctaUrl = t.useReferral ? ctx.referralUrl : t.usePro ? ctx.proUrl : ctx.siteUrl;
  const bodyHtml = t.body.map((para) => `<p style="margin:0 0 14px">${para.replace('{name}', esc(name))}</p>`).join('');
  const subject = t.subject.replace('{name}', name);
  const html = wrap({
    pre: t.pre, h: t.h.replace('{name}', name), bodyHtml,
    cta: t.cta, ctaUrl, tip: t.tip,
    unsubUrl: ctx.unsubUrl, footerBy: p.footer_by, footerUnsub: p.footer_unsub,
  });
  const text = `${t.h.replace('{name}', name)}\n\n${t.body.map((b) => b.replace(/<[^>]+>/g, '')).join('\n\n')}\n\n${t.cta}: ${ctaUrl}\n\n${p.footer_unsub}: ${ctx.unsubUrl}`;
  return { subject, html, text };
}

// ── Resend-utskick (fetch, inget SDK) ──────────────────────────────
export async function sendEmail({ to, subject, html, text, unsubUrl }) {
  const KEY = process.env.RESEND_API_KEY;
  const FROM = process.env.NURTURE_FROM || 'Spökkartan 👻 <hej@spokkartan.se>';
  // Svar hamnar här — sätt till en brevlåda du faktiskt läser så att svar
  // aldrig fastnar. (Discord-vidarebefordran sker separat via inbound-email.)
  const REPLY_TO = process.env.NURTURE_REPLY_TO || '';
  if (!KEY) throw new Error('RESEND_API_KEY saknas i env');
  const res = await fetch('https://api.resend.com/emails', {
    method: 'POST',
    headers: { Authorization: `Bearer ${KEY}`, 'Content-Type': 'application/json' },
    body: JSON.stringify({
      from: FROM, to: [to], subject, html, text,
      ...(REPLY_TO ? { reply_to: REPLY_TO } : {}),
      // RFC 8058: ett-klicks avregistrering direkt i mejlklienten
      headers: {
        'List-Unsubscribe': `<${unsubUrl}>`,
        'List-Unsubscribe-Post': 'List-Unsubscribe=One-Click',
      },
    }),
  });
  if (!res.ok) {
    const detail = await res.text().catch(() => '');
    throw new Error(`Resend ${res.status}: ${detail.slice(0, 300)}`);
  }
  return res.json().catch(() => ({}));
}
