-- Spökkartan — Berikning av 6 platser från Wikipedia
-- Genererad 2026-05-04. Källa: svenska och engelska Wikipedia.
-- VIKTIGT: Texterna är sammanställda direkt från Wikipedia-artiklarna.
--          Inga fakta är tillagda eller hittade på — bara översättning/komprimering.
-- Kör i Supabase SQL Editor.

BEGIN;

-- ───────────────────────────────────────────────────────────
-- 1. HÄRINGE SLOTT (Södermanland)
-- Källa: https://sv.wikipedia.org/wiki/Häringe_slott
-- ───────────────────────────────────────────────────────────
UPDATE places SET
  description = 'Häringe är ett tidigare säteri i Västerhaninge socken i Haninge kommun på Södertörn i Södermanland. Huvudbyggnaden uppfördes på 1650-talet och stod färdig 1657, på initiativ av Gustaf Horn.

Nuvarande byggnad i enkel karolinsk arkitektur skapades på 1770-talet under Fabian Löwen. Idag har huset två våningar under ett koppartäckt säteritak, och innehåller fem matsalar och sex salonger.

Häringe har under åren haft flera kända ägare, däribland Gustav II Adolf, Fabian Löwen, Torsten Kreuger, Axel Wenner-Gren och Olle Hartwig. Efter Kreugerkraschen förvärvades slottet 1934 av industrimannen Axel Wenner-Gren och hans hustru Marguerite Wenner-Gren. Under Wenner-Grens tid vistades många berömda gäster på slottet — Greta Garbo, Danny Kaye, Joséphine Baker, Karl Gerhard och Zarah Leander har alla varit där.

Sedan 2017 ägs anläggningen av Vesko Mijac, som driver hotell- och konferensverksamhet på slottet.

