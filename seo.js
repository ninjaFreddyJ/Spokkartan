// seo.js — SEO helpers for multilingual indexing
// Handles: dynamic <title>/meta, hreflang, JSON-LD, URL <-> state sync

// All supported languages
export const SEO_LANGS = ['sv', 'en', 'de', 'no', 'da'];
export const DEFAULT_LANG = 'sv';

// Production domain (update when domain bought)
// Falls back to current host when running locally / on Vercel preview
export function getOrigin() {
  if (typeof window === 'undefined') return 'https://spokkartan.com';
  return window.location.origin;
}

// ── Per-page metadata per language ────────────────────────────
// Each route has a translations object keyed by language code.
const META = {
  home: {
    sv: { title: 'Spökkartan — Hemsökta platser i världen', desc: 'Utforska hundratals hemsökta platser. Läs berättelser, hitta din nästa spökresa och boka hemsökta hotell.' },
    en: { title: 'Ghostmap — Haunted Places Around the World', desc: 'Explore hundreds of haunted places. Read stories, plan your next ghost trip and book haunted hotels.' },
    de: { title: 'Spukkarte — Spukorte auf der Welt', desc: 'Erkunde hunderte Spukorte. Lies Geschichten, plane deine nächste Geisterreise und buche Spukhotels.' },
    no: { title: 'Spøkelseskartet — Hjemsøkte steder i verden', desc: 'Utforsk hundrevis av hjemsøkte steder. Les historier, planlegg neste spøkelsestur og bestill hjemsøkte hoteller.' },
    da: { title: 'Spøgelseskortet — Hjemsøgte steder i verden', desc: 'Udforsk hundredvis af hjemsøgte steder. Læs historier, planlæg din næste spøgelsestur og book hjemsøgte hoteller.' },
  },
  map: {
    sv: { title: 'Karta — Spökkartan', desc: 'Interaktiv karta över världens hemsökta platser. Filtrera på land, typ, skräckfaktor och bokningsbart boende.' },
    en: { title: 'Map — Ghostmap', desc: 'Interactive map of haunted places around the world. Filter by country, type, scariness and bookable accommodation.' },
    de: { title: 'Karte — Spukkarte', desc: 'Interaktive Karte der Spukorte weltweit. Filtere nach Land, Typ, Gruselfaktor und buchbarer Unterkunft.' },
    no: { title: 'Kart — Spøkelseskartet', desc: 'Interaktivt kart over hjemsøkte steder. Filtrer etter land, type, skrekkfaktor og overnattingsmuligheter.' },
    da: { title: 'Kort — Spøgelseskortet', desc: 'Interaktivt kort over hjemsøgte steder. Filtrer efter land, type, uhyggefaktor og overnatningsmuligheder.' },
  },
  stories: {
    sv: { title: 'Spökhistorier — Spökkartan', desc: 'Läs sanna och påhittade spökhistorier från hemsökta platser i hela världen.' },
    en: { title: 'Ghost Stories — Ghostmap', desc: 'Read true and folkloric ghost stories from haunted places worldwide.' },
    de: { title: 'Geistergeschichten — Spukkarte', desc: 'Lies wahre und überlieferte Geistergeschichten von Spukorten weltweit.' },
    no: { title: 'Spøkelseshistorier — Spøkelseskartet', desc: 'Les sanne og folkloristiske spøkelseshistorier fra hjemsøkte steder over hele verden.' },
    da: { title: 'Spøgelseshistorier — Spøgelseskortet', desc: 'Læs sande og folkloriske spøgelseshistorier fra hjemsøgte steder verden over.' },
  },
  hunters: {
    sv: { title: 'Spökjägare — Spökkartan', desc: 'Möt världens spökjägare, läs deras berättelser och boka in dem på din nästa undersökning.' },
    en: { title: 'Ghost Hunters — Ghostmap', desc: "Meet the world's ghost hunters, read their stories and hire them for your next investigation." },
    de: { title: 'Geisterjäger — Spukkarte', desc: 'Lerne Geisterjäger weltweit kennen, lies ihre Geschichten und buche sie für deine nächste Untersuchung.' },
    no: { title: 'Spøkelsesjegere — Spøkelseskartet', desc: 'Møt verdens spøkelsesjegere, les historiene deres og leie dem til neste undersøkelse.' },
    da: { title: 'Spøgelsesjægere — Spøgelseskortet', desc: 'Mød verdens spøgelsesjægere, læs deres historier og book dem til din næste undersøgelse.' },
  },
  partners: {
    sv: { title: 'Partners — Spökkartan', desc: 'Hotell, medier, eventarrangörer och restauranger som är partners till Spökkartan.' },
    en: { title: 'Partners — Ghostmap', desc: 'Hotels, mediums, event organizers and restaurants partnered with Ghostmap.' },
    de: { title: 'Partner — Spukkarte', desc: 'Hotels, Medien, Eventveranstalter und Restaurants, die mit der Spukkarte zusammenarbeiten.' },
    no: { title: 'Partnere — Spøkelseskartet', desc: 'Hoteller, medier, arrangører og restauranter som er partnere med Spøkelseskartet.' },
    da: { title: 'Partnere — Spøgelseskortet', desc: 'Hoteller, medier, arrangører og restauranter, der er partnere med Spøgelseskortet.' },
  },
  about: {
    sv: { title: 'Om oss — Spökkartan', desc: 'Vi är nördiga storytellers som älskar spökhistorier. Läs om vår mission att bevara och dela historien.' },
    en: { title: 'About — Ghostmap', desc: 'We are nerdy storytellers who love ghost stories. Read about our mission to preserve and share folklore.' },
    de: { title: 'Über uns — Spukkarte', desc: 'Wir sind nerdige Geschichtenerzähler, die Geistergeschichten lieben. Erfahre mehr über unsere Mission.' },
    no: { title: 'Om oss — Spøkelseskartet', desc: 'Vi er nerdete historiefortellere som elsker spøkelseshistorier. Les om misjonen vår.' },
    da: { title: 'Om os — Spøgelseskortet', desc: 'Vi er nørdede historiefortællere, der elsker spøgelseshistorier. Læs om vores mission.' },
  },
};

