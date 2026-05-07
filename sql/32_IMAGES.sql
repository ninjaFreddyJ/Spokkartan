-- Spökkartan — UPDATE: bilder från Wikimedia Commons
-- Genererad 2026-05-06.
-- Källa: Wikimedia Commons (verifierade filnamn via WebSearch)
-- URL-format: https://commons.wikimedia.org/wiki/Special:FilePath/{filename}
-- (Special:FilePath auto-redirectar till upload.wikimedia.org/wikipedia/commons/...)
--
-- Endast platser där filnamn verifierats via Wikimedia Commons.
-- Övriga lämnas NULL och berikas senare.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- ============================================================
-- ASIEN
-- ============================================================
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/ForbiddenCity-59f.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY 4.0' WHERE id = 'forbidden-city';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Aokigahara_forest_03.jpg', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'aokigahara-forest';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Himeji_castle.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'himeji-castle';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Sunshine_60.JPG', img_credit = 'Wikimedia Commons / Kakidai', img_author = 'CC BY-SA 3.0' WHERE id = 'sunshine-60';

-- ============================================================
-- AUSTRALIEN
-- ============================================================
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Port_Arthur%2C_Tasmania.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY 4.0' WHERE id = 'port-arthur';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Aradale_Mental_Hospital.jpg', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'aradale-asylum';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Fremantle_prison_main_cellblock.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'fremantle-prison';

-- ============================================================
-- AFRIKA
-- ============================================================
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/The_Castle_of_Good_Hope%2C_Cape_Town.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA 3.0' WHERE id = 'castle-good-hope';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Baron_Empain_Palace.jpg', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'baron-empain-palace';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Kolmanskop_Ghost_Town_Buildings.jpg', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'kolmanskop';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Giza-pyramids.JPG', img_credit = 'Wikimedia Commons', img_author = 'Public domain' WHERE id = 'pyramids-of-giza';

-- ============================================================
-- EUROPA — UK
-- ============================================================
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/White_Tower%2C_London%2C_August_2014.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'tower-of-london';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Edinburgh_Castle_from_the_North.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'edinburgh-castle';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Hampton_Court_Palace_20120224.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'hampton-court-palace';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Glamis_castle.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'glamis-castle';

-- ============================================================
-- EUROPA — ÖST/CENTRAL/NORDEN
-- ============================================================
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/CastelulBran.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'bran-castle';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Sedlec_Ossuary_chandelier.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'sedlec-ossuary';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Hill_of_Crosses%2C_Lithuania.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'hill-of-crosses';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Wewelsburg.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'wewelsburg-castle';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Wawel_on_Wisla.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'wawel-castle';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/10th_anniversary_of_Slovene_Wikipedia_-_Predjama_castle.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'predjama-castle';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Suomenlinna_aerial.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'suomenlinna';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Poiana_Rotunda_%28The_Round_Meadow%29%2C_most_haunted_place_in_Hoia_Baciu.jpg', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'hoia-baciu-forest';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Borgvattnet%27s_vicarage_%28Mr_Thinktank%29_4_-_Flickr.jpg', img_credit = 'Wikimedia Commons / Mr Thinktank', img_author = 'CC BY' WHERE id = 'borgvattnet-prastgard';

-- ============================================================
-- EUROPA — SYD
-- ============================================================
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Coliseum-of-Rome.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'colosseum';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Cimitero_dei_Cappuccini_a_Palermo.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'catacombe-cappuccini';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Evora_capela_dos_ossos.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'capela-dos-ossos-evora';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Belchite_-_Iglesia_de_San_Marin_-_Fachada01.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'belchite';

-- ============================================================
-- EUROPA — FRANKRIKE
-- ============================================================
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Catacombes_de_Paris.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'catacombs-of-paris';

-- ============================================================
-- USA
-- ============================================================
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Stanley_in_Snow.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'stanley-hotel-estes-park';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Myrtles_Plantation_Louisiana.jpg', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'myrtles-plantation-louisiana';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Lizzie_Borden_House_%28Bed_Breakfast%29_%283535957840%29.jpg', img_credit = 'Wikimedia Commons', img_author = 'CC BY' WHERE id = 'lizzie-borden-house';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Whaley_House_in_Old_Town_San_Diego.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'whaley-house-san-diego';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Crescent_Hotel_%28cropped%29.jpg', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'crescent-hotel-eureka-springs';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/The_LaLaurie_Mansion.jpg', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'lalaurie-mansion-new-orleans';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Eastern_State_Penitentiary_-_Cell_blocks_1.jpg', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'eastern-state-penitentiary';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Exterior_of_the_alcatraz_jailhouse.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'alcatraz-island';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Queen_Mary_Long_Beach.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'queen-mary-long-beach';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Hollywood_Sign.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'hollywood-sign-peg-entwistle';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Hotel_del_Coronado.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY 3.0' WHERE id = 'hotel-del-coronado';

-- ============================================================
-- SYDAMERIKA
-- ============================================================
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Edif%C3%ADcio_Joelma.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'edificio-joelma';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Edif%C3%ADcio_Martinelli_01.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'edificio-martinelli';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Buenos_Aires-Recoleta-Cementery-P2090035.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'recoleta-cemetery';
UPDATE places SET img = 'https://commons.wikimedia.org/wiki/Special:FilePath/Matusita-k_PICT0719-4.JPG', img_credit = 'Wikimedia Commons', img_author = 'CC BY-SA' WHERE id = 'casa-matusita';

-- Verifiering: räkna platser med bild
-- SELECT COUNT(*) AS med_bild FROM places WHERE img IS NOT NULL;
-- SELECT COUNT(*) AS utan_bild FROM places WHERE img IS NULL;

COMMIT;
