-- Spökkartan — 10 fler hemsökta platser i USA, omgång 8 (USA 12 -> 22)
-- Genererad 2026-06-10. METOD: engelska sökord -> Wikipedia, ghostcitytours.com,
-- usghostadventures.com, Legends of America, americanhauntingsink.com m.fl.
-- Svenska, 200-600 ord/plats, aldrig fler ord än källan.
-- OBS: koordinater är landmärkesnivå (Maps/OSM ej nåbara i denna miljö) — bör
-- finverifieras mot Google Maps/OSM innan/efter publicering.
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. THE STANLEY HOTEL — The Shinings födelseplats
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'stanley-hotel','The Stanley Hotel','stanley-hotel','USA','Colorado, Estes Park','Hotell',
  40.3828,-105.5217,4,false,true,NULL,
  'Här drömde Stephen King fram The Shining i rum 217 — där en husa ännu sägs dröja kvar.',
  'Stanley Hotel i Estes Park i Colorado är ett 140-rums hotell i georgiansk stil, omkring åtta kilometer från Rocky Mountain National Park, och räknas som ett av Amerikas mest hemsökta hotell. Det byggdes av Freelan Oscar Stanley, delägare i Stanley Motor Carriage Company, och öppnade den 4 juli 1909 som lyxresort och hälsohem för lungtuberkulos.

Hotellets mest berömda gäst var författaren Stephen King. Natten till den 30 oktober 1974 checkade King och hans hustru Tabitha in i rum 217 — det enda upptagna rummet innan hotellet stängde för säsongen. Den natten hade King den dröm som gav upphov till skräckromanen The Shining.

Rum 217 är hotellets mest ökända plats. I hotellets tidiga år inträffade där en svår olycka när en explosion nästan dödade en husa, som sedan dess sägs dröja kvar i rummet. Från spökbarn som leker i korridorerna till pianomusik från ingenstans erbjuder Stanley en verkligt kuslig upplevelse. Freelan Stanley själv sägs vandra i hotellet, oftast i baren, och hans hustru Flora har skymtats spela piano i balsalen.

Idag är Stanley Hotel en av Colorados största turistattraktioner, med spökturer och paranormala vandringar — en plats där The Shinings mardrömslika atmosfär tycks ha blivit verklighet.

Källa: Engelska Wikipedia "The Stanley Hotel" + ghostcitytours.com + usghostadventures.com + roadtrippers.com',
  NULL,NULL,NULL,true,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. EASTERN STATE PENITENTIARY — Al Capones plågade nätter
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'eastern-state-penitentiary','Eastern State Penitentiary','eastern-state-penitentiary','USA','Pennsylvania, Philadelphia','Fängelse',
  39.9684,-75.1727,4,false,true,NULL,
  'Isoleringsstraffets vagga — där Al Capone sägs ha hemsökts av anden efter ett av sina mordoffer.',
  'Eastern State Penitentiary i Philadelphia öppnade 1829 som en av de första byggnaderna i USA med centralvärme och rinnande vatten — något inte ens Vita huset kunde skryta med. Fängelset var pionjär för isoleringsstraffet, som drev otaliga fångar till vansinne. Det stängde 1971.

Bland dess mest kända fångar fanns Al Capone, som 1929 avtjänade åtta månader här för vapenbrott. Hans cell var lyxutrustad med fåtölj, orientalisk matta, lampor, radio och garderob. Enligt legenden hemsöktes Capone under sin tid här av anden efter James Clark, ett av offren i Alla hjärtans dag-massakern; fångar i hans cellblock påstod sig höra honom på natten be Clarks ande att lämna honom i fred.

Den förfallande, slottslika anläggningen räknas som Pennsylvanias mest hemsökta plats. En kvinnlig uppenbarelse syns så ofta i den sista cellen på andra våningen att personalen döpt henne till "tvålkvinnan". I cellblock 4 ska en underhållsarbetare på 1990-talet ha drabbats av en intensiv känsla av ondska, sett plågade ansikten på cellväggarna och en skuggestalt som hoppade tvärs över blocket.

