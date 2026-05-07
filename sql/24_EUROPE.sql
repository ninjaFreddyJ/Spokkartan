-- Spökkartan — 9 platser i Tyskland, Polen, Frankrike, Italien, Rumänien, Slovenien, Finland
-- Genererad 2026-05-04. Källa: engelska Wikipedia.
-- VIKTIGT: All text direkt från Wikipedia. Inga fakta hittade på.
--
-- NOTERING om Auschwitz: medvetet utelämnat. Auschwitz är ett UNESCO världsarv
-- och statlig minnesplats för 1,1 miljoner Förintelse-offer — det är inte
-- lämpligt att marknadsföra som spökattraktion. Om du vill ha det med i Spökkartan,
-- gör det som "minnesplats" i en separat kategori, inte som hemsökt plats.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. WEWELSBURG (Tyskland) — SS-slottet
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'wewelsburg-castle','Wewelsburg','wewelsburg-castle','Tyskland','Nordrhein-Westfalen, Büren','Slott',
  51.6069,8.6517,5,false,false,NULL,
  'SS-slottet under Himmler — planerad som "världens centrum" efter Tysklands seger.',
  'Wewelsburg är ett renässansslott beläget i byn Wewelsburg, en del av staden Büren i Westfalen, i Landkreis Paderborn i nordöstra Nordrhein-Westfalen, Tyskland. Slottet har en triangulär layout, med tre runda torn förbundna av massiva murar.

Heinrich Himmler tog officiellt över Wewelsburg i en stor ceremoni den 22 september 1934. Efter 1934 användes slottet av SS under Himmler och skulle byggas ut till ett komplex som skulle tjäna som central SS-kultplats. Efter 1941 utvecklades planer på att förstora det till så kallat "Centre of the World" — världens centrum efter den nazistiska "slutgiltiga segern".

Mellan 1936 och 1942 beordrade Himmler slottet att byggas ut och byggas om för ceremoniella ändamål. Arbetet koncentrerades på att bedriva grundläggande pseudovetenskaplig forskning inom germansk för- och tidig historia, medeltida historia, folklore och genealogi (Sippenforschung) — allt avsett att underbygga SS rasläror.

Fångar från det närliggande Niederhagen-koncentrationslägret användes som slavarbetare för utbyggnaden av Wewelsburg, som — enligt Himmlers planer — skulle bli "världens centrum" efter "Slutsegern".

År 1950 öppnade slottet på nytt som museum och vandrarhem. Idag rymmer det Historiska museet i furstebiskopsdömet Paderborn samt minnesmuseet Wewelsburg 1933–1945. "Generals Hall" och dess Solhjul i golvet — "Schwarze Sonne" — är platser där paranormala fenomen rapporteras.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Wewelsburg',
  NULL,NULL,NULL,true,true,'published','wikipedia_intl'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. FRANKENSTEIN CASTLE (Tyskland)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'frankenstein-castle','Frankenstein Castle','frankenstein-castle','Tyskland','Hessen, Darmstadt','Ruin',
  49.7900,8.6700,4,true,false,NULL,
  'Slottet som påstås ha inspirerat Mary Shelley — alkemisten Johann Konrad Dippels mörka experiment.',
  'Frankenstein Castle är en bergslott i Odenwald som blickar ut över staden Darmstadt i Tyskland. Före 1250 byggde herr Conrad II Reiz av Breuberg slottet och började därefter kalla sig "von und zu Frankenstein". 1292 öppnade Frankenstein-familjen slottet för grevarna av Katzenelnbogen och bildade en allians med dem. 1363 delades slottet i två delar och ägdes av två olika familjer av herrar och riddare av Frankenstein.

I början av 1400-talet utvidgades och moderniserades slottet. Frankenstein-riddarna blev åter oberoende av grevarna av Katzenelnbogen. Efter territoriella konflikter och tillhörande tvister med lantgrevskapet Hessen-Darmstadt beslutade familjeöverhuvudet John I att sälja herraväldet till lantgrevarna 1662.

Slottet användes därefter som tillflykt och sjukhus, och förföll till ruiner under 1700-talet. De två tornen som idag är så distinkta är en historiskt felaktig restaurering utförd i mitten av 1800-talet.

Slottets koppling till Mary Shelleys Frankenstein-roman är omtvistad — vissa hävdar att hon hörde berättelser om alkemisten Johann Konrad Dippel (1673–1734), född på slottet och känd för makabra experiment med kroppsdelar. Hennes biografer säger dock inget bestämt.

