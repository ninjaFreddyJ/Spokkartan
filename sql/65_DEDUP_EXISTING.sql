-- ============================================================
-- Spökkartan — DEDUP av BEFINTLIGA dubbletter (GRANSKA FÖRE KÖRNING)
-- Genererad 2026-06-10.
--
-- Dessa dubbletter fanns REDAN i datan (oberoende av de nya platserna):
-- samma plats har lagts in två gånger med olika slug, troligen för att
-- WordPress-importen (09) och de senare batch-filerna (21/23/24) överlappade.
--
-- Varje block: BEHÅLL en kanonisk rad (keeper), fyll dess ev. tomma fält från
-- dubbletten (COALESCE — skriver ALDRIG över befintlig bild/koordinat/text),
-- radera sedan dubbletten.
--
-- ⚠️ KÖR SYNC_TO_HAUNTEDPLACES.sql FÖRST (den berikar keeper-radernas text),
--    kör SEDAN detta.
-- ⚠️ GRANSKA: om någon tabell (t.ex. hunter_visits) refererar place-id måste
--    referensen flyttas till keeper innan DELETE. Avkommentera UPDATE-raderna
--    nedan om så är fallet i din databas.
-- ============================================================

BEGIN;

-- Hjälp: flytta ev. besök/referenser från dubblett -> keeper innan radering.
-- (Avkommentera om din databas har dessa kolumner.)
-- UPDATE hunter_visits SET place_id = keeper WHERE place_id = dup;  -- exempel

-- 1) Château de Brissac:  keeper 'chateau-de-brissac'  | dup 'ch-teau-de-brissac'
UPDATE places k SET
  img=COALESCE(NULLIF(k.img,''),d.img), img_credit=COALESCE(NULLIF(k.img_credit,''),d.img_credit),
  img_author=COALESCE(NULLIF(k.img_author,''),d.img_author),
  lat=COALESCE(k.lat,d.lat), lng=COALESCE(k.lng,d.lng),
  description=COALESCE(NULLIF(k.description,''),d.description), teaser=COALESCE(NULLIF(k.teaser,''),d.teaser)
FROM places d WHERE k.id='chateau-de-brissac' AND d.id='ch-teau-de-brissac';
DELETE FROM places WHERE id='ch-teau-de-brissac';

-- 2) Pluckley:  keeper 'pluckley'  | dup 'pluckley-village'
UPDATE places k SET
  img=COALESCE(NULLIF(k.img,''),d.img), img_credit=COALESCE(NULLIF(k.img_credit,''),d.img_credit),
  img_author=COALESCE(NULLIF(k.img_author,''),d.img_author),
  lat=COALESCE(k.lat,d.lat), lng=COALESCE(k.lng,d.lng),
  description=COALESCE(NULLIF(k.description,''),d.description), teaser=COALESCE(NULLIF(k.teaser,''),d.teaser)
FROM places d WHERE k.id='pluckley' AND d.id='pluckley-village';
DELETE FROM places WHERE id='pluckley-village';

-- 3) Wewelsburg:  keeper 'wewelsburg'  | dup 'wewelsburg-castle'
UPDATE places k SET
  img=COALESCE(NULLIF(k.img,''),d.img), img_credit=COALESCE(NULLIF(k.img_credit,''),d.img_credit),
  img_author=COALESCE(NULLIF(k.img_author,''),d.img_author),
  lat=COALESCE(k.lat,d.lat), lng=COALESCE(k.lng,d.lng),
  description=COALESCE(NULLIF(k.description,''),d.description), teaser=COALESCE(NULLIF(k.teaser,''),d.teaser)
FROM places d WHERE k.id='wewelsburg' AND d.id='wewelsburg-castle';
DELETE FROM places WHERE id='wewelsburg-castle';

-- 4) The Stanley Hotel:  keeper 'the-stanley-hotel'  | dup 'stanley-hotel-estes-park'
UPDATE places k SET
  img=COALESCE(NULLIF(k.img,''),d.img), img_credit=COALESCE(NULLIF(k.img_credit,''),d.img_credit),
  img_author=COALESCE(NULLIF(k.img_author,''),d.img_author),
  lat=COALESCE(k.lat,d.lat), lng=COALESCE(k.lng,d.lng),
  description=COALESCE(NULLIF(k.description,''),d.description), teaser=COALESCE(NULLIF(k.teaser,''),d.teaser)
FROM places d WHERE k.id='the-stanley-hotel' AND d.id='stanley-hotel-estes-park';
DELETE FROM places WHERE id='stanley-hotel-estes-park';

-- 5) Myrtles Plantation:  keeper 'myrtles-plantation'  | dup 'myrtles-plantation-louisiana'
UPDATE places k SET
  img=COALESCE(NULLIF(k.img,''),d.img), img_credit=COALESCE(NULLIF(k.img_credit,''),d.img_credit),
  img_author=COALESCE(NULLIF(k.img_author,''),d.img_author),
  lat=COALESCE(k.lat,d.lat), lng=COALESCE(k.lng,d.lng),
  description=COALESCE(NULLIF(k.description,''),d.description), teaser=COALESCE(NULLIF(k.teaser,''),d.teaser)
FROM places d WHERE k.id='myrtles-plantation' AND d.id='myrtles-plantation-louisiana';
DELETE FROM places WHERE id='myrtles-plantation-louisiana';

COMMIT;

-- Verifiera efteråt:
-- SELECT lower(name) n, count(*) FROM places GROUP BY 1 HAVING count(*)>1 ORDER BY 2 DESC;
