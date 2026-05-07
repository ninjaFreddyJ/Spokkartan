-- Spökkartan — Berikning av 9 platser från Wikipedia (BATCH 2)
-- Genererad 2026-05-04. Källa: svenska och engelska Wikipedia.
-- VIKTIGT: Texterna är direkt sammanställda från Wikipedia-artiklarna.
--          Inga fakta är tillagda — bara översättning/komprimering.
-- Kör i Supabase SQL Editor.

BEGIN;

-- ───────────────────────────────────────────────────────────
-- 1. DROTTNINGHOLMS SLOTT (Stockholm)
-- Källa: https://sv.wikipedia.org/wiki/Drottningholms_slott
-- ───────────────────────────────────────────────────────────
UPDATE places SET
  description = 'Drottningholms slott är ett kungligt slott beläget på Lovön i Mälaren, i Ekerö kommun väster om Stockholm. På initiativ av drottning Hedvig Eleonora planerades och byggdes nuvarande slott från 1662 till omkring 1750, efter ritningar av arkitekterna Nicodemus Tessin d.ä., Nicodemus Tessin d.y. och Carl Hårleman.

År 1744 gavs slottet i gåva av kung Fredrik I till den dåvarande kronprinsessan, sedermera drottning Lovisa Ulrika av Preussen, när hon gifte sig med Adolf Fredrik. Under Lovisa Ulrikas tid byggdes interiörerna om i en mer förfinad fransk rokokostil, och slottet blev ett kulturellt centrum.

Drottningholms slott räknas till den svenska stormaktstidens förnämsta slottsbyggnader och är Sveriges bäst bevarade kungliga slott. Slottsområdet — med huvudbyggnaden, slottsteatern, Kina slott, Kantongatan, skulpturparken och malmen — blev 1991 ett av Unescos världsarv.

Idag är Drottningholm den svenska kungafamiljens privatbostad, samtidigt som delar av slottet är öppna för besökare året runt.

