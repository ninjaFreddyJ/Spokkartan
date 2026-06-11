-- ============================================================
-- Spökkartan — DEDUP (komplett). Idempotent — säker att köra om.
-- Genererad 2026-06-10.
--
-- Kör EFTER SYNC_TO_HAUNTEDPLACES.sql (den berikar keeper-radernas text först).
--
-- DEL A: tar bort de 6 fel-slug-rader som kan ha hamnat live när tidigare
--        versioner av batch-filerna kördes (mitt innehåll ligger nu på den
--        kanoniska raden via SYNC). DELETE av rad som inte finns = 0 rader (ofarligt).
-- DEL B: slår ihop 5 dubbletter som fanns i datan redan innan (WordPress-import
--        09 vs senare batch-filer 21/23/24).
--
-- Alla merges använder COALESCE -> skriver ALDRIG över befintlig bild/koordinat/text.
-- ⚠️ Om någon tabell refererar place-id (t.ex. hunter_visits) — flytta referensen
--    till keeper innan DELETE (se exempelrad).
-- ============================================================

BEGIN;

-- Generisk merge: fyll keeper (k) med dubblettens (d) ev. saknade fält.
-- Mönstret upprepas per par nedan.

-- ---------- DEL A: mina tidigare fel-slug-dubbletter ----------
-- (keeper = kanonisk befintlig rad | dup = min tidigare fel slug)

-- Beelitz-Heilstätten
UPDATE places k SET img=COALESCE(NULLIF(k.img,''),d.img), img_credit=COALESCE(NULLIF(k.img_credit,''),d.img_credit), img_author=COALESCE(NULLIF(k.img_author,''),d.img_author), lat=COALESCE(k.lat,d.lat), lng=COALESCE(k.lng,d.lng), description=COALESCE(NULLIF(k.description,''),d.description), teaser=COALESCE(NULLIF(k.teaser,''),d.teaser)
FROM places d WHERE k.id='beelitz-heilstatten' AND d.id='beelitz-heilstaetten';
DELETE FROM places WHERE id='beelitz-heilstaetten';

-- RMS Queen Mary
UPDATE places k SET img=COALESCE(NULLIF(k.img,''),d.img), img_credit=COALESCE(NULLIF(k.img_credit,''),d.img_credit), img_author=COALESCE(NULLIF(k.img_author,''),d.img_author), lat=COALESCE(k.lat,d.lat), lng=COALESCE(k.lng,d.lng), description=COALESCE(NULLIF(k.description,''),d.description), teaser=COALESCE(NULLIF(k.teaser,''),d.teaser)
FROM places d WHERE k.id='queen-mary-long-beach' AND d.id='rms-queen-mary';
DELETE FROM places WHERE id='rms-queen-mary';

-- Whaley House
UPDATE places k SET img=COALESCE(NULLIF(k.img,''),d.img), img_credit=COALESCE(NULLIF(k.img_credit,''),d.img_credit), img_author=COALESCE(NULLIF(k.img_author,''),d.img_author), lat=COALESCE(k.lat,d.lat), lng=COALESCE(k.lng,d.lng), description=COALESCE(NULLIF(k.description,''),d.description), teaser=COALESCE(NULLIF(k.teaser,''),d.teaser)
FROM places d WHERE k.id='whaley-house-san-diego' AND d.id='whaley-house';
DELETE FROM places WHERE id='whaley-house';

-- The Stanley Hotel
UPDATE places k SET img=COALESCE(NULLIF(k.img,''),d.img), img_credit=COALESCE(NULLIF(k.img_credit,''),d.img_credit), img_author=COALESCE(NULLIF(k.img_author,''),d.img_author), lat=COALESCE(k.lat,d.lat), lng=COALESCE(k.lng,d.lng), description=COALESCE(NULLIF(k.description,''),d.description), teaser=COALESCE(NULLIF(k.teaser,''),d.teaser)
FROM places d WHERE k.id='the-stanley-hotel' AND d.id='stanley-hotel';
DELETE FROM places WHERE id='stanley-hotel';

-- LaLaurie Mansion
UPDATE places k SET img=COALESCE(NULLIF(k.img,''),d.img), img_credit=COALESCE(NULLIF(k.img_credit,''),d.img_credit), img_author=COALESCE(NULLIF(k.img_author,''),d.img_author), lat=COALESCE(k.lat,d.lat), lng=COALESCE(k.lng,d.lng), description=COALESCE(NULLIF(k.description,''),d.description), teaser=COALESCE(NULLIF(k.teaser,''),d.teaser)
FROM places d WHERE k.id='lalaurie-mansion-new-orleans' AND d.id='lalaurie-mansion';
DELETE FROM places WHERE id='lalaurie-mansion';