År 1978 startade amerikanska flygare från 435th Transportation Squadron en årlig Halloweenfestival vid slottet, som blev en av Europas största Halloweenfestivaler.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Frankenstein_Castle',
  NULL,NULL,NULL,true,true,'published','wikipedia_intl'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. WAWEL CASTLE (Polen)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'wawel-castle','Wawel Slott','wawel-castle','Polen','Małopolska, Kraków','Slott',
  50.0540,19.9354,3,false,false,NULL,
  'Polens kungliga residens — under slottet ligger Smocza Jama, draken Smok Wawelskis grotta.',
  'Wawel Royal Castle och Wawel-höjden den står på utgör den mest historiskt och kulturellt betydelsefulla platsen i Polen. En befäst residens vid floden Wisła i Kraków, etablerad på order av kung Kasimir III den store och utvidgat under århundraden till en samling byggnader runt en gård i polsk renässansstil. Med över 3,47 miljoner besökare 2025 är Wawel det mest besökta konstmuseet i Polen och det 14:e mest besökta i världen.

Några av Wawels äldsta stenbyggnader kan spåras tillbaka till år 970 e.Kr., samt de tidigaste exemplen på romansk och gotisk arkitektur i Polen. Det nuvarande slottet byggdes på 1300-talet och byggdes ut under de följande hundratals åren. År 1978 utsågs Wawel till UNESCO världsarv som del av "Historic Centre of Kraków".

Draken Smok Wawelski var en mystisk best som enligt sägnen terroriserade lokalbefolkningen — åt deras får och lokala oskuldssjäliga jungfrur — innan han enligt en version dödades hjältemodigt av Krakus, en legendarisk polsk prins som enligt traditionen grundade staden Kraków och byggde sitt palats på Wawel.

Idag firas drakdyret på Wawel-höjdens nedre sluttningar nära floden där en modern eldsprutande metallstaty står. Statyn är placerad framför Smocza Jama (Drakgrotten) — en av de kalkstensgrottor som finns spridda över höjden. Statyn installerades 1972 och kan på begäran släppa ut eld från sitt gap.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Wawel_Castle',
  NULL,NULL,NULL,true,true,'published','wikipedia_intl'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. KSIĄŻ CASTLE (Polen)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'ksiaz-castle','Książ Castle','ksiaz-castle','Polen','Niederschlesien, Wałbrzych','Slott',
  50.8417,16.2922,4,false,false,NULL,
  'Polens tredje största slott — under det två nivåer Nazi-tunnlar (Project Riese), 53 m djupt.',
  'Książ Castle ligger i norra Wałbrzych i Niederschlesien voivodskap, Polen, och är det tredje största slottet i Polen efter Marienburg och Wawel — det största i Schlesien-regionen.

Den schlesiska hertigen Bolko I den stränge lät bygga ett nytt slott från 1288 till 1292 och tog sin bostad där. Familjen von Hochberg ägde slottet fram till 1944.

Under andra världskriget togs slottet över av tyska militära myndigheter 1944. Närmare bestämt beslagtog den nazistiska regeringen slottet och dess marker 1941 — delvis som skattebetalning, delvis som straff för familjens söners förmodade förräderi.

"Riese" var kodnamnet för ett byggprojekt som genomfördes av Nazityskland mellan 1943 och 1945, bestående av sju underjordiska strukturer vid Książ Castle och i Eulengebirge i Niederschlesien. Under arkitekten Hermann Gieslers ledning anpassades slottet först för att hysa ledningen för statens järnvägar, men 1944 blev det en del av Project Riese.

Det allvarligaste arbetet ägde rum under slottet, med två tunnelnivåer — den första 15 meter under jord, åtkomlig från fjärde våningen, och den andra underjordiska nivån 53 meter under gården. Vad tunnlarna verkligen var avsedda för är fortfarande omtvistat — bunker för Hitler? Atomvapenfabrik? Ingen vet säkert.

Slottet är idag öppet för besökare med guidade turer i både den prunkande paradvåningen och delar av tunnelsystemet.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Ksi%C4%85%C5%BC_Castle',
  NULL,NULL,NULL,true,true,'published','wikipedia_intl'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 5. CATACOMBS OF PARIS (Frankrike)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'catacombs-of-paris','Catacombs of Paris','catacombs-of-paris','Frankrike','Île-de-France, Paris','Urban',
  48.8338,2.3324,5,false,false,NULL,
  '6 miljoner människors kvarlevor under Paris gator — flyttades dit i nattliga processioner från 1788.',
  'Pariserkatakomberna är underjordiska benhus i Paris, Frankrike, som rymmer kvarlevorna från mer än sex miljoner människor. De byggdes för att konsolidera Paris gamla stenbrott och sträcker sig söderut från den forna stadsporten Barrière d''Enfer ("Helvetets port").

