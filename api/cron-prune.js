// Vercel serverless — retention-prune för snabbt växande loggtabeller
// (default: user_interactions, som växer obegränsat). Håller Supabase-databasen
// under gratisnivåns 500 MB på sikt.
//
// SÄKERHET (viktigt): raderar INGENTING förrän du uttryckligen sätter
// PRUNE_APPLY=true. Utan den svarar den bara med hur många rader som *skulle*
// raderas (dry-run) — så du kan verifiera tabell/kolumn och vad som läser datan
// innan något tas bort. Kan schemaläggas i vercel.json utan risk (dry-run tills
// du flippar PRUNE_APPLY).
//
// Testa manuellt:
//   curl "https://<din-domän>/api/cron-prune?key=<CRON_SECRET>"
//   → { mode:'dry-run', candidates: N, cutoff, ... }
//
// Env (Vercel):
//   SUPABASE_SERVICE_ROLE_KEY, VITE_SUPABASE_URL   (finns redan)
//   CRON_SECRET                                    (finns redan, auth)
//   PRUNE_TABLE            — tabell att städa (default 'user_interactions')
//   PRUNE_COLUMN           — tidsstämpelkolumn att jämföra (default 'created_at')
//   PRUNE_RETENTION_DAYS   — behåll rader nyare än så här många dagar (default 365)
//   PRUNE_APPLY            — 'true' för att FAKTISKT radera; annars dry-run

import { createClient } from '@supabase/supabase-js';

export const config = { maxDuration: 60 };

const SUPABASE_URL = process.env.VITE_SUPABASE_URL || process.env.SUPABASE_URL;
const SERVICE_KEY  = process.env.SUPABASE_SERVICE_ROLE_KEY;
const CRON_SECRET  = process.env.CRON_SECRET;

const TABLE  = process.env.PRUNE_TABLE  || 'user_interactions';
const COLUMN = process.env.PRUNE_COLUMN || 'created_at';
const DAYS   = Number(process.env.PRUNE_RETENTION_DAYS || 365);
const APPLY  = process.env.PRUNE_APPLY === 'true';

export default async function handler(req, res) {
  // Auth: Bearer (Vercel cron skickar det automatiskt) eller ?key= (manuellt).
  const bearer = (req.headers.authorization || '').replace('Bearer ', '').trim();
  const key = bearer || (req.query.key || '').toString();
  if (!CRON_SECRET || key !== CRON_SECRET) { res.status(401).json({ error: 'Otillåten' }); return; }
  if (!SUPABASE_URL || !SERVICE_KEY) { res.status(500).json({ error: 'Supabase-nyckel saknas' }); return; }
  if (!Number.isFinite(DAYS) || DAYS < 1) { res.status(400).json({ error: 'PRUNE_RETENTION_DAYS måste vara >= 1' }); return; }

  const supabase = createClient(SUPABASE_URL, SERVICE_KEY);
  const cutoff = new Date(Date.now() - DAYS * 86400000).toISOString();

  // Räkna kandidater (äldre än cutoff) utan att hämta rader.
  const { count, error: cErr } = await supabase
    .from(TABLE)
    .select('*', { count: 'exact', head: true })
    .lt(COLUMN, cutoff);
  if (cErr) {
    res.status(500).json({
      error: `count: ${cErr.message}`,
      hint: `Stämmer PRUNE_TABLE ('${TABLE}') och PRUNE_COLUMN ('${COLUMN}')? Rätta env-variablerna.`,
    });
    return;
  }

  // Dry-run (standard): rapportera bara, radera inget.
  if (!APPLY) {
    res.status(200).json({
      ok: true, mode: 'dry-run',
      table: TABLE, column: COLUMN, retention_days: DAYS, cutoff,
      candidates: count,
      note: 'Inget raderat. Sätt PRUNE_APPLY=true när du verifierat att inget viktigt läser dessa rader.',
    });
    return;
  }

  // Skarp körning: radera rader äldre än cutoff.
  const { error: dErr } = await supabase.from(TABLE).delete().lt(COLUMN, cutoff);
  if (dErr) { res.status(500).json({ error: `delete: ${dErr.message}` }); return; }

  res.status(200).json({
    ok: true, mode: 'applied',
    table: TABLE, column: COLUMN, retention_days: DAYS, cutoff,
    deleted_estimate: count,
  });
}
