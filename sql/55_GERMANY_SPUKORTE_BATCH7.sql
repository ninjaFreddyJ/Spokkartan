-- Spökkartan — 9 fler hemsökta platser i Tyskland (Deutschland), omgång 7
-- Genererad 2026-06-09. Del av målet ~40 platser/land.
--
-- METOD: tyska sökord (Sage, Geist, Spuk, weiße Frau, Lost Place) -> sidor som
-- samlat spökhistorier/sägner (hohenzollern-orte.de, regionalgeschichte.net,
-- abandonedberlin.com, harzlife.de m.fl. samt Wikipedia). Skrivet på SVENSKA,
-- 200-600 ord/plats, aldrig fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. BURG HOHENZOLLERN — den vita frun, husets dödsbåderska
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'burg-hohenzollern','Burg Hohenzollern','burg-hohenzollern','Tyskland','Baden-Württemberg, Hechingen','Borg',
  48.3236,8.9678,3,false,true,NULL,
  'Den vita frun Kunigunde vandrar i kungaättens stamborg — och hennes uppenbarelse bådar alltid död.',
  'Burg Hohenzollern tronar på en kägelformad bergstopp i Schwabiska Alb och är stamborgen för det preussiska kungahuset och de tyska kejsarna. Till dess mest kända sägner hör den om Weiße Frau — "den vita frun" — som räknas som huset Hohenzollerns eget hemspöke.

Legendens ursprung leder tillbaka till 1300-talet och den frankiska Plassenburg vid Kulmbach. Där ska borgfrun Kunigunde, genom ett tragiskt missförstånd, ha dödat sina egna barn. När hon insåg sanningen dog hon själv av förtvivlan — och hennes ande fann aldrig ro. Snart berättade de första Hohenzollern att de sett Kunigunde som en blek gestalt klädd i vitt, alltid strax före ett dödsfall i familjen. Så föddes sägnen om den vita frun som bådar död.

När Hohenzollern på 1400-talet flyttade till Berlin följde spöket med till den nya residensstaden. Hon sägs ha skymtats i Berlins stadsslott, i citadellet Spandau och till och med i Nikolaiviertel. Diktaren Christian Graf zu Stolberg beskrev 1814 hur hon "höljd i vit änkedräkt och vit nunneslöja" skred genom borg- och slottsmurar vid midnatt.

Idag är Burg Hohenzollern ett av Tysklands mest besökta slott — men enligt familjetraditionen vandrar den vita frun ännu i dess salar, och hennes uppenbarelse sägs alltid förebåda att någon i ätten snart ska dö.

Källa: hohenzollern-orte.de + National Geographic + Tyska Wikipedia "Weiße Frau" + watson.ch',
  NULL,NULL,NULL,true,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. SABABURG — Törnrosaslottet och Mordkammern
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'sababurg','Sababurg','sababurg','Tyskland','Hessen, Reinhardswald','Slott',
  51.5530,9.5360,2,false,true,NULL,
  'Bröderna Grimms Törnrosaslott — med en jättinnas mord och en kammare som ännu kallas Mordkammern.',
  'Sababurg i Reinhardswald i Hessen kallas ofta Dornröschenschloss — Törnrosaslottet — eftersom det sägs ha inspirerat bröderna Grimm när de nedtecknade den världsberömda sagan om Törnrosa, med sin hundraåriga sömn bakom en törnhäck.

Bakom det sagolika namnet döljer sig dock en mörkare historia. Borgen uppfördes 1334 som skyddsborg för pilgrimer på väg till den heliga Elisabeth av Thüringens grav. På 1490-talet restes ett befäst hus på ruinerna av den äldre Zapfenburg, och från 1508 byggdes Sababurg som jaktslott i den djupa skogen.

Enligt sägnen byggde två jättesystrar var sitt slott i trakten. Men systern Trendula kunde inte tygla sin vrede, utan ströp sin syster Saba ute i skogen. Den del av borgen som förknippas med dådet bär än idag det kusliga namnet Mordkammer — "mordkammaren".

Reinhardswald, den vidsträckta urskogen runt borgen, är själv höljd i sägner om älvor, häxor och vålnader, och kallas ibland "Tysklands trollskog". Sedan 2018 renoveras Sababurg av delstaten Hessen. Idag rymmer den ett hotell och en djurpark — men i skymningen, när dimman lägger sig över de uråldriga, knotiga ekarna och Mordkammerns murar, är det inte svårt att förstå varför just denna plats kommit att förknippas med både sagornas och skräckens skog.

