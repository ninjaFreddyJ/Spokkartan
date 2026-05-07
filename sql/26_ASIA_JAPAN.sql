-- Spökkartan — Asien: Japan (20 platser)
-- Genererad 2026-05-06. Källa: Användarens forskningsrapport.
-- Detaljerade beskrivningar från användarens rapport där de finns.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. SUNSHINE 60 (Tokyo)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'sunshine-60','Sunshine 60','sunshine-60','Japan','Tokyo, Ikebukuro','Skyskrapa',
  35.7289,139.7192,4,true,false,NULL,
  'Skyskrapa byggd ovanpå avrättningsplatsen för japanska krigsförbrytare.',
  'Denna skyskrapa i Ikebukuro är byggd på den mark där det ökända Sugamo-fängelset en gång stod. Fängelset var platsen för avrättningen av sju japanska krigsförbrytare, inklusive tidigare premiärminister Hideki Tojo, som hängdes här 1948.

Sedan byggnadens färdigställande 1978 har det funnits otaliga rapporter om paranormala fenomen. Besökare och kontorsanställda har vittnat om "eldklot" som svävar i luften nattetid, hissar som stannar vid våningsplan utan att någon tryckt på knappen och en känsla av att bli iakttagen av osynliga gestalter i trapphusen.

Skyskrapan ses som ett monument över Japans mörka krigshistoria, där den moderna fasaden inte helt lyckas dölja markens blodiga förflutna.',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. TOYAMA PARK (Tokyo)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'toyama-park','Toyama Park','toyama-park','Japan','Tokyo, Shinjuku','Park',
  35.7075,139.7092,4,true,false,NULL,
  'Park byggd över massgravar från Enhet 731:s biologiska krigsföringsexperiment.',
  'Belägen i Shinjuku-distriktet, framstår denna park som en idyllisk grön oas under dagen. Men bakom ytan döljer sig spår av Enhet 731, den kejserliga japanska arméns enhet för biologisk och kemisk krigföring. Under andra världskriget användes området för medicinska experiment på krigsfångar, och 1989 hittades hundratals mänskliga ben begravda i parkens utkant.

Besökare efter mörkrets inbrott har rapporterat om hjärtskärande snyftningar, ljudet av smärtsamma skrik och ljusfenomen som rör sig mellan träden. Platsen betraktas som en av Tokyos mest "negativa" zoner, där de orättfärdigt dödas lidande sägs ha lämnat permanenta avtryck i den spirituella geografin.',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. AOKIGAHARA FOREST (Yamanashi)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'aokigahara-forest','Aokigahara Forest','aokigahara-forest','Japan','Yamanashi','Skog',
  35.4747,138.6517,5,true,false,NULL,
  'Världens mest kända självmordsskog vid foten av Fuji — onaturligt tyst och full av yūrei.',
  'Världens kanske mest kända självmordsplats breder ut sig vid foten av Fuji. Den täta skogen, växande på porös lava som absorberar ljud, skapar en onaturlig tystnad. Området är historiskt förknippat med ubasute — den antika sedvänjan att lämna kvar gamla eller sjuka släktingar i vildmarken för att dö under tider av hungersnöd.

Legenden säger att skogen är full av yūrei (andar) som söker sällskap. Turister och skogsvaktare har beskrivit en desorienterande känsla där röster tycks viska i vinden och skepnader rör sig precis utanför synfältet. Det magnetiska fältet i marken stör kompasser, vilket bidrar till den paranormala mystiken och de många rapporterna om människor som gått vilse utan förklaring.',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. HACHIOJI CASTLE (Tokyo)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'hachioji-castle','Hachioji Castle','hachioji-castle','Japan','Tokyo','Slottsruin',
  35.6511,139.2542,4,true,false,NULL,
  'Slott förstört 1590 — kvinnor begick massjälvmord vid vattenfallet för att undgå tillfångatagande.',
  'Detta slott förstördes 1590 under en massiv belägring av Toyotomi Hideyoshi. Det sägs att de kvinnliga invånarna i slottet begick massjälvmord genom att kasta sig i ett närliggande vattenfall för att undvika att bli tillfångatagna.