// Lookup metadata for a given view + language
export function getMeta(view, lang) {
  const langKey = SEO_LANGS.includes(lang) ? lang : DEFAULT_LANG;
  return META[view]?.[langKey] || META.home[langKey] || META.home[DEFAULT_LANG];
}

// Build place title/desc for a place detail page
export function getPlaceMeta(place, lang) {
  const country = place.country || '';
  const region = place.region || country;
  const teaser = (place.teaser || place.description || '').slice(0, 160).replace(/\s+/g, ' ');
  const t = {
    sv: { title: `${place.name} — Hemsökt plats i ${region} | Spökkartan`, desc: teaser || `Hemsökt plats: ${place.name} i ${region}. Läs hela historien på Spökkartan.` },
    en: { title: `${place.name} — Haunted Place in ${region} | Ghostmap`, desc: teaser || `Haunted place: ${place.name} in ${region}. Read the full story on Ghostmap.` },
    de: { title: `${place.name} — Spukort in ${region} | Spukkarte`, desc: teaser || `Spukort: ${place.name} in ${region}. Lies die ganze Geschichte auf der Spukkarte.` },
    no: { title: `${place.name} — Hjemsøkt sted i ${region} | Spøkelseskartet`, desc: teaser || `Hjemsøkt sted: ${place.name} i ${region}. Les hele historien på Spøkelseskartet.` },
    da: { title: `${place.name} — Hjemsøgt sted i ${region} | Spøgelseskortet`, desc: teaser || `Hjemsøgt sted: ${place.name} i ${region}. Læs hele historien på Spøgelseskortet.` },
  };
  const langKey = SEO_LANGS.includes(lang) ? lang : DEFAULT_LANG;
  return t[langKey];
}