Eastern State har undersökts grundligt av paranormala team och figurerat i tv-program som Ghost Adventures och Ghost Hunters. Idag är det ett museum — och varje höst en av landets mest berömda spökattraktioner.

Källa: ghostcitytours.com + phillyghosts.com + hauntedus.com + frightfind.com',
  NULL,NULL,NULL,true,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. WAVERLY HILLS SANATORIUM — liktunneln "the body chute"
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'waverly-hills-sanatorium','Waverly Hills Sanatorium','waverly-hills-sanatorium','USA','Kentucky, Louisville','Sanatorium',
  38.1167,-85.8408,5,false,true,NULL,
  'De döda fördes ut i hemlighet genom "liktunneln" — och rum 502 bär en sjuksköterskas tragedi.',
  'Waverly Hills Sanatorium i Louisville i Kentucky öppnade 1910 som ett litet tvåvåningssjukhus för 40–50 tuberkulospatienter, under den epidemi av "vita pesten" som härjade Jefferson County. När behovet växte uppfördes 1924–1926 en femvånings byggnad för över 400 patienter.

Efter att antibiotikan streptomycin införts 1943 minskade tuberkulosfallen, och 1961 stängde sanatoriet. Året därpå öppnade det som Woodhaven geriatriska center, ett vårdhem för åldrande dementa och svårt funktionsnedsatta — men efter anklagelser om vanvård stängdes även det av delstaten 1980.

Sjukhusets mörkaste symbol är "the body chute" — liktunneln — en lång underjordisk gång som användes för att i hemlighet föra ut de döda, så att de levande patienterna inte skulle se hur många som dukade under. Efter decennier av lidande och död räknas Waverly Hills idag som en av världens mest hemsökta byggnader.

Besökare berättar ofta om plötsliga kalla fläckar, kroppslösa röster som ropar på hjälp och samtal från osynliga källor. Mest ökänt är rum 502, dit sjuksköterskor förr drog sig undan när de själva insjuknade — och där en sjuksköterska enligt sägnen tog sitt liv. Många besökare berättar också om en liten pojke vid namn Timmy som sägs leka i korridorerna, och om en skuggestalt som rör sig längs väggarna. Idag erbjuds historiska turer och paranormala nattvandringar i de förfallande, ekande korridorerna, och tv-program som Ghost Hunters har gjort platsen världsberömd.

Källa: Engelska Wikipedia "Waverly Hills Sanatorium" + americanhauntingsink.com + usghostadventures.com + thelittlehouseofhorrors.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. WINCHESTER MYSTERY HOUSE — trappor som leder ingenstans
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'winchester-mystery-house','Winchester Mystery House','winchester-mystery-house','USA','Kalifornien, San Jose','Herrgård',
  37.3184,-121.9511,3,false,true,NULL,
  'Änkan byggde i 36 år utan uppehåll för att fly gevärsoffrens andar — trappor leder rakt in i taket.',
  'Winchester Mystery House i San Jose i Kalifornien var bostad åt Sarah Winchester, änka efter vapenmagnaten William Wirt Winchester. Hon byggde på den viktorianska herrgården oavbrutet i 36 år, från 1886 till sin död 1922.

Sarah hade förlorat både sitt enda barn, Annie, som dog en månad gammal 1866, och sin make i tuberkulos 1881 — varpå hon ärvde 20 miljoner dollar och blev en av USA:s rikaste kvinnor. Enligt den populära sägnen sökte hon upp ett medium, som sade att hon hemsöktes av andarna efter alla som dödats av Winchestergeväret, och att hon för att undkomma dem måste flytta västerut och bygga utan uppehåll.

Resultatet blev ett arkitektoniskt vansinne på över 160 rum: trappor som leder rakt in i taket, dörrar som öppnas mot en åtta fots fallhöjd ned till en diskbänk eller femton fot ned i buskarna, fönster placerade där inget ljus når dem, och fler hemliga gångar än man kan räkna. Av husets 2 000 dörrar går många inte att passera.