Besökare vid ruinerna hävdar att de fortfarande kan höra ljudet av kvinnornas skrik som blandas med vattenfallets dån, och att vattnet ibland tycks färgas rött av blod under årsdagen av striden.',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 5. KIYOTAKI TUNNEL (Kyoto)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'kiyotaki-tunnel','Kiyotaki Tunnel','kiyotaki-tunnel','Japan','Kyoto','Tunnel',
  35.0322,135.6625,4,true,false,NULL,
  'En av Japans mest beryktade hemsökta tunnlar — byggd av tvångsarbetare under andra världskriget.',
  'Kiyotaki-tunneln nära Kyoto är en av Japans mest beryktade hemsökta platser. Tunneln byggdes till stor del av tvångsarbetare under andra världskriget och är förknippad med många urbana legender om paranormala fenomen.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 6. HIMEJI CASTLE (Hyōgo)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'himeji-castle','Himeji Castle','himeji-castle','Japan','Hyōgo','Slott',
  34.8392,134.6939,3,false,false,NULL,
  'Vita Hägrar-slottet — Japans bäst bevarade slott och hem för Okiku-anden vid brunnen.',
  'Himeji Castle är ett av Japans bäst bevarade slott och ett UNESCO-världsarv. Slottet är förknippat med den klassiska spökhistorien om Okiku, en tjänarinna vars ande sägs räkna tallrikar i en brunn på slottsområdet.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 7. INUNAKI TUNNEL (Fukuoka)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'inunaki-tunnel','Inunaki Tunnel','inunaki-tunnel','Japan','Fukuoka','Tunnel',
  33.6841,130.5422,4,true,false,NULL,
  'Tunnel i Fukuoka förknippad med en mängd urbana legender och paranormal aktivitet.',
  'Inunaki-tunneln i Fukuoka är en av Japans mest omtalade hemsökta tunnlar och är förknippad med en mängd urbana legender, inklusive den berömda "Inunaki Village"-legenden.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 8. OIRAN BUCHI (Yamanashi)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'oiran-buchi','Oiran Buchi','oiran-buchi','Japan','Yamanashi','Klyfta',
  35.7958,138.8256,4,true,false,NULL,
  'Klyfta där 55 kurtisaner enligt legenden mördades för att skydda en silvergruva.',
  'Oiran Buchi är en klyfta i Yamanashi förknippad med en lokal legend om kurtisaner som ska ha mördats av en gruvägare för att hemlighålla platsen för en silvergruva.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 9. AKASAKA MANSION (Tokyo)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'akasaka-mansion','Akasaka Mansion','akasaka-mansion','Japan','Tokyo','Hotell',
  35.6711,139.7342,3,true,false,NULL,
  'Hotell i Akasaka, Tokyo, känt för paranormala anekdoter.',
  'Hotell i Akasaka, Tokyo, känt i lokal folktro för paranormala anekdoter och rapporter.