// ── Set <title> and meta tags on the document ─────────────────
export function applyMeta(meta, opts = {}) {
  if (typeof document === 'undefined') return;
  if (meta?.title) document.title = meta.title;
  setMetaTag('description', meta?.desc || '');
  setMetaTag('og:title', meta?.title || '', 'property');
  setMetaTag('og:description', meta?.desc || '', 'property');
  setMetaTag('og:type', opts.ogType || 'website', 'property');
  setMetaTag('og:image', opts.image || `${getOrigin()}/og-default.jpg`, 'property');
  setMetaTag('og:url', opts.url || (typeof window !== 'undefined' ? window.location.href : ''), 'property');
  setMetaTag('twitter:card', 'summary_large_image', 'name');
  setMetaTag('twitter:title', meta?.title || '', 'name');
  setMetaTag('twitter:description', meta?.desc || '', 'name');
  setMetaTag('twitter:image', opts.image || `${getOrigin()}/og-default.jpg`, 'name');
}

function setMetaTag(name, content, attr = 'name') {
  if (typeof document === 'undefined') return;
  let el = document.querySelector(`meta[${attr}="${name}"]`);
  if (!el) {
    el = document.createElement('meta');
    el.setAttribute(attr, name);
    document.head.appendChild(el);
  }
  el.setAttribute('content', content || '');
}

// ── hreflang link tags — tells Google about all language versions ─────
export function applyHreflang(path) {
  if (typeof document === 'undefined') return;
  // remove any existing hreflang links
  document.querySelectorAll('link[rel="alternate"][hreflang]').forEach(el => el.remove());
  const origin = getOrigin();
  const cleanPath = path.replace(/^\/(sv|en|de|no|da)(\/|$)/, '/');
  SEO_LANGS.forEach(lang => {
    const link = document.createElement('link');
    link.setAttribute('rel', 'alternate');
    link.setAttribute('hreflang', lang);
    link.setAttribute('href', `${origin}/${lang}${cleanPath === '/' ? '' : cleanPath}`);
    document.head.appendChild(link);
  });
  // x-default points to Swedish (default)
  const xd = document.createElement('link');
  xd.setAttribute('rel', 'alternate');
  xd.setAttribute('hreflang', 'x-default');
  xd.setAttribute('href', `${origin}/sv${cleanPath === '/' ? '' : cleanPath}`);
  document.head.appendChild(xd);
}

// ── Canonical URL ─────────────────────────────────────────────
export function applyCanonical(url) {
  if (typeof document === 'undefined') return;
  let link = document.querySelector('link[rel="canonical"]');
  if (!link) {
    link = document.createElement('link');
    link.setAttribute('rel', 'canonical');
    document.head.appendChild(link);
  }
  link.setAttribute('href', url);
}

// ── JSON-LD structured data for places (Schema.org) ───────────
export function applyPlaceJsonLd(place, lang) {
  if (typeof document === 'undefined' || !place) return;
  // remove old
  document.querySelectorAll('script[type="application/ld+json"][data-spokkartan]').forEach(el => el.remove());
  const data = {
    '@context': 'https://schema.org',
    '@type': 'TouristAttraction',
    name: place.name,
    description: (place.teaser || place.description || '').slice(0, 500),
    image: place.img || undefined,
    address: {
      '@type': 'PostalAddress',
      addressCountry: place.country || undefined,
      addressRegion: place.region || undefined,
    },
    geo: (place.lat && place.lng) ? {
      '@type': 'GeoCoordinates',
      latitude: place.lat,
      longitude: place.lng,
    } : undefined,
    inLanguage: lang || DEFAULT_LANG,
    isAccessibleForFree: place.free === true || place.free === 'true',
    url: typeof window !== 'undefined' ? window.location.href : undefined,
  };
  const script = document.createElement('script');
  script.setAttribute('type', 'application/ld+json');
  script.setAttribute('data-spokkartan', '1');
  script.textContent = JSON.stringify(data);
  document.head.appendChild(script);
}

