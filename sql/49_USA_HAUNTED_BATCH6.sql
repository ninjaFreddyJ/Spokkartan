-- Spökkartan — 4 fler hemsökta platser i USA, omgång 6
-- Genererad 2026-06-09. Kompletterar 21/22/40_USA (Stanley, Myrtles, Winchester,
-- Eastern State, Alcatraz, Waverly Hills, Queen Mary, Lemp m.fl. — utelämnas här).
--
-- METOD: engelska sökord (haunted, ghosts, most haunted) -> sidor som samlat
-- spökhistorier (usghostadventures.com, Legends of America, ghostcitytours.com,
-- Atlas Obscura m.fl. samt engelska Wikipedia). Skrivet på SVENSKA, 200-600
-- ord/plats, aldrig fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. OHIO STATE REFORMATORY (USA) — Shawshank-fängelset
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'ohio-state-reformatory','Ohio State Reformatory','ohio-state-reformatory','USA','Ohio, Mansfield','Fängelse',
  40.7900,-82.5030,4,false,true,NULL,
  'Filmkulissen för "The Shawshank Redemption" — och ett av världens mest hemsökta fängelser.',
  'Ohio State Reformatory i Mansfield i Ohio öppnade 1896 efter tio års byggande. Anstalten inhyste från början förstagångsförbrytare, som fördes hit för att få struktur och stöd att ställa sina liv till rätta. På 1970-talet hade den dock blivit en högsäkerhetsanstalt, där fångarna tillbringade större delen av dygnet i celler så små som drygt två gånger en och en halv meter.

Den 31 december 1990 fördes de sista fångarna till en annan anstalt och reformatoriet stängde. Byggnaden stod tom i flera år, men blev världsberömd som inspelningsplats för den Oscarsnominerade filmen "The Shawshank Redemption" 1993.

Idag räknas OSR till världens mest hemsökta fängelser. Tv-program som Ghost Brothers och Destination Fear har undersökt platsen och fångat anmärkningsvärda belägg. Ljudet av kedjor som faller mot golvet, morrningar, steg och kyrkklockor har hörts i vissa delar av fängelset, liksom spöklika dofter, kroppslösa röster och ljusklot.

Flera fångar berättade om en kvinna som brukade besöka cellblocken och stoppa om deras filtar nattetid — fast ingen sådan kvinna fanns. Somliga menar att det är anden efter en sjuksköterska som mördades i fängelset många år tidigare, som ännu vakar över de intagna i de kalla, ekande korridorerna.

Källa: Engelska Wikipedia "Ohio State Reformatory" + usghostadventures.com + ohiomagazine.com + mrps.org',
  NULL,NULL,NULL,true,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. WEST VIRGINIA PENITENTIARY (USA) — Shadow Man
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'wv-penitentiary-moundsville','West Virginia Penitentiary','wv-penitentiary-moundsville','USA','West Virginia, Moundsville','Fängelse',
  39.9200,-80.7440,5,false,true,NULL,
  'Byggt på en indiansk gravhög — 94 avrättningar och den ökände "Shadow Man".',
  'West Virginia State Penitentiary i Moundsville grundades 1866 och hyste fångar ända till 1995. Under sina 119 år som fängelse höll anstalten några av delstatens mest våldsamma brottslingar, varav många aldrig lämnade den i livet.

Här avrättades 94 män, genom hängning eller i elektriska stolen. Hängningarna var offentliga fram till 1931, då en man halshöggs av repet — därefter skedde avrättningarna "endast på inbjudan". När dödsstraffet återinfördes 1951 byggde en intagen själv fängelsets elektriska stol, kallad "Old Sparky".

Fängelset räknas till USA:s mest hemsökta. De paranormala berättelserna går tillbaka till 1930-talet, då nattvakter började se fångar vandra fritt på gården och i avspärrade områden. Larm utlöstes och vakter mobiliserades — men några vandrande fångar hittades aldrig. Mest ökänd är "Shadow Man", en mörk skuggestalt som gärna ställer sig i redan skuggiga partier och är så hotfull att somliga bara känner var han befinner sig.

