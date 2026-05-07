// Vercel serverless function — dynamic sitemap.xml
// Builds a complete multi-language sitemap from Supabase places.
// Cached for 1h on Vercel edge.

import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = process.env.VITE_SUPABASE_URL || process.env.SUPABASE_URL;
const SUPABASE_KEY = process.env.VITE_SUPABASE_ANON_KEY || process.env.SUPABASE_ANON_KEY;
const LANGS = ['sv', 'en', 'de', 'no', 'da'];

// URL slug for the place segment, per language
const PLACE_SEG = { sv: 'plats', en: 'place', de: 'ort', no: 'sted', da: 'sted' };

export default async function handler(req, res) {
  const origin = `https://${req.headers.host || 'spokkartan.com'}`;
  const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

  let places = [];
  try {
    const { data } = await supabase
      .from('places')
      .select('id,slug,name,country,region,updated_at,status')
      .eq('status', 'published')
      .limit(2000);
    places = data || [];
  } catch (e) {
    // continue with empty list — sitemap still has static routes
  }

  const staticPaths = [
    { path: '', priority: '1.0', changefreq: 'daily' },
    { path: 'karta', priority: '0.9', changefreq: 'daily', altKeys: { sv: 'karta', en: 'map', de: 'karte', no: 'kart', da: 'kort' } },
    { path: 'historier', priority: '0.7', changefreq: 'weekly', altKeys: { sv: 'historier', en: 'stories', de: 'geschichten', no: 'historier', da: 'historier' } },
    { path: 'spokjagare', priority: '0.7', changefreq: 'weekly', altKeys: { sv: 'spokjagare', en: 'hunters', de: 'geisterjaeger', no: 'spokelsesjegere', da: 'spogelsesjaegere' } },
    { path: 'partners', priority: '0.6', changefreq: 'weekly', altKeys: { sv: 'partners', en: 'partners', de: 'partner', no: 'partnere', da: 'partnere' } },
    { path: 'om-oss', priority: '0.5', changefreq: 'monthly', altKeys: { sv: 'om-oss', en: 'about', de: 'ueber-uns', no: 'om-oss', da: 'om-os' } },
  ];

  // Build URL set: each URL has hreflang siblings via xhtml:link
  const urls = [];
  staticPaths.forEach(sp => {
    LANGS.forEach(lang => {
      const seg = sp.altKeys ? sp.altKeys[lang] : sp.path;
      const loc = sp.path === '' ? `${origin}/${lang}/` : `${origin}/${lang}/${seg}`;
      const alts = LANGS.map(L => {
        const segL = sp.altKeys ? sp.altKeys[L] : sp.path;
        const href = sp.path === '' ? `${origin}/${L}/` : `${origin}/${L}/${segL}`;
        return `<xhtml:link rel="alternate" hreflang="${L}" href="${href}"/>`;
      }).join('');
      urls.push(`<url><loc>${loc}</loc>${alts}<changefreq>${sp.changefreq}</changefreq><priority>${sp.priority}</priority></url>`);
    });
  });

  // Per-place URLs (multilingual)
  places.forEach(p => {
    const slug = p.slug || p.id;
    if (!slug) return;
    const lastmod = p.updated_at ? new Date(p.updated_at).toISOString().slice(0, 10) : undefined;
    LANGS.forEach(lang => {
      const seg = PLACE_SEG[lang] || 'plats';
      const loc = `${origin}/${lang}/${seg}/${encodeURIComponent(slug)}`;
      const alts = LANGS.map(L => {
        const segL = PLACE_SEG[L] || 'plats';
        return `<xhtml:link rel="alternate" hreflang="${L}" href="${origin}/${L}/${segL}/${encodeURIComponent(slug)}"/>`;
      }).join('');
      const lm = lastmod ? `<lastmod>${lastmod}</lastmod>` : '';
      urls.push(`<url><loc>${loc}</loc>${alts}${lm}<changefreq>monthly</changefreq><priority>0.8</priority></url>`);
    });
  });

  const xml = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xhtml="http://www.w3.org/1999/xhtml">
${urls.join('\n')}
</urlset>`;

  res.setHeader('Content-Type', 'application/xml; charset=utf-8');
  res.setHeader('Cache-Control', 's-maxage=3600, stale-while-revalidate');
  res.status(200).send(xml);
}
