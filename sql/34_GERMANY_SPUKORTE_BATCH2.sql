-- Spökkartan — 9 fler hemsökta platser i Tyskland (Deutschland), omgång 2
-- Genererad 2026-06-09. Fortsättning på 33_GERMANY_SPUKORTE.sql.
--
-- METOD (samma generella lösning): översatte nyckelorden till tyska
-- (Spukorte, Geister, Gespenster, Spukschloss, Weiße Frau, Lost Place, Sage,
-- Hexen, Walpurgisnacht) och sökte tyska sidor som SAMLAT spökhistorier om
-- platser (GeisterNet, harzwelten.online, hohenzollern-orte.de, luther2017.de,
-- schloss-heidelberg.de, abandonedberlin.com, viasaga.de m.fl. samt tyska
-- Wikipedia/Wikisource). Skrivet på SVENSKA, 200-600 ord per plats, aldrig
-- fler ord än källmaterialet.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. AUERBACHS KELLER (Tyskland) — Faust och djävulen
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'auerbachs-keller','Auerbachs Keller','auerbachs-keller','Tyskland','Sachsen, Leipzig','Värdshus',
  51.3406,12.3753,2,false,false,NULL,
  'Tysklands äldsta vinkällare — här red doktor Faust ut på ett fat med djävulens hjälp.',
  'Auerbachs Keller är en av Tysklands äldsta och mest berömda krogar, belägen i Mädlerpassage i hjärtat av Leipzig i Sachsen. En vinstuga på platsen omnämns redan 1438, och 1525 lät läkaren och universitetsprofessorn Heinrich Stromer von Auerbach servera vin åt studenter i källaren under sitt hus.

Källarens rykte vilar på sägnen om doktor Faust. Enligt legenden — först nedtecknad i en Historia från 1589 — bad studenter i Wittenberg den lärde magikern och astrologen Johann Georg Faust att följa med dem till Leipzigs marknad. Goethe såg på 1700-talet två målningar från 1625 i källaren: den ena visade Faust drickande med studenter, den andra hur han red ut genom dörren på ett vinfat — ett konststycke han bara kunde utföra med djävulens hjälp.

Den unge Johann Wolfgang von Goethe studerade i Leipzig 1765–1768 och besökte ofta den berömda vinkällaren. I sitt drama Faust I reste han ett litterärt minnesmärke över sin studentkrog: i scenen "Auerbachs Keller i Leipzig" förhäxar Mefistofeles studenterna så att de tror sig stå i en vingård och vilja skära druvor — men inser plötsligt att de är på väg att skära av varandra näsorna.

När källaren återinvigdes den 22 februari 1913 restes vid ingången två skulpturgrupper: "Mefisto och Faust" samt "De förhäxade studenterna". Här, där dikt och djävulspakt möts, sägs Fausts skugga ännu dröja kvar mellan vinfaten.

Källa: Engelska Wikipedia "Auerbachs Keller" + leipzig-lese.de + leipzig.travel',
  NULL,NULL,NULL,true,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. BURG FALKENSTEIN (Tyskland) — det vita spöket
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'burg-falkenstein-harz','Burg Falkenstein','burg-falkenstein-harz','Tyskland','Sachsen-Anhalt, Harz','Borg',
  51.6817,11.2575,3,false,false,NULL,
  'En vit skugga vandrar i korridorerna — anden efter en riddare som söker sin förlorade kärlek.',
  'Burg Falkenstein reser sig på en bergsklint i Selketal i Harz, i Sachsen-Anhalt, och räknas till de bäst bevarade medeltidsborgarna i regionen. Enligt sägnen har borgen sitt ursprung i ett mord: omkring år 1080 dräpte Egeno II av Konradsburg i en träta greve Adalbert II av Ballenstedt. Som botgöring skulle mördarens släktsäte göras om till kloster, och Egenos son Burchard av Konradsburg lät i stället uppföra den nya Burg Falkenstein under första hälften av 1100-talet. Här ska Eike von Repgow ha författat den berömda lagboken Sachsenspiegel.

Men borgen är framför allt känd för sitt vita spöke. En spöklik vit skugga sägs vandra i de mörka korridorerna. Enligt sägnen är det anden efter en död riddare som inte finner ro i sin grav — han söker rastlöst efter sin förlorade kärlek, som också levde på Falkenstein. Andra berättar om en mystisk kvinna i vitt som vid midnatt svävar genom gångarna.

Många besökare påstår sig ha sett den kusliga uppenbarelsen. Borgen, som idag rymmer ett museum, hör till Harzregionens populäraste utflyktsmål — men när skymningen faller och de uråldriga korridorerna tystnar, vågar få dröja kvar ensamma innanför murarna med tanke på den vita gestalt som sägs vandra där.