Historiker betonar att det inte finns något belägg för att Sarah faktiskt besökte medier eller kände skuld. Men huset, av Time utnämnt till en av världens mest hemsökta platser, har dragit till sig otaliga paranormala utredare. Idag erbjuds turer och spökjakter i den labyrintiska herrgården.

Källa: Engelska Wikipedia "Winchester Mystery House" + winchestermysteryhouse.com + Atlas Obscura + Legends of America',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 5. MYRTLES PLANTATION — Chloe och den förbannade spegeln
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'myrtles-plantation','Myrtles Plantation','myrtles-plantation','USA','Louisiana, St. Francisville','Herrgård',
  30.7868,-91.3690,4,false,true,NULL,
  'Den förslavade Chloe bakade en giftig tårta — och en bortglömd spegel fångade de dödas själar.',
  'Myrtles Plantation i St. Francisville i Louisiana, byggd 1796, kallas ofta ett av USA:s mest hemsökta hus. Dess mest kända spöke är Chloe.

Enligt sägnen var Chloe en förslavad kvinna hos familjen Woodruff. Sedan hon avslöjats med att tjuvlyssna ska ett av hennes öron ha skurits av, varför hon bar en grön turban för att dölja stympningen. I hämnd, eller för att göra sig oumbärlig, ska hon ha bakat en tårta med kokta, giftiga oleanderblad — som dödade två av husets barn och deras mor.

En spegel i huset sägs hysa andarna efter mor och barn. Enligt seden täcktes speglar efter ett dödsfall, men just denna ska ha glömts bort — varpå de dödas själar fångades i glaset, där de ännu skymtas eller lämnar handavtryck.

Historiskt vilar legenden dock på lös grund. Folkräkningarna bekräftar att familjen ägde förslavade människor, men det finns inga belägg för någon Chloe, och mor och barn dog inte av gift utan i gula febern. Trots det lever berättelserna vidare, och Myrtles Plantation drivs idag som värdshus och museum, där gäster och personal berättar om uppenbarelser, steg och oförklarliga händelser i de gamla rummen — särskilt nära den ökända spegeln.

Källa: Engelska Wikipedia "Legends of Myrtles Plantation" + themoonlitroad.com + myrtlesplantation.com + americanhauntingsink.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 6. LALAURIE MANSION — New Orleans ondskefullaste hus
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'lalaurie-mansion','LaLaurie Mansion','lalaurie-mansion','USA','Louisiana, New Orleans','Herrgård',
  29.9595,-90.0637,4,true,false,NULL,
  'Branden 1834 blottade torterade slavar på vinden — de plågades skrik sägs ännu eka i kvarteret.',
  'LaLaurie Mansion på 1140 Royal Street i New Orleans franska kvarter räknas som en av stadens mest hemsökta — och ondskefulla — byggnader. Den uppfördes 1832 av societetsdamen Madame Delphine LaLaurie, som i hemlighet torterade och mördade förslavade människor i sitt hushåll.

Den 10 april 1834 ryckte räddningsmanskap ut till en brand i herrgården och gjorde en fasansfull upptäckt: på vinden fann de förslavade människor, fastkedjade och med spår av grym, långvarig misshandel. Enligt tidningen The New Orleans Bee påträffades "sju slavar, mer eller mindre fruktansvärt lemlästade", inlåsta i byggnaden. De svultna och torterade offren fördes till Cabildo för vård.

En rasande folkmassa plundrade därefter huset, medan Madame LaLaurie flydde till Frankrike med sin familj och aldrig ställdes inför rätta. Sedan dess har människor rapporterat om de misshandlade slavarnas plågade skrik som ekar genom kvarteren, lukten av brinnande kött, ljudet av släpande kedjor och uppenbarelser — bland dem en storväxt svart man i kedjor och en vit kvinna med stirrande blick.

Det bör nämnas att historiker manar till försiktighet: The New Orleans Bee var den enda tidning som beskrev de lemlästade slavarna, och uppgifterna byggde delvis på hörsägen. Men oavsett detaljerna förblir LaLaurie-huset en symbol för verklig grymhet — och New Orleans mörkaste spökhus.