Benhuset skapades som del av en insats för att eliminera effekterna av stadens överfulla kyrkogårdar. Förberedande arbete inleddes strax efter att 1774 års serie av källarväggsras runt Holy Innocents-kyrkogården gjorde behovet av att lägga ner kyrkogårdar akut. Från 1788 transporterade nattliga processioner av täckta vagnar kvarlevor från större delen av Paris kyrkogårdar till en gruvgång nära Rue de la Tombe-Issoire.

Det skulle ta två år att tömma huvuddelen av Paris kyrkogårdar. Bland kyrkogårdarna vars kvarlevor flyttades fanns Saints-Innocents (den största — cirka 2 miljoner begravda under 600 års drift), Saint-Étienne-des-Grès (en av de äldsta), Madeleine-kyrkogården, Errancis-kyrkogården (använd för franska revolutionens offer) och Notre-Dame-des-Blancs-Manteaux.

Katakomberna var i sina första år ett oorganiserat benförvar. Louis-Étienne Héricart de Thury, direktör för Paris gruvinspektion från 1810, ledde renoveringar som inkluderade staplandet av skallar, lårben och skenben i de mönster vi ser idag.

Allmänna besök började efter renoveringen till ett ordentligt benhus och 1814–1815 års krig. Benhuset blev en turistattraktion i liten skala från tidigt 1800-tal, och har varit öppet för allmänheten regelbundet sedan 1867.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Catacombs_of_Paris',
  NULL,NULL,NULL,true,true,'published','wikipedia_intl'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 6. CASTEL SANT'ANGELO (Italien)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'castel-santangelo-rome','Castel Sant''Angelo','castel-santangelo-rome','Italien','Lazio, Rom','Fästning',
  41.9031,12.4663,3,false,false,NULL,
  'Hadrianus mausoleum från 139 e.Kr — påvarnas tillflyktsfästning och fängelse genom 1900 år.',
  'Castel Sant''Angelo beställdes ursprungligen av den romerske kejsaren Hadrianus som ett mausoleum för honom själv och hans familj. Det uppfördes av kejsar Hadrianus mellan 134 och 139 e.Kr.

Påvarna använde senare byggnaden som fästning och slott tillägnat ärkeängeln Mikael, och idag är det ett museum. Strukturen var en gång den högsta byggnaden i Rom.

Fästningen var påven Klemens VII:s tillflykt under belägringen av Karl V:s landsknektar under "Sacco di Roma" 1527. Påvestaten använde också Sant''Angelo som fängelse — bland de mest kända fångarna var Giordano Bruno och alkemisten Cagliostro.

Leo X byggde ett kapell med en Madonna av Raffaello da Montelupo. 1536 skapade Montelupo också en marmorstaty av Sankt Mikael med svärd, för att kröna borgen efter pesten 590. Montelupos staty ersattes av en bronsstaty av samma motiv, utförd av den flamländske skulptören Peter Anton von Verschaffelt 1753 — den staty som idag ses på toppen.

Avvecklat 1901 är slottet idag ett museum: Museo Nazionale di Castel Sant''Angelo. Det tog emot 1 234 443 besökare 2016. En hemlig korridor — Passetto di Borgo — förbinder fästningen direkt med Vatikanen och användes av påvar i kris.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Castel_Sant%27Angelo',
  NULL,NULL,NULL,true,true,'published','wikipedia_intl'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 7. HOIA-BACIU FOREST (Rumänien)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'hoia-baciu-forest','Hoia-Baciu Forest','hoia-baciu-forest','Rumänien','Cluj, Cluj-Napoca','Skog',
  46.7869,23.5256,5,true,false,NULL,
  '"Transsylvaniens Bermuda-triangel" — UFO-foton 1968 och försvunna herdar enligt legenden.',
  'Hoia-Baciu-skogen (rumänska: Pădurea Hoia-Baciu, ungerska: Hója erdő) är en skog belägen väster om staden Cluj-Napoca, nära den utomhusbaserade delen av Transsylvaniens etnografiska museum. Skogen täcker ett område på cirka 3 kvadratkilometer.

Enligt legenden är Hoia-Baciu-skogen en hotspot för paranormala fenomen. Många spökhistorier och urbana legender bidrar till skogens popularitet som turistattraktion. Kallad "Transsylvaniens Bermuda-triangel" är skogen ett av världens mest aktiva områden vad gäller paranormala fenomen.

En legend beskriver en herde som försvann i skogen tillsammans med sina 200 får — ingen lyckades hitta varken honom eller någon del av flocken. Det var den första mystiska försvinnandet som ägde rum i skogen.

Hoia-skogen blev världsberömd efter att, den 18 augusti 1968, militärtekniker Emil Barnea fotograferade ett UFO i Round Glade (rumänska: Poiana Rotundă). Fotografierna räknas av experter som bland de få äkta i sitt slag.