Källa: GeisterNet (geisternet.com) + Tyska Wikipedia "Burg Falkenstein (Harz)" + geisterspiegel.de + harzinfo.de',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. BROCKEN / WALPURGISNACHT (Tyskland) — häxornas berg
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'brocken-walpurgisnacht','Brocken (Blocksberg)','brocken-walpurgisnacht','Tyskland','Sachsen-Anhalt, Harz','Naturplats',
  51.7991,10.6155,3,true,false,NULL,
  'Sista natten i april bjuder djävulen häxorna till sabbat på Blocksberg — ridande på kvastar och getter.',
  'Brocken, även kallad Blocksberg, är Harzbergens högsta topp (1 141 m) i Sachsen-Anhalt och själva sinnebilden av tysk häxtro. Enligt sägnen bjuder djävulen sista natten i april — Walpurgisnatten — in häxorna till en häxsabbat på berget. Från hela landet kommer de ridande på kvastar, högafflar, kattsvansar, trädstammar och getter.

Djävulen står på Teufelskanzel ("Djävulens predikstol"), en klippformation nära Brockenhaus, och talar till de församlade häxorna, fladdermössen, katterna, ormarna och vattenödlorna. Kring stora eldar dansas en vild dans med brinnande facklor, medan gäll djävulsmusik fyller natten.

Inte långt därifrån, vid Thale i Bodetal, ligger Hexentanzplatz ("Häxornas dansplats"). Enligt sägnen samlas häxorna där varje år natten till första maj för att sedan flyga gemensamt till Blocksberg och viga sig med djävulen.

Det första moderna Walpurgisfirandet på Brocken anordnades 1896 av bokhandlaren Rudolf Stolle från Bad Harzburg, med fest vid Brockenhotellet och ett fackeltåg till Teufelskanzel vid midnatt. År 1905 förbjöds firandet sedan bergets dåvarande ägare, furst Christian-Ernst zu Stolberg-Wernigerode, fått nog av de sataniska upptågen på sitt berg. Idag är Walpurgisnatten åter en av Harzregionens mest besökta — och mest kusliga — traditioner, då tusentals besökare klär ut sig till häxor och djävlar och tågar upp mot toppen i facklors sken.

Källa: harzwelten.online + Tyska Wikipedia "Walpurgisnacht" + "Brockenhexe" + harzlife.de + National Geographic',
  NULL,NULL,NULL,true,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. PLASSENBURG (Tyskland) — den Vita frun, Kunigunde von Orlamünde
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'plassenburg','Plassenburg','plassenburg','Tyskland','Bayern, Kulmbach','Fästning',
  50.1147,11.4622,3,false,false,NULL,
  'Hohenzollerns dödsbudbärerska — grevinnan som dödade sina barn vandrar i vitt och bådar död.',
  'Plassenburg tronar högt över staden Kulmbach i Bayern och är en av Tysklands mäktigaste renässansfästningar. Här går den kanske mest berömda av alla tyska gengångare: den Vita frun (die Weiße Frau), känd som "Hohenzollerns dödsbudbärerska", som under århundraden sägs ha bådat död för medlemmar av den furstliga ätten.

Sägnens historiska kärna är grevinnan Kunigunde von Orlamünde (1303–1382). Som ung änka kom hon till Plassenburg och förälskade sig i Albrecht den sköne, borggreve av Nürnberg och medlem av huset Hohenzollern. Albrecht var villig att gifta sig, men sade att "fyra ögon" stod i vägen för förbindelsen. Han syftade på sina föräldrar, som motsatte sig giftermålet — men Kunigunde missförstod orden och trodde att han menade hennes två små barn.

I sin förtvivlan dödade hon barnen genom att sticka en nål genom deras huvuden, ett sätt som inte lämnade några synliga spår. Gripen av ånger vallfärdade hon till Rom, där påven förlät henne på villkor att hon grundade ett kloster och tillbringade sina sista år där.

Sedan dess uppenbarar sig grevinnan av Orlamünde som den Vita frun i Hohenzollrarnas slott — oftast på Plassenburg, men också i Nya slottet i Bayreuth, på Burg Hohenzollern och i Berlins stadsslott. Historiskt vet man idag att Kunigunde i själva verket dog barnlös, och att morden aldrig kan ha ägt rum. Men gengångerskan i vitt vägrar lämna murarna.

Källa: hohenzollern-orte.de + National Geographic + Grässe "Sagenbuch des Preußischen Staats" (zeno.org) + radio-plassenburg.de',
  NULL,NULL,NULL,true,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 5. HEIDELBERGER SCHLOSS (Tyskland) — Hexenbiss och Rittersprung
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'heidelberger-schloss','Heidelberger Schloss','heidelberger-schloss','Tyskland','Baden-Württemberg, Heidelberg','Slott',
  49.4106,8.7156,2,false,false,NULL,
  'Häxan som bet i järnringen, riddaren som hoppade ur tornet och den spöklika rösten vid Heidenloch.',
  'Heidelbergs slott reser sig som en mäktig röd sandstensruin över Neckar och gamla staden i Baden-Württemberg — en av Tysklands mest besjungna borgruiner. Kring slottet ringlar sig en mängd sägner.