Källa: Engelska Wikipedia "Delphine LaLaurie" + ghostcitytours.com + frenchquarterphantoms.com + allthatsinteresting.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 7. TRANS-ALLEGHENY LUNATIC ASYLUM — lobotomiprojektets hem
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'trans-allegheny-asylum','Trans-Allegheny Lunatic Asylum','trans-allegheny-asylum','USA','West Virginia, Weston','Asyl',
  39.0382,-80.4686,4,false,true,NULL,
  'Byggd för 250, fylld med tio gånger fler — och hem för West Virginia Lobotomy Project.',
  'Trans-Allegheny Lunatic Asylum i Weston i West Virginia tog emot patienter från 1864 till 1994. Bygget inleddes 1858 och stod färdigt först 1881, ritat enligt den så kallade Kirkbride-planen av arkitekten Richard Snowden Andrews.

Den väldiga byggnaden var ursprungligen tänkt att hysa högst 250 personer. Men på 1950-talet rymde den tio gånger så många, och vårdkvaliteten rasade. Patienterna utsattes för insulinchock, elchock, hydroterapi och lobotomier; i början av 1950-talet blev Weston State Hospital hem för West Virginia Lobotomy Project, ett försök att minska den svåra överbeläggningen genom lobotomi.

Bristen på vård och sanitet, i kombination med den enorma trängseln, ledde till ett stort antal dödsfall. Någon officiell siffra finns inte, men uppskattningarna pekar mot att dödstalet kan ha legat i eller över femsiffriga tal — ett ofattbart mått av lidande inom dessa murar.

Sedan stängningen räknas asylen som en av USA:s mest hemsökta. Besökare och paranormala team berättar om kroppslösa röster, steg, skuggestalter och känslan av att bli berörd i de tomma salarna. Sedan 2007 hålls varje höst en festival med historiska turer, paranormala nattvandringar och tävlingar i den kolossala, vittrande byggnaden — ett av landets mest storslagna och olycksbådande minnesmärken över psykvårdens mörka historia.

Källa: Engelska Wikipedia "Trans-Allegheny Lunatic Asylum" + Legends of America + usghostadventures.com + allthatsinteresting.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 8. ALCATRAZ — kalla fläckar i cellblock D
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'alcatraz','Alcatraz','alcatraz','USA','Kalifornien, San Francisco','Fängelse',
  37.8267,-122.4230,4,false,true,NULL,
  'Cell 14D är tio grader kallare än resten — och kalla fläckar rör sig genom blocket i mänsklig form.',
  'Alcatraz, "the Rock", är den ökända ön i San Francisco-bukten som mellan 1934 och 1963 hyste ett federalt högsäkerhetsfängelse. Innan dess var ön en militär befästning och militärfängelse. Idag räknas Alcatraz som en av Amerikas mest hemsökta platser.

Mest ökänt är cellblock D, "the Treatment Unit", med 42 celler — varav fem kallades "the Hole", där fångar kunde sitta upp till nitton dagar i totalt mörker och isolering. Cell 14D, klädd i stål och utan vask eller toalett, sägs vara omkring tio grader kallare än resten av blocket. Utredningar med värmekameror har dokumenterat kalla fläckar som rör sig genom cellhuset i mönster som inte stämmer med luftcirkulationen, och som ibland tycks anta mänsklig form och förflytta sig från cell till cell.

Vakter i cellblock D berättade om en man i 1800-talskläder, kanske samma gestalt som setts vid fängelsedirektörens julfest. Decennier efter Al Capones tid har banjomusik hörts från hans gamla cell och i duschutrymmet, där han brukade öva. Personalen har vittnat om oförklarliga krascher, springande steg, kusliga skrik, celldörrar som slagit igen av sig själva, jämmer, skramlande kedjor och en ständig känsla av att vara iakttagen.

