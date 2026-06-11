-- Spökkartan — 12 fler hemsökta platser i USA, omgång 10 (USA 32 -> 44)
-- Genererad 2026-06-10. METOD: engelska sökord -> Wikipedia, ghostcitytours.com,
-- usghostadventures.com, Legends of America, Atlas Obscura m.fl. Svenska, 200-600 ord.
-- Koordinater landmärkesnivå (Maps/OSM ej nåbara i miljön). Kör i Supabase SQL Editor.

BEGIN;

-- 1. CECIL HOTEL
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'cecil-hotel','Cecil Hotel','cecil-hotel','USA','Kalifornien, Los Angeles','Hotell',
  34.0445,-118.2480,4,false,false,NULL,
  'Night Stalker bodde här och Elisa Lam hittades död i vattentanken — 80 dödsfall, 16 oförklarade.',
  'Cecil Hotel i Los Angeles byggdes 1924 och har sedan dess varit skådeplats för en lång rad självmord, mord och mystiska dödsfall — vilket gjort det till ett av Amerikas mest ökända och hemsökta hotell. Av omkring 80 dödsfall på hotellet förblir 16 oförklarade.

Platsen är även knuten till seriemördare. Richard Ramirez — "the Night Stalker" — bodde på Cecil under sin mordturné i mitten av 1980-talet, då han dödade minst tretton människor.

Mest känt är fallet Elisa Lam. År 2013 spreds övervakningsfilm där den unga kanadensiska studenten betedde sig märkligt i hotellets hiss. Nitton dagar senare klagade gäster på lågt vattentryck och en underlig smak i kranarna — varpå Elisa Lams kropp hittades flytande i en av takvattentankarna, naken med kläderna drivande intill. Rättsläkaren bedömde dödsfallet som en olyckshändelse genom drunkning, med hennes bipolära sjukdom som bidragande faktor.

Paranormala utredare har genomfört otaliga undersökningar på hotellet och fångat oförklarliga ljud, plötsliga temperaturfall och skuggestalter. Många knyter de kusliga upplevelserna just till de översta våningarna och till hisschaktet där Elisa Lam sågs sista gången. Tillsammans med de många verkliga tragedierna har detta cementerat Cecils rykte som en av Los Angeles mörkaste platser — en byggnad där olyckan tycks ha bott kvar i väggarna i ett sekel, och som inspirerat både dokumentärer och skräckserier.

Källa: ghostcitytours.com + laghosttour.com + americanghostwalks.com + Medium (C.L. Nichols)',
  NULL,NULL,NULL,true,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. FRANKLIN CASTLE
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'franklin-castle','Franklin Castle','franklin-castle','USA','Ohio, Cleveland','Hus',
  41.4830,-81.7220,3,false,false,NULL,
  'Ohios mest hemsökta hus — mänskliga ben i en garderom och en familj tyngd av dödsfall.',
  'Franklin Castle (Tiedemann House) i Cleveland i Ohio uppfördes 1881–1883 åt den välbärgade tyske invandraren Hannes Tiedemann. Den dystra stenvillan kallas ofta hela Ohios mest hemsökta hus.

Familjen Tiedemann drabbades av flera dödsfall. Den femtonåriga dottern Emma dog i diabetes i januari 1881, och hustrun Louise avled i leversjukdom 1895, 57 år gammal. Tvärtemot ryktena dog dock inget av barnen i själva huset, som stod färdigt först 1883.

Spökhistorierna började först på 1960-talet, sedan en tysk klubb sålt huset 1968 och familjen Romano med sina sex barn flyttat in. Ryktet gjorde gällande att huset hemsöktes av fru Tiedemann och dottern Emma. År 1975 hittades mänskliga ben i en garderob — men det tros att de planterats av en ägare som ville göra reklam för sina spökturer.

Historiker manar till eftertanke. Författaren William Krejci, som skrivit en bok om Franklin Castle, menar att berättelserna om Hannes Tiedemanns grymhet förstorats med åren: "De var mycket vänliga människor. Herr Tiedemann var en välgörare i samhället." Genom åren har dock boende och besökare berättat om kvinnoröster, barngråt, dörrar som slår igen av sig själva och en kvinna i svart som skymtas i tornrummet. Oavsett hur det förhåller sig med sanningen lever Franklin Castle vidare som Clevelands mest sägenomspunna byggnad, med torn, gargoyler och en olycksbådande historia.

