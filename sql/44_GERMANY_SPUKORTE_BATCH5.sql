-- Spökkartan — 4 fler hemsökta platser i Tyskland (Deutschland), omgång 5
-- Genererad 2026-06-09. Fortsättning på 33-36_GERMANY_SPUKORTE.
--
-- METOD: tyska sökord (Lost Place, verbotene Stadt, Hexenverfolgung,
-- Geisterbahnhof, Geisterdorf, Spuk) -> sidor som samlat spökhistorier
-- (travelbook.de, museen-lemgo.de, Stiftung Berliner Mauer, bpb.de m.fl. samt
-- tyska Wikipedia). Skrivet på SVENSKA, 200-600 ord/plats, aldrig fler ord än
-- källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. WÜNSDORF (Tyskland) — den förbjudna sovjetstaden
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'wuensdorf','Wünsdorf (Verbotene Stadt)','wuensdorf','Tyskland','Brandenburg, Zossen','Övergiven',
  52.1670,13.4670,3,false,true,NULL,
  'Sovjets "förbjudna stad" — 35 000 soldater, egen järnväg till Moskva, idag en övergiven bunkerstad.',
  'Wünsdorf, söder om Berlin i Brandenburg, var i decennier känt som "den förbjudna staden". Platsen har en lång militärhistoria — först under första världskriget, sedan under nazitiden och därefter som Sovjetarméns högkvarter.

Under naziregimen inrymdes den tyska arméns överkommando och dess kommunikationscentraler i två väldiga bunkrar med namnen "Zeppelin" och "Maybach". Efter andra världskrigets slut 1945 blev Wünsdorf högkvarter för de sovjetiska väpnade styrkorna i Östtyskland, med upp till 35 000 sovjetiska soldater stationerade. Sovjeterna byggde butiker, en brödfabrik, skolor, ett sjukhus och till och med en teater — en självförsörjande sovjetisk stad mitt i Brandenburg, med en egen direkt järnvägslinje till Moskva.

Begreppet "förbjudna staden" blev vanligt bland östtyskarna, eftersom tillträde till Wünsdorf var förbjudet för vanliga medborgare. När ryssarna drog sig tillbaka på 1990-talet lämnades en spökstad av tomma kaserner, förfallna byggnader och otaliga bunkrar.

Idag vittnar de raserade husen och bunkrarna ännu om det förflutna. Sedan slutet av 1990-talet har spökstaden förvandlats till "bok- och bunkerstaden" Wünsdorf, med flera antikvariat, guidade turer som förklarar bunkrarnas funktioner och utställningar om platsens militärhistoria. Men vandrar man bland de övergivna kvarteren, de fukttyngda korridorerna och de jättelika bunkrarna under marken känns kalla krigets tystnad fortfarande tung — som om de tusentals soldaterna bara nyss lämnat platsen.

Källa: travelbook.de + eighttwoeightsix.de + reiseland-brandenburg.de + berlinermauerweg.com',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. HEXENBÜRGERMEISTERHAUS LEMGO (Tyskland) — häxprocessernas hus
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'hexenbuergermeisterhaus-lemgo','Hexenbürgermeisterhaus Lemgo','hexenbuergermeisterhaus-lemgo','Tyskland','Nordrhein-Westfalen, Lemgo','Museum',
  52.0277,8.9007,4,false,false,NULL,
  'Häxborgmästaren Cothmann skickade hundra människor på bålet — i huset där processerna hölls.',
  'Hexenbürgermeisterhaus ("häxborgmästarens hus") i Lemgo i Nordrhein-Westfalen är idag ett museum tillägnat häxförföljelsernas historia, inrymt i en historisk byggnad som en gång var borgmästarens bostad och där häxprocesser hölls.

Lemgo var en av de tyska städer där häxprocesserna bedrevs särskilt intensivt. I stadsarkivet bevaras omkring 200 processakter — bland de mest omfattande lokala vittnesbörden om häxprocesser i Tyskland. Enligt dessa föll cirka 250 människor offer för rättegångarna, ungefär hälften av dem efter 1653. Omkring 80 procent av de anklagade var kvinnor, och bekännelser pressades fram under tortyr, varpå dödsdomarna vanligen verkställdes genom bränning på bål.

År 1617 var Lemgo den enda staden i Lippe som av landsherren Simon VII beviljades egen kriminell domsrätt — rätten att självständigt avgöra liv och död. Den mest beryktade gestalten är borgmästaren Hermann Cothmann, "häxborgmästaren", som styrde 1667–1683. Under hans tid föll närmare hundra dödsdomar; han utnyttjade befolkningens häxmani för att stärka sin egen makt och röja undan motståndare.