Källa: erlebnis-sababurg.de + Engelska Wikipedia "Sababurg" + reinhardswald.de + deutsche-maerchenstrasse.com',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. BINGER MÄUSETURM — biskopen som åts upp av mössen
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'maeuseturm-bingen','Mäuseturm Bingen','maeuseturm-bingen','Tyskland','Rheinland-Pfalz, Bingen','Torn',
  49.9710,7.8870,3,false,false,NULL,
  'Den grymme biskop Hatto hånade de svältande — och åts levande av tusentals möss i tornet.',
  'Mäuseturm — "mustornet" — står på en liten ö i Rhen utanför Bingen och var ursprungligen ett vakt- och tulltorn, uppfört i början av 1300-talet för att driva in vägtull. Men det är en blodig sägen som gjort tornet världsberömt.

Enligt legenden lät Mainz ärkebiskop Hatto II uppföra tornet på 900-talet. När en svår hungersnöd härjade i landet ska den hårdhjärtade biskopen ha vägrat de fattiga hjälp ur sina fyllda kornbodar. När de fortsatte att tigga lät han spärra in dem i en lada, som hans hantlangare därefter satte i brand. De döendes skrik kommenterade han hånfullt med orden: "Hör ni hur kornmössen piper?"

I samma stund, säger sägnen, kröp tusentals möss fram ur alla vrår och vällde över bordet och genom biskopens gemak. Mängden av gnagare drev tjänstefolket på flykten, och Hatto flydde med ett skepp nedför Rhen till ön, där han trodde sig säker. Men när han väl låst in sig där, ska han ha blivit levande uppäten av mössen.

Namnet kommer troligen i själva verket av tornets uppgift som tullvakt — av medelhögtyskans "mûsen", att speja och lura. Men för alla som ser det ensliga tornet resa sig ur Rhens vatten lever sägnen om den grymme biskopen och de hämndlystna mössen vidare.

Källa: regionalgeschichte.net + Tyska Wikipedia "Binger Mäuseturm" + drachenwolke.com + sagen.at',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. SCHLOSS BERG / STARNBERGER SEE — sagokungens olösta död
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'schloss-berg-starnberger-see','Schloss Berg & Starnberger See','schloss-berg-starnberger-see','Tyskland','Bayern, Berg','Slott',
  47.9460,11.3370,2,true,false,NULL,
  'Sagokungen Ludwig II drunknade i sjön under olösta omständigheter — hans ande sägs aldrig ha lämnat den.',
  'Vid Starnberger See söder om München ligger Schloss Berg, platsen för Bayerns mest berömda och olösta dödsmysterium. Här dog den 13 juni 1886 kung Ludwig II — "sagokungen" — under oklara omständigheter.

Bara dagen innan hade Ludwig, känd som den drömmande och tillbakadragne byggaren av slotten Neuschwanstein, Herrenchiemsee och Linderhof, förklarats omyndig och förts till Schloss Berg. Kvällen därpå gick han ut på en promenad längs sjön i sällskap med den psykiater som skrivit omyndighetsförklaringen. Båda männen hittades senare döda i det grunda vattnet. Var det självmord, en olycka, eller mord? Frågan har aldrig fått något säkert svar och räknas som Bayerns mest omtvistade dödsfall.

Redan medan Ludwig levde började myten byggas kring honom. "Ett evigt gåtfullt vill jag förbli, för mig själv och för andra", skrev han en gång till sin lärare. Än idag vördas "der Kini" som en folkkär idol, och enligt sägnen ska hans ande återkomma som ett löfte om den triumferande skönheten.

På platsen där kungen drogs upp ur vattnet står idag ett minneskors strax utanför stranden, och ett votivkapell på höjden ovanför. När kvällsdimman lägger sig över Starnberger See berättar man fortfarande om sagokungen som aldrig riktigt lämnade sin sjö.

Källa: bavarikon.de + Tyska Wikipedia "Ludwig II. (Bayern)" + neuschwanstein.de + starnbergersee-info.de',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 5. HEILSTÄTTE GRABOWSEE — det övergivna sanatoriet
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'heilstaette-grabowsee','Heilstätte Grabowsee','heilstaette-grabowsee','Tyskland','Brandenburg, Oranienburg','Sanatorium',
  52.7560,13.2330,4,false,true,NULL,
  'Ett av Tysklands mest kända lost places — ett tyst lungsanatorium där björkar växer genom golven.',
  'Heilstätte Grabowsee är ett övergivet tuberkulossanatorium vid sjön Grabowsee i utkanten av Oranienburg, norr om Berlin — och ett av Tysklands mest kända lost places. Det byggdes 1896 som det första lungsanatoriet i norra Tyskland.

