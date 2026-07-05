// Vercel serverless — dynamisk robots.txt.
// Host-baserad (ingen hårdkodad domän) och med explicit allowlist för sök- OCH
// svarsmotorer (AEO). Själva skrapskyddet sker på CDN/WAF-nivå (verifierade
// bottar släpps förbi, övriga utmanas) — den här filen styr vad som får indexeras.

export default function handler(req, res) {
  const origin = `https://${req.headers.host || 'spokkartan.se'}`;

  // Bottar vi uttryckligen vill in: klassiska sökmotorer + AI-svarsmotorer.
  // (AEO: de här citerar dig live i AI-svar — det vi vill ranka i.)
  const allow = [
    'Googlebot', 'Googlebot-Image', 'Bingbot', 'DuckDuckBot', 'Slurp', 'Applebot',
    // Svarsmotorer / AI-sök
    'OAI-SearchBot', 'ChatGPT-User', 'PerplexityBot', 'Perplexity-User',
    'ClaudeBot', 'Claude-SearchBot', 'Anthropic-AI', 'Google-Extended', 'Applebot-Extended',
    'Amazonbot', 'Bytespider-Search',
  ];

  const blocks = allow.map((ua) => `User-agent: ${ua}\nAllow: /`).join('\n\n');

  const body = `# Spökkartan — vi vill indexeras av sökmotorer OCH citeras av svarsmotorer.
# Skrapskydd hanteras på CDN/WAF-nivå, inte här.

User-agent: *
Allow: /
Disallow: /admin
Disallow: /api/

${blocks}

Sitemap: ${origin}/sitemap.xml
`;

  res.setHeader('Content-Type', 'text/plain; charset=utf-8');
  res.setHeader('Cache-Control', 's-maxage=86400, stale-while-revalidate');
  res.status(200).send(body);
}