Källa: Engelska Wikipedia "Franklin Castle" + clevelandhistorical.org + allthatsinteresting.com + ghostsofohio.org',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. SHANGHAI TUNNELS
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'shanghai-tunnels-portland','Shanghai Tunnels','shanghai-tunnels-portland','USA','Oregon, Portland','Tunnel',
  45.5255,-122.6730,4,false,true,NULL,
  'Berusade män bortrövades till havs genom gångarna — och Ninas ande kastades i ett hisschakt.',
  'Shanghai Tunnels i Portland i Oregon är ett nät av underjordiska gångar, främst under Old Town Chinatown, som band samman källarna till hotell och krogar med Willamettefloden. Tunnlarna byggdes för att frakta varor från fartygen till källarförråden utan att störa gatutrafiken.

Enligt legenden användes de också för "shanghaiing": kaptener betalade omkring femtio dollar per huvud för bortrövade besättningsmän. Värvare strök runt i Portlands barer, lurade berusade, ensamma män till källaren, slog dem medvetslösa och släpade dem genom tunnlarna till hamnen. Som mest ska 2 000 personer om året ha shanghajats. Historiker betonar dock att även om tunnlarna och shanghaiing fanns, saknas belägg för att just tunnlarna användes för detta — berättelsen spreds via The Oregonian 1962 och populariserades av tunnelturer på 1970-talet.

Tunnlarna sägs vara en av planetens mest hemsökta platser. Djupt nere känner besökare hur det kryper i skinnet, som om någon iakttar dem ur skuggorna. Många berättar om en asiatisk man som går förbi, en ande de döpt till "Sam". Mest känd är dock Nina — en social reformator eller prostituerad som enligt sägnen mördades och kastades ned i ett hisschakt sedan hon försökt avslöja shanghaiingens sanning. Turerna utgår från Old Town Pizza, en gång lobbyn i det påstått hemsökta Merchant Hotel från 1880.

Källa: Engelska Wikipedia "Shanghai tunnels" + travelportland.com + usghostadventures.com + portlandghosts.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. HOTEL MONTELEONE
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'hotel-monteleone','Hotel Monteleone','hotel-monteleone','USA','Louisiana, New Orleans','Hotell',
  29.9560,-90.0660,3,false,true,NULL,
  'Lille Maurice dog på 1890-talet och visade sig för sin mor — på den ökända fjortonde våningen.',
  'Hotel Monteleone i New Orleans franska kvarter byggdes 1886 av den siciliske invandraren Antonio Monteleone och är än idag familjeägt. Berömt är hotellets Carousel Bar från 1949 — New Orleans första och enda roterande bar, vars handmålade karusellsäten gör ett långsamt varv var femtonde minut.

Den mest kända spökhistorien handlar om Maurice Begere. Enligt Historic Hotels of America var Maurice en liten pojke som bodde på hotellet med sin familj på 1890-talet. Medan föräldrarna var på operan insjuknade han hastigt i sin barnsköterskas vård och dog samma natt. Enligt sägnen visade sig Maurice senare för sin mor på fjortonde våningen och bad henne att inte gråta — han mådde bra. Många gäster har sedan dess sett honom på just den våningen.

Fjortonde våningen — som i själva verket är den trettonde — anses mest hemsökt. Gäster har sett spökgestalter i tidstypiska kläder sitta vid baren, bara för att de ska försvinna när man närmar sig, och barens speglar sägs ibland återspegla ansikten på personer som inte finns i rummet.

Genom åren har författare som Ernest Hemingway, Tennessee Williams och William Faulkner bott på Monteleone, vilket gett hotellet en rik litterär historia vid sidan av dess spökerier.

Källa: ghostcitytours.com + usghostadventures.com + Historic Hotels of America + beyondhaunted.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 5. MARSHALL HOUSE
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'marshall-house','The Marshall House','marshall-house','USA','Georgia, Savannah','Hotell',
  32.0795,-81.0920,3,false,true,NULL,
  'Amputerade lemmar gömdes under golvet 1864 — soldaternas andar söker ännu en kirurg i korridorerna.',
  'Marshall House i Savannah i Georgia öppnade 1851 och är stadens äldsta hotell i drift. Under amerikanska inbördeskriget ockuperade Unionsarmén byggnaden 1864–65 och använde den som fältsjukhus för sårade soldater.

När hotellet renoverades i slutet av 1990-talet fann arbetare mänskliga kvarlevor under golvbräderna på nedervåningen. Platsen blev kort en brottsplats, tills man insåg att nedervåningen en gång varit sjukhusets operationsrum — benen kom sannolikt från soldaters amputerade lemmar. Enligt berättelsen drabbades läkarna 1864 av en bister vinter då den frusna marken gjorde det omöjligt att begrava de många avskurna armarna och benen; deras lösning blev att gömma kvarlevorna under golvet.