-- Trans-Allegheny Lunatic Asylum
UPDATE places k SET img=COALESCE(NULLIF(k.img,''),d.img), img_credit=COALESCE(NULLIF(k.img_credit,''),d.img_credit), img_author=COALESCE(NULLIF(k.img_author,''),d.img_author), lat=COALESCE(k.lat,d.lat), lng=COALESCE(k.lng,d.lng), description=COALESCE(NULLIF(k.description,''),d.description), teaser=COALESCE(NULLIF(k.teaser,''),d.teaser)
FROM places d WHERE k.id='trans-allegheny-lunatic-asylum' AND d.id='trans-allegheny-asylum';
DELETE FROM places WHERE id='trans-allegheny-asylum';

-- ---------- DEL B: pre-existerande dubbletter i datan ----------
-- ⚠️ Granska: flytta ev. referenser innan DELETE, t.ex.
-- UPDATE hunter_visits SET place_id='chateau-de-brissac' WHERE place_id='ch-teau-de-brissac';

-- Château de Brissac
UPDATE places k SET img=COALESCE(NULLIF(k.img,''),d.img), img_credit=COALESCE(NULLIF(k.img_credit,''),d.img_credit), img_author=COALESCE(NULLIF(k.img_author,''),d.img_author), lat=COALESCE(k.lat,d.lat), lng=COALESCE(k.lng,d.lng), description=COALESCE(NULLIF(k.description,''),d.description), teaser=COALESCE(NULLIF(k.teaser,''),d.teaser)
FROM places d WHERE k.id='chateau-de-brissac' AND d.id='ch-teau-de-brissac';
DELETE FROM places WHERE id='ch-teau-de-brissac';

-- Pluckley
UPDATE places k SET img=COALESCE(NULLIF(k.img,''),d.img), img_credit=COALESCE(NULLIF(k.img_credit,''),d.img_credit), img_author=COALESCE(NULLIF(k.img_author,''),d.img_author), lat=COALESCE(k.lat,d.lat), lng=COALESCE(k.lng,d.lng), description=COALESCE(NULLIF(k.description,''),d.description), teaser=COALESCE(NULLIF(k.teaser,''),d.teaser)
FROM places d WHERE k.id='pluckley' AND d.id='pluckley-village';
DELETE FROM places WHERE id='pluckley-village';

-- Wewelsburg
UPDATE places k SET img=COALESCE(NULLIF(k.img,''),d.img), img_credit=COALESCE(NULLIF(k.img_credit,''),d.img_credit), img_author=COALESCE(NULLIF(k.img_author,''),d.img_author), lat=COALESCE(k.lat,d.lat), lng=COALESCE(k.lng,d.lng), description=COALESCE(NULLIF(k.description,''),d.description), teaser=COALESCE(NULLIF(k.teaser,''),d.teaser)
FROM places d WHERE k.id='wewelsburg' AND d.id='wewelsburg-castle';
DELETE FROM places WHERE id='wewelsburg-castle';

-- The Stanley Hotel (seed-dubblett)
UPDATE places k SET img=COALESCE(NULLIF(k.img,''),d.img), img_credit=COALESCE(NULLIF(k.img_credit,''),d.img_credit), img_author=COALESCE(NULLIF(k.img_author,''),d.img_author), lat=COALESCE(k.lat,d.lat), lng=COALESCE(k.lng,d.lng), description=COALESCE(NULLIF(k.description,''),d.description), teaser=COALESCE(NULLIF(k.teaser,''),d.teaser)
FROM places d WHERE k.id='the-stanley-hotel' AND d.id='stanley-hotel-estes-park';
DELETE FROM places WHERE id='stanley-hotel-estes-park';

-- Myrtles Plantation (seed-dubblett)
UPDATE places k SET img=COALESCE(NULLIF(k.img,''),d.img), img_credit=COALESCE(NULLIF(k.img_credit,''),d.img_credit), img_author=COALESCE(NULLIF(k.img_author,''),d.img_author), lat=COALESCE(k.lat,d.lat), lng=COALESCE(k.lng,d.lng), description=COALESCE(NULLIF(k.description,''),d.description), teaser=COALESCE(NULLIF(k.teaser,''),d.teaser)
FROM places d WHERE k.id='myrtles-plantation' AND d.id='myrtles-plantation-louisiana';
DELETE FROM places WHERE id='myrtles-plantation-louisiana';

COMMIT;

-- Verifiera (ska ge 0 rader):
-- SELECT lower(name) n, count(*) c FROM places GROUP BY 1 HAVING count(*)>1 ORDER BY c DESC;