På porttornet hänger en kraftig järnring, men den bär en spricka. Enligt sägnen lovades den som kunde bita igenom ringen att bli slottets ägare med alla dess skatter. En häxa som kom förbi lyckades bita en skåra i järnet — men ett andra bett blev henne nekat, för i det första miste hon sin sista tand. Skåran kallas än idag Hexenbiss, "häxbettet".

En annan sägen knyts till en fördjupning i sandstenen på den stora terrassen, lik ett fotavtryck. När en eld en gång rasade i slottet ska en riddare i full rustning ha hoppat ut genom ett fönster i Friedrichsbau och landat här — Rittersprung, "riddarsprånget".

Under slottet talar man om Heidenloch, en hemlig gång som sägs leda under Neckar. Den franske författaren Victor Hugo påstod sig under en månljus vandring på Heiligenberg ha hört en spöklik röst nära Heidenloch. Till detta kommer berättelserna om hovnarren Perkeo, vaktaren av slottets jättelika vinfat. Sägner, spöksyner och en magisk atmosfär gör ruinen till en av Tysklands mest sägenomspunna platser.

Källa: schloss-heidelberg.de (Staatliche Schlösser und Gärten) + heidelberg24.de + Tyska Wikipedia "Heidelberger Schloss" + lokalmatador.de',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 6. SPREEPARK BERLIN (Tyskland) — den övergivna nöjesparken
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'spreepark-berlin','Spreepark Berlin','spreepark-berlin','Tyskland','Berlin, Plänterwald','Övergiven',
  52.4847,13.4889,3,false,true,NULL,
  'DDR:s enda nöjespark — övergiven sedan 2002, med ett pariserhjul som ännu knarrar i vinden.',
  'Spreepark i stadsdelen Plänterwald i Berlin är Tysklands mest berömda "lost place" — en övergiven nöjespark där pariserhjulet ännu står och knarrar i vinden. Parken öppnade 1969 under namnet Kulturpark Plänterwald och var DDR:s enda nöjespark. Under den kommunistiska tiden blomstrade den med 1,7 miljoner besökare om året.

År 1991 övertogs parken av den omstridde nöjesparksdrivaren Norbert Witte, som döpte om den till Spreepark. Efter konkursen 2001 försvann Witte med större delen av åkattraktionerna till Peru — och dömdes senare till sju års fängelse för att ha försökt smuggla 167 kilo kokain till Tyskland gömt i masten på attraktionen "Den flygande mattan".

Sedan 2002 stod parken övergiven. Rostiga dinosauriefigurer, ett stillastående pariserhjul och igenvuxna karuseller gjorde platsen till en magnet för fotografer och äventyrare — och till en kuslig kuliss som ständigt förknippats med spökhistorier. Redan 1979 hade DDR-televisionens populära serie "Spuk unterm Riesenrad" ("Spöke under pariserhjulet") valt just detta pariserhjul som skådeplats.

År 2014 förvärvade delstaten Berlin parken, och sedan 2016 förvandlas den gamla DDR-parken långsamt till en konst-, kultur- och naturpark genom det landsägda bolaget Grün Berlin. Men för många berlinare förblir Spreepark framför allt den övergivna, hemsökta sagovärlden bortom staketet, där pariserhjulet ibland sägs börja snurra av sig självt i nattvinden.

Källa: Tyska Wikipedia "Spreepark Berlin" + urbexplorer.com + travelbook.de + wmn.de',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 7. WARTBURG (Tyskland) — Luther och djävulen
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'wartburg','Wartburg','wartburg','Tyskland','Thüringen, Eisenach','Borg',
  50.9663,10.3064,2,false,false,NULL,
  'Luther kastade sitt bläckhorn på djävulen — bläckfläcken på väggen finns kvar, fast den krymper.',
  'Wartburg tronar på en klippa ovanför Eisenach i Thüringen och hör till Tysklands mest historiskt laddade borgar — idag UNESCO-världsarv. Den mest berömda sägnen handlar om Martin Luther och djävulen.

Efter riksdagen i Worms togs Luther i maj 1521 i skyddsförvar av kurfurst Fredrik den vise genom en iscensatt kidnappning. Förklädd till "junker Jörg" levde han på Wartburg fram till mars 1522 i en enkel kammare, idag känd som Lutherstuben, där han översatte Nya testamentet till tyska.