Marshall House har sedan dess fått rykte om sig som hemsökt. Gäster berättar om amputerade soldaters andar som vandrar tomt och planlöst genom hotellet. En av dem har setts i lobbyn med sin saknade arm i handen, vädjande till gästerna att hjälpa honom finna en kirurg. Andra har klagat över en fruktansvärd stank, som av ruttnande kött, om kranar som vrids på av sig själva mitt i natten, och om barn som hörs springa och skratta i de tomma korridorerna. Fjärde våningen är mest aktiv, och rum 414 är det med flest rapporterade syner — ett elegant hotell med en blodig krigshistoria gömd i sina golv.

Källa: usghostadventures.com + ghostcitytours.com + savannahfirsttimer.com + frightfind.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 6. FORT MIFFLIN
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'fort-mifflin','Fort Mifflin','fort-mifflin','USA','Pennsylvania, Philadelphia','Fort',
  39.8790,-75.2120,3,false,true,NULL,
  'Den skrikande kvinnan skriker så att polisen tillkallas — och smeden Jacob grälar än med sin befälhavare.',
  'Fort Mifflin vid Delawarefloden i Philadelphia togs i bruk 1771 och räknas som en av Pennsylvanias mest hemsökta platser. Hösten 1777 höll en liten garnison på 400 frusna, svältande amerikanska soldater stånd mot 250 brittiska örlogsfartyg i sex brutala veckor.

Den mest kusliga anden är "den skrikande kvinnan". Vittnen har hört henne utstöta ett så bloddrypande skrik att polisen tillkallats. Enligt sägnen sörjer hon högljutt de män som föll under belägringen av Fort Mifflin, och förknippas allt oftare med officersbostäderna. Den första rapporterade övernaturliga händelsen — just den skrikande kvinnan — inträffade redan 1778, bara ett år efter krigets slut.

Bland fortets övriga andar finns "den ansiktslöse mannen", "lykttändaren", barn och hundar, samt en smed vid namn Jacob. Han grälade ofta med sin befälhavare och krävde att dörrar och fönster skulle hållas öppna — ett gräl som sägs fortgå än idag, då vittnen berättar om dörrar och fönster som öppnas och stängs av sig själva i den gamla smedjan.

Besökare har i århundraden rapporterat kusliga möten och oförklarliga fenomen vid Fort Mifflin: spöksteg, viskningar från osynliga gestalter och en ständig känsla av att det förflutnas soldater aldrig riktigt lämnat sin post.

Källa: ghostcitytours.com + phillyghosts.com + Atlas Obscura + fortmifflin.us',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 7. ATHENS LUNATIC ASYLUM (THE RIDGES)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'athens-lunatic-asylum','Athens Lunatic Asylum (The Ridges)','athens-lunatic-asylum','USA','Ohio, Athens','Asyl',
  39.3260,-82.1100,4,true,false,NULL,
  'En patient hittades död efter 42 dagar — hennes kroppsavtryck syns ännu kvar i golvet.',
  'Athens Lunatic Asylum i Ohio öppnade den 9 januari 1874, ritat enligt den så kallade Kirkbride-planen med dess karakteristiska "fladdermusvinge"-planlösning och påkostade viktorianska arkitektur. Anstalten stängde 1993, varpå området döptes om till "The Ridges".

Platsens mest ökända historia är Margaret Schillings. Patienten försvann den 1 december 1978 och hittades död först 42 dagar senare, den 12 januari 1979, av en vaktmästare i en låst, sedan länge övergiven avdelning som en gång använts för patienter med smittsamma sjukdomar. Trots att hon dött av hjärtsvikt låg hon helt naken, med kläderna prydligt vikta bredvid kroppen.

Ett avtryck av hennes hår och kropp syns ännu kvar i golvet, trots upprepade försök att få bort det. En rättsteknisk grupp som undersökte fläcken 2007 fann att avtrycket sannolikt uppstått genom adipocere — när kroppens fett under förruttnelsen bryts ned till en tvålliknande massa.

Studenter vid närliggande Ohio University har påstått sig se en kvinna stirra ned från vindsfönstret där Margaret hittades, och andra har sett en skuggestalt försöka fly ur rummet. Också på den intilliggande kyrkogården, där hundratals patienter ligger begravda under nummerförsedda stenar utan namn, berättas om kroppslösa röster och kalla fläckar. Hennes ande sägs vandra genom byggnaden om natten — en rastlös själ i en plats tyngd av institutionsvårdens mörka arv.

