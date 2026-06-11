// Vercel serverless function — Open Graph-taggar för crawlers (Facebook m.fl.)
//
// PROBLEM: Spökkartan är en SPA. Facebooks/Twitters/WhatsApps crawler kör ingen
// JavaScript, så när någon delar en plats-länk ser crawlern bara index.html:s
// generiska taggar -> ingen rubrik/bild i förhandsvisningen.
//
// LÖSNING: vercel.json dirigerar enbart crawler-User-Agents för plats-URL:er
// hit. Vi hämtar platsen från Supabase och returnerar minimal HTML med korrekta
// og:-taggar. Riktiga besökare skickas vidare till appen via location.replace.
//
// Kräver env: VITE_SUPABASE_URL + VITE_SUPABASE_ANON_KEY (finns redan i projektet).

import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = process.env.VITE_SUPABASE_URL || process.env.SUPABASE_URL;
const SUPABASE_KEY = process.env.VITE_SUPABASE_ANON_KEY || process.env.SUPABASE_ANON_KEY;
const PLACE_SEG = { sv: 'plats', en: 'place', de: 'ort', no: 'sted', da: 'sted' };

const esc = (s) => String(s == null ? '' : s)
  .replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');

export default async function handler(req, res) {
  const origin = `https://${req.headers.host || 'spokkartan.com'}`;
  const slug = (req.query.slug || '').toString();
  const lang = (req.query.lang || 'sv').toString();
  const seg = PLACE_SEG[lang] || 'plats';
  const canonical = `${origin}/${lang}/${seg}/${encodeURIComponent(slug)}`;

  let place = null;
  if (slug && SUPABASE_URL && SUPABASE_KEY) {
    try {
      const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);
      const { data } = await supabase
        .from('places')
        .select('name,teaser,description,img,country,region,slug,id')
        .or(`slug.eq.${slug},id.eq.${slug}`)
        .eq('status', 'published')
        .limit(1);
      place = (data && data[0]) || null;
    } catch (e) { /* fall through to site default */ }
  }

  let title, desc, image;
  if (place) {
    const loc = [place.region, place.country].filter(Boolean).join(', ');
    title = `${place.name}${loc ? ' — ' + loc : ''} | Spökkartan`;
    desc = place.teaser || (place.description ? place.description.slice(0, 180).trim() + '…' : 'Hemsökt plats på Spökkartan.');
    image = place.img || `${origin}/og-default.png`;
  } else {
    title = 'Spökkartan — Hemsökta platser i världen';
    desc = 'Utforska hundratals hemsökta platser. Läs berättelser och hitta din nästa spökresa.';
    image = `${origin}/og-default.png`;
  }

  const html = `<!doctype html><html lang="${esc(lang)}"><head><meta charset="utf-8"/>
<title>${esc(title)}</title>
<meta name="description" content="${esc(desc)}"/>
<link rel="canonical" href="${esc(canonical)}"/>
<meta property="og:site_name" content="Spökkartan"/>
<meta property="og:type" content="article"/>
<meta property="og:title" content="${esc(title)}"/>
<meta property="og:description" content="${esc(desc)}"/>
<meta property="og:url" content="${esc(canonical)}"/>
<meta property="og:image" content="${esc(image)}"/>
<meta name="twitter:card" content="summary_large_image"/>
<meta name="twitter:title" content="${esc(title)}"/>
<meta name="twitter:description" content="${esc(desc)}"/>
<meta name="twitter:image" content="${esc(image)}"/>
</head><body>
<p>${esc(title)}</p>
<script>location.replace(${JSON.stringify(canonical)});</script>
<noscript><a href="${esc(canonical)}">Öppna på Spökkartan</a></noscript>
</body></html>`;

  res.setHeader('Content-Type', 'text/html; charset=utf-8');
  res.setHeader('Cache-Control', 's-maxage=3600, stale-while-revalidate');
  res.status(200).send(html);
}
