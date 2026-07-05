// Vercel serverless — avregistrering från nurturing (ett-klick, RFC 8058).
// GET  /api/unsubscribe?u=<token>  → visar bekräftelsesida
// POST /api/unsubscribe?u=<token>  → List-Unsubscribe-Post (mejlklientens ett-klick)
//
// Env: VITE_SUPABASE_URL + SUPABASE_SERVICE_ROLE_KEY (finns redan).

import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = process.env.VITE_SUPABASE_URL || process.env.SUPABASE_URL;
const SERVICE_KEY  = process.env.SUPABASE_SERVICE_ROLE_KEY;

export default async function handler(req, res) {
  const token = (req.query.u || '').toString().trim();
  if (!token || !SUPABASE_URL || !SERVICE_KEY) {
    res.status(400).send('Ogiltig länk.'); return;
  }
  const supabase = createClient(SUPABASE_URL, SERVICE_KEY);
  await supabase.from('nurture_state')
    .update({ unsubscribed: true, status: 'unsubscribed', updated_at: new Date().toISOString() })
    .eq('unsub_token', token);

  // Ett-klick från mejlklienten (POST) förväntar sig bara 200.
  if (req.method === 'POST') { res.status(200).json({ ok: true }); return; }

  res.setHeader('Content-Type', 'text/html; charset=utf-8');
  res.status(200).send(`<!doctype html><html lang="sv"><head><meta charset="utf-8"/>
<meta name="viewport" content="width=device-width,initial-scale=1"/><title>Avregistrerad</title></head>
<body style="margin:0;background:#07060f;color:#f0ecff;font-family:-apple-system,Segoe UI,Roboto,Arial,sans-serif;display:flex;min-height:100vh;align-items:center;justify-content:center;text-align:center">
<div style="max-width:420px;padding:32px">
<div style="font-size:44px">👻</div>
<h1 style="font-size:22px;margin:16px 0 8px">Du är avregistrerad</h1>
<p style="color:#cfc8ea;line-height:1.6;font-size:15px">Vi skickar inga fler mejl. Du är alltid välkommen tillbaka till kartan.</p>
<a href="https://spokkartan.se" style="display:inline-block;margin-top:18px;color:#a855f7;text-decoration:none;font-weight:700">Till Spökkartan →</a>
</div></body></html>`);
}