Röda Korset arrenderade samma år 20 hektar avskild skogsmark vid sjön. Anläggningen grundades som ett experiment för att se om lungsjuka kunde botas i det tyska låglandet — man trodde dittills att endast bergsluft hade läkande verkan. Från 1926 fördubblades kapaciteten till omkring 420 sängar, och komplexet växte till ett trettiotal byggnader: vårdpaviljonger, läkarbostäder, kök, förvaltning, ett eget kapell, en teater och en skola.

Under första världskriget tjänade Grabowsee som lasarett för soldater med lungsjukdomar och hyste fram till 1918 även krigsfångar. Efter andra världskriget användes platsen från 1945 till 1995 som sovjetiskt militärsjukhus. Sedan dess har den stått övergiven.

Idag är de vittrande paviljongerna höljda i tystnad — sönderslagna fönster, flagnande färg och björkar som växer genom golven. Platsen har blivit ett populärt mål för urban explorers och filmteam; här spelades bland annat "Monuments Men" och skräckfilmen "Heilstätten" in. Numera bevakas området dygnet runt och kan besökas lagligt mot en avgift. Men i de tomma korridorerna, där en gång hundratals dödssjuka vårdades, dröjer en kuslig stämning kvar.

Källa: abandonedberlin.com + digitalcosmonaut.com + Atlas Obscura + wmn.de',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 6. SCHLOSS BURG (SOLINGEN) — den ansiktslösa vita damen
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'schloss-burg-solingen','Schloss Burg an der Wupper','schloss-burg-solingen','Tyskland','Nordrhein-Westfalen, Solingen','Borg',
  51.1380,7.1530,3,false,true,NULL,
  'Den vita damen visar sig före oväder och bröllop — på foton skymtas en kvinna i lång klänning, utan ansikte.',
  'Schloss Burg an der Wupper ovanför Solingen är Nordrhein-Westfalens största återuppbyggda borg och var en gång stamsäte för grevarna av Berg. Här sägs Weiße Dame — "den vita damen" — vandra.

Hon visar sig i sorgens stunder, före oväder eller vid bröllop på borgen, som om hon ville påminna om en sedan länge förlorad kärlek från grevarna av Bergs tid. Enligt de lokala guiderna är hon inte ondsint, utan anden efter en kvinna som aldrig lämnade sitt hem — borgens och dess minnens väktarinna.

Flera kusliga händelser har rapporterats. En inspelning ska tydligt ha fångat ljudet av en tung trädörr som öppnades mitt under en guides berättelse — trots att personalen bekräftat att alla dörrar var låsta. En besökare från Köln berättade om "en lätt vindpust med doft av friska rosor", och i samma ögonblick fångade hennes kamera en vit skugga som drog förbi bakom henne. Andra vittnen har hört prasslande tyg i tomma korridorer om natten, och turister har på fotografier från nordflygeln tyckt sig se en kvinna i lång klänning — utan ansikte — på tröskeln till grevesalen.

Borgens äldsta historia knyts till greve Engelbert I av Berg, som dog 1189 under det tredje korståget. Men det är den ansiktslösa vita damen som gör Schloss Burg till en av Bergiska landets mest sägenomspunna platser.

Källa: unserechroniken.de + schlossburg.de + Tyska Wikipedia "Schloss Burg" + National Geographic',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 7. BURG REGENSTEIN — rövargreven och den fångna jungfrun
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'burg-regenstein','Burg Regenstein','burg-regenstein','Tyskland','Sachsen-Anhalt, Blankenburg','Borg',
  51.8060,10.9430,3,false,true,NULL,
  'Klippborg med världens djupaste borgbrunn — där rövargreven Alberts ande vandrar i stormiga nätter.',
  'Burg Regenstein är ruinen av en medeltida klippborg i norra Harz, vid Blankenburg. Det märkliga med borgen är att stora delar är uthuggna direkt i sandstensklippan — än idag finns 32 bevarade klipprum och gravar, och borgbrunnen från 1671, över 197 meter djup, räknas som världens djupaste borgbrunn. Greve Konrad av Regenstein nämns första gången 1162.

Borgen är rik på övernaturliga sägner. En av de mest kända handlar om den fångna jungfrun: en av landets skönaste flickor hölls fången i ett av borgens fängelsehål, sedan greven av Regenstein fattat tycke för henne och låtit bortföra henne. Med en diamantring ristade hon under ett helt år en springa i klippan, tills den blev så stor att hon kunde krypa ut och fly. När hon senare återvände med sina anhöriga var greven försvunnen — och genom springan såg hon honom plågas i skärselden. Av medlidande kastade hon då sin ring till honom, för att låta hans ande komma till ro.