Källa: Wikipedia — https://sv.wikipedia.org/wiki/H%C3%A4ringe_slott',
  img = COALESCE(NULLIF(img,''), 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/H%C3%A4ringe_slott_2009b.jpg/1280px-H%C3%A4ringe_slott_2009b.jpg'),
  img_credit = COALESCE(NULLIF(img_credit,''), 'Wikipedia / Wikimedia Commons')
WHERE name = 'Häringe Slott';


-- ───────────────────────────────────────────────────────────
-- 2. BORGVATTNETS PRÄSTGÅRD (Jämtland)
-- Källa: https://en.wikipedia.org/wiki/Borgvattnet
-- ───────────────────────────────────────────────────────────
UPDATE places SET
  description = 'Borgvattnet är känt för sin gamla prästgård som byggdes 1876 — av många ansedd som en av Sveriges mest hemsökta byggnader. 1945 flyttade kaplan Erik Lindgren in i prästgården och började föra dagbok över alla underliga fenomen han upplevde. Dessa anteckningar blev grunden för platsens växande rykte.

I början av 1970-talet köptes prästgården av den lokala entreprenören Erik Brännholms, som omvandlade huset till ett vandrarhem. Övernattande gäster fick ett certifikat efter sin vistelse — som bevis på att de vågat sova i prästgården.

1981 verkade prästen Tore Forslund (kallad "spökprästen") i Borgvattnet och erbjöd byn att lyfta de andar som sägs hemsöka huset. Ritualen blev rikskänd, men prästgården fortsatte att rapporteras som aktiv.

Borgvattnet har även undersökts av det amerikanska TV-teamet Ghost Hunters International, som sände sitt avsnitt om platsen i januari 2009. Sedan dess har prästgården varit ett av de mest besökta målen för paranormala utredare i Sverige.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Borgvattnet',
  img = COALESCE(NULLIF(img,''), 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/Borgvattnets_pr%C3%A4stg%C3%A5rd.jpg/1280px-Borgvattnets_pr%C3%A4stg%C3%A5rd.jpg'),
  img_credit = COALESCE(NULLIF(img_credit,''), 'Wikipedia / Wikimedia Commons')
WHERE name = 'Borgvattnets Prästgård';


-- ───────────────────────────────────────────────────────────
-- 3. VADSTENA SLOTT (Östergötland)
-- Källa: https://sv.wikipedia.org/wiki/Vadstena_slott
-- ───────────────────────────────────────────────────────────
UPDATE places SET
  description = 'Vadstena slott byggdes ursprungligen av Gustav Vasa 1545 som en fästning för att skydda Stockholm från fiender som kunde komma söderifrån. Slottet var till en början rent militärt — men efter att Magnus Vasa utsetts till hertig av Östergötland ändrades planerna och byggnaden gjordes om till hertiglig residens.

När slottet stod färdigt 1620 hade alla Vasa-kungar bidragit till bygget. Sedan dess har det bevarats mycket väl, och räknas idag som ett av Sveriges främsta exempel på renässansarkitektur.

Slottet fungerade som kungligt residens fram till 1716, då kungafamiljen tappade intresset. Därefter användes slottet som spannmålsmagasin under flera decennier.

Sedan 1899 huserar landsarkivet i Vadstena slott. Idag finns även ett slottsmuseum med möbler, porträtt och målningar från 1500- och 1600-talen. Slottet är dessutom säte för Internationella Vadstena-akademien — Sveriges minsta operahus, som beställer nya operor och återupplivar bortglömda verk från arkivpartiturer.

Källa: Wikipedia — https://sv.wikipedia.org/wiki/Vadstena_slott',
  img = COALESCE(NULLIF(img,''), 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Vadstena_slott_april_2014.jpg/1280px-Vadstena_slott_april_2014.jpg'),
  img_credit = COALESCE(NULLIF(img_credit,''), 'Wikipedia / Wikimedia Commons')
WHERE name = 'Vadstena Slott';


-- ───────────────────────────────────────────────────────────
-- 4. GLIMMINGEHUS (Skåne)
-- Källa: https://en.wikipedia.org/wiki/Glimmingehus
-- ───────────────────────────────────────────────────────────
UPDATE places SET
  description = 'Glimmingehus byggdes 1499–1506, under en epok då Skåne var en vital del av Danmark. Borgen är fylld av tidstypiska försvarsanordningar — bröstvärn, falska dörrar och dödskorridorer, "mordhål" för att hälla ner kokande tjära över angripare, vallgravar, vindbroar och mer. Konstverket över borgens entré, beställt av Jens Holgersen Ulfstand, daterar grundläggandet till 1499.

Ulfstand var rådman, adelsman och amiral under den danske kungen Hans I. Några av Europas dyrbaraste föremål från den tiden — venetianskt glas, målat glas från Rhen-området och spansk keramik — har hittats på platsen.

Glimmingehus tjänade troligen som residens i bara några generationer innan det blev förvandlat till spannmålsmagasin. 1676 beordrade Karl XI förvaltningen i Skåne att riva borgen. 20 skånska bönder skickades först — utan resultat. En andra styrka på 130 män sändes ut, men innan de hann genomföra rivningen anlände en dansk-holländsk flottavdelning till Ystad och svenskarna fick avbryta.

Under hela 1700-talet användes huset som lagringsplats för jordbruksvaror. 1924 donerades Glimmingehus till svenska staten.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Glimmingehus',
  img = COALESCE(NULLIF(img,''), 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Glimmingehus_2014.jpg/1280px-Glimmingehus_2014.jpg'),
  img_credit = COALESCE(NULLIF(img_credit,''), 'Wikipedia / Wikimedia Commons')
WHERE name = 'Glimmingehus';


-- ───────────────────────────────────────────────────────────
-- 5. EKETORPS BORG (Öland)
-- Källa: https://sv.wikipedia.org/wiki/Eketorps_borg
-- ───────────────────────────────────────────────────────────
UPDATE places SET
  description = 'Eketorps borg är en järnåldersborg belägen på Stora alvaret i Gräsgårds socken i sydöstra Öland. Borgen utvidgades kraftigt under 400-talet och har under sin historia haft skiftande funktioner — från försvarsanläggning för bondebefolkningen till garnison för rytteri.

Inom borgens murar har 52 celler eller mindre byggnader hittats, vissa centralt placerade och andra inbyggda i ringmuren. Borgen övergavs i slutet av 600-talet och stod oanvänd fram till tidigt 1000-tal, då den byggdes upp på nytt — den gamla strukturen återanvändes men vissa inre stenkonstruktioner ersattes med timmer, och en andra försvarsmur lades till.

Eketorps borg är idag öppen för besökare och ett av Sveriges populäraste arkeologiska museer. Inne i borgen visas föremål från utgrävningarna, samt en utställning om Ölands totalt 15 fornborgar.

Källa: Wikipedia — https://sv.wikipedia.org/wiki/Eketorps_borg',
  img = COALESCE(NULLIF(img,''), 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Eketorp_borg_06.JPG/1280px-Eketorp_borg_06.JPG'),
  img_credit = COALESCE(NULLIF(img_credit,''), 'Wikipedia / Wikimedia Commons')
WHERE name = 'Eketorps Borg';


-- ───────────────────────────────────────────────────────────
-- 6. CARLSTENS FÄSTNING (Bohuslän)
-- Källa: https://sv.wikipedia.org/wiki/Karlstens_fästning
-- ───────────────────────────────────────────────────────────
UPDATE places SET
  description = 'Carlstens fästning byggdes på order av Karl X Gustav efter freden i Roskilde 1658, för att skydda den nyförvärvade provinsen Bohuslän mot fientliga angrepp. Marstrand valdes som plats tack vare sitt strategiska läge och tillgången till en isfri hamn.

Bygget genomfördes till stor del av straffångar, dömda till tvångsarbete på fästningen. Successiva utbyggnader fortsatte ända fram till 1860, då anläggningen slutligen ansågs färdigställd.

Efter 1800-talets utbyggnader betraktades fästningen internationellt som en av Europas starkaste befästningar. Den består av ett runt sjuvåningstorn omgivet av huggna vallgravar i berget och höga murar med fyra bastioner — allt byggt i granit.

Liksom många andra fästningar användes Carlsten även som fängelse fram till 1854. 1882 togs den ur rikets permanenta försvar. Den 25 januari 1935 förklarades fästningen som statligt skyddsobjekt och är idag ett byggnadsminne.

Källa: Wikipedia — https://sv.wikipedia.org/wiki/Karlstens_f%C3%A4stning',
  img = COALESCE(NULLIF(img,''), 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/Carlstens_f%C3%A4stning.jpg/1280px-Carlstens_f%C3%A4stning.jpg'),
  img_credit = COALESCE(NULLIF(img_credit,''), 'Wikipedia / Wikimedia Commons')
WHERE name = 'Carlsten fästning' OR name = 'Carlstens fästning' OR name = 'Karlstens fästning';


COMMIT;

-- Verifiera resultatet:
-- SELECT name, length(description) AS desc_len, length(img) AS img_len
-- FROM places
-- WHERE name IN ('Häringe Slott','Borgvattnets Prästgård','Vadstena Slott','Glimmingehus','Eketorps Borg','Carlsten fästning','Carlstens fästning','Karlstens fästning');