År 1994 restes minnesstenen "Stein des Anstoßes", som bär namnet Maria Rampendahl — en kvinna som överlevde sin process — som representant för alla oskyldigt förföljda i Lemgos historia. Husets väggar bär ännu på minnet av allt det lidande som utspelade sig innanför dem.

Källa: Tyska Wikipedia "Hexenverfolgung in Lemgo" + museen-lemgo.de + lippe-trip.de + weltenkundler.com',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. BERLINER GEISTERBAHNHÖFE (Tyskland) — spökstationerna under muren
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'berliner-geisterbahnhoefe','Berlins Geisterbahnhöfe','berliner-geisterbahnhoefe','Tyskland','Berlin, Nordbahnhof','Station',
  52.5320,13.3880,3,true,false,NULL,
  'Tågen saktade in men stannade aldrig — öde, bevakade perronger under det delade Berlin.',
  'När Berlinmuren byggdes den 13 augusti 1961 delade den inte bara staden utan också dess trafiksystem. Två tunnelbanelinjer och en S-Bahn-linje med start- och slutstationer i Västberlin fortsatte ändå att gå rakt genom östsektorn — och därmed föddes Berlins "Geisterbahnhöfe", spökstationerna.

Tågen rullade genom de stängda och bevakade stationerna i Östberlin, saktade in men stannade aldrig. Stationerna spärrades av och vaktades av beväpnade DDR-gränssoldater, med undantag för Friedrichstraße med sin gränsövergång. På den östtyska sidan monterades skyltarna ned och ingångarna murades igen. Med åren byggdes ett underjordiskt barrikadsystem — men människor försökte ändå fly genom järnvägstunnlarna mot väster.

I nästan tre decennier, mellan 1961 och 1989, passerade resenärerna dessa svagt upplysta, öde perronger där tiden tycktes ha stannat: dammiga stationsklockor, gamla annonser och uniformerade vakter i skuggorna. För många västberlinare blev de en spöklik, daglig påminnelse om den delade staden.

Idag berättar en utställning i den gamla Nordbahnhof-stationen om detta kapitel av Berlins delningshistoria. Flera av de forna spökstationerna är åter i bruk — bland dem Nordbahnhof, Potsdamer Platz och Bornholmer Straße — men minnet av de tysta, bevakade perrongerna under jorden, där ljuset flämtade och soldaterna stod orörliga i mörkret, lever vidare som en av kalla krigets mest kusliga berättelser.

Källa: Stiftung Berliner Mauer + Tyska Wikipedia "Geisterbahnhof" + berlin.de + tagesspiegel.de',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. WOLLSEIFEN / VOGELSANG (Tyskland) — spökbyn och NS-borgen
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'wollseifen-vogelsang','Wollseifen & Vogelsang','wollseifen-vogelsang','Tyskland','Nordrhein-Westfalen, Schleiden','Övergiven',
  50.5760,6.4310,3,true,false,NULL,
  'Spökbyn vars invånare fördrevs på tre veckor — bredvid Tysklands största bevarade NS-borg.',
  'I Eifel-bergen i Nordrhein-Westfalen, ovanför Urftdammen, ligger två sammanlänkade och olycksbådande platser: den forna NS-Ordensburg Vogelsang och spökbyn Wollseifen.

Vogelsang uppfördes av nazisterna och tjänade mellan 1936 och 1939 som utbildningsanläggning för NSDAP:s blivande ledarkader. De monumentskyddade byggnaderna omfattar över 50 000 kvadratmeter och räknas, näst efter rikspartidagsområdet i Nürnberg, som det största bevarade exemplet på nazistisk arkitektur i Tyskland. Här formades unga män till partielit genom fysiska övningar och ideologisk skolning.

Efter andra världskriget, 1946, beslagtogs området av brittiska styrkor och gjordes om till övningsfält — varvid invånarna i den närbelägna byn Wollseifen tvingades överge sina hem inom tre veckor. Naturen tog tillbaka platsen, och Wollseifen fick rykte som spökby. I Eifel berättas om nattliga besökare som söker souvenirer i ruinerna, och om de fördrivna invånarnas andar som sägs hemsöka trakten efter solnedgången.

Sedan 2006 är området och de skyddade byggnaderna åter öppna för allmänheten. Platsen kallas nu Vogelsang IP (Internationaler Platz) och fungerar som minnes- och utbildningsplats som dokumenterar nazismens historia. Men bland Wollseifens tomma husgrunder, den övergivna bykyrkan och den gamla skolan vilar tystnaden tung över det som en gång var — och få vandrare dröjer gärna kvar i den öde byn när skymningen faller och dimman kryper in över Eifel-höjderna.

Källa: Tyska Wikipedia "NS-Ordensburg Vogelsang" + bpb.de + aachen.t-online.de + vogelsang-ip.de',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
