// Vercel serverless — crawler-prerender för SEO + AEO.
//
// PROBLEM: Spökkartan är en SPA. Google renderar JS trögt, och Bing + nästan
// alla AI-crawlers (GPTBot, PerplexityBot, ClaudeBot …) kör INGEN JavaScript —
// de ser en tom sida. Då finns inget innehåll att indexera eller citera.
//
// LÖSNING: vercel.json dirigerar crawler-User-Agents (sök, AI-sök, sociala) hit.
// Vi hämtar riktigt innehåll från Supabase och returnerar fullständig,
// indexerbar HTML med serverrenderad JSON-LD (TouristAttraction/FAQPage/
// CollectionPage/BreadcrumbList). Riktiga besökare rör aldrig den här vägen —
// de får SPA:n som vanligt.
//
// Env: VITE_SUPABASE_URL + VITE_SUPABASE_ANON_KEY (finns redan).

import { createClient } from '@supabase/supabase-js';
import { parsePath, buildPath, getMeta, getPlaceMeta, SEO_LANGS, DEFAULT_LANG } from '../seo.js';

export const config = { maxDuration: 15 };

const SUPABASE_URL = process.env.VITE_SUPABASE_URL || process.env.SUPABASE_URL;
const SUPABASE_KEY = process.env.VITE_SUPABASE_ANON_KEY || process.env.SUPABASE_ANON_KEY;
const PLACE_SEG = { sv: 'plats', en: 'place', de: 'ort', no: 'sted', da: 'sted' };

const esc = (s) => String(s == null ? '' : s)
  .replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
const jsonLd = (obj) => `<script type="application/ld+json">${JSON.stringify(obj).replace(/</g, '\\u003c')}</script>`;

// Lokaliserade UI-etiketter (sv/en fullt, övriga faller tillbaka på en).
const UI = {
  sv: { explore: 'Utforska hemsökta platser', all: 'Alla platser på kartan', related: 'Hemsökta platser i närheten', faq: 'Vanliga frågor', book: 'Boka övernattning', story: 'Läs historien', home: 'Till startsidan', scary: 'Skräckfaktor' },
  en: { explore: 'Explore haunted places', all: 'All places on the map', related: 'Haunted places nearby', faq: 'FAQ', book: 'Book a stay', story: 'Read the story', home: 'Home', scary: 'Scare factor' },
};
const ui = (lang) => UI[lang] || UI.en;

function placeUrl(origin, lang, slug) { return `${origin}/${lang}/${PLACE_SEG[lang] || 'plats'}/${encodeURIComponent(slug)}`; }

// FAQ per plats (sv/en) — matar FAQPage-schema + synligt Q&A för AI-svar.
function placeFaq(place, lang) {
  const region = place.region || place.country || '';
  const teaser = (place.teaser || place.description || '').slice(0, 240).replace(/\s+/g, ' ').trim();
  if (lang === 'en') {
    return [
      [`Is ${place.name} haunted?`, teaser || `${place.name} is a haunted place listed on Spökkartan.`],
      [`Where is ${place.name} located?`, `${place.name} is located in ${region}${place.country ? ', ' + place.country : ''}.`],
      [`Can you visit ${place.name}?`, place.bookable ? `Yes — you can book a stay near ${place.name}.` : `${place.name} is a place you can explore and read about on Spökkartan.`],
    ];
  }
  return [
    [`Är ${place.name} hemsökt?`, teaser || `${place.name} är en hemsökt plats på Spökkartan.`],
    [`Var ligger ${place.name}?`, `${place.name} ligger i ${region}${place.country ? ', ' + place.country : ''}.`],
    [`Kan man besöka ${place.name}?`, place.bookable ? `Ja — du kan boka övernattning nära ${place.name}.` : `${place.name} är en plats du kan utforska och läsa om på Spökkartan.`],
  ];
}

function head({ title, desc, canonical, image, origin, path, lang, ogType }) {
  const alts = SEO_LANGS.map((L) => {
    const parsed = parsePath(path);
    const href = origin + buildPath({ lang: L, view: parsed.view, placeSlug: parsed.placeSlug });
    return `<link rel="alternate" hreflang="${L}" href="${esc(href)}"/>`;
  }).join('');
  const xdef = `<link rel="alternate" hreflang="x-default" href="${esc(origin + buildPath({ lang: DEFAULT_LANG, view: parsePath(path).view, placeSlug: parsePath(path).placeSlug }))}"/>`;
  return `<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width,initial-scale=1"/>
<title>${esc(title)}</title>
<meta name="description" content="${esc(desc)}"/>
<meta name="robots" content="index,follow,max-image-preview:large"/>
<link rel="canonical" href="${esc(canonical)}"/>
${alts}${xdef}
<meta property="og:site_name" content="Spökkartan"/>
<meta property="og:type" content="${ogType || 'website'}"/>
<meta property="og:title" content="${esc(title)}"/>
<meta property="og:description" content="${esc(desc)}"/>
<meta property="og:url" content="${esc(canonical)}"/>
<meta property="og:image" content="${esc(image)}"/>
<meta name="twitter:card" content="summary_large_image"/>
<meta name="twitter:title" content="${esc(title)}"/>
<meta name="twitter:description" content="${esc(desc)}"/>
<meta name="twitter:image" content="${esc(image)}"/>`;
}