Idag är Alcatraz ett av San Franciscos mest besökta utflyktsmål — en ö där fångenskapens fasor tycks ha etsat sig fast i de kalla betongmurarna.

Källa: Legends of America + sfghosts.com + ghostcitytours.com + amyscrypt.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 9. LIZZIE BORDEN HOUSE — yxmorden 1892
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'lizzie-borden-house','Lizzie Borden House','lizzie-borden-house','USA','Massachusetts, Fall River','Hus',
  41.7000,-71.1547,4,false,true,NULL,
  'Andrew och Abby Borden höggs ihjäl med yxa 1892 — Lizzie sägs ta kvävtag på gäster i sin säng.',
  'Lizzie Borden House i Fall River i Massachusetts är platsen för ett av Amerikas mest berömda olösta mordfall. Den 4 augusti 1892 mördades Andrew och Abby Borden i sitt hem, ihjälhuggna med en yxa — Abby med nitton hugg, Andrew med elva.

Andrews dotter Lizzie Borden åtalades för morden men frikändes 1893 av en förstående, helt manlig jury. Vem som egentligen utförde dåden har aldrig fastställts, och fallet har sedan dess fascinerat och förfärat generationer.

Huset, som idag drivs som värdshus och museum, kallas av många USA:s mest hemsökta. Gäster och personal berättar om underliga viskningar, skuggestalter och spöklika steg. Bland rapporterna finns spökkatter, uppenbarelser, gungstolar som gungar av sig själva — och Lizzie själv, som sägs ännu hemsöka huset och ta kvävtag på gäster som lägger sig i hennes säng.

Värdshuset erbjuder två sviter och fyra rum för uthyrning, och det rum där styvmodern Abby Borden hittades mördad är det mest efterfrågade. Frukosten speglar dessutom det som familjen Borden åt den ödesdigra morgonen. Huset är öppet dagligen från klockan tio på förmiddagen till midnatt, med historiska turer, spökturer och nattliga spökjakter. För den som vågar tillbringa natten på mordplatsen, i samma rum där yxan föll, väntar en av landets mest skräckinjagande övernattningar.

Källa: Engelska Wikipedia "Lizzie Borden House" + lizzie-borden.com + usghostadventures.com + bostonghosts.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 10. GETTYSBURG — inbördeskrigets rastlösa soldater
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'gettysburg-battlefield','Gettysburg slagfält','gettysburg-battlefield','USA','Pennsylvania, Gettysburg','Slagfält',
  39.7920,-77.2419,3,true,false,NULL,
  'Över 50 000 föll på tre dagar 1863 — fantomsoldater sägs ännu marschera vid Devils Den.',
  'Slagfältet vid Gettysburg i Pennsylvania var platsen för det amerikanska inbördeskrigets blodigaste slag den 1–3 juli 1863, med över 50 000 stupade, sårade och saknade. Många menar att slaget lämnade ett ärr på platsen, och Gettysburg räknas idag som en av Amerikas mest hemsökta orter — full av rastlösa själar efter glömda soldater som aldrig funnit ro.

Den mest ökända platsen är Devils Den, en klippformation där striderna rasade som värst. Besökare berättar gång på gång om kameror som krånglar, gestalter som dyker upp på fotografier och avlägset gevärseld och skrik som ekar mellan klipporna. Också Triangular Field, the Wheatfield, Little Round Top och Sachs Bridge hör till de mest aktiva platserna.

Otaliga vittnen berättar om fantomsoldater — sedda marschera i formation, rida till häst eller fortfarande strida — samt marscherande steg, avlägsna röster, vapenslammer och kanonliknande dån.

I staden finns också spökhus. Jennie Wade, 20 år, var den enda civila som dödades i slaget, träffad av en kula medan hon bakade bröd i sin systers kök. I huset rapporteras dörrar som öppnas och stängs av sig själva, kroppslösa röster och känslan av att bli iakttagen — och många tror att Jennies ande ännu dröjer kvar där hon mötte sin död.

Källa: history.com + National Geographic + americanhauntingsink.com + gettysburgghosts.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