Enligt sägnen plågades Luther vintern 1521/1522 av djävulen i sin kammare. När han under arbetet hörde ett skrapande och raspande ska han ha gripit sitt bläckhorn och kastat det i ansiktet på den onde för att driva bort honom. En blå bläckfläck på väggen intill kakelugnen sägs ha uppstått ur denna händelse — fast idag återstår bara ett hål, eftersom generationer av besökare skrapat loss "bläcket" som souvenir.

Sanningen bakom legenden är osäker. Luther berättade mycket om sin tid på Wartburg men teg om bläckfläcken, och berättelsen dyker upp först på 1600-talet. Troligen togs hans egna ord — att han "drivit bort djävulen med bläck" — alltför bokstavligt; han syftade på sin bibelöversättning. Men sägnen lever vidare, lika seg som fläcken som aldrig vill försvinna.

Källa: luther2017.de + luther.de + diegradwanderung.de + berliner-woche.de',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 8. TEUFELSBERG BERLIN (Tyskland) — kalla krigets spökstation
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'teufelsberg-berlin','Teufelsberg','teufelsberg-berlin','Tyskland','Berlin, Grunewald','Övergiven',
  52.4980,13.2410,3,false,true,NULL,
  'Ett berg av krigsspillror med en övergiven NSA-avlyssningsstation — kupolerna viner i vinden.',
  'Teufelsberg ("Djävulsberget") i Grunewald i västra Berlin är ingen naturlig kulle. Den restes av krigsspillror — omkring 26 miljoner kubikmeter rasmassor från det sönderbombade Berlin — som tippades över en aldrig färdigställd nazistisk militärteknisk högskola. Redan namnet, hämtat från den närbelägna Teufelssee, gav platsen en olycksbådande klang.

År 1963 byggde den amerikanska underrättelsetjänsten NSA en av sina största avlyssningsstationer på toppen, som en del av det globala ECHELON-nätverket. Inuti de stora radarkupolerna dolde sig tolv meter höga antenner och dåtidens mest avancerade spaningsutrustning, med vilken USA och Storbritannien avlyssnade sovjetisk, östtysk och annan Warszawapaktstrafik. Spaningen pågick dygnet runt fram till 1989, och upp till 1 500 personer arbetade här.

När muren föll och kalla kriget tog slut stängdes stationen och utrustningen plockades bort. Sedan dess har Teufelsberg stått övergiven — gång på gång har planer på återuppbyggnad misslyckats. De tomma byggnaderna och de söndertrasade kupolerna, där vinden får membranen att skälva med spöklika ljud, har gjort platsen till en av Tysklands mest besökta lost places. Konstnärer har tagit över ruinerna och skapat ett av Europas största utomhusgallerier för gatukonst. År 2018 fick anläggningen kulturminnesskydd för sin betydelse som monument över kalla kriget.

Källa: Engelska Wikipedia "Teufelsberg" + abandonedberlin.com + visitberlin.de + urbex.nl',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 9. EXTERNSTEINE (Tyskland) — den hedniska kultplatsen
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'externsteine','Externsteine','externsteine','Tyskland','Nordrhein-Westfalen, Teutoburger Wald','Naturplats',
  51.8686,8.9181,2,true,false,NULL,
  'Uråldriga stenpelare i Teutoburgerskogen — hednisk kultplats omgiven av myter och en magisk cirkel.',
  'Externsteine är en dramatisk formation av höga sandstenspelare i Teutoburger Wald i Nordrhein-Westfalen — en av Tysklands mest gåtfulla kultplatser. Kring klipporna har man funnit vallanläggningar och föremål från äldre och mellersta stenåldern, däribland 10 000 år gamla flintspetsar. Redan stenåldersmänniskor sökte skydd hos kolosserna, och även kelterna lämnade verktyg, smycken och fästen i skogen.

I årtusenden har Externsteine betraktats som helig plats av skilda grupper — hedningar, munkar, nazister och esoteriker. Otaliga gåtor omger klipporna, och sägner, myter och hemligheter sägs springa fram ur dem lika talrikt som sandkorn.

Enligt legenden ska sierskan och prästinnan Veleda av brukterernas stam ha spått här; så klokt var hennes råd och så mäktig hennes ställning bland germanerna att till och med romarna fruktade henne. En annan sägen berättar att Karl den store på 700-talet lät förstöra den hedniska världspelaren Irminsul och jämna de gamla kultplatserna vid Externsteine med marken.

Den magiska stämningen har fängslat besökare i sekler. Goethe skrev: "Man må värja sig och vända sig hur man vill — man finner sig fången i en magisk cirkel." Vid soluppgången under sommarsolståndet, då ljuset faller genom hålet i den övre kammaren, samlas ännu nutida sökare för att uppleva platsens uråldriga kraft.

Källa: web.de + viasaga.de + morgntau.de + Tyska Wikisource "Sage vom Externsteine"',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
