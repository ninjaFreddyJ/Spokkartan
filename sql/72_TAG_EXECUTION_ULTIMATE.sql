-- 72: Tagga avrättningsplats-batchen som Ultimate-only.
-- Batchen = platser med type='Avrättningsplats' (kategorin infördes när batchen
-- lades till; de äldre "mest kända" avrättningsplatserna har andra typer och
-- lämnas orörda). På Spökkartan-domänen behandlar appen 'ultimate' som 'pro'
-- (se placeMinTier i App.jsx), så där ingår de i PRO — men bara i ULTIMATE på
-- hauntedplaces. Idempotent + stabil vid CI-omkörningar.

-- 1. Tagga batchen som ultimate (bara första gången per rad → CI-stabilt,
--    överskriver aldrig manuella justeringar).
update public.places
   set min_tier = 'ultimate'
 where type = 'Avrättningsplats'
   and min_tier is null;

-- 2. UNDANTAG: de mest kända som ska ligga kvar på vanlig nivå (PRO/Explorer).
--    Fyll i sluggar här → de sätts till 'explorer' och tas därmed UR ultimate.
--    (Sätt INTE till null — då tar steg 1 tillbaka dem vid nästa CI-körning.)
update public.places
   set min_tier = 'explorer'
 where type = 'Avrättningsplats'
   and slug in (
     -- 'exempel-slug-1',
     -- 'exempel-slug-2',
     ''  -- platshållare (matchar inget)
   );

-- VERIFIERA (kör i Supabase SQL Editor):
--   select slug, name, region, min_tier from public.places
--    where type='Avrättningsplats' order by min_tier, name;
-- ÅTERSTÄLL allt (om du ångrar dig):
--   update public.places set min_tier=null where type='Avrättningsplats';