Källa: legendsofamerica.com + thepreservationworks.org + ohioexploration.com + thelittlehouseofhorrors.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 8. RIDDLE HOUSE
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'riddle-house','Riddle House','riddle-house','USA','Florida, Royal Palm Beach','Hus',
  26.6920,-80.2330,3,false,true,NULL,
  'Ett forna begravningskapell där Joseph hängde sig på vinden — och nu sägs angripa män.',
  'Riddle House byggdes 1905 i West Palm Beach i Florida och flyttades senare till friluftsmuseet Yesteryear Village i Royal Palm Beach. Huset var ursprungligen ett begravningskapell, men på 1920-talet köpte Karl Riddle det och gjorde det till privatbostad. År 1995 plockades huset ned och återuppfördes på museet i sitt 1920-talsskick.

Huset sägs hemsökas av en ande vid namn Joseph, en anställd hos Riddle som hängde sig på vinden hellre än att möta sina ekonomiska problem. Hans ande sägs ogilla män och har sagts angripa dem. Besökare och personal berättar om föremål som rör sig av sig själva, oförklarliga ljud och en genomträngande känsla av obehag, särskilt på vinden.

Andra rapporter beskriver en kvinna i vitt som skymtas i de övre fönstren, kroppslösa röster, steg och ljudet av kedjor. Snickare som arbetat med huset lär på morgnarna ha funnit sina verktyg utkastade från vinden ned på bakgården.

Husets rykte som hemsökt förstärktes ytterligare när det 2008 figurerade i tv-programmet Ghost Adventures, vars team uppgav att en av dem knuffades och att utrustning kastades omkring under inspelningen på vinden. Idag är Riddle House en av södra Floridas mest besökta spökplatser — en tidskapsel från 1920-talet med en ande som vägrar lämna sin vind.

Källa: Engelska Wikipedia "Riddle House" + floridahauntedhouses.com + miamihaunts.com + paranormaltraveler.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 9. PALMER HOUSE HOTEL
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'palmer-house-hotel','Palmer House Hotel','palmer-house-hotel','USA','Minnesota, Sauk Centre','Hotell',
  45.7375,-94.9520,3,false,true,NULL,
  'Spökbarn i korridoren, en spökkatt i sängen och en dansande snögubbe som inte är inkopplad.',
  'Palmer House Hotel i Sauk Centre i Minnesota byggdes 1901 av Ralph Palmer, sedan det tidigare stadshotellet brunnit ned. Det var ett av de första företagen utanför Twin Cities med rinnande vatten och elektricitet, och fördes 1982 upp på det nationella registret över historiska platser.

Hotellet räknas som ett av Minnesotas mest hemsökta. Bland berättelserna finns barn som leker i korridoren trots att inga barn bor på hotellet, och gäster som hört och känt en spökkatt hoppa upp i sängen.

Bland de namngivna andarna finns Raymond, som för ett sekel sedan ska ha drivit en bordell på översta våningen och vars ande sägs hemsöka ett rum där uppe. En anställd berättade att hon samtalat med en kvinna som liknade Palmers dotter Hazel — innan kvinnan helt enkelt försvann. På trappan upp till andra våningen har en spökpojke med smutsblont hår och gröna ögon setts.

I källaren har en mörk skugga setts vandra fram och tillbaka i en dörröppning, och där flackar lamporna utan anledning. I ett annat rum sägs en snögubbsdekoration ibland dansa för gästerna — trots att den inte ens är inkopplad. Hotellet drar fortfarande till sig paranormala utredare från hela landet.

Källa: Engelska Wikipedia "The Palmer House (Sauk Centre)" + CBS Minnesota + kare11.com + usghostadventures.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 10. THE PIRATES HOUSE
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'pirates-house-savannah','The Pirates House','pirates-house-savannah','USA','Georgia, Savannah','Restaurang',
  32.0810,-81.0860,3,false,true,NULL,
  'Sjömän shanghajades genom tunneln till havs — skrik hörs ännu ur de igenbommade gångarna.',
  'The Pirates House i Savannah i Georgia är en krog som byggdes 1794 — vissa källor uppger så tidigt som 1753 som värdshus för sjöfarare. Den ryktas vara den äldsta byggnaden i hela delstaten Georgia. Hit kom pirater och sjömän för en drink, och stället blev snabbt traktens hetaste tillhåll för öl och slagsmål.

Från rumkällaren löper en unken tunnel ut mot River Street, som en gång användes för att frakta intet ont anande män. Många hamnade i baren för en öl eller två och vaknade ombord på ett fartyg hundratals mil från kusten — offer för "shanghaiing", som gjorde otaliga män till tvångstjänstgörande sjömän.