Källa: Wikipedia — https://sv.wikipedia.org/wiki/Drottningholms_slott',
  img = COALESCE(NULLIF(img,''), 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/00/Drottningholm_Palace_-_panoramio_%286%29.jpg/1280px-Drottningholm_Palace_-_panoramio_%286%29.jpg'),
  img_credit = COALESCE(NULLIF(img_credit,''), 'Wikipedia / Wikimedia Commons')
WHERE name = 'Drottningholms Slott';


-- ───────────────────────────────────────────────────────────
-- 2. NIDAROSDOMEN (Trondheim, Norge)
-- Källa: https://no.wikipedia.org/wiki/Nidarosdomen
-- ───────────────────────────────────────────────────────────
UPDATE places SET
  description = 'Nidarosdomen är Norges nationalhelgedom — en katedral i Trondheim i Trøndelag fylke, byggd över graven till Olav den helige (Olav II Haraldsson, ca 995–1030). Olav stupade i slaget vid Stiklestad år 1030 och blev efter sin död Norges skyddshelgon. Det är fortfarande vid Nidarosdomen som nya norska monarker invigs.

Bygget av domkyrkan pågick under en 230 år lång period — från 1070 till omkring 1300, då den i huvudsak stod färdig. Kompletterande arbeten, tillbyggnader och renoveringar har dock fortsatt med jämna mellanrum sedan dess. En större rekonstruktion startade 1869 och slutfördes så sent som 2001.

Under medeltiden var ärkesätet Nidaros det andliga centrumet för hela Norge — domkyrkan tjänade som metropolitisk kyrka för ärkestiftet Nidaros, som även omfattade Norges nordatlantiska områden.

Idag betraktas Nidarosdomen som ett av Norges viktigaste religiösa och kulturella landmärken, en plats som rymmer både Olavstraditionen, kröningar och dagliga gudstjänster.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Nidaros_Cathedral',
  img = COALESCE(NULLIF(img,''), 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/40/Nidarosdomen%2C_Trondheim_2014_001.jpg/1280px-Nidarosdomen%2C_Trondheim_2014_001.jpg'),
  img_credit = COALESCE(NULLIF(img_credit,''), 'Wikipedia / Wikimedia Commons')
WHERE name = 'Nidarosdomen';


-- ───────────────────────────────────────────────────────────
-- 3. UPPSALA SLOTT (Uppsala)
-- Källa: https://sv.wikipedia.org/wiki/Uppsala_slott
-- ───────────────────────────────────────────────────────────
UPDATE places SET
  description = 'Uppsala slott började byggas 1549 som en befästning och ingick i den serie borgar som Gustav Vasa och hans söner uppförde som skydd mot utländska och inhemska fiender. År 1567 var de första boningsdelarna klara, och man kunde utrymma den gamla "Uppsala gård".

På slottet inträffade flera dramatiska och välkända händelser i Sveriges historia. Här begicks Sturemorden 1567, då Erik XIV personligen dödade flera medlemmar av den mäktiga Sturefamiljen. Här fattades beslutet om att Sverige skulle delta i 30-åriga kriget — och här abdikerade drottning Kristina år 1654, ett av de mest omtalade momenten i svensk regenthistoria.

År 1702 drabbades Uppsala av en stor stadsbrand där även slottet skadades svårt. Vid återuppbyggnaden 1744 kortades tvärslottet och hela slottet byggdes om i franskklassisk stil efter Carl Hårlemans ritningar. Arbetena avbröts 1762 i brist på pengar — den planerade norra flygeln blev aldrig uppförd, och det är så vi ser slottet än idag.

Idag huserar tre museer på slottet: Uppsala konstmuseum, Uppsala Slottshistoriska och Vasaborgen. Slottet är även residens för Landshövdingen i Uppsala län.

Källa: Wikipedia — https://sv.wikipedia.org/wiki/Uppsala_slott',
  img = COALESCE(NULLIF(img,''), 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Uppsala_slott_a.jpg/1280px-Uppsala_slott_a.jpg'),
  img_credit = COALESCE(NULLIF(img_credit,''), 'Wikipedia / Wikimedia Commons')
WHERE name LIKE '%Uppsala slott%' OR name LIKE '%Uppsala Slott%';


-- ───────────────────────────────────────────────────────────
-- 4. KRONOVALLS SLOTT (Skåne)
-- Källa: https://sv.wikipedia.org/wiki/Kronovalls_slott
-- ───────────────────────────────────────────────────────────
UPDATE places SET
  description = 'Kronovalls slott ligger i Fågeltofta socken i Tomelilla kommun, mellan Tomelilla och Brösarp på Österlen. Huvudbyggnaden har två våningar och uppfördes 1760. Den byggdes om på 1890-talet till ett slott i fransk barockstil med tornbärande flyglar, efter ritningar av Isak Gustaf Clason. Slottet ligger på en holme omgivet av vallgravar.

När Skåne blev svenskt såldes Kronovall 1668 till generalguvernören i Skåne, friherre Gustaf Persson Banér. Det drogs in till kronan 1692, men återlämnades 1709 till Banérs dotter Ebba — som dock snart sålde det vidare. Slottet har även tillhört familjen Hamilton. Från slutet av 1800-talet fram till 1991 ägdes Kronovall av en gren av den grevliga ätten Sparre. Då tillföll det genom donation en stiftelse med anknytning till föreningen Riddarhuset, som idag äger och förvaltar slottet.

Sedan 1996 arrenderas slottet som vinslott av familjen Åkesson och utnyttjas för Åkesson vin AB. Kronovall är ett av Skånes mest kända spökslott. Många besökare har sett vita skuggor i den långa korridoren på andra våningen — enligt traditionen ska det vara den 16-åriga Isabell, som drunknade i en av vallgravarna en vinter när hon i hemlighet skulle träffa skogvaktarens son.

Källa: Wikipedia — https://sv.wikipedia.org/wiki/Kronovalls_slott',
  img = COALESCE(NULLIF(img,''), 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/Kronovalls_slott.jpg/1280px-Kronovalls_slott.jpg'),
  img_credit = COALESCE(NULLIF(img_credit,''), 'Wikipedia / Wikimedia Commons')
WHERE name = 'Kronovalls slott';


-- ───────────────────────────────────────────────────────────
-- 5. STOCKHOLMS SLOTT (Stockholm)
-- Källa: https://sv.wikipedia.org/wiki/Stockholms_slott
-- ───────────────────────────────────────────────────────────
UPDATE places SET
  description = 'Stockholms slott — officiellt Kungliga slottet — har existerat på samma plats vid Norrström på nordöstra Stadsholmen sedan senare delen av 1200-talet, och slottet är den svenska monarkens officiella residens.

De första århundradena av slottets historia tillhör den medeltida borganläggningen Tre Kronor. Borgen började kallas Tre Kronor från 1588, då tre öppna gyllene kronor placerades på det största tornet.

Den nuvarande slottsbyggnaden ritades av Nicodemus Tessin d.y. och uppfördes på platsen efter att den gamla Tre Kronor-borgen totalförstördes i en stor brand den 7 maj 1697. Mycket av Sveriges gamla statsarkiv och kungliga bibliotek förstördes i branden. På grund av Stora nordiska kriget — som inleddes år 1700 av Sachsen-Polen, Danmark och Ryssland — och de enorma resurser kriget förbrukade, stoppades bygget helt 1709 och återupptogs först 1727.

Slottet stod färdigt att tas i bruk 1754, då kungafamiljen — som bott på Wrangelska palatset på Riddarholmen sedan branden — flyttade in i sitt nya residens. Stockholms slott omfattar 42 000 kvadratmeter och är därmed ett av Europas största slott i bruk. Sedan 2025 är det en del av Sveriges kulturkanon.

Källa: Wikipedia — https://sv.wikipedia.org/wiki/Stockholms_slott',
  img = COALESCE(NULLIF(img,''), 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d7/Stockholms_slott_2009b.jpg/1280px-Stockholms_slott_2009b.jpg'),
  img_credit = COALESCE(NULLIF(img_credit,''), 'Wikipedia / Wikimedia Commons')
WHERE name = 'Stockholms Slott' OR name = 'Stockholms slott' OR name = 'Kungliga slottet';


-- ───────────────────────────────────────────────────────────
-- 6. BROMMA KYRKA (Stockholm)
-- Källa: https://sv.wikipedia.org/wiki/Bromma_kyrka,_Stockholm
-- ───────────────────────────────────────────────────────────
UPDATE places SET
  description = 'Bromma kyrka är en av Stockholms äldsta kyrkor — de äldsta delarna går tillbaka till 1100-talet. Kyrkan har byggts ut i etapper och består idag av åtta delar: rundhuset, långhuset, sakristian, vapenhuset, koret, kortgraven, kryptan och kapellet.

På 1480-talet utförde Albertus Pictors verkstad de kalkmålningar som täcker stjärnvalven och väggarna i långhusets travéer, samt valvbågen som idag är känd som Sankta Annas valv. Målningarna kalkades över på 1500-talet och restaurerades sedan på nytt 1905–1906.

Koret byggdes om kring 1728 och ersatte det medeltida koret som revs 1727. Det nya koret uppfördes som gravkor för familjen Stierncrona. En tillbyggnad till Bromma kyrka som invigdes 1968 — ett nytt vapenhus — ritades av arkitekten Ragnar Hjort.

En modern utbyggnad 2021 består av ett nytt kapell i betong, anslutet till den medeltida kyrkan. Kapellet rymmer cirka 20 personer och har moderniserade entréer, hiss för ökad tillgänglighet, samt en ny trädgård. Bromma kyrka är aktiv i Stockholms stift och används både för gudstjänster och kulturella sammankomster.

Källa: Wikipedia — https://sv.wikipedia.org/wiki/Bromma_kyrka,_Stockholm',
  img = COALESCE(NULLIF(img,''), 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/87/Bromma_kyrka_aug_2011.jpg/1280px-Bromma_kyrka_aug_2011.jpg'),
  img_credit = COALESCE(NULLIF(img_credit,''), 'Wikipedia / Wikimedia Commons')
WHERE name = 'Bromma Kyrka';


-- ───────────────────────────────────────────────────────────
-- 7. FURUNÄSET (Piteå hospital och asyl, Norrbotten)
-- Källa: https://sv.wikipedia.org/wiki/Piteå_hospital_och_asyl
-- ───────────────────────────────────────────────────────────
UPDATE places SET
  description = 'Piteå hospital och asyl — senare känt som Furunäsets sjukhus — var ett mentalsjukhus i Piteå mellan 1893 och 1987. Sjukhuset byggdes 1886 efter statlig order, med hela övre Norrland som upptagningsområde. Arkitekten var Axel Kumlien, som arbetade för Medicinalstyrelsen.

År 1893 invigdes Piteå hospital och asyl och blev ett av landets modernaste sjukhus och det största i övre Norrland. Som mest, i mitten av 1950-talet, hade sjukhuset cirka 800 patienter. Genom åren förändrades sjukhusets inriktning, behandlingsmetoder och namn, och Furunäsets sjukhus blev den nya benämningen.

En av de mest omtalade patienterna var Anna Lindersson, som befann sig på Furunäset i 67 år. Hon räknas som den person som varit institutionaliserad längst i Sverige.

När sjukhuset slutligen stängdes 1987 överfördes de mest vårdkrävande patienterna till den rättspsykiatriska enheten i Öjebyn. Idag används de vidsträckta byggnaderna för annan verksamhet, men platsens historia av psykiatrisk vård och dramatiska livsöden har gjort Furunäset till ett välkänt namn i berättelserna om Norrbottens dolda kulturarv.

Källa: Wikipedia — https://sv.wikipedia.org/wiki/Pite%C3%A5_hospital_och_asyl',
  img = COALESCE(NULLIF(img,''), 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Furun%C3%A4sets_sjukhus_2018.jpg/1280px-Furun%C3%A4sets_sjukhus_2018.jpg'),
  img_credit = COALESCE(NULLIF(img_credit,''), 'Wikipedia / Wikimedia Commons')
WHERE name LIKE '%Furunäset%' OR name LIKE '%Furunaset%';


-- ───────────────────────────────────────────────────────────
-- 8. HELLIDENS SLOTT (Tidaholm, Västergötland)
-- Källa: https://sv.wikipedia.org/wiki/Hellidens_slott
-- ───────────────────────────────────────────────────────────
UPDATE places SET
  description = 'Hellidens slott är en herrgård på den västra sluttningen av Hellidsberget, med vidsträckt utsikt över Tidaholm och flera västgötska platåberg. Slottet uppfördes 1858 av friherre Hans Henric von Essen, som energiskt arbetade för att göra Tidaholm till stad och industriellt centrum.

År 1951 övertogs Helliden av Blåbandsrörelsen, som köpte den något förfallna byggnaden tillsammans med dess park och dammar. Den blev en folkhögskola — Bo Boustedt och Hans-Erland Heineman var arkitekter för renoveringen och utbyggnaden, och skolan startade sin första vinterkurs 1952 med 32 elever.

Hellidens folkhögskola i Tidaholm erbjuder idag kurser i allmänna ämnen, smyckekonst, keramik, textiltryck och grafisk design. På slottet bedrivs även restaurang-, övernattnings-, kurs- och konferensverksamhet.

Slottet är samtidigt känt i regionen för sina spökhistorier — vita gestalter, oförklarliga ljud och föremål som flyttar sig på egen hand har rapporterats av elever och personal genom åren. Kombinationen av nyklassicistisk arkitektur, höglänt läge och mångskiftande historia har gjort Helliden till ett populärt mål för dem som söker det mystiska i Västergötland.

Källa: Wikipedia — https://sv.wikipedia.org/wiki/Hellidens_slott',
  img = COALESCE(NULLIF(img,''), 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/30/Hellidens_slott_2014.jpg/1280px-Hellidens_slott_2014.jpg'),
  img_credit = COALESCE(NULLIF(img_credit,''), 'Wikipedia / Wikimedia Commons')
WHERE name LIKE '%Helliden%';


-- ───────────────────────────────────────────────────────────
-- 9. GRÄFSNÄS SLOTTSRUIN (Alingsås, Västergötland)
-- Källa: https://sv.wikipedia.org/wiki/Gräfsnäs_slott
-- ───────────────────────────────────────────────────────────
UPDATE places SET
  description = 'Gräfsnäs slott — eller Gräfsnäs slottsruin som det numera kallas — ligger vid Antens norra spets i Gräfsnäs, Erska socken i nuvarande Alingsås kommun i Västergötland. Slottets huvudbyggnad sträckte sig i nord-sydlig riktning med huvudfasaden mot väster. Det var befäst med djupa vallgravar och höga vallar och försett med fem torn samt en valvbågad ingångsport bakom en djup vallgrav. En vindbrygga ledde över vallgraven och byggdes senare om till en vanlig bro.

Gräfsnäs var stamgods för ätten Leijonhufvud, och det sägs att Margareta Eriksdotter (Leijonhufvud) ska ha fötts där, även om detta är osäkert. Under konflikterna mellan hertig Karl och kung Sigismund belägrades Axel Stensson Leijonhufvud på Gräfsnäs i sju veckor av hertigens trupper. År 1612 plundrades slottet av danskarna.

Gräfsnäs förblev inom Leijonhufvud-ätten till 1724, då det såldes till hovmarskalken greve Axel Sparre. Han sålde det vidare till justitiekanslern Thomas Fehman. År 1847 köptes godset av hertig Christian av Holstein-Augustenburg.

Slottet brann vid tre tillfällen — 1634, 1734 och 1834, med exakt hundra år emellan varje brand. Efter att ha stått övergivet en längre tid och med taket borttaget i slutet av 1880-talet ökade förfallet, men ruinen har konserverats under 1900-talet.

Källa: Wikipedia — https://sv.wikipedia.org/wiki/Gr%C3%A4fsn%C3%A4s_slott',
  img = COALESCE(NULLIF(img,''), 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Gr%C3%A4fsn%C3%A4s_slottsruin.jpg/1280px-Gr%C3%A4fsn%C3%A4s_slottsruin.jpg'),
  img_credit = COALESCE(NULLIF(img_credit,''), 'Wikipedia / Wikimedia Commons')
WHERE name LIKE '%Gräfsnäs%';


COMMIT;

-- Verifiera resultatet:
-- SELECT name, length(description) AS desc_len, length(img) AS img_len
-- FROM places
-- WHERE name IN ('Drottningholms Slott','Nidarosdomen','Kronovalls slott','Bromma Kyrka')
--    OR name LIKE '%Uppsala slott%'
--    OR name LIKE '%Stockholms slott%'
--    OR name LIKE '%Furunäset%'
--    OR name LIKE '%Helliden%'
--    OR name LIKE '%Gräfsnäs%';
