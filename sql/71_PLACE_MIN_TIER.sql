-- 71: Nivåstyrt innehåll per plats.
-- min_tier = lägsta medlemsnivå som låser upp platsen.
--   null  → standard (gratisplatser = alla; övriga = explorer+, som idag)
--   'ultimate' → t.ex. avrättningsplats-batchen: bara Ultimate ser dem
-- På Spökkartan-domänen behandlar appen 'ultimate' som 'pro' (se placeMinTier
-- i App.jsx), så avrättningsplatser ingår i PRO där men bara i ULTIMATE på
-- hauntedplaces.
--
-- Idempotent. Själva taggningen av vilka rader som är avrättningsplatser görs
-- separat (se kommentar nedan) eftersom den batchen ligger i live-DB, inte i repo.

alter table public.places
  add column if not exists min_tier text
  check (min_tier in ('free','explorer','pro','ultimate'));

create index if not exists places_min_tier_idx on public.places(min_tier);

-- TAGGNING (kör manuellt när vi bestämt hur batchen identifieras). Exempel:
--   update public.places set min_tier='ultimate' where type = 'Avrättningsplats';
--   update public.places set min_tier='ultimate' where source = '<batch-tagg>';
-- De mest kända (äldre) avrättningsplatserna lämnas med min_tier = null så de
-- ligger kvar på vanlig nivå.