Besökare hör osynliga människor gräla och viska, och känner iskalla fläckar. I en cell i North Hall satt Red Snyder, som knivhöggs ihjäl av medfångar med 37 stick; hans ande sägs dröja kvar och sträcka sig ut ur cellen för att gripa förbipasserande. Fängelset byggdes dessutom på Adena-folkets heliga gravhögar — en av högarna står ännu kvar och gav Moundsville dess namn.

Källa: Legends of America + usghostadventures.com + amyscrypt.com + Atlas Obscura',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. WHALEY HOUSE (USA) — Yankee Jims tunga steg
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'whaley-house-san-diego','Whaley House','whaley-house-san-diego','USA','Kalifornien, San Diego','Hus',
  32.7510,-117.1950,3,false,true,NULL,
  'Byggt på galgbacken där Yankee Jim hängdes — hans tunga steg ekar än i tegelhuset.',
  'Whaley House i Old Town i San Diego, Kalifornien, byggdes 1857 av Thomas Whaley och är den äldsta tegelbyggnaden i södra Kalifornien. Genom åren tjänade huset som familjebostad, domstol och teater — men dess mörka rykte går längre tillbaka än så.

På exakt den plats där huset senare restes hängdes 1852 tjuven och drifteren Yankee Jim Robinson, dömd för att ha stulit en båt. Bödeln tog inte hänsyn till Jims längd på 193 centimeter, så att hans fötter nätt och jämnt nådde marken — vilket gav honom en långsam och plågsam död.

Kort efter att familjen Whaley flyttat in berättade de för tidningen San Diego Union att de hört tunga steg i huset, som de trodde var Yankee Jims ande. Vanliga spökupplevelser i huset är steg, kroppslösa röster och ljudet av ett gråtande spädbarn. Somliga besökare ser uppenbarelser eller känner plötsliga kalla fläckar, ser föremål som rör sig av sig själva och lampor som fladdrar utan förklaring.

Whaley House kallas ofta "Amerikas mest hemsökta hus" och är idag ett museum. För många besökare är det Yankee Jims tunga steg, som ekar genom det gamla tegelhuset, som dröjer kvar längst i minnet långt efter besöket.

Källa: Engelska Wikipedia "Whaley House" + sdghosts.com + usghostadventures.com + ghostcitytours.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. BIRD CAGE THEATRE (USA) — Vilda västerns syndigaste nattklubb
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'bird-cage-theatre','Bird Cage Theatre','bird-cage-theatre','USA','Arizona, Tombstone','Teater',
  31.7120,-110.0670,4,false,true,NULL,
  '26 dödsfall och kvarsittande kulhål — "den vildaste, syndigaste nattklubben" i Vilda västern.',
  'Bird Cage Theatre i Tombstone i Arizona byggdes 1881, mitt under gruvboomen, för att roa stadens invånare och besökare. Det öppnade på julafton 1881 — men blev snart något helt annat än respektabel underhållning.

The New York Times kallade det "den vildaste, syndigaste nattklubben mellan Basin Street och Barbary Coast". Minst 26 människor mötte sin död innanför dess väggar. Skjutningar, knivhuggningar och slagsmål var vanliga, och flera slutade dödligt. Det så kallade Gallows Room ovanför scenen var ökänt för flera självmord och hängningar. Kulhålen sitter ännu kvar i väggar och tak — inte som dekoration, utan som spår av verkliga eldstrider, som teatern bevarat i stället för att laga.

Bird Cage Theatre har rykte om sig att vara den mest hemsökta platsen i staden och sägs hysa så många som 31 spöken. Genom åren har otaliga besökare och anställda berättat om kusliga upplevelser: uppenbarelser av forna prostituerade och arbetare, spökljud, föremål som rör sig av sig själva och annan paranormal aktivitet kopplad till platsens våldsamma förflutna.

Idag är teatern ett museum där tiden tycks ha stannat — med kvarlämnade spelbord, scenkläder och kulhål — och där Vilda västerns blodiga historia sägs leva vidare i form av dess rastlösa andar.

Källa: tombstonebirdcage.com + ghostcitytours.com + Legends of America + amyscrypt.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