Författaren Robert Louis Stevenson lär ha besökt byggnaden och hämtat inspiration till Skattkammarön (1883). Enligt sägnen slutade kapten Flints liv i Savannah, kanske till och med i just det värdshus som inspirerade Stevensons karaktär.

Personalen berättar om kusliga närvaron och möten med sjömäns andar. Tunga stövelsteg har hörts röra sig i byggnaden efter stängning, och skrik har rapporterats från de igenbommade tunnlarna under huset. Glas och flaskor har kastats från hyllorna av osynliga krafter, skuggestalter vandrar i matsalarna, och steg ekar över trägolven — en av Savannahs mest hemsökta platser.

Källa: usghostadventures.com + savannahghosttour.com + destinationghost.com + thelittlehouseofhorrors.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 11. BOURBON ORLEANS HOTEL
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'bourbon-orleans-hotel','Bourbon Orleans Hotel','bourbon-orleans-hotel','USA','Louisiana, New Orleans','Hotell',
  29.9585,-90.0645,3,false,true,NULL,
  'Barn och nunnor från ett forna barnhem — och en ensam danserska under balsalens kristallkrona.',
  'Bourbon Orleans Hotel i New Orleans franska kvarter räknas till USA:s tio mest hemsökta hotell enligt USA Today. Det sägs hemsökas av barn och nunnor från ett tidigare kloster och barnhem, samt av en ensam spökdanserska.

Byggnaden har en lång historia. Orleans Theatre och den praktfulla Orleans Ballroom, ritad av Henry Latrobe, stod färdiga 1815–17. År 1881 köpte systrarna av Den heliga familjen den forna balsalen och gjorde om byggnaden till kloster och skola för afroamerikanska flickor — St. Marys Academy — samt ett barnhem för flickor. Egendomen såldes 1964.

Hotellet sägs hysa över tjugo andar. Bland dem finns unga flickor som dog i en gulafeber-epidemi, ett par nunnor som omkom på platsen, en nunna som tog sitt liv i rum 644, och en dansande kvinna i balsalen. Den berömda Orleans Ballroom är hemvist för en ensam spökdanserska, sedd virvla under kristallkronan. Flera gäster har också rapporterat prassel och en gestalt som gömmer sig bakom draperierna, trots att inget fönster är öppet och ingen finns där.

Också en konfedererad soldat — kallad "mannen" — sägs spöka på sjätte och tredje våningen, i detta eleganta hotell byggt på lager av New Orleans historia.

Källa: bourbonorleans.com + usghostadventures.com + ghostcitytours.com + hauntedrooms.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 12. OLD SOUTH PITTSBURG HOSPITAL
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'old-south-pittsburg-hospital','Old South Pittsburg Hospital','old-south-pittsburg-hospital','USA','Tennessee, South Pittsburg','Sjukhus',
  35.0110,-85.7030,4,false,true,NULL,
  'Tennessees mest hemsökta plats — barnskrik, skuggmänniskor och utrustning som slår på av sig själv.',
  'Old South Pittsburg Hospital i South Pittsburg i Tennessee grundades 1959 av fyra läkare och hette ursprungligen South Pittsburg Municipal Hospital. Den drygt 6 000 kvadratmeter stora byggnaden uppfördes för att möta vårdbehoven i ett växande samhälle, och stängde 1998.

Idag anses sjukhuset av många vara Tennessees mest hemsökta plats. Hit hör berättelser om barnskrik, helkroppsuppenbarelser, kroppslösa röster och skuggmänniskor, bland mycket annat övernaturligt.

Besökare och utredare rapporterar en mängd fenomen: skuggestalter, kroppslösa röster och föremål som rör sig av sig själva; lampor som flackar i tomma rum, dörrar som öppnas och stängs, och medicinsk utrustning som slås på utan anledning; samt hörbara ljud, EVP-inspelningar (röster i bandbrus), orbar och direkt kommunikation med andar via så kallade spirit boxes.

Många tror att aktiviteten härrör från de skador, sjukdomar och dödsfall som ägde rum medan sjukhuset var i drift. Dessutom ligger byggnaden på mark som en gång tillhörde Chiaha-folket, och under inbördeskriget dödades här både unionssoldater och medlemmar av urbefolkningen.

Byggnaden har köpts av en paranormal utredare och drivs nu som Old South Pittsburg Hospital Paranormal Research Center, med regelbundna utredningar och turer, och har figurerat i tv-program som Destination Fear och Kindred Spirits.

Källa: osphprc.com + onlyinyourstate.com + phantomhistory.com + kcghosts.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