(Kort grundtext — kan berikas med lokala källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 10. DORYODO RUINS (Tokyo)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'doryodo-ruins','Doryodo Ruins','doryodo-ruins','Japan','Tokyo','Tempelruin',
  35.6311,139.3756,4,true,false,NULL,
  'Tempelruin i västra Tokyo — plats för tragiska brott på 1960-talet.',
  'Doryodo Ruins är en gammal tempelplats i västra Tokyo som är förknippad med dramatiska brott från 1960-talet. Ruinen är en återkommande plats i japansk paranormal folktro.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 11. MASAKADO'S GRAVE (Tokyo)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'masakado-grave','Taira no Masakados grav','masakado-grave','Japan','Tokyo, Otemachi','Gravplats',
  35.6847,139.7644,3,true,false,NULL,
  'Mitt i Tokyos finansdistrikt — graven över rebellsamurajen som ingen vågar flytta.',
  'Graven över samurajen Taira no Masakado, halshuggen 940 e.Kr. och vars huvud enligt legenden flög hela vägen till Tokyo. Graven står kvar mitt i Otemachis moderna skyskrapeområde — flera försök att flytta den har enligt traditionen följts av olyckor och dödsfall.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 12. MOUNT OSORE (Aomori)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'mount-osore','Mount Osore','mount-osore','Japan','Aomori','Berg/Tempel',
  41.3286,141.0911,4,false,false,NULL,
  '"Skräckens berg" — en av Japans tre heliga platser, en port till underjorden.',
  'Mount Osore (Osorezan) i Aomori-prefekturen är ett av Japans tre heliga buddhistiska berg och anses vara en port till efterlivet. Området är känt för sin svavelluft, kala landskap och de blinda kvinnliga shamaner (itako) som påstås kunna kommunicera med de döda.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 13. GRIDLEY TUNNEL (Kanagawa)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'gridley-tunnel','Gridley Tunnel','gridley-tunnel','Japan','Kanagawa, Yokosuka','Tunnel',
  35.2933,139.6711,3,true,false,NULL,
  'Tunnel i Yokosuka med rapporter om paranormala fenomen.',
  'Tunnel i Kanagawa-prefekturen, Yokosuka, förknippad med lokala spökhistorier och paranormala anekdoter.

(Kort grundtext — kan berikas med lokala källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 14. RYOKUFUSO INN (Iwate)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'ryokufuso-inn','Ryokufuso Inn','ryokufuso-inn','Japan','Iwate','Hotell/Värdshus',
  39.3142,141.3158,3,true,false,NULL,
  'Värdshus i Iwate förknippat med paranormala anekdoter.',
  'Värdshus (ryokan) i Iwate-prefekturen, känt i lokal folktro för paranormala anekdoter.

(Kort grundtext — kan berikas med lokala källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 15. MARUOKA CASTLE (Fukui)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'maruoka-castle','Maruoka Castle','maruoka-castle','Japan','Fukui','Slott',
  36.1517,136.2711,3,false,false,NULL,
  'Ett av Japans äldsta bevarade slott — legenden om "den enögda" Oshizu vakar här.',
  'Maruoka Castle är ett av Japans äldsta kvarvarande slott (byggt 1576). En klassisk japansk legend berättar om Oshizu, en kvinna offrad i slottets fundament för att stärka konstruktionen — hennes ande sägs vakta platsen.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 16. MIDORO POND (Kyoto)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'midoro-pond','Midoro Pond','midoro-pond','Japan','Kyoto','Sjö',
  35.0592,135.7675,3,true,false,NULL,
  'Sjö i Kyoto med klassiska japanska spökhistorier kopplade till sig.',
  'Sjö i Kyoto-området med lokala spökhistorier och paranormala anekdoter förknippade med vattnet.

(Kort grundtext — kan berikas med lokala källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 17. OIWA SHRINE (Tokyo)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'oiwa-shrine','Oiwa Inari Shrine','oiwa-shrine','Japan','Tokyo, Yotsuya','Helgedom',
  35.6811,139.7211,4,true,false,NULL,
  'Helgedom tillägnad Oiwa — Japans mest berömda hämndande från Yotsuya Kaidan.',
  'Oiwa Inari-helgedomen i Yotsuya, Tokyo, är tillägnad Oiwa, huvudpersonen i den berömda spökhistorien Yotsuya Kaidan från 1700-talet. Skådespelare och filmskapare som arbetar med berättelsen besöker traditionellt helgedomen för att be om Oiwas tillstånd, för att undvika olyckor.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 18. PRUDENTIAL TOWER (Tokyo)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'prudential-tower-tokyo','Prudential Tower (Tokyo)','prudential-tower-tokyo','Japan','Tokyo','Skyskrapa',
  35.6767,139.7381,3,false,false,NULL,
  'Tokyos skyskrapa förknippad med urbana legender om paranormal aktivitet.',
  'Skyskrapa i centrala Tokyo som är föremål för urbana legender om paranormal aktivitet.

(Kort grundtext — kan berikas med lokala källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 19. HANAYASHIKI (Tokyo)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'hanayashiki','Hanayashiki','hanayashiki','Japan','Tokyo, Asakusa','Nöjespark',
  35.7153,139.7944,3,false,false,NULL,
  'Japans äldsta nöjespark (1853) i Asakusa — full av urbana spökhistorier.',
  'Hanayashiki är Japans äldsta nöjespark, öppnad 1853 i Asakusa-distriktet i Tokyo. Den långa historien har gett upphov till en rad lokala spökhistorier kopplade till parkens äldre attraktioner.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 20. TOSHIMAEN (Tokyo)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'toshimaen','Toshimaen (stängd)','toshimaen','Japan','Tokyo, Nerima','Övergiven nöjespark',
  35.7444,139.6467,3,true,false,NULL,
  'Tokyos klassiska nöjespark som stängdes 2020 — sägs vara hemsökt.',
  'Toshimaen var en av Tokyos äldsta nöjesparker, öppnad 1926 och stängd 2020. Området är förknippat med urbana legender och rapporter om paranormal aktivitet både under driften och efter stängningen.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