Människor som av en slump passerar genom aktiva områden rapporterar hudbrännskador, rodnad, irritationer, huvudvärk, förstärkt törstkänsla, ångest och svimningskänsla. En särskilt karakteristisk plats är Round Glade — en perfekt cirkulär glänta där inga träd växer trots ideala förutsättningar.

Skogen används som vanligt rekreationsmål. På senare år har en cykelpark anlagts i skogen, tillsammans med områden för andra sporter som paintball, airsoft och bågskytte.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Hoia-Baciu_Forest',
  NULL,NULL,NULL,true,true,'published','wikipedia_intl'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 8. PREDJAMA CASTLE (Slovenien)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'predjama-castle','Predjama Castle','predjama-castle','Slovenien','Inre Krain, Postojna','Slott',
  45.8156,14.1283,4,false,false,NULL,
  'Renässansslottet inbäddat i en grottmun — Erasmus av Lueg överlevde belägringen via hemlig grottunnel.',
  'Predjama Castle är ett renässansslott byggt inuti en grottmun i centrala södra Slovenien, i den historiska regionen Inre Krain. Det ligger i byn Predjama, cirka 11 kilometer från staden Postojna och 9 kilometer från Postojna-grottan.

Slottet nämndes första gången 1274 under det tyska namnet Luegg, då patriarken av Aquileia byggde det i gotisk stil. Slottet byggdes under en naturlig stenbåge högt uppe i stenväggen för att försvåra åtkomst. Det förvärvades senare och utvidgades av den adliga Luegg-familjen, även känd som riddarna av Adelsberg.

Slottet blev känt som hemvist för riddaren Erasmus av Lueg, slottsherren på 1400-talet och en ökänd rövarbaron. Enligt legenden kom Erasmus i konflikt med Habsburgarna när han dödade marskalk Pappenheim, befälhavaren för den kejserliga armén. På flykt undan kejsar Fredrik III:s vrede tog Erasmus sin tillflykt till sin familjefästning Predjama. Därifrån allierade han sig med kung Mattias Corvinus och började attackera habsburgska egendomar och städer i Krain.

Ravbar försökte svälta ut Erasmus, men han överlevde tack vare mat som levererades via en hemlig tunnel genom grottsystemet under slottet. Han dödades till slut när en förrädare signalerade till belägrarna att avlossa kanonen mot toaletten — som var den enda delen av slottet utan stensköld.

År 1511 förstördes ett tidigare slott av en jordbävning. 1570 byggdes det nuvarande slottet i renässansstil tryckt mot en lodrät klippa under den ursprungliga medeltida fästningen. Slottet konfiskerades efter andra världskriget och förvandlades till museum av de jugoslaviska kommunisterna.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Predjama_Castle',
  NULL,NULL,NULL,true,true,'published','wikipedia_intl'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 9. SUOMENLINNA (Finland)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'suomenlinna','Suomenlinna','suomenlinna','Finland','Nyland, Helsingfors','Fästning',
  60.1455,24.9881,3,true,false,NULL,
  '"Nordens Gibraltar" — sjöfästningen från 1748 byggd av Sverige, idag UNESCO världsarv.',
  'Suomenlinna ligger sydost om centrala Helsingfors och består av åtta öar — fem av dem förbundna med broar eller en sandbank.

Bygget av fästningen påbörjades 1748 under svenska kronan som försvar mot Ryssland. Generalansvaret för befästningsarbetet gavs till amiral Augustin Ehrensvärd.

Fästningen har haft flera namn genom historien. Ursprungligen byggd under Sveriges styre i Finland under 1700-talet, var den känd som Viapori på finska och fick det nuvarande namnet Suomenlinna 1918. Sveaborg fick sitt nuvarande namn — Suomenlinna ("Finlands borg") — den 12 maj 1918, då den röd-gula lejonflaggan ceremoniellt hissades på flaggstången på Gustavssvärd.

Fästningen upplevde betydande militära händelser, inklusive en belägring våren 1808 under finska kriget — där fästningen, trots sitt formidabla rykte som "Nordens Gibraltar", kapitulerade efter två månaders belägring. Dessutom låg ett fångläger för röda upprorsmän på Suomenlinna efter finska inbördeskriget.

Suomenlinna förblev under finska försvarsdepartementets kontroll fram till 1973, då huvuddelen överfördes till civil förvaltning. Fästningen utsågs till UNESCO världsarv 1991. Suomenlinna är idag en av Helsingfors mest populära turistattraktioner och en uppskattad picknickplats för stadens invånare.

Spöksägner från fästningen handlar om svenska soldater och finska fångar — gestalter som setts på murar och i de underjordiska kasematterna.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Suomenlinna',
  NULL,NULL,NULL,false,true,'published','wikipedia_intl'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