export default async function handler(req, res) {
  const origin = `https://${req.headers.host || 'spokkartan.se'}`;
  let path = (req.query.path || '/').toString();
  if (!path.startsWith('/')) path = '/' + path;
  const { lang: rawLang, view, placeSlug } = parsePath(path);
  const lang = SEO_LANGS.includes(rawLang) ? rawLang : DEFAULT_LANG;
  const L = ui(lang);

  const supabase = (SUPABASE_URL && SUPABASE_KEY) ? createClient(SUPABASE_URL, SUPABASE_KEY) : null;
  const defaultImg = `${origin}/og-default.jpg`;
  let body = '', title = '', desc = '', image = defaultImg, ogType = 'website';
  const jsonLdBlocks = [];

  // ── PLATSSIDA ─────────────────────────────────────────────────────
  if (view === 'place' && placeSlug && supabase) {
    const { data } = await supabase.from('places')
      .select('id,slug,name,teaser,description,img,country,region,type,scary,bookable,booking_url,lat,lng,free')
      .or(`slug.eq.${placeSlug},id.eq.${placeSlug}`).eq('status', 'published').limit(1);
    const place = data && data[0];
    if (place) {
      // Besökarnas aggregerade recensioner (UGC → AggregateRating för SEO/AEO)
      const { data: stats } = await supabase.from('place_review_stats').select('*').eq('place_id', place.id).maybeSingle();
      const m = getPlaceMeta(place, lang);
      title = m.title; desc = m.desc; image = place.img || defaultImg; ogType = 'article';
      const meta = [place.type, place.region, place.country].filter(Boolean).map(esc).join(' · ');
      const paras = (place.description || place.teaser || '').split(/\n+/).filter(Boolean)
        .map((p) => `<p>${esc(p)}</p>`).join('');
      const faq = placeFaq(place, lang);
      const faqHtml = `<section><h2>${esc(L.faq)}</h2>${faq.map(([q, a]) => `<h3>${esc(q)}</h3><p>${esc(a)}</p>`).join('')}</section>`;

      // Relaterade platser (samma land) — interna länkar för crawl-djup + AEO.
      let relHtml = '';
      const { data: rel } = await supabase.from('places')
        .select('slug,id,name,region').eq('status', 'published').eq('country', place.country)
        .neq('id', place.id).limit(6);
      if (rel && rel.length) {
        relHtml = `<section><h2>${esc(L.related)}</h2><ul>${rel.map((r) =>
          `<li><a href="${esc(placeUrl(origin, lang, r.slug || r.id))}">${esc(r.name)}${r.region ? ' — ' + esc(r.region) : ''}</a></li>`).join('')}</ul></section>`;
      }

      const bookHtml = (place.bookable && place.booking_url)
        ? `<p><a href="${esc(place.booking_url)}" rel="nofollow">${esc(L.book)} →</a></p>` : '';

      const spookHtml = (stats && stats.review_count)
        ? `<p class="reviews">${lang === 'en' ? 'Visitor scare rating' : 'Besökarnas spöklighet'}: ${esc(stats.avg_spook)}/5 (${esc(stats.review_count)} ${lang === 'en' ? 'reviews' : 'omdömen'})</p>` : '';

      body = `<article><h1>${esc(place.name)}</h1><p class="meta">${meta}${place.scary ? ` · ${esc(L.scary)}: ${esc(place.scary)}/5` : ''}</p>${spookHtml}
${paras || `<p>${esc(place.teaser || '')}</p>`}${bookHtml}${faqHtml}${relHtml}
<p><a href="${esc(origin + buildPath({ lang, view: 'home' }))}">${esc(L.home)}</a></p></article>`;

      jsonLdBlocks.push({
        '@context': 'https://schema.org', '@type': 'TouristAttraction',
        name: place.name, description: (place.teaser || place.description || '').slice(0, 500),
        image: place.img || undefined, url: placeUrl(origin, lang, place.slug || place.id),
        address: { '@type': 'PostalAddress', addressCountry: place.country || undefined, addressRegion: place.region || undefined },
        geo: (place.lat && place.lng) ? { '@type': 'GeoCoordinates', latitude: place.lat, longitude: place.lng } : undefined,
        aggregateRating: (stats && stats.review_count) ? { '@type': 'AggregateRating', ratingValue: stats.avg_spook, bestRating: 5, worstRating: 1, ratingCount: stats.review_count } : undefined,
        isAccessibleForFree: place.free === true, inLanguage: lang,
      });
      jsonLdBlocks.push({
        '@context': 'https://schema.org', '@type': 'FAQPage',
        mainEntity: faq.map(([q, a]) => ({ '@type': 'Question', name: q, acceptedAnswer: { '@type': 'Answer', text: a } })),
      });
      jsonLdBlocks.push({
        '@context': 'https://schema.org', '@type': 'BreadcrumbList',
        itemListElement: [
          { '@type': 'ListItem', position: 1, name: 'Spökkartan', item: origin + buildPath({ lang, view: 'home' }) },
          { '@type': 'ListItem', position: 2, name: place.name, item: placeUrl(origin, lang, place.slug || place.id) },
        ],
      });
    }
  }

  // ── LISTVYER (home/map/stories/hunters/partners/about) ─────────────
  if (!body) {
    const m = getMeta(view === 'place' ? 'home' : view, lang);
    title = m.title; desc = m.desc;
    let items = [];
    if (supabase && ['home', 'map', 'stories'].includes(view === 'place' ? 'home' : view)) {
      const { data } = await supabase.from('places')
        .select('slug,id,name,teaser,region,country,img').eq('status', 'published')
        .order('featured', { ascending: false }).order('is_new', { ascending: false }).limit(80);
      items = (data || []).map((p) => ({ url: placeUrl(origin, lang, p.slug || p.id), name: p.name, sub: [p.region, p.country].filter(Boolean).join(', '), teaser: p.teaser, img: p.img }));
    } else if (supabase && view === 'hunters') {
      const { data } = await supabase.from('profiles').select('id,full_name,bio').eq('is_hunter', true).limit(60);
      items = (data || []).map((h) => ({ url: origin + buildPath({ lang, view: 'hunters' }), name: h.full_name || 'Spökjägare', teaser: h.bio }));
    } else if (supabase && view === 'partners') {
      const { data } = await supabase.from('partners').select('id,name,tagline,type').eq('status', 'live').limit(60);
      items = (data || []).map((p) => ({ url: origin + buildPath({ lang, view: 'partners' }), name: p.name, sub: p.type, teaser: p.tagline }));
    }
    const list = items.length
      ? `<h2>${esc(L.all)}</h2><ul>${items.map((it) =>
          `<li><a href="${esc(it.url)}">${esc(it.name)}</a>${it.sub ? ` — ${esc(it.sub)}` : ''}${it.teaser ? `<br/><span>${esc(String(it.teaser).slice(0, 160))}</span>` : ''}</li>`).join('')}</ul>` : '';
    if (items[0]?.img) image = items[0].img;

    body = `<main><h1>${esc(title)}</h1><p>${esc(desc)}</p>${list}</main>`;

    jsonLdBlocks.push({
      '@context': 'https://schema.org', '@type': 'Organization', name: 'Spökkartan',
      alternateName: ['Ghostmap', 'Spukkarte', 'Spøkelseskartet', 'Spøgelseskortet'],
      url: origin, logo: defaultImg, sameAs: ['https://spokkartan.se'],
    });
    jsonLdBlocks.push({
      '@context': 'https://schema.org', '@type': 'WebSite', name: 'Spökkartan', url: origin, inLanguage: lang,
      potentialAction: { '@type': 'SearchAction', target: `${origin}/${lang}/?q={search_term_string}`, 'query-input': 'required name=search_term_string' },
    });
    if (items.length) {
      jsonLdBlocks.push({
        '@context': 'https://schema.org', '@type': 'ItemList',
        itemListElement: items.slice(0, 40).map((it, i) => ({ '@type': 'ListItem', position: i + 1, name: it.name, url: it.url })),
      });
    }
  }

  const canonical = origin + buildPath({ lang, view: view === 'place' ? 'place' : view, placeSlug });
  const html = `<!doctype html><html lang="${esc(lang)}"><head>
${head({ title, desc, canonical, image, origin, path, lang, ogType })}
${jsonLdBlocks.map(jsonLd).join('\n')}
</head><body>
${body}
<footer><p>${esc(ui(lang).explore)} — <a href="${esc(origin + buildPath({ lang, view: 'home' }))}">Spökkartan</a></p></footer>
</body></html>`;

  res.setHeader('Content-Type', 'text/html; charset=utf-8');
  res.setHeader('Cache-Control', 's-maxage=3600, stale-while-revalidate=86400');
  res.status(200).send(html);
}