// JSON-LD for the site itself (Organization)
export function applySiteJsonLd() {
  if (typeof document === 'undefined') return;
  if (document.querySelector('script[type="application/ld+json"][data-site-org]')) return;
  const origin = getOrigin();
  const data = {
    '@context': 'https://schema.org',
    '@type': 'Organization',
    name: 'Spökkartan',
    alternateName: ['Ghostmap', 'Spukkarte', 'Spøkelseskartet', 'Spøgelseskortet'],
    url: origin,
    logo: `${origin}/og-default.jpg`,
    sameAs: ['https://spokkartan.se'],
  };
  const script = document.createElement('script');
  script.setAttribute('type', 'application/ld+json');
  script.setAttribute('data-site-org', '1');
  script.textContent = JSON.stringify(data);
  document.head.appendChild(script);
}

// ── URL parsing & building ────────────────────────────────────
// URL formats:
//   /sv/                              → home (sv)
//   /en/map                           → map (en)
//   /sv/plats/{slug}                  → place detail (sv)
//   /en/place/{slug}                  → place detail (en)
//   /de/ort/{slug}                    → place detail (de)
//   /no/sted/{slug}                   → place detail (no)
//   /da/sted/{slug}                   → place detail (da)
const PLACE_PATH = { sv: 'plats', en: 'place', de: 'ort', no: 'sted', da: 'sted' };
const VIEW_PATHS = {
  // language-specific URL labels per view
  map: { sv: 'karta', en: 'map', de: 'karte', no: 'kart', da: 'kort' },
  stories: { sv: 'historier', en: 'stories', de: 'geschichten', no: 'historier', da: 'historier' },
  hunters: { sv: 'spokjagare', en: 'hunters', de: 'geisterjaeger', no: 'spokelsesjegere', da: 'spogelsesjaegere' },
  partners: { sv: 'partners', en: 'partners', de: 'partner', no: 'partnere', da: 'partnere' },
  about: { sv: 'om-oss', en: 'about', de: 'ueber-uns', no: 'om-oss', da: 'om-os' },
  ebook: { sv: 'e-bok', en: 'ebook', de: 'e-buch', no: 'e-bok', da: 'e-bog' },
  board: { sv: 'anslagstavla', en: 'board', de: 'pinnwand', no: 'oppslagstavle', da: 'opslagstavle' },
};

export function parsePath(path = (typeof window !== 'undefined' ? window.location.pathname : '/')) {
  const parts = path.split('/').filter(Boolean);
  let lang = DEFAULT_LANG;
  let view = 'home';
  let placeSlug = null;
  if (parts.length > 0 && SEO_LANGS.includes(parts[0])) {
    lang = parts[0];
    parts.shift();
  }
  if (parts.length === 0) {
    return { lang, view: 'home', placeSlug: null };
  }
  const seg = parts[0];
  // place detail?
  if (Object.values(PLACE_PATH).includes(seg) && parts[1]) {
    return { lang, view: 'place', placeSlug: parts.slice(1).join('/') };
  }
  // map view?
  for (const [v, paths] of Object.entries(VIEW_PATHS)) {
    if (Object.values(paths).includes(seg)) {
      view = v;
      break;
    }
  }
  return { lang, view, placeSlug: null };
}

export function buildPath({ lang, view, placeSlug }) {
  const langKey = SEO_LANGS.includes(lang) ? lang : DEFAULT_LANG;
  if (placeSlug) {
    const placeSeg = PLACE_PATH[langKey] || 'plats';
    return `/${langKey}/${placeSeg}/${placeSlug}`;
  }
  if (view === 'home' || !view) return `/${langKey}/`;
  const seg = VIEW_PATHS[view]?.[langKey] || view;
  return `/${langKey}/${seg}`;
}

// Push URL change without full reload
export function pushPath(p) {
  if (typeof window === 'undefined') return;
  if (window.location.pathname !== p) {
    window.history.pushState({}, '', p);
  }
}
