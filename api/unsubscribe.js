// Vercel serverless function — avregistrering från mailutskick (unsubscribe).
//
// Lägg den här länken i FOTEN på varje mail du skickar:
//   https://DIN-DOMAN/api/unsubscribe?email=mottagarens@adress.se
//
// Två lägen:
//   GET  /api/unsubscribe?email=...   -> lägger till adressen i suppression-
//                                        listan och visar en bekräftelsesida.
//   POST /api/unsubscribe             -> RFC 8058 "List-Unsubscribe=One-Click"
//        (body: email=... eller {"email":"..."}) -> 200, ingen HTML.
//
// För one-click i mailklienter, sätt även dessa headers på utgående mail:
//   List-Unsubscribe: <https://DIN-DOMAN/api/unsubscribe?email=...>
//   List-Unsubscribe-Post: List-Unsubscribe=One-Click
//
// Env som måste sättas i Vercel (finns redan för web-push):
//   VITE_SUPABASE_URL
//   SUPABASE_SERVICE_ROLE_KEY   (skriver förbi RLS)

import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = process.env.VITE_SUPABASE_URL || process.env.SUPABASE_URL;
const SERVICE_KEY  = process.env.SUPABASE_SERVICE_ROLE_KEY;

const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

function page(emoji, heading, message) {
  return `<!doctype html>
<html lang="sv"><head>
<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta name="robots" content="noindex"/>
<title>${heading} · Spökkartan</title>
<style>
  *{box-sizing:border-box} body{margin:0;font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,sans-serif;
  background:#0f0f1a;color:#e7e7ef;display:flex;align-items:center;justify-content:center;min-height:100vh;padding:24px}
  .card{max-width:440px;width:100%;background:#1a1a2e;border:1px solid #2a2a44;border-radius:18px;padding:36px 28px;text-align:center}
  .emoji{font-size:48px;margin-bottom:12px}
  h1{font-size:20px;font-weight:800;margin:0 0 10px}
  p{font-size:14px;line-height:1.6;color:#b9b9cc;margin:0}
  a{color:#a78bfa;text-decoration:none}
</style></head>
<body><div class="card">
  <div class="emoji">${emoji}</div>
  <h1>${heading}</h1>
  <p>${message}</p>
</div></body></html>`;
}

export default async function handler(req, res) {
  const isPost = req.method === 'POST';
  if (req.method !== 'GET' && !isPost) {
    res.status(405).json({ error: 'GET eller POST' });
    return;
  }

  // Adress från query (länk i mail) eller body (one-click POST).
  let email = (req.query && req.query.email ? String(req.query.email) : '').trim().toLowerCase();
  if (!email && isPost) {
    try {
      const b = typeof req.body === 'string' ? JSON.parse(req.body) : (req.body || {});
      email = String(b.email || '').trim().toLowerCase();
    } catch (e) { /* ignoreras */ }
  }

  if (!SUPABASE_URL || !SERVICE_KEY) {
    if (isPost) { res.status(500).json({ error: 'SUPABASE_SERVICE_ROLE_KEY saknas i env' }); return; }
    res.setHeader('Content-Type', 'text/html; charset=utf-8');
    res.status(500).send(page('⚠️', 'Något gick fel', 'Servern är felkonfigurerad. Försök igen senare.'));
    return;
  }

  if (!EMAIL_RE.test(email)) {
    if (isPost) { res.status(400).json({ error: 'Ogiltig e-postadress' }); return; }
    res.setHeader('Content-Type', 'text/html; charset=utf-8');
    res.status(400).send(page('🤔', 'Ogiltig länk', 'E-postadressen saknas eller är felaktig i länken.'));
    return;
  }

  const supabase = createClient(SUPABASE_URL, SERVICE_KEY);
  const { error } = await supabase
    .from('email_unsubscribes')
    .upsert(
      { email, source: 'self', reason: 'Avregistrerad via länk i mail' },
      { onConflict: 'email' }
    );

  if (error) {
    if (isPost) { res.status(500).json({ error: error.message }); return; }
    res.setHeader('Content-Type', 'text/html; charset=utf-8');
    res.status(500).send(page('⚠️', 'Något gick fel', 'Kunde inte avregistrera just nu. Försök igen senare.'));
    return;
  }

  if (isPost) { res.status(200).json({ ok: true, email }); return; }
  res.setHeader('Content-Type', 'text/html; charset=utf-8');
  res.status(200).send(page(
    '✅',
    'Du är avregistrerad',
    `<strong>${email}</strong> kommer inte längre att få mail från Spökkartan. Du behöver inte göra något mer.`
  ));
}
