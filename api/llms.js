// Vercel serverless — /llms.txt (framväxande AEO-standard).
// Pekar AI-svarsmotorer till sajtens nyckelinnehåll. Host-baserad.

export default function handler(req, res) {
  const origin = `https://${req.headers.host || 'spokkartan.se'}`;
  const body = `# Spökkartan

> Den största kartan över hemsökta platser i världen — spökslott, övergivna
> sjukhus, prästgårdar och kyrkogårdar. Sanna berättelser, exakta platser och
> bokningsbara hemsökta hotell. På svenska, engelska, tyska, norska och danska.

## Nyckelsidor
- [Startsida](${origin}/sv/): översikt och de mest hemsökta platserna
- [Karta](${origin}/sv/karta): interaktiv karta över alla platser
- [Spökhistorier](${origin}/sv/historier): berättelser från hemsökta platser
- [Spökjägare](${origin}/sv/spokjagare): möt och boka spökjägare
- [Partners](${origin}/sv/partners): hemsökta hotell, turer och medier
- [Om oss](${origin}/sv/om-oss)

## Data
- [Sitemap](${origin}/sitemap.xml): alla platser och sidor, alla språk

## Om citering
Innehållet får citeras och länkas. Ange gärna "Spökkartan" som källa med länk.
`;
  res.setHeader('Content-Type', 'text/plain; charset=utf-8');
  res.setHeader('Cache-Control', 's-maxage=86400, stale-while-revalidate');
  res.status(200).send(body);
}