En annan sägen berättar om rövargreven Albert av Regenstein, den mörke riddaren som ska ha överfallit resande, plundrat städer och förbundit sig med djävulen. Än idag, heter det, vandrar hans ande över klipporna i stormiga nätter, åtföljd av gamla vapens skrammel och hans förbannade knektars rop.

Källa: harzlife.de + Tyska Wikipedia "Burg Regenstein" + harzer-sagen.harz-urlaub.de + burgen.de',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 8. HEXENTURM IDSTEIN — häxförföljelsens mörka minne
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'hexenturm-idstein','Hexenturm Idstein','hexenturm-idstein','Tyskland','Hessen, Idstein','Torn',
  50.2200,8.2660,3,true,false,NULL,
  'Stadens vartecken bär namnet "häxtornet" — minnet av en häxjakt som krävde 39 människors liv.',
  'Hexenturm — "häxtornet" — i Idstein i Hessen är stadens vartecken och dess äldsta bevarade byggnad. Tornet började uppföras omkring 1170, höjdes på 1240-talet och fick sin karakteristiska "smörtunneform" omkring år 1500.

Trots namnet visar nyare forskning att tornet egentligen inte har med häxprocesserna att göra: de anklagade satt inte fängslade här, utan i ett mindre torn vid stadsmuren, och det finns inga belägg för att tortyr kopplad till häxprocesserna ägt rum i tornet. Namnet kom till genom en litterär skildring av författaren Ottokar Schupp på 1800-talet.

Men den verkliga häxförföljelsen i Idstein var fasansfull nog. Under den protestantiske greven Johann av Nassau-Idstein rasade åren 1676–77 en omfattande häxjakt. Enligt rättegångsprotokollen genomfördes förhören och tortyren främst i kanslibyggnaden, där kvinnorna under plågorna bekände allt de anklagades för. Förföljelsen upphörde först med grevens död — och hade då krävt 39 människors liv.

År 1996 restes en minnestavla vid Hexenturm, och 2014 rehabiliterade Idsteins stadsfullmäktige enhälligt och formellt över 40 offer, moraliskt och socialetiskt. Idag står det åttkantiga tornet kvar mitt i den pittoreska fackverksstaden — en tyst påminnelse om en av Hessens mörkaste epoker, då rädsla och vidskepelse sände oskyldiga i döden.

Källa: idstein.de + Tyska Wikipedia "Hexenturm" + heftrich-evangelisch.de + artikel33.com',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 9. BURG HOHNSTEIN — den vita grevinnan på murkrönet
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'burg-hohnstein','Burg Hohnstein','burg-hohnstein','Tyskland','Sachsen, Hohnstein','Borg',
  50.9790,14.1110,3,false,true,NULL,
  'En vit gestalt vandrar längs murkrönet — själen efter en grevinna från 1400-talet, sägs det.',
  'Burg Hohnstein tronar högt över Polenztal på en klippavsats i Sächsische Schweiz, vid kanten av nationalparken. Borgen nämns första gången 1353 och har genom seklen tjänat som adelssäte, förvaltningssäte, domstol, jaktslott — och fängelse.

Enligt lokala berättelser kan man klara nätter se en vit gestalt vandra längs borgens murkrön. Somliga ortsbor menar att det är själen efter en grevinna från 1400-talet, som ännu inte funnit ro. Den vita frun på Burg Hohnstein är en del av en bredare tradition av spökhistorier i Sächsische Schweiz, där byborna kring Bad Schandau, Hohnstein och Königstein i århundraden berättat kusliga historier om vålnader och rastlösa själar som vandrar mellan klipporna.

Borgens oroliga historia kan ha bidragit till sägnerna. Under seklen användes den växelvis som kurfurstligt ämbete, tingsplats och fängelse — och 1933/34 som ett av nazisternas tidiga koncentrationsläger, där politiska fångar misshandlades svårt. Detta mörka kapitel har lämnat sina egna spår av lidande i murarna.

Idag rymmer borgen ett vandrarhem och en utställning om dess historia. Men när dimman stiger ur Polenztals djup och månen lyser över de branta sandstensklipporna, vågar få blicka för länge mot murkrönet — av rädsla för att där skymta den vita grevinnan som ännu vandrar sin eviga rond.

Källa: dresdenausflug.de + Tyska Wikipedia "Burg Hohnstein" + hohnstein.de + saechsische-schweiz.de',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
