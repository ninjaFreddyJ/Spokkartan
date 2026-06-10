-- ============================================================
-- Spökkartan → hauntedplaces SYNC-paket (DEDUPLICERAT)
-- Genererad 2026-06-10. Delad Supabase: kör EN gång.
-- Alla rader är idempotenta. De ~16 platser som redan fanns har nu
-- kanonisk slug -> ON CONFLICT BERIKAR befintlig rad (text), behåller
-- befintliga bilder/koordinater. Inga nya dubbletter skapas.
-- (Pre-existerande dubbletter i datan städas separat, se 65_DEDUP_*.sql)
-- ============================================================

-- ===== 33_GERMANY_SPUKORTE.sql =====
-- Spökkartan — 7 hemsökta platser i Tyskland (Deutschland)
-- Genererad 2026-06-09. Generell metod, denna gång med fokus på Tyskland.
--
-- METOD (samma generella lösning som tidigare länder):
--   1. Översätt nyckelorden till tyska:
--        "hemsökta platser" -> Spukorte / Geisterorte / verwunschene Orte
--        "spöken"           -> Geister / Gespenster
--        relaterat          -> Spukschloss, Spukgeschichten, Geistergeschichten,
--                              gruselige Orte, Weiße Frau, Lost Place, Sage, Legende
--   2. Googla på de tyska orden + relaterade och hitta sidor som SAMLAT
--      spökhistorier om platser:
--        - GeisterNet (geisternet.com) — katalog över tyska Spukorte
--        - geister-und-gespenster.de
--        - burgen.de, baden24.de, travelbook.de, rlp-tourismus.com, SAGEN.at
--        - tyska Wikipedia (Sagen-/Legende-avsnitt)
--   3. Lista platserna och skriv dem på SVENSKA, 200–600 ord per plats
--      (men aldrig fler ord än källmaterialet jag hämtat).
--
-- NOTERING: Wewelsburg och Frankenstein Castle finns redan i 24_EUROPE.sql
-- och utelämnas därför här. Auschwitz/koncentrationsläger marknadsförs inte
-- som spökattraktioner (se not i 24_EUROPE.sql).
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. SCHWERINER SCHLOSS (Tyskland) — husanden Petermännchen
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'schweriner-schloss','Schweriner Schloss','schweriner-schloss','Tyskland','Mecklenburg-Vorpommern, Schwerin','Slott',
  53.6244,11.4179,3,false,false,NULL,
  'Slottets vaktande husande — koboldens 700 sägner gör Petermännchen till Tysklands mest sagoomspunna spöke.',
  'Schweriner Schloss reser sig på en ö i Schwerinsjön i Mecklenburg-Vorpommern och har i århundraden varit residens för hertigarna av Mecklenburg. I de väldiga källarvalven, vindarna och korridorerna bor enligt sägnen Petermännchen — slottets husande.

Petermännchen beskrivs som en liten, godmodig men barskt blickande kobold. Det sägs finnas över 700 nedtecknade berättelser om honom — ett ovanligt stort antal för en enda sägengestalt. Han visar sig i olika skepnader: ibland som en gammal man med rynkigt ansikte och ett vitt, flödande skägg som når ned till bröstet, klädd i en lång svart rock med trång ärm, vit krage och rund mössa. Andra gånger uppenbarar han sig som en medeltida ryttare med spetsad mustasch, kort vapenrock, höga stövlar med sporrar, svärd och fjäderhatt, med en nyckelknippa skramlande vid bältet.

Petermännchen vandrar genom slottets rum, skälmsk och vaktande. Han gör sig osynlig, retas, belönar och bestraffar — men straffar bara de onda. Han spår kommande händelser som ett orakel och sägs vara förtrollad, men kan förlösas på underliga vis.

De sista nedtecknade mötena ägde rum i modern tid. År 1913 visade han sig för en av storhertigens döttrar när en del av slottet stod i lågor. En polis påstod sig 1930 ha sett en gestalt med spetsig hatt i slottsträdgården, som sedan löstes upp i tomma intet. Forskaren Richard Wossidlo tolkade flera sägner som att Petermännchen i själva verket är guden Radegast, förvandlad till kobold för att vakta obotriternas heliga skatt.

Källa: Tyska Wikipedia "Petermännchen (Schwerin)" + Landeshauptstadt Schwerin (schwerin.de) + erlebnistour-mv.de',
  NULL,NULL,NULL,true,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. BURG ELTZ (Tyskland) — grevinnan Agnes
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'burg-eltz','Burg Eltz','burg-eltz','Tyskland','Rheinland-Pfalz, Wierschem','Slott',
  50.2056,7.3367,3,false,false,NULL,
  'Den sköna Agnes föll i rustning vid borgens försvar — hennes ande svävar ännu över borggården.',
  'Burg Eltz är sinnebilden av en tysk riddarborg — en medeltida höjdborg som reser sig ur en skogklädd dal vid floden Elzbach, nära Moseln i Rheinland-Pfalz. Under sin 800-åriga historia erövrades den aldrig av fiender, och den ägs och bebos än idag av samma familj.

Borgens spöke är grevinnan Agnes von Eltz. Sägnen berättar att Agnes och den unge riddaren von Braunsberg lovats bort till varandra redan som barn. När Agnes insåg att Braunsberg var en grobian, och han framför den samlade släkten försökte kyssa henne, stötte hon hårt bort honom. När han då slog flickan i ansiktet kastade hennes far ut honom ur borgen.

Detta utlöste en blodig fejd mellan ätterna Eltz och Braunsberg. Braunsbergarna lockade genom list bort borgherren och hans män. Agnes, som visste vad som väntade om hon föll i junkerns händer, grep sin brors rustning och ett svärd för att strida vid sitt folks sida. Men en dödlig pil från junkern träffade henne, och den unga grevinnan föll.

I grevinnans kammare — ett av de få rum besökare får se, och påstått ett av de mest hemsökta — hänger ännu bröstharnesket som pilen sägs ha genomborrat, jämte fejdhandsken som Braunsbergarna en gång kastade framför Eltzarna. Hennes säng och stridsyxa står kvar i rummet. Agnes goda ande sägs ännu nattetid sväva graciöst över borggården, och hon har blivit en symbol för borgherrarnas ståndaktighet — borgen som aldrig föll.

Källa: GeisterNet (geisternet.com) + rlp-tourismus.com + pressenet.info + burgen.de',
  NULL,NULL,NULL,true,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. BURG LAHNECK (Tyskland) — Idilia Dubb
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'burg-lahneck','Burg Lahneck','burg-lahneck','Tyskland','Rheinland-Pfalz, Lahnstein','Slott',
  50.3050,7.6019,3,false,false,NULL,
  'Den 17-åriga skotskan klättrade upp i tornet — trappan rasade och ingen hörde hennes rop.',
  'Burg Lahneck tronar på en klippa över floden Lahns mynning i Rhen, ovanför staden Lahnstein i Rheinland-Pfalz. Borgen byggdes på 1200-talet, förföll till ruin och nyuppfördes i nygotisk stil under 1800-talet.

Borgens mest kända spöksägen handlar om Idilia Dubb, en 17-årig flicka från Edinburgh. Enligt berättelsen reste hon år 1851 med sin familj på en Rhenfärd. Ensam gjorde hon en utflykt till den då övervuxna borgruinen för att teckna av den. Hon tog sig uppför den igenvuxna borgstigen och klättrade upp i ett av tornen — men den murkna trätrappan rasade samman under henne. Fångad högst uppe i tornet, utan att någon hörde hennes rop, sägs hon ha svultit och törstat ihjäl.

Historien fick trovärdighet när byggnadsarbetare år 1860 påstods ha funnit ett skelett i tornet samt Idilias dagbok instoppad i en murspringa. Berättelsen trycktes i två delar i Adenauer Kreis- und Wochenblatt i oktober och november 1863.

Nyare forskning, särskilt av historikern Klaus Graf, visar dock att det med all sannolikhet rör sig om en modern legend som först kom i omlopp genom publikationer från 1863. Den verkliga källan tycks vara Thomas Hoods novell "The Tower of Lahneck. A Romance", publicerad 1842, om en engelsk kvinna och hennes unge tyske vän som besteg samma torn i slutet av maj. Sant eller ej — många besökare påstår alltjämt att flickans ande vakar kvar däruppe i tornet.

Källa: Tyska Wikipedia "Idilia Dubb" + "Burg Lahneck" + GeisterNet + burgerbe.de',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. KLOSTER SALEM (Tyskland) — den drunknade munken
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'kloster-salem','Kloster Salem','kloster-salem','Tyskland','Baden-Württemberg, Salem','Kloster',
  47.7736,9.2786,3,false,false,NULL,
  'En törstig munk klättrade upp på det väldiga vinfatet, föll i och drunknade — hans steg hörs ännu i källaren.',
  'Schloss och Kloster Salem ligger i orten Salem nära Bodensjön i Baden-Württemberg och var under medeltiden ett mäktigt cistercienskloster. Dess mest berömda sägen — känd redan på 1600-talet och nedtecknad på vers i Badisches Sagenbuch 1846 — handlar om en munk och ett gigantiskt vinfat.

Omkring mitten av 1400-talet lät abbot Georg I. Münch bygga ett väldigt fat som rymde ungefär 60 000 liter, fyllt med de finaste vinerna. Ur fatet tappades vin endast på de stora högtidsdagarna, och källarmästaren vaktade noga nycklarna.

En gång föll källarmästaren i djup sömn. Då stal en särskilt törstig munk nycklarna och började smyga ned i vinkällaren efter aftonmässan för att dricka. När källarmästaren bytte ut tappkranen mot en plugg gav munken ändå inte upp: han reste en stege, klättrade upp på det enorma fatet och öppnade det stora sprundhålet. Han drack så girigt att han blev yr, föll ned i fatet och drunknade.

När källarmästaren med en mätstång fann den drunknade munkens kropp tog han i hemlighet bort den och begravde den om natten — av rädsla för att vinet annars skulle anses besudlat. Först strax före sin egen död bekände han brottet, men dog innan han hann avslöja var den hemliga graven låg.

Eftersom munken aldrig fick en värdig begravning måste han enligt sägnen vandra rastlöst som spöke i källaren än idag. Hör besökaren steg i sandaler och ett svagt skrapande, som när någon raspar fingrarna mot fatets metallband, då vet de att munken är nära.

Källa: SAGEN.at + salem.de (Staatliche Schlösser und Gärten) + wein-bastion.de (Badisches Sagenbuch 1846)',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 5. BURG WOLFSEGG (Tyskland) — Vita frun
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'burg-wolfsegg','Burg Wolfsegg','burg-wolfsegg','Tyskland','Bayern, Oberpfalz','Borg',
  49.0908,11.9897,3,false,false,NULL,
  'Grevinnan Klara ströps och stacks ned vid fönstret — hennes vita gestalt söker än ro.',
  'Burg Wolfsegg ligger i Oberpfalz i Bayern, högt över Naabdalen, och är en av få medeltida borgar i regionen som bevarats nästan oförändrad. Den är framför allt känd för sitt spöke — den Vita frun av Wolfsegg.

Sägnen har sina rötter i 1400-talet och handlar om grevinnan Klara von Helfenstein, på den tiden gift med borgherren Ulrich von Laaber. När Ulrich upptäckte sin hustrus otrohet beslöt han att låta mörda henne och lejde två drängar för dådet. Mordet ska ha skett i det så kallade renässansrummet, medan kvinnan satt vid ett fönster. Den ene ströp henne, den andre stack ned henne när hon föll till golvet. Mördarna begravde henne sedan i hemlighet.

Historiska källor motsäger dock sägnen: Klara överlevde i själva verket sin make med fyra år och tycks efter hans död ha flyttat till sina bröder i Riedenburg.

Trots det berättar man i Wolfsegg sedan urminnes tider om den Vita frun, som gång på gång setts nattetid i borgen som en vit, eterisk uppenbarelse. Enligt sägnen finns bara ett sätt att befria henne: att finna liket, ge det en värdig begravning och läsa en mässa. Först då får hon ro. Borgen har genom åren undersökts av spökjägare, och den Vita frun hör till de mest omtalade gestalterna i bayersk folktro.

Källa: GeisterNet + mysteryhunter.de + Tyska Wikipedia "Burg Wolfsegg" + freyhammer.wordpress.com',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 6. LORELEY (Tyskland) — nixan på klippan
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'loreley','Loreley','loreley','Tyskland','Rheinland-Pfalz, St. Goarshausen','Naturplats',
  50.1390,7.7290,2,true,false,NULL,
  'Den gyllenhåriga jungfrun kammar sitt hår och sjunger — skepparna ser upp och driver mot de dödliga reven.',
  'Loreley är en 132 meter hög skifferklippa som reser sig brant över Rhen vid St. Goarshausen i Rheinland-Pfalz, mitt i den Övre Mellersta Rhendalen — idag UNESCO världsarv. Här är floden som smalast och djupast, och de farliga strömmarna och dolda reven har genom seklen orsakat många skeppsbrott.

Enligt sägnen satt en gyllenhårig jungfru vid namn Loreley på klippan, kammade sitt långa hår och sjöng en ljuvlig melodi. Hennes skönhet och sång var så förtrollande att skepparna på Rhen blickade upp mot henne i stället för att akta på vattnet — och drev rakt mot de dödliga reven och klipporna, där de gick under.

Sägnen är yngre än man kan tro. Nixan "Lore Lay" diktades fram år 1800 av den romantiske författaren Clemens Brentano, som placerade henne på den redan ökända Rhenklippan. Tjugotre år senare skrev Heinrich Heine sin berömda dikt: "Ich weiß nicht, was soll es bedeuten, dass ich so traurig bin; ein Märchen aus alten Zeiten, das kommt mir nicht aus dem Sinn." Dikten publicerades första gången 1824 och tonsattes av Friedrich Silcher 1837.

Det är framför allt Heine som format vår bild av den blonda skönheten som kammar sitt hår på klippan och med sin himmelska röst lockar Rhenskepparna i fördärvet — likt antikens sirener. Sägen och klippa har sedan dess blivit oskiljaktiga.

Källa: loreley-felsen.de + rheinreise.com + reisenexclusiv.com + Goethe-Institut',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 7. BEELITZ-HEILSTÄTTEN (Tyskland) — den övergivna kliniken
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'beelitz-heilstatten','Beelitz-Heilstätten','beelitz-heilstatten','Tyskland','Brandenburg, Beelitz','Sanatorium',
  52.2700,12.9230,4,false,true,NULL,
  'Tysklands mest beryktade lost place — steg i tomma korridorer och dörrar som öppnas av sig själva.',
  'Beelitz-Heilstätten ligger i skogarna i Fläming söder om Berlin, i Brandenburg. Anläggningen byggdes mellan 1898 och 1902 och bestod av omkring 60 byggnader på cirka 200 hektar. I slutet av 1800-talet var tuberkulos en mycket smittsam sjukdom som dödade nära hälften av de 15–40-åriga i storstäder som Berlin, och Beelitz uppfördes som ett lungsanatorium för stadens arbetare.

Under båda världskrigen användes anläggningen som lasarett för sårade soldater — mellan 1914 och 1918 togs omkring 17 500 konvalescenter emot här. Efter 1945 övertog Röda armén området, och fram till 1994 var det den sovjetisk-ryska arméns största militärsjukhus utanför hemlandet. När ryssarna drog sig tillbaka lämnades stora delar att förfalla.

Idag är Beelitz-Heilstätten en av Tysklands mest beryktade "lost places" och en magnet för spökjägare. Besökare berättar om steg i de tomma korridorerna, dörrar som öppnas som av en osynlig hand och till och med skrik från den gamla kirurgibyggnaden. Vetenskapen betonar dock att det inte finns några belägg för övernaturlig aktivitet.

Platsen bär också en mörk verklig historia: i området härjade 1989–1990 en seriemördare, och flera dödsfall har inträffat i ruinerna. På senare år har man försökt tvätta bort grusel-stämpeln, bland annat genom en trädkronsstig och guidade turer som berättar om sanatoriets historia.

Källa: travelbook.de + urbexplorer.com + medwing.com + travellersarchive.de',
  NULL,NULL,NULL,true,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;

-- ===== 34_GERMANY_SPUKORTE_BATCH2.sql =====
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

-- ===== 35_GERMANY_SPUKORTE_BATCH3.sql =====
-- Spökkartan — 3 fler hemsökta platser i Tyskland (Deutschland), omgång 3
-- Genererad 2026-06-09. Fortsättning på 33/34_GERMANY_SPUKORTE.
--
-- METOD (samma generella lösning): tyska sökord (Spukhaus, Hexenkeller,
-- Hexenverfolgung, Sage, Geist, Lost Place, Drache/Nibelungen) -> sidor som
-- samlat spökhistorier (travelbook.de, alte-burg.amt-penzliner-land.de,
-- drachenwolke.com, koeln.mitvergnuegen.com m.fl. samt tyska Wikipedia/
-- Wikisource). Svenska, 200-600 ord/plats, aldrig fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. ALTE BURG PENZLIN (Tyskland) — häxkällaren
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'alte-burg-penzlin','Alte Burg Penzlin','alte-burg-penzlin','Tyskland','Mecklenburg-Vorpommern, Penzlin','Borg',
  53.5046,13.0814,4,false,false,NULL,
  'Europas enda bevarade häxfängelse från 1560 — i de djupaste valven hörde ingen de torterades skrik.',
  'Alte Burg Penzlin ligger i staden Penzlin sydväst om Neubrandenburg i Mecklenburg-Vorpommern och rymmer en av Europas mest skräckinjagande källare. År 1560 byggdes här en så kallad Hexenkeller — en häxkällare och tortyrkällare. I de djupaste valven finns Europas enda bevarade häxfängelse från tidigmodern tid som exakt följde reglerna i Malleus Maleficarum, "Häxhammaren".

Djupt under jorden, dit inga skrik nådde upp, torterades de anklagade. Bland redskapen fanns stolar besatta med spikar. I det understa fängelsehålet finns flera stora väggnischer som i sekler kallats "häxnischerna" — man misstänker att människor kedjades fast i dem bakom kraftiga trädörrar.

Häxförföljelserna i Mecklenburg krävde fram till sitt slut uppemot 2 000 människors liv på bålet. Rättegången mot Benigna Schultzen i Penzlin har fått överregional betydelse som en av de längsta: hennes inkvisitions- och revisionsprocess sträckte sig över tolv år, från 1699 till 1711.

Sedan 1994 inhyser borgen ett specialmuseum för magi och häxförföljelser i Mecklenburg. Besökare berättar om en tryckande, iskall stämning i de underjordiska valven — som om de torterade själarna aldrig riktigt lämnat platsen. Få murar i Tyskland bär på ett så konkret och dokumenterat lidande som Penzlins häxkällare.

Källa: travelbook.de + alte-burg.amt-penzliner-land.de + Tyska Wikipedia "Alte Burg Penzlin" + Gerda Henkel Stiftung (lisa.gerda-henkel-stiftung.de)',
  NULL,NULL,NULL,true,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. DRACHENFELS (Tyskland) — Siegfried och draken
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'drachenfels','Drachenfels','drachenfels','Tyskland','Nordrhein-Westfalen, Königswinter','Ruin',
  50.6680,7.2070,2,true,false,NULL,
  'Drakklippan vid Rhen — här ska Siegfried ha dräpt draken och badat i dess blod.',
  'Drachenfels ("Drakklippan") är ett berg i Siebengebirge mellan Königswinter och Bad Honnef vid Rhen, krönt av en medeltida borgruin. Namnet bär på en av Tysklands äldsta sägner.

Enligt Nibelungensägnen dödade hjälten Siegfried av Xanten en drake som levde i en håla på Drachenfels. Efter segern badade han i drakens blod, vilket gjorde honom osårbar — men ett lindlöv föll på hans skuldra och lämnade en enda sårbar fläck, den som långt senare blev hans död. I vissa versioner kallas draken Fafnir.

Vid bergets fot ligger Nibelungenhalle i Königswinter, invigd 1913 till hundraårsminnet av Richard Wagners födelse. Tolv mystiska väggmålningar skildrar scener ur Wagners "Nibelungens ring", och en stor drakskulptur vaktar platsen. Sedan 1883 förbinder Drachenfelsbahn — Tysklands äldsta ännu drivna kuggstångsjärnväg — staden med berget.

Drachenfels är en av de mest besjungna Rhenklipporna, romantiserad av diktare och målare genom seklen. När dimman lägger sig kring den uråldriga ruinen är det inte svårt att föreställa sig draken i sin håla — och hjälten som steg ned i mörkret för att möta den. Sägnen om Siegfried och draken har gjort berget till en av hela Rhendalens mest sägenomspunna platser.

Källa: varta-guide.de + drachenwolke.com + travelbook.de + Tyska Wikisource "Siegfried auf dem Drachenfelsen"',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. HAUS FÜHLINGEN (Tyskland) — Kölns spökvilla
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'haus-fuehlingen','Haus Fühlingen','haus-fuehlingen','Tyskland','Nordrhein-Westfalen, Köln','Övergiven',
  51.0330,6.8850,4,false,false,NULL,
  'Kölns beryktade gruselvilla, byggd på en blodåker — tre män har hängt sig i samma våning.',
  'Haus Fühlingen i Köln byggdes 1888 som sommarresidens åt Eduard friherre von Oppenheim, ur familjen bakom Kölnbanken Sal. Oppenheim. Idag är den en gång eleganta villan en övergiven ruin med en mörk och delvis fullt verklig historia.

Huset restes på den så kallade Blutacker ("blodåkern") — marken där mer än 1 000 människor stupade i slaget vid Worringen 1288. Enligt sägnen spökar här anden efter en polsk tvångsarbetare som mördades av nazisterna 1943: den då 19-årige Edward Margol, som offentligt hängdes av Gestapo i ett gammalt tegelbruk nära villan.

Till legenden hör flera verkliga tragedier. Nyårsnatten 1962 ska en man vid namn van Kempen ha hängt sig på husets andra våning. Hans änka levde kvar som villans sista invånare ensam ända till år 2000. Och 2007, 45 år efter van Kempens självmord och långt efter att villan övergivits, hängde sig ännu en man på exakt samma andra våning.

Dessa dystra dödsfall har gjort Haus Fühlingen till en av Kölns mest beryktade "gruselvillor", omsusad av spökhistorier om röster, skuggor och plötslig kyla. I maj 2023 strök staden Köln slutligen villan från kulturminneslistan — vilket innebär att det förfallna spökhuset nu i teorin får rivas.

Källa: koeln.mitvergnuegen.com + t-online.de (koeln.t-online.de) + verliebtinkoeln.com + travelbook.de',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;

-- ===== 36_GERMANY_SPUKORTE_BATCH4.sql =====
-- Spökkartan — 3 fler hemsökta platser i Tyskland (Deutschland), omgång 4 (sista)
-- Genererad 2026-06-09. Avslutar Tysklandsserien (33-36).
--
-- METOD (samma generella lösning): tyska sökord (Lost Place, Lochgefängnis,
-- Folterkammer, Teufel, Sage) -> sidor som samlat spökhistorier/sägner
-- (verlassenes.de, museen.nuernberg.de, harzlife.de, harzwelten.online,
-- travelbook.de m.fl. samt tyska Wikipedia). Svenska, 200-600 ord/plats,
-- aldrig fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. OLYMPISCHES DORF ELSTAL (Tyskland) — den övergivna OS-byn 1936
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'olympisches-dorf-elstal','Olympisches Dorf Elstal','olympisches-dorf-elstal','Tyskland','Brandenburg, Wustermark','Övergiven',
  52.5390,12.9640,3,false,true,NULL,
  'Den övergivna olympiska byn från Berlin-OS 1936 — tysta salar där historiens skuggor vilar tunga.',
  'Den olympiska byn i Elstal, omkring 18 kilometer väster om Berlin i Brandenburg, byggdes inför sommar-OS i Berlin 1936. Anläggningen — drygt 540 000 kvadratmeter — ritades av arkitekten Werner March, samme man som ritade Reichssportfeld och olympiastadion. Den utformades som en rofylld oas långt från storstadens larm, men planlades helt enligt den nazistiska ledningens idéer. Under spelen 1–16 augusti 1936 bodde här omkring 3 600 manliga idrottare med ledare och personal, medan de cirka 330 kvinnliga deltagarna inkvarterades vid Reichssportfeld.

Efter kriget, 1945, flyttade Röda armén in och använde idrottsanläggningarna som prestationscentrum för den sovjetiska armésportklubben SASK. Först sommaren 1992 lämnade de sista ryska trupperna byn, som därefter till stora delar lämnades att förfalla.

På grund av sin historiska och arkitektoniska betydelse, och då den hotades av förfall, är området kulturminnesskyddat sedan 1993. De övergivna, vittrande byggnaderna — med igenvuxna gårdar och tomma salar — har blivit en av Berlinområdets mest besökta "lost places", en kuslig kuliss där historiens skuggor vilar tunga. En del av byn har på senare år moderniserats till en trädgårdsstad med stadsradhus, men många huskroppar står ännu öde och tysta. Bland de övergivna byggnaderna finns det runda matsalshuset, simhallen och idrottarnas boningar, där putsen flagnar och naturen långsamt tar tillbaka korridorerna — en plats som drar till sig både historieintresserade och de som söker det olycksbådande i tystnaden efter ett av historiens mest laddade idrottsspel.

Källa: verlassenes.de + berlinstaiga.de + t-online.de + geschichtsspuren.de',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. NÜRNBERGER LOCHGEFÄNGNISSE (Tyskland) — medeltidens tortyrhålor
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'nuernberger-lochgefaengnisse','Nürnberger Lochgefängnisse','nuernberger-lochgefaengnisse','Tyskland','Bayern, Nürnberg','Fängelse',
  49.4548,11.0775,4,false,true,NULL,
  'Under rådhuset gömmer sig tolv mörka celler och en tortyrkammare — de torterades skrik nådde upp till torget.',
  'Under det gamla rådhuset i Nürnberg, i Bayern, döljer sig "Nürnberger Loch" — en av Tysklands största och bäst bevarade medeltida stadsfängelser. När nürnbergarna från 1332 anlade torget Hauptmarkt som ny stadskärna byggde de om bakhuset till rådhus och höjde marken runtomkring, så att bottenvåningen blev källare och de gamla butikerna blev fängelsehålor.

Idag kan man fortfarande se tolv celler. Med bara två meters längd, bredd och höjd kedjades ofta två fångar samtidigt fast i fullständigt mörker. Vissa förbrytare — som mordbrännare och förtalare — hade särskilt utmärkta celler reserverade för sig.

Det så kallade kapellet tjänade som tortyrkammare, där bekännelser pressades fram. Enligt sägnen trängde de torterades skrik ända upp genom myllret på Hauptmarkt ovanför. Celler, tortyrkammare, smedja, fängelseköket och brunnskammaren ger än idag en levande — och kuslig — bild av medeltidens rättsskipning.

Den som stiger ned i de trånga, fuktiga valven känner snabbt tyngden av allt det lidande murarna bevittnat. Idag förs guidade turer ned i mörkret varje timme mellan klockan 11 och 18 — men barn under tio år släpps inte in. Platsen räknas till Nürnbergs mest skräckinjagande hörn, en stum påminnelse om en tid då tortyren var en del av lagen.

Källa: museen.nuernberg.de + tourismus.nuernberg.de + travelbook.de + infranken.de',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. TEUFELSMAUER (Tyskland) — djävulens misslyckade mur
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'teufelsmauer-harz','Teufelsmauer','teufelsmauer-harz','Tyskland','Sachsen-Anhalt, Harz','Naturplats',
  51.7870,10.9460,2,true,false,NULL,
  'Djävulens gränsmur — som han slog sönder i raseri när tuppen gol för tidigt och Harz gick förlorat.',
  'Teufelsmauer ("Djävulsmuren") är en omkring 20 kilometer lång formation av härdade sandstensklippor i norra Harz, i Sachsen-Anhalt, som reser sig som en taggig mur ur landskapet. Kring den ringlar sig en av regionens mest kända djävulssägner.

Enligt legenden begärde djävulen efter skapelsen en del av världen — särskilt Harzbergen, hans käraste trakt. Efter mycket om och men gick Gud med på att dela landet, men på ett villkor: djävulen måste resa en gränsmur färdig innan den första tuppen gol nästa morgon. Frenetiskt byggde den onde genom natten.

Men just som bara den sista stenen återstod snubblade i gryningen en bondkvinna från Timmenrode, på väg till marknaden, över muren — en tupp hade nämligen galt för tidigt, och skulden låg helt på henne. Därmed var natten över och Harz förlorat för djävulen. Rasande slungade mörkrets furste den sista stenen långt ut över Harzförlandet, kallade på blixt och dunder och slog sönder den nästan färdiga muren. Spillrorna blev stående som ett vittnesbörd om den Högstes allmakt.

I verkligheten uppstod Teufelsmauer genom bergsförskjutningar under kritperioden, då hårdare sandstenslager blottlades när de mjukare vittrade bort. Men för folktron förblir klipporna djävulens misslyckade mur — och nära ligger också den så kallade Hexenaltar, häxaltaret.

Källa: harzlife.de + harzwelten.online + Tyska Wikipedia "Teufelsmauer (Harz)" + travelbook.de + scinexx.de',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;

-- ===== 37_NETHERLANDS_SPOOKPLEKKEN.sql =====
-- Spökkartan — 3 hemsökta platser i Nederländerna (Nederland)
-- Genererad 2026-06-09. Samma generella metod, nu Nederländerna.
--
-- METOD: översatte nyckelorden till nederländska (hemsökta platser ->
-- spookplekken/spookhuizen, spöken -> spoken/geesten; relaterat: spookkasteel,
-- spookverhalen, witte wieven, legende) och sökte sidor som SAMLAT spökhistorier
-- (kasteelhoensbroek.nl, visittwente.nl, verhalenbank.nl, dutch-folklore.fandom.com,
-- mijngelderland.nl m.fl. samt nederländska/engelska Wikipedia). Skrivet på
-- SVENSKA, 200-600 ord/plats, aldrig fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. KASTEEL HOENSBROEK (Nederländerna) — de Blauwe Dame
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'kasteel-hoensbroek','Kasteel Hoensbroek','kasteel-hoensbroek','Nederländerna','Limburg, Heerlen','Slott',
  50.9200,5.9270,3,false,false,NULL,
  'Den Blå damen som fick 24 barn — varje 5 november återvänder hon för att söka sina inmurade små.',
  'Kasteel Hoensbroek i Heerlen i Limburg är ett av Nederländernas största och bäst bevarade medeltidsslott. Det är framför allt känt för legenden om den Blå damen (de Blauwe Dame).

Den blå damen var i verkligheten Anna Catharina, riksgrevinna von Schönborn, som 1720 gifte sig med markisen Frans Arnold van Hoensbroek. Tillsammans fick de hela 24 barn — men av dessa överlevde bara sex. Två av barnen som dog vid födseln murades, enligt 1700-talets sed, in i slottets väggar.

Anna Catharina dog den 5 november 1760. Sägnen berättar att hon varje år på just denna dag återvänder till slottet för att söka efter sina inmurade barn. Efter sin död har hon setts vandra genom slottets gångar nattetid, klädd i sin blå klänning. Högst uppe i slottets runda torn märker förbipasserande då och då ett blått ljus.

Man har försökt komma sägnen på spåren med slagrutor och pendlar. En viss källarmur väckte särskild uppmärksamhet — men tillstånd att bryta upp den medeltida muren gavs aldrig. Så förblir gåtan olöst, och den Blå damen fortsätter sin sorgsna vandring. Spökhistorien har fängslat besökare i sekler och är än idag en av de mest älskade legenderna kring Kasteel Hoensbroek.

Källa: kasteelhoensbroek.nl + thelittlewalkofhorrors.com + adremlimburg.nl + indeheiligestede.nl',
  NULL,NULL,NULL,true,true,'published','web_nl_spookplekken'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. SINGRAVEN (Nederländerna) — den inmurade nunnan
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'singraven','Huis Singraven','singraven','Nederländerna','Overijssel, Denekamp','Slott',
  52.3760,7.0030,3,false,false,NULL,
  'En nunna murades in levande i klostermuren — hennes jämmer ekar ännu vid vattenkvarnen.',
  'Singraven är ett herrgårdsgods vid floden Dinkel nära Denekamp i Twente, i provinsen Overijssel. I en avlägsen forntid tjänade godset under ett tiotal år som nunnekloster, och kring år 1506 ska en av nunnorna ha murats in levande i klostermuren.

Enligt sägnen hade en av nunnorna ett gott förhållande till byborna och bröt mot reglerna genom att besöka den lokala krogen. När de övriga nunnorna upptäckte detta anklagades hon för okyskt leverne och skulle straffas av abbedissan. Domen blev att hon murades in levande i en av byggnadens väggar. Varje dag ekade hennes jämmer och skrik genom korridorerna.

Sedan dess sägs en spöklik gestalt, lik en nunna, vandra runt på Singraven. Hon syns regelbundet sväva ovanför det forsande vattnet vid den gamla vattenkvarnen, och hennes ande ska ha bringat olycka över godsets invånare.

Historiker påpekar att abbedissan knappast hade laglig rätt att verkställa en sådan dödsdom — hon kunde straffa, men i princip inte gå längre än till fängelse, och Singraven var kloster i bara tio år. Sann eller ej är "Non van Singraven" — nunnan från Singraven — en av Twentes mest kända och seglivade sägner, alltjämt levande i teater, böcker och lokalt folkminne, och få vågar vandra ensamma längs Dinkels stränder när skymningen faller över det gamla godset.

Källa: visittwente.nl + reisreport.nl + verhalenbank.nl + Nederländska Wikipedia "Singraven"',
  NULL,NULL,NULL,false,true,'published','web_nl_spookplekken'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. WITTE WIEVEN / WITTEWIJVENKUIL (Nederländerna) — folktrons dimandar
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'wittewijvenkuil-barchem','Wittewijvenkuil (Witte Wieven)','wittewijvenkuil-barchem','Nederländerna','Gelderland, Barchem','Naturplats',
  52.1460,6.3470,2,true,false,NULL,
  'De vita kvinnorna — kloka örtkvinnors andar som svävar i höstdimman över Achterhoeks hedar.',
  'Witte Wieven ("vita kvinnorna") är gestalter ur nederländsk folktro — dimmiga kvinnliga andar vars sägner går tillbaka åtminstone till förkristen tid, omkring 600-talet. De är mest kända i östra och norra Nederländerna, särskilt i Drenthe, Overijssel och Gelderland, med trakterna Twente, Achterhoek och Veluwe.

Trots att namnet bokstavligen betyder "vita", tolkas "witte" ofta som "vita" i betydelsen visa. Ursprungligen tänktes Witte Wieven vara kloka örtkvinnor och läkekunniga som botade människors krämpor till kropp och själ, och som dessutom hade gåvan att spå och se in i framtiden.

Andarna förknippas starkt med dimma. Man trodde att dimma vid en grav var tecken på att en ande visade sig, och förr menade folk sig ofta se Witte Wieven i dimstråken när hösten kom och kvällsdimman steg ur markerna.

Nära byn Barchem i Gelderland ligger Wittewijvenkuil — "de vita kvinnornas grop" — en sänka mellan två kullar där tre vita kvinnor enligt sägnen bodde. Liknande gropar finns på flera håll i Veluwe, bland annat vid Bathmen och Luttenberg. När höstdimman lägger sig över de östnederländska hedarna och skogarna är det inte svårt att förstå hur sägnen om de vita, svävande kvinnorna en gång föddes.

Källa: Engelska Wikipedia "Witte Wieven" + dutch-folklore.fandom.com + mijngelderland.nl + pansophia.nl',
  NULL,NULL,NULL,false,true,'published','web_nl_spookplekken'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;

-- ===== 38_AUSTRIA_SPUKORTE.sql =====
-- Spökkartan — 3 hemsökta platser i Österrike (Österreich)
-- Genererad 2026-06-09. Samma generella metod, nu Österrike (tyskspråkigt).
--
-- METOD: tyska sökord (Spukorte, Spukschloss, Geister, weiße Frau, Sage,
-- Raubritter) -> sidor som samlat spökhistorier (sagen.at, servus.com,
-- gruselblog.com, gedaechtnisdeslandes.at, burgenland.orf.at, vol.at m.fl.
-- samt tyska Wikipedia). Skrivet på SVENSKA, 200-600 ord/plats, aldrig fler
-- ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. BURG BERNSTEIN (Österrike) — den Vita frun
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'burg-bernstein','Burg Bernstein','burg-bernstein','Österrike','Burgenland, Bernstein','Slott',
  47.4060,16.2530,3,false,false,NULL,
  'Välj mellan två spöken — den sorgsna Vita frun eller "röde Iwan" som skrattar grymt vid barnens sängar.',
  'Burg Bernstein ligger nära den ungerska gränsen i Burgenland i östra Österrike och rymmer en av landets mest berömda spöksägner: den Vita frun av Bernstein.

Hon brukar visa sig i kvällstimmarna på olika platser i slottet och sägs sväva uppför trapporna. Till sist når hon kapellet, där hon knäböjer i bön framför altaret och sedan försvinner. Den späda kvinnogestalten med svallande hår trycker de knäppta händerna mot vänster kind och blickar sorgset ut i tomma intet. Hon bär en "párta", en diademliknande ungersk huvudprydnad, och en vit slöja höljer hela uppenbarelsen.

Den historiska förebilden är Katharina Frescobaldi, som mördades av sin man — antingen nedstucken eller inmurad i borgtornet. Den Vita frun ska ha setts upprepade gånger sedan 1859, med en topp strax före första världskriget. En ofta citerad händelse är hennes uppenbarelse vid ett fackeltåg 1912, inför slottsherrens familj och byborna; senast sågs hon under längre tid 1921.

På Bernstein kan man enligt sägnen rentav välja mellan två spöken: den sorgsna Vita frun och den så kallade "röde Iwan", som helst visar sig bredvid barnens sängar och skrattar grymt. Idag är borgen ett slottshotell — där gästerna kan tillbringa natten i sällskap med dess gengångare.

Källa: Tyska Wikipedia "Weiße Frau von Bernstein" + sagen.at + gruselblog.com + servus.com',
  NULL,NULL,NULL,true,true,'published','web_at_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. BURGRUINE AGGSTEIN (Österrike) — Schreckenwald och Rosengärtlein
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'burgruine-aggstein','Burgruine Aggstein','burgruine-aggstein','Österrike','Niederösterreich, Wachau','Ruin',
  48.3100,15.4290,4,false,false,NULL,
  'Den grymme Schreckenwald lät fångar svälta eller hoppa från klipphyllan — hans "rosenträdgård".',
  'Burgruine Aggstein tronar 300 meter över Donau på en klippudde i Wachau-dalen i Niederösterreich — en sägenomspunnen borgruin med en grym historia.

Den mest kända sägnen handlar om Rosengärtlein, "den lilla rosenträdgården". Borgherren Scheck von Wald, kallad "Schreckenwald" på grund av sin grymhet, lät spärra in sina fångar på en smal klipphylla som sköt ut från borgmuren, högt över avgrunden. Där gav han dem ett grymt val: att svälta ihjäl eller hoppa i döden. De instängda offren påminde Schreckenwald om rosor — och så föddes namnet Rosengärtlein.

Grunden för sägnen var främst Kuenringarnas välde i Donaudalen, där sagan om "Kuenringarnas hundar" vävdes samman med berättelsen om Rosengärtlein. Genom att identifiera Schreckenwald med Hadmar von Kuenring blev rosengårdsmotivet en del av Kuenringarnas sagotradition.

Den historiske Jörg Scheck von Wald var i själva verket inblandad i strider om tulluppbörd på Donau och i feodala fejder, som vållade befolkningen svår skada — och som med tiden förvandlade honom till sägnens skoningslöse rövarriddare. Idag är den vidsträckta ruinen, med sin svindlande utsikt över Donau och vinodlingarna i Wachau, ett av Niederösterreichs populäraste utflyktsmål — men på den smala klipphyllan, där vinden viner kring stenarna, vilar ännu skuggan av Schreckenwalds blodiga rosenträdgård, och få besökare lutar sig gärna ut över avgrunden där fångarna en gång tvingades välja sin död.

Källa: Tyska Wikipedia "Burgruine Aggstein" + sagen.at + gedaechtnisdeslandes.at + noe.orf.at',
  NULL,NULL,NULL,false,true,'published','web_at_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. BURG FORCHTENSTEIN (Österrike) — den grymma Rosalia
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'burg-forchtenstein','Burg Forchtenstein','burg-forchtenstein','Österrike','Burgenland, Forchtenstein','Borg',
  47.7100,16.3280,4,false,false,NULL,
  'Den grymma borgfrun svalt sina offer i det svarta tornet — och dömdes till samma död.',
  'Burg Forchtenstein reser sig på en klippa i Burgenland i östra Österrike och är känd för sägnen om den grymma borgfrun Rosalia.

Rosalia, gift med furst Giletus av Forchtenstein, var en hjärtlös och grym kvinna för vilken undersåtarna var värda mindre än villebråd. Hon plågade och förtryckte den värnlösa befolkningen på det mest hänsynslösa vis. Kom det in en enda slant för lite i skatt, eller dröjde betalningen, lät hon kasta folk i fängelsetornet — den svarta tornkammaren — där somliga rentav svalt ihjäl.

När hennes make återvände höll han dom över henne. Liksom hennes torterade offer bands hon i ett rep och firades ned i det svarta tornet, där hon fick svälta ovanpå kropparna av dem hon dödat. Borgvakten ropade var femtonde minut "Sallah he!", och ur djupet steg ett hjärtskärande skrik — men på åttonde dagen var det tyst i tornet.

Sedan dess svävade vid midnatt den döda borgfruns lysande ande kring det svarta tornet. Den försvann bara när borgvakten grep till vapen och ropade ett utdraget "Salah he!" mot tornet. Först när en senare herre av Forchtenstein lät bygga Rosalienkapelle på ett närliggande berg som botgöring fann den grymma fruns ande till slut evig ro.

Källa: sagen.at + austria-forum.org + burgenland.orf.at + meinbezirk.at',
  NULL,NULL,NULL,false,true,'published','web_at_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;

-- ===== 39_SWITZERLAND_SPUKORTE.sql =====
-- Spökkartan — 4 hemsökta platser i Schweiz (Schweiz/Suisse)
-- Genererad 2026-06-09. Samma generella metod, nu Schweiz (tysk-/franskspråkigt).
--
-- METOD: sökord på tyska/franska (Spukorte, Geister, Sage, lieux hantés,
-- fantômes) -> sidor som samlat spökhistorier (srf.ch, schweizer-illustrierte.ch,
-- baublatt.ch, watson.ch, swissinfo.ch, sagen-relaterade samt tyska Wikipedia).
-- Skrivet på SVENSKA, 200-600 ord/plats, aldrig fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. SENNENTUNTSCHI (Schweiz) — halmdockan som vaknade till liv
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'sennentuntschi','Sennentuntschi','sennentuntschi','Schweiz','Graubünden, Chur','Museum',
  46.8499,9.5329,5,false,false,NULL,
  'Herdarna byggde en docka av halm för ro skull — den vaknade och flådde sin mästare.',
  'Sennentuntschi är en av Alpernas mest skräckinjagande sägner, särskilt känd i Schweiz. Den handlar om en kvinnodocka av halm som väcks till liv och grymt vänder sig mot sina skapare.

Enligt sägnen tillverkar några sennar — fäbodvallens herdar — uttråkade högt uppe på en alp en docka av halm med blont hår. Snart sitter dockan med vid bordet, bjuds upp till dans och skickas nattetid från man till man. När sennarna döper sin "Tuntschi" öppnar dockan plötsligt ögonen och kräver härefter sin tribut av förråd och uppmärksamhet.

Till slut flyr de skräckslagna herdarna. Men just i flykten ser de hur Sennentuntschi spikar upp mästersennens avdragna hud till tork på hyddans tak, medan de blodiga resterna ligger kvar på golvet.

Motivet med halmdockan är känt i stora delar av alpområdet, men det är i Schweiz den fått sitt namn Sennentuntschi och sin mest kusliga form. I Rätiska museet i Chur, i kantonen Graubünden, kan man se den enda äkta Sennentuntschi-dockan — en träfigur med "explicit avbildade könsdelar, äkta människohår på huvudet och ett oroande ansikte med uppspärrad mun". Museet förvärvade figuren 1978 från en av de sista invånarna i byn Masciadon. Sägnen har inspirerat både filmer och konst och förblir en av Schweiz mörkaste berättelser.

Källa: Tyska Wikipedia "Sennentuntschi" + srf.ch + Bergwelten + swissinfo.ch (Rätisches Museum Chur)',
  NULL,NULL,NULL,true,true,'published','web_ch_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. SCHLOSS CHILLON (Schweiz) — fången i de underjordiska valven
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'schloss-chillon','Schloss Chillon','schloss-chillon','Schweiz','Vaud, Veytaux','Slott',
  46.4142,6.9275,3,false,false,NULL,
  'Vattenborgen vid Genèvesjön — där Bonivard satt kedjad i åratal, övertygad om att sjön skulle dränka honom.',
  'Schloss Chillon (Château de Chillon) är en mäktig vattenborg som i nästan tusen år tronat på en klippö vid Genèvesjöns strand nära Montreux i kantonen Vaud. Bakom den vackra fasaden döljer sig en mörk historia, främst förknippad med fången François Bonivard.

Bonivard (1493–1570) var en schweizisk patriot och prior av Sankt Viktor i Genève, som motsatte sig huset Savojens välde. År 1530 kastades han i Chillons fängelsehåla. Efter två år i borgens våningar — tack vare sin adliga rang — tillbringade han de följande fyra åren kedjad i de underjordiska valven, dit dagens besökare nu stiger ned.

Enligt sägnen hade Bonivard ingen utsikt mot omvärlden och trodde i åratal att han satt under sjöns vattenyta, och var följaktligen skräckslagen för att drunkna i en översvämning. Den pelare han kedjades fast vid i åratal kan ännu ses i fängelsevalvet på borgens sjösida. Han befriades först 1536, när bernarna erövrade Chillon.

År 1816 besökte lord Byron borgen och blev så gripen att han kort därpå skrev den 392 rader långa dikten "The Prisoner of Chillon", som gjorde borgen världsberömd och förvandlade Bonivard till en frihetssymbol. Den fuktiga, kalla fångenskapens skuggor vilar ännu tunga över de underjordiska gångarna vid sjön.

Källa: Tyska Wikipedia "Schloss Chillon" + "Der Gefangene von Chillon" + burgerbe.de + swissinfo.ch',
  NULL,NULL,NULL,false,true,'published','web_ch_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. SCHLOSS NEU-BECHBURG (Schweiz) — den inmurade junkern Kuoni
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'neu-bechburg','Schloss Neu-Bechburg','neu-bechburg','Schweiz','Solothurn, Oensingen','Slott',
  47.2880,7.7060,3,false,false,NULL,
  'Den onde rövarriddaren murades in levande 1408 — hans ande retas ännu med slottets teknik.',
  'Schloss Neu-Bechburg reser sig på en kulle ovanför Oensingen i kantonen Solothurn och kallas allmänt för "spökslottet". Borgen byggdes i slutet av 1200-talet av grevarna av Bechburg.

Enligt sägnen murades den onde junkern Kuoni in här år 1408. Som rövarriddare hade han begått ogärningar och spritt skräck över hela trakten. Det gudomliga straffet kom i form av digerdöden — och det världsliga blev att han sattes i ständig karantän på sin egen borg: levande inmurad i sydtornets tillbyggnad. Försörjd med mat och dryck genom en smal springa dog den grymme Kuoni till slut en ensam död som utstött.

Men det har inte hindrat rövarriddarens rastlösa ande från att hemsöka borgens korridorer. Idag betraktas Kuoni som ett stillsamt och fredligt slottsspöke som då och då spelar små spratt, stänger dörrar och mest vandrar omkring i salarna. Borgvaktmästaren och besökare berättar om visslande, knarrande och poltrande — och dyra apparater och datorer som plötsligt ger upp andan, som om spöket har en förkärlek för teknik.

År 1415 såldes borg och herradöme till Bern och Solothurn, och omkring sextio år senare övergick det helt till Solothurn. Sägnen om den inmurade junkern fängslar än idag besökarna till denna historiska borg, och spökjägare har gång på gång sökt sig hit.

Källa: srf.ch + watson.ch + blick.ch + 20min.ch + neu-bechburg.ch',
  NULL,NULL,NULL,false,true,'published','web_ch_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. KURHOTEL VAL SINESTRA (Schweiz) — husanden Hermann
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'val-sinestra','Kurhotel Val Sinestra','val-sinestra','Schweiz','Graubünden, Sent','Hotell',
  46.8870,10.3460,3,false,true,NULL,
  'Spökhotellet i Unterengadin — där fönster som låsts personligen öppnas igen av sig själva.',
  'Kurhotel Val Sinestra ligger nära byn Sent i Unterengadin, i kantonen Graubünden — en elva våningar hög, avsides badanläggning i de schweiziska alperna. År 1978 köpte den nederländske byggingenjören Peter Kruit huset, utan att veta att någon redan bodde där: den olycksbådande Hermann.

Hermann, som han kom att kallas, är inget vanligt gästspel — han sägs vara ett spöke. Det var hotellföreståndaren Wanda Hopmann som gav gästen från andra sidan hans namn.

Hermann tycks vara en snarast fredlig närvaro, mer en skälmsk husande än en skräckinjagande uppenbarelse. Men fenomenen är många: ett högt mullrande mötte den nye ägaren, nyckelknippor börjar svänga utan anledning, och fönster öppnas som av en osynlig hand. När personalen stängde hotellet inför vintern öppnades enskilda fönster på nytt — "fönster som jag personligen låst", försäkrar hotelldirektören.

Enligt vittnesmål visade sig mannen i elegant kostym med hatt, i 1920-talsstil — den tid då han sägs ha dött. Han var en belgare som arbetade inom textilindustrin och stred som soldat i första världskriget, där han ska ha smittats av tuberkulos, som han sedan behandlade just vid Val Sinestra. Idag drar det avlägsna "spökhotellet" till sig både nyfikna gäster och spökjägare, som hoppas få en skymt av Hermann.

Källa: baublatt.ch + blick.ch + tagesanzeiger.ch + NZZ.ch + SRF Kulturplatz',
  NULL,NULL,NULL,false,true,'published','web_ch_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;

-- ===== 40_USA_HAUNTED_BATCH5.sql =====
-- Spökkartan — 4 fler hemsökta platser i USA (haunted places)
-- Genererad 2026-06-09. Kompletterar 21/22_USA_PLACES (Stanley, Myrtles,
-- Winchester, Lizzie Borden, Trans-Allegheny, LaLaurie, Amityville, Eastern
-- State, Alcatraz, Waverly Hills, Bell Witch, Gettysburg — utelämnas här).
--
-- METOD: engelska sökord (haunted places, ghosts, most haunted) -> sidor som
-- samlat spökhistorier (hauntedrooms.com, usghostadventures.com, ghostcitytours.com,
-- Atlas Obscura, Smithsonian m.fl. samt engelska Wikipedia). Skrivet på SVENSKA,
-- 200-600 ord/plats, aldrig fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. RMS QUEEN MARY (USA) — det hemsökta skeppet
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'queen-mary-long-beach','RMS Queen Mary','queen-mary-long-beach','USA','Kalifornien, Long Beach','Fartyg',
  33.7522,-118.1903,3,false,true,NULL,
  'Lyxångaren med över 150 andar — i hytt B340 dras täcken av nybäddade sängar.',
  'RMS Queen Mary, en gång världens lyxigaste oceanångare, tjänade som trupptransport under andra världskriget och ligger sedan dess permanent förtöjd i Long Beach i Kalifornien — idag ett av USA:s mest omtalat hemsökta fartyg. Skeppet sägs hysa över 150 andar, och både personal och besökare rapporterar regelbundet om vad som kan vara paranormal aktivitet.

Mest ökänd är hytt B340. Gäster och städerskor har funnit badrumskranen rinnande utan att någon bott i rummet, och täcken bortdragna strax efter att sängen bäddats. Under 1970-talet stängdes B340 av, men 2018 öppnades den åter som spökattraktion.

Den nu tömda förstaklasspoolen sägs hemsökas av minst två andar — bland dem en liten flicka vid namn Jackie, som ska ha drunknat i poolen på 1940-talet. Gäster och guider berättar att de hör hennes skratt och plask.

Det finns dock betydande skepsis kring historierna. Det finns ingen notering om att någon drunknat i vare sig första- eller andraklasspoolen, och inget register över en styckad kropp i B340 eller de tre tredjeklasshytter som rummet en gång slogs samman av. Huvuddelen av spökaktiviteten började omkring 1989 — vilket vissa kopplar till Disney, som då drev fartyget och var känt för att väva fängslande berättelser. Sant eller påhittat: Queen Mary förblir ett av Amerikas mest besökta spökskepp.

Källa: hauntedrooms.com + usghostadventures.com + ghostcitytours.com + worldofcruising.co.uk',
  NULL,NULL,NULL,true,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. 1886 CRESCENT HOTEL (USA) — "Amerikas mest hemsökta hotell"
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'crescent-hotel','1886 Crescent Hotel','crescent-hotel','USA','Arkansas, Eureka Springs','Hotell',
  36.4097,-93.7383,3,false,true,NULL,
  'Kvacksalvaren Norman Bakers falska cancerklinik — bårhus, lik-kylrum och spöklika sjuksköterskor.',
  'Crescent Hotel i Eureka Springs i Arkansas, byggt 1886, kallas ofta "Amerikas mest hemsökta hotell". Det uppfördes som en lyxanläggning för förmögna resenärer, men dess mörka rykte vilar på en senare epok.

År 1937 köptes hotellet av Norman Baker, en karismatisk men bedräglig figur utan någon medicinsk utbildning, som redan jagats ut ur sin hemstat Iowa. Han gjorde om hotellet till Baker Cancer Clinic och utgav sig för att ha botemedlet mot cancer. En av hans "behandlingar" bestod i att borra hål i patienternas skallar och spruta in en blandning av källvatten, majssilke, karbolsyra och malda vattenmelonfrön. År 1940 greps och fängslades Baker för postbedrägeri.

En arkeologisk utgrävning har senare blottlagt hundratals flaskor med Bakers "hemliga formel" och burkar med kirurgiska "preparat" tagna ur patienter. Till den makabra atmosfären hör också ett bårhus från Bakers tid, med obduktionsbord och en kylkammare för lik.

Under de senaste 25 åren har Crescent fått rykte som "Amerikas mest hemsökta hotell", uppmärksammat i sjutton nationella och internationella paranormala tv-program. Gäster berättar om spöklika sjuksköterskor som skjuter bårvagnar, uppenbarelser av forna patienter, underliga ljus som driver genom korridorerna och steg som ekar i tomma rum. Idag tar hotellet emot både vanliga gäster och spöksökare.

Källa: crescent-hotel.com + Smithsonian Magazine + usghostadventures.com + Atlas Obscura',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. VILLISCA AXE MURDER HOUSE (USA) — det olösta massmordet
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'villisca-axe-murder-house','Villisca Axe Murder House','villisca-axe-murder-house','USA','Iowa, Villisca','Hus',
  40.9300,-94.9760,5,false,true,NULL,
  'Åtta människor — sex av dem barn — yxmördades i sömnen 1912. Mordet är ännu olöst.',
  'Villisca Axe Murder House i den lilla orten Villisca i Iowa är en av delstatens mest ökända spökplatser — skådeplatsen för ett brutalt och ännu olöst massmord.

Natten mellan den 9 och 10 juni 1912, efter en kyrkogudstjänst, blev åtta människor ihjälslagna med en yxa medan de sov. Offren var föräldrarna Josiah B. Moore (43) och Sarah (39), deras fyra barn Herman (11), Mary Katherine (10), Arthur (7) och Paul (5), samt två gästande flickor, Ina May (8) och Lena Stillinger (11). Alla åtta hade svåra huvudskador; Josiah ensam hade träffats minst trettio gånger.

Utredningen pekade ut flera misstänkta. Pastorn George Kelly bekände inför rätten, men juryn trodde inte på bekännelsen, och han friades efter två rättegångar. I boken "The Man from the Train" (2017) hävdar Bill och Rachel James att mördaren var Paul Mueller, en tysktalande immigrant som var föremål för en år lång men resultatlös klappjakt. Brottet är än idag olöst.

Ett par köpte huset 1995 och återställde det till hur det såg ut 1912, utan moderna installationer. Idag erbjuds guidade turer och övernattningar i huset — vars främsta dragningskraft är att det sägs vara hemsökt av offren. Få platser i USA bär på en så tung och konkret tragedi.

Källa: Engelska Wikipedia "Villisca axe murders" + murderhouse.com + allthatsinteresting.com + traveliowa.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. LEMP MANSION (USA) — bryggardynastins självmord
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'lemp-mansion','Lemp Mansion','lemp-mansion','USA','Missouri, St. Louis','Herrgård',
  38.5970,-90.2230,3,false,true,NULL,
  'Fyra i bryggarfamiljen Lemp tog sina liv — tre av dem innanför husets väggar.',
  'Lemp Mansion på DeMenil Place i Benton Park i St. Louis, Missouri, byggdes 1890 och räknas till stadens mest hemsökta byggnader. Bakom spökhistorierna ligger en av Amerikas mest tragiska bryggardynastier.

John Adam Lemp kom till St. Louis från Eschwege i Tyskland 1838 och byggde 1840 ett blygsamt bryggeri. William J. Lemp Brewing Co. växte till en dominerande kraft på den amerikanska ölmarknaden före förbudstiden, särskilt känd för ölmärket Falstaff.

Men familjen drabbades av en rad självmord. Mellan 1904 och 1949 tog fyra medlemmar av familjen Lemp sina liv, tre av dem innanför husets väggar. Det första skedde den 13 februari 1904, då William sköt sig i huvudet med en revolver i sitt sovrum. År 1920 tog hans dotter Elsa, ansedd som St. Louis rikaste arvtagerska, sitt liv. William J. Lemp Jr. sköt sig i samma byggnad där hans far dött arton år tidigare, och brodern Charles, som bodde kvar i huset, dog likaså för egen hand.

Sedan dess sägs herrgården vara hemsökt av familjen Lemps andar. Besökare och personal berättar om steg, röster och skuggor i de gamla rummen. Idag är Lemp Mansion en restaurang med övernattningsrum — där gästerna kan dela natten med den olycksdrabbade familjens gengångare.

Källa: Engelska Wikipedia "Lemp Mansion" + ghostcitytours.com + Atlas Obscura + lempmansion.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;

-- ===== 41_INDIA_HAUNTED.sql =====
-- Spökkartan — 4 hemsökta platser i Indien (भूतिया जगहें / haunted places)
-- Genererad 2026-06-09. Samma generella metod, nu Indien.
--
-- METOD: sökord på engelska/hindi (haunted places, ghosts, भूत, भूतिया जगह)
-- -> sidor som samlat spökhistorier (Rajasthan Tourism, holidify.com,
-- nativeplanet.com, homegrown.co.in m.fl. samt engelska Wikipedia).
-- Skrivet på SVENSKA, 200-600 ord/plats, aldrig fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. BHANGARH FORT (Indien) — Indiens mest hemsökta plats
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'bhangarh-fort','Bhangarh Fort','bhangarh-fort','Indien','Rajasthan, Alwar','Fästning',
  27.0963,76.2872,5,false,false,NULL,
  'Indiens mest hemsökta plats — myndigheten förbjuder inträde efter solnedgången.',
  'Bhangarh Fort i Rajasthan, byggt på 1600-talet av Madho Singh, betraktas allmänt som Indiens mest hemsökta plats. Fästningen ligger omkring 50 kilometer från Sariska-reservatet, mellan Jaipur och Alwar.

Två sägner förklarar dess rykte. Den första handlar om asketen Baba Balau Nath, vars meditationsplats fanns här långt före fästningen. Han tillät bygget på ett strikt villkor: att fästningens skugga aldrig fick falla över hans plats. Allt var väl tills en ärelysten efterträdare byggde på fästningen på höjden, så att dess olycksbringande skugga slukade asketens boning — och därmed var Bhangarh dömt.

Den andra sägnen rör prinsessan Ratnavati, eftertraktad av många friare. En trollkarl, bevandrad i svartkonst, blev förälskad i henne och bytte i hemlighet ut hennes parfym mot en kärleksdryck. Men prinsessan genomskådade listen och kastade drycken på ett stenblock, som rullade mot trollkarlen och krossade honom. Innan han dog förbannade han staden: den skulle snart förstöras och ingen skulle någonsin kunna leva där.

Eftersom platsen anses hemsökt är Bhangarh stängt för besökare före soluppgång och efter solnedgång — den indiska fornminnesmyndigheten ASI har officiellt förbjudit inträde nattetid. ASI har dock aldrig officiellt förklarat platsen hemsökt; förbudet motiveras med att de instabila ruinerna är farliga i mörker och att trakten hyser leoparder och vildsvin. Men för de flesta är Bhangarh helt enkelt Indiens mest skräckinjagande plats.

Källa: Rajasthan Tourism + holidify.com + thomascook.in + urbanjaipur.com',
  NULL,NULL,NULL,true,true,'published','web_in_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. KULDHARA (Indien) — den förbannade spökbyn
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'kuldhara','Kuldhara','kuldhara','Indien','Rajasthan, Jaisalmer','Övergiven',
  26.7700,70.6470,4,false,false,NULL,
  'En hel by försvann över en natt 1825 — och förbannade marken så att ingen mer kan bo där.',
  'Kuldhara är en spökby omkring 17 kilometer väster om Jaisalmer i Rajasthan. För tre sekler sedan var den en blomstrande ort, men idag ligger den öde, höljd i mystik.

Byn grundades 1291 av Paliwal-brahminerna, ett välmående samhälle tack vare deras skicklighet att odla rika skördar i den karga öknen med hjälp av ett uppfinningsrikt system som utnyttjade underjordiska vattenådror.

Enligt sägnen försvann en natt år 1825 alla invånare i Kuldhara och 83 närliggande byar i mörkret. Anledningen var byns onde minister Salim Singh, som fäst blicken vid byhövdingens dotter och förklarat att han skulle gifta sig med henne, med eller mot hennes vilja, och hotat byborna med fruktansvärda följder om de inte lydde. Hellre än att ge efter beslöt bybornas råd att överge sina förfäders hem över en enda natt. Innan de gav sig av förbannade de Kuldhara så att ingen någonsin mer skulle kunna bosätta sig där.

Trogen förbannelsen ligger byn fortfarande öde, och det sägs att ingen lyckats tillbringa ens en natt där. Forskare pekar också på andra möjliga orsaker till den plötsliga flykten — sinande vattentillgång eller en jordbävning. Idag är Kuldhara ett skyddat fornminne under delstatens arkeologiska myndighet, en kuslig stad av tomma sandstenshus där öknens vind viskar mellan ruinerna.

Källa: Rajasthan Tourism + Engelska Wikipedia "Kuldhara" + heritagetourandtravels.com + jaisalmercab.com',
  NULL,NULL,NULL,false,true,'published','web_in_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. SHANIWAR WADA (Indien) — "Farbror, rädda mig"
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'shaniwar-wada','Shaniwar Wada','shaniwar-wada','Indien','Maharashtra, Pune','Ruin',
  18.5195,73.8553,4,false,false,NULL,
  'På fullmånenätter hörs den mördade prinsens rop genom ruinerna: "Kaka mala vachva".',
  'Shaniwar Wada i Pune i Maharashtra byggdes 1732 som säte för Peshwa-härskarna i Marathakonfederationen, skapad av den ikoniske ledaren Baji Rao I. Bakom de mäktiga murarna utspelade sig en av Indiens mest beryktade förräderier.

Den unge Peshwan Narayanrao hade hamnat i konflikt med sin farbror Raghunathrao och satt honom i husarrest. För att bli fri konspirerade farbrodern med ett band legoknektar, Gardis, och sände ett meddelande: "Narayanrao la dhara" ("Grip Narayanrao"). Men farbroderns hustru Anandibai ändrade ett enda ord, så att budskapet blev "Narayanrao la mara" ("Döda Narayanrao"). Den 30 augusti 1773 mutades vakterna, och när Narayanrao försökte fly höggs han brutalt ihjäl, hans kropp styckad, medan han skrek efter sin farbror om hjälp.

Sedan dess sägs Narayanraos ande hemsöka platsen. På fullmånenätter ska man kunna höra en ung pojkes röst ropa "Kaka mala vachva" ("Farbror, rädda mig") genom de tomma salarna och raserade korridorerna. Besökare berättar om oförklarliga steg, en isande närvaro och plötsliga temperaturfall efter mörkrets inbrott.

Den 27 februari 1828 utbröt en väldig eld som rasade i sju dagar och lade palatset i ruiner — bara de tunga granitmurarna, de mäktiga teakportarna och de djupa grundvalarna stod kvar. Idag är Shaniwar Wada en av Indiens mest omtalade spökplatser.

Källa: Engelska Wikipedia "Shaniwar Wada" + homegrown.co.in + thrillingtravel.in + savaari.com',
  NULL,NULL,NULL,false,true,'published','web_in_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. DOW HILL, KURSEONG (Indien) — den huvudlöse pojken
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'dow-hill-kurseong','Dow Hill, Kurseong','dow-hill-kurseong','Indien','Västbengalen, Kurseong','Naturplats',
  26.8780,88.2780,4,true,false,NULL,
  'En huvudlös pojke i skoluniform vandrar längs "Death Road" i de dimhöljda skogarna.',
  'Dow Hill ligger i de dimhöljda bergen vid Kurseong i Västbengalen, bara tre mil från Darjeeling, och räknas till Indiens mest hemsökta platser.

Den mest kända sägnen handlar om en huvudlös pojke. Människor påstår sig ha sett en ung pojke i skoluniform gå i och kring Dow Hill-skolan och den intilliggande skogen — bärande sitt eget huvud i händerna eller under armen. Många berättar om en huvudlös gestalt som vandrar längs vägsträckan mellan Dow Hill Road och skogskontoret, allmänt kallad "Death Road", dödens väg.

Victoria Boys High School och den närliggande internatskolan är brännpunkter för det paranormala. Elever rapporterar ofta om steg i tomma korridorer, känslan av att vara iakttagen och flyktiga skuggor som far genom klassrummen. Lokalbefolkningen säger att man ständigt känner sig bevakad så snart man går djupare in i skogen, och somliga berättar om ett "fasansfullt rött öga" som stirrar rakt in i ens egna innan det försvinner i en blixt.

Berättelserna bygger till stor del på lokala sägner och muntlig tradition, och det finns inga vetenskapliga belägg för spöken vare sig i Kurseong eller någon annanstans. Men i den eviga dimman, bland de täta barrträden och de gamla skolbyggnaderna, behöver man inte tro på spöken för att känna kalla kårar längs ryggraden.

Källa: nativeplanet.com + zeezest.com + tripoto.com + northeasternchronicle.in',
  NULL,NULL,NULL,false,true,'published','web_in_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;

-- ===== 42_JAPAN_HAUNTED_BATCH2.sql =====
-- Spökkartan — 3 fler hemsökta platser i Japan
-- Genererad 2026-06-09. Kompletterar 26_ASIA_JAPAN (Aokigahara, Himeji,
-- Inunaki, Kiyotaki, Oiran Buchi, Mount Osore m.fl. — utelämnas här).
--
-- METOD: engelska/japanska sökord (haunted, ghosts, 心霊スポット) -> sidor som
-- samlat spökhistorier (atlasobscura.com, japantoday.com, timeout.com m.fl.
-- samt engelska Wikipedia). Skrivet på SVENSKA, 200-600 ord/plats, aldrig
-- fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. HASHIMA ISLAND / GUNKANJIMA (Japan) — spökön
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'hashima-gunkanjima','Hashima (Gunkanjima)','hashima-gunkanjima','Japan','Nagasaki','Övergiven',
  32.6277,129.7386,4,false,true,NULL,
  '"Slagskeppsön" — en övergiven gruvö med mörk tvångsarbetshistoria och viskningar ur tomma korridorer.',
  'Hashima, allmänt kallad Gunkanjima ("slagskeppsön"), är en övergiven ö omkring 15 kilometer från Nagasakis centrum. Smeknamnet kom av att ön på avstånd liknar det japanska slagskeppet Tosa.

Den bara 6,3 hektar stora ön var känd för sina undervattenskolgruvor, anlagda 1887. Mitsubishi köpte ön 1890 och började bryta kol ur havsbottnen, medan sjömurar och utfyllnader byggde ut ön. År 1959 nådde befolkningen sin topp på 5 259 invånare — vilket gjorde Hashima till en av de mest tätbefolkade platserna på jorden.

Men ön bär också på en mörk historia. Före och under andra världskriget var den en plats för tvångsarbete: med regeringens stöd förde Mitsubishi hit tusentals arbetare från Korea och Kina, ofta mot deras vilja, för att slita i de farliga och utmattande gruvorna. Dödssiffrorna uppskattas till mellan 137 och 1 300.

Mitsubishi stängde gruvan i januari 1974, och den 20 april tömdes ön på sina invånare. Efter 35 år öppnades den åter för besök 2009, och 2015 togs den upp på Unescos världsarvslista. De spöklika ruinerna och den tragiska historien har gett upphov till rykten om paranormal aktivitet — besökare berättar om en kvävande atmosfär, viskningar ur tomma korridorer och mörka gestalter skymtade genom krossade fönster.

Källa: Engelska Wikipedia "Hashima Island" + Atlas Obscura + asiangeo.com + GaijinPot Travel',
  NULL,NULL,NULL,true,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. SUZUGAMORI EXECUTION GROUNDS (Japan) — Edos avrättningsplats
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'suzugamori','Suzugamori avrättningsplats','suzugamori','Japan','Tokyo, Shinagawa','Avrättningsplats',
  35.5897,139.7372,5,true,false,NULL,
  'Upp till 200 000 avrättades här — och vid brunnen där huvudena tvättades tar spöksynerna aldrig slut.',
  'Suzugamori avrättningsplats i Shinagawa i Tokyo var i drift från 1651 till 1871 och var en av Edos två officiella avrättningsplatser. Den låg medvetet placerad längs Tōkaidō-vägen söder om Edo, där resenärer och inkommande rōnin skulle se den — som både straff och avskräckande exempel.

Under sina 220 år sägs mellan 100 000 och 200 000 människor ha avrättats här. Halshuggning med svärd var den officiella metoden i Japan fram till 1873, men flera andra användes också. Somliga offer utsattes för mizuharitsuke, en grym "vattenkorsfästning", där de dömda bands vid pålar och långsamt dränktes av den stigande tidvattenfloden. Korsfästning och bränning på bål förekom också och drog till sig stora skaror åskådare.

Den första dokumenterade avrättningen var rōninen Marubashi Chūya, en av männen bakom Keian-upproret 1651. Den unga grönsakshandlardottern Yaoya Oshichi brändes levande här 1683, bara sexton år gammal, sedan hon tänt eld på sitt hem.

Berättelser om spöken och vilsna andar lever vidare och drar än idag till sig amatörspökjägare och nyfikna. Det sägs att de avrättades andar visar sig sent på natten, och många trafikolyckor vid närliggande korsningar har tillskrivits människor som sett dem. Kvar finns brunnen Kubiarai-no Ido, där de avhuggna huvudena tvättades — och rapporterna om spöksyner tar aldrig slut.

Källa: Engelska Wikipedia "Suzugamori execution grounds" + japantoday.com + about-tokyo.com + minnano-rakuraku.com',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. KOZUKAPPARA EXECUTION GROUNDS (Japan) — den orenade marken
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'kozukappara','Kozukappara avrättningsplats','kozukappara','Japan','Tokyo, Arakawa','Avrättningsplats',
  35.7330,139.7990,5,true,false,NULL,
  'Tågen saktar in för att inte störa andarna — på marken där 200 000 dog under Edotiden.',
  'Kozukappara (även stavat Kotsukappara) i Minami-Senju i Arakawa i Tokyo var en av Edotidens tre stora avrättningsplatser, anlagd 1651 under shogunatets dagar. Den ligger bara några minuters promenad från Minami-Senju station.

Mellan 1651 och 1873 ska svindlande 200 000 människor ha dödats här på de mest fasansfulla vis man kan tänka sig: halshuggning, korsfästning, bränning på bål och till och med kokning levande. Vanligen korsfästes, brändes eller halshöggs fångarna, varpå deras huvuden sattes upp på spjut i tre dagar som varning.

Platsen ligger intill Enmeiji-templet, och en stor del av den gamla avrättningsplatsen täcks idag av järnvägsspår. En tre meter hög stenjizo restes här till offrens minne, men efter jordbävningen den 11 mars 2011 bedömdes statyn vara rasfärdig och monterades ned; sockeln, huvudet och en arm finns ännu kvar.

Som avrättningsplats ansågs Kozukappara andligt orenad, och de enda som bodde där var de utstötta eta. Än idag berättar äkta Edo-bor att Jōban- och Hibiyalinjerna ofta får driftstopp när de passerar platsen, eller att tågen saktar in för att inte störa de andar som hemsöker området. Få platser i Tokyo bär på en så tung historia av lidande och död.

Källa: Engelska Wikipedia "Kozukappara execution grounds" + Time Out Tokyo + Atlas Obscura + city.arakawa.tokyo.jp',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;

-- ===== 43_CHINA_HK_HAUNTED_BATCH2.sql =====
-- Spökkartan — 4 fler hemsökta platser i Kina och Hongkong
-- Genererad 2026-06-09. Kompletterar 25_ASIA_CHINA_HK_MACAU (Chaonei 81,
-- Förbjudna Staden, Nam Koo Terrace, Tat Tak School m.fl. — utelämnas här).
--
-- METOD: engelska/kinesiska sökord (haunted, ghosts, 鬼) -> sidor som samlat
-- spökhistorier (ancient-origins.net, thebeijinger.com, hongkongliving.com,
-- ghoststories.sg m.fl. samt engelska Wikipedia). Skrivet på SVENSKA,
-- 200-600 ord/plats, aldrig fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. FENGDU GHOST CITY (Kina) — dödsrikets stad
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'fengdu-ghost-city','Fengdu Ghost City','fengdu-ghost-city','Kina','Chongqing, Fengdu','Tempel',
  29.8920,107.7300,3,false,false,NULL,
  'Dödsrikets stad vid Yangtze — där själen prövas vid hjälplöshetens bro och spökporten.',
  'Fengdu Ghost City — "spökstaden" — är ett vidsträckt komplex av helgedomar, tempel och kloster tillägnade livet efter detta, beläget på Mingberget i Fengdu i Chongqing, omkring 170 kilometer nedströms längs Yangtzefloden.

Enligt sägnen fick Fengdu sitt namn under östra Han-dynastin, då två kejserliga ämbetsmän, Yin Changsheng och Wang Fangping, kom till Mingberget för att utöva taoism och därvid blev odödliga. Deras sammanslagna namn, "Yinwang", betyder "dödsrikets kung" — och därmed började platsens inriktning mot underjorden.

Komplexet förenar konfucianism, taoism och buddhism och kretsar helt kring döden. Många av templen visar målningar och skulpturer av människor som torteras för sina synder. Tre prov måste den dödes själ klara på vägen genom dödsriket. Naihebron, "hjälplöshetens bro", byggd under Mingdynastin, sägs förbinda de levandes värld med underjorden. Vid Guimen-porten, "spökporten", anmäler sig de dödas själar inför dödsrikets kung för att dömas och få ett vägpass som bevis för att registreras i livet efter detta. Det sista provet sker i Tianzi-palatset, kejsarpalatset, vars nuvarande byggnad härrör från tidig Qingtid.

Idag är Fengdu en av de populäraste hållplatserna på Yangtze-kryssningarna — en plats där hela den kinesiska föreställningen om dödsriket gjutits i sten, tegel och färg, och där besökaren själv kan vandra den väg själarna sägs ta efter döden.

Källa: Engelska Wikipedia "Fengdu Ghost City" + Ancient Origins + silkroadtravel.com + ichongqing.info',
  NULL,NULL,NULL,true,true,'published','web_cn_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. BUSS 375 (Kina) — Pekings spökbuss
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'beijing-bus-375','Buss 375 (Xiangshan)','beijing-bus-375','Kina','Peking, Xiangshan','Vägsträcka',
  39.9920,116.1880,4,true,false,NULL,
  'Nattens sista buss tog ombord tre fotsida gestalter — utan ben. Sedan försvann den spårlöst.',
  'Buss 375 är en av Kinas mest kända spökhistorier, sägs ha utspelat sig vid midnatt den 14 november 1995 i Peking. Det var nattens sista buss, som lämnade hållplatsen vid Yuanmingyuan med Xiangshan ("Doftkullarna") som mål.

Vid Sommarpalatsets sydport steg fyra passagerare på: en gammal kvinna, ett ungt par och en ung man. Efter en stund fick föraren syn på två skuggor vid vägkanten som vinkade åt bussen. Han stannade, dörrarna öppnades och tre personer steg på — klädda i långa, fotsida dräkter. När vinden lyfte deras rockar såg den gamla kvinnan att de saknade ben.

Nästa dag rapporterade buss 375 aldrig in till stationen. Den hade försvunnit tillsammans med föraren och konduktrisen. Polisen genomsökte hela staden utan att finna ett spår. Två dagar senare hittades bussen till slut — sjunken i Miyun-reservoaren, omkring tio mil från Xiangshan. Inuti låg tre svårt förmultnade kroppar: föraren, konduktrisen och en oidentifierad man.

Det bör påpekas att busslinjen i verkligheten aldrig har existerat, vilket talar för att det rör sig om en modern skröna. Historien spreds via nattliga radioprogram, tv-shower och till och med av den berömda sångerskan Na Ying i Taiwan under 1990-talet — och har sedan dess blivit en av den kinesiska internetkulturens mest seglivade spökberättelser.

Källa: thebeijinger.com + scaryforkids.com + newstrack.com + urban-folklores.blogspot.com',
  NULL,NULL,NULL,false,true,'published','web_cn_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. DRAGON LODGE (Hongkong) — Peaks mest hemsökta hus
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'dragon-lodge','Dragon Lodge','dragon-lodge','Hongkong','Victoria Peak','Övergiven',
  22.2710,114.1450,4,true,false,NULL,
  'Den övergivna herrgården på Peak — där byggarbetare flytt för en osynlig barngråt.',
  'Dragon Lodge är en herrgård från tiden före andra världskriget på adressen 32 Lugard Road, högt uppe på Victoria Peak i Hongkong, med en oöverträffad utsikt över skyline och Victoria Harbour. Sedan många år står den tom — och kallas ofta "Hongkongs mest hemsökta hus".

Flera sägner omger huset. Det sägs att den ursprunglige ägaren gick i konkurs, och att den andre ägaren dog inne i huset. Under andra världskriget ska japanska soldater ha använt egendomen för sina operationer, och enligt en utbredd men ospårbar historia ska de ha halshuggit flera katolska nunnor på innergården. Var berättelsen har sitt ursprung tycks dock ingen veta.

Efter 1980-talet växte de inre vägarna igen, och Dragon Lodge fick sitt rykte som Hongkongs mest hemsökta hus. Byggnadsarbetare som försökt utföra arbeten på egendomen berättar om en osynlig barngråt som ekat genom huset och fått modet att svikta.

Idag är herrgården fortfarande öde och obebodd, avspärrad med taggtråd och nästan uppslukad av den frodiga grönskan på bergssidan. Den som kikar in förbi stängslet ser inte längre ett ståtligt hem för de stenrika, utan en förfallande ruin med tomma fönstergluggar — en kuslig kvarleva av Peaks förflutna, omsusad av historier om konkurs, död, halshuggna nunnor och ett gråtande barn som ingen riktigt kan förklara. För många vandrare på den natursköna Lugard Road är den övergivna villan höjdpunkten — och mardrömmen.

Källa: hongkongliving.com + theghostinmymachine.com + culture-hongkong.com + Gwulo',
  NULL,NULL,NULL,false,true,'published','web_cn_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. BRIDES POOL (Hongkong) — den drunknade bruden
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'brides-pool','Brides Pool (Bruddammen)','brides-pool','Hongkong','New Territories, Tai Po','Naturplats',
  22.4830,114.2330,3,true,false,NULL,
  'Bruden föll ur bärstolen och drunknade — en kvinna i rött kammar ännu sitt hår vid vattnet.',
  'Brides Pool (bruddammen) är en liten flod i de nordöstra New Territories i Hongkong, nära Tai Mei Tuk i Plover Cove Country Park. Bakom det vackra vattenfallet döljer sig en av territoriets mest tragiska sägner.

Enligt legenden bars en brud i en bärstol av fyra bärare på väg till sin brudgum, i ett rasande oväder. När de passerade vattensamlingen halkade en av bärarna, och bruden föll i. Nedtyngd av sina tunga ceremoniella kläder drunknade hon i poolen nedanför. Byborna lyckades aldrig återfinna vare sig hennes kropp eller bärstolen.

Man tror att hennes ande ännu dröjer kvar i trakten. Lokalbor och vandrare säger sig ha sett en kvinna i röd klänning som kammar sitt långa hår vid vattenbrynet eller i spegelbilden i den närliggande Mirror Pool. Övergivna andetavlor har skymtats i trädens skugga, och till och med kremerade kvarlevor i själva poolen.

En spökhistoria varnar för att besöka platsen nattetid, då somliga tror att onda andar i vattnet alltjämt söker efter någon att dra med sig ned. Trots — eller tack vare — sitt dystra rykte är Brides Pool ett populärt vandringsmål om dagen, och räknas till Hongkongs mest hemsökta platser.

Källa: Engelska Wikipedia "Brides Pool" + ghoststories.sg + SCMP (scmp.com) + timeout.com',
  NULL,NULL,NULL,false,true,'published','web_cn_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;

-- ===== 44_GERMANY_SPUKORTE_BATCH5.sql =====
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

-- ===== 45_AUSTRIA_SPUKORTE_BATCH2.sql =====
-- Spökkartan — 4 fler hemsökta platser i Österrike (Österreich), omgång 2
-- Genererad 2026-06-09. Fortsättning på 38_AUSTRIA_SPUKORTE.
--
-- METOD: tyska sökord (Hexenprozesse, Spuk, Geist, Teufelskammer, Sage) ->
-- sidor som samlat spökhistorier (travelbook.de, schlossmoosham.at,
-- steiermark.com, servus.com m.fl. samt tyska/engelska Wikipedia). Skrivet på
-- SVENSKA, 200-600 ord/plats, aldrig fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. SCHLOSS MOOSHAM (Österrike) — häxborgen
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'schloss-moosham','Schloss Moosham','schloss-moosham','Österrike','Salzburg, Lungau','Slott',
  47.1280,13.7770,5,false,false,NULL,
  '"Österrikes häxborg" — 66 avrättningar, tortyrkammare och varulvsprocesser i Lungau.',
  'Schloss Moosham i Unternberg i Lungau i Salzburg kallas ofta "Österrikes häxborg". På 1300-talet blev slottet säte för blods- och pleggerätten i Lungau, där de svåraste brotten avgjordes — däribland häxprocesser.

Mellan 1534 och 1762 ägde 66 avrättningar rum, varav 44 gällde personer anklagade för trolldom och häxeri. I Lungau krävde häxprocesserna 13 manliga och 22 kvinnliga offer. De anklagade hölls i fängelseceller i häxtornet, intill den bevarade tortyrkammaren med sträckbänk, munsperrar, tumskruvar och ett rep i vilket människor hissades upp baklänges.

Två unga tiggare bekände under tortyr att de fått en svart salva av djävulen, smort in sig och förvandlats till varulvar; domen blev livstids slavtjänst på venetianska galärer. När en bekännelse pressats fram och domen fallit rullade rackarkärran till avrättningsplatsen vid Passeggen nära Tamsweg, där skarprättaren väntade med rättssvärdet.

Kring Schloss Moosham ringlar sig många spökhistorier. Besökare i tortyrkammaren berättar om spöklika beröringar av osynliga händer och möbler som rör sig av sig själva. Med tanke på allt det dokumenterade lidandet är det inte underligt att slottet räknas till Österrikes mest hemsökta — en plats där historiens grymhet tycks sitta kvar i de kalla murarna. Många besökare beskriver en tryckande, olustig känsla redan i borggården, och guiderna har samlat på sig otaliga berättelser om oförklarliga ljud, skuggor och kyla i de gamla domstols- och tortyrutrymmena.

Källa: travelbook.de + schlossmoosham.at + Tyska Wikipedia "Schloss Moosham" + sn.at',
  NULL,NULL,NULL,true,true,'published','web_at_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. SCHLOSS SCHÖNBRUNN (Österrike) — Sisis rastlösa ande
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'schloss-schoenbrunn','Schloss Schönbrunn','schloss-schoenbrunn','Österrike','Wien','Slott',
  48.1845,16.3120,2,false,false,NULL,
  'Kejsarinnan Sisi flydde sin gyllene bur — och sägs vandra i slottet ännu efter sin död.',
  'Schloss Schönbrunn i Wien, habsburgarnas väldiga sommarresidens, är inte bara ett av Europas mest besökta slott — det sägs också vara hemsökt.

Kejsarinnan Elisabeth, "Sisi", upplevde under sin livstid Schönbrunn som en gyllene bur som hon ständigt försökte fly. Det lyckades aldrig riktigt — vare sig i livet eller efter döden. Otaliga berättelser gör gällande att den vackra kejsarinnan ännu hemsöker slottet.

Tre guider påstår sig upprepade gånger ha sett Sisis bleka gestalt tillsammans med hennes kammarfriserska Fanny Feifalik i kejsarinnans toalettrum. Besökare berättar gång på gång om två kvinnogestalter i just det rummet, varav den ena tycks vara en hårfriserska.

Men Sisi är inte ensam. Enligt kejsarinnan Zita, gift med kejsar Karl I, lär ännu en adelsdam regelbundet besöka slottet: grevinnan Wilhelmine Auersperg, som sägs ha svävat omkring i salarna långt efter sin död. Dessa berättelser förblir folktro och spökhistorier snarare än bekräftade fenomen — men de ger en mörkare, mer melankolisk klang åt det praktfulla kejsarslottet med sina 1 441 rum. Sisi, vars liv präglades av rastlöshet, depression och till slut mordet i Genève 1898, sägs vandra ännu i just de gyllene rum hon en gång längtade bort ifrån, och för många besökare är det den olyckliga kejsarinnans skugga, snarare än prakten, som dröjer kvar längst i minnet.

Källa: schoenbrunn.at + servus.com + web.de + gmx.at',
  NULL,NULL,NULL,false,true,'published','web_at_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. BURG RIEGERSBURG (Österrike) — blomsterhäxan
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'burg-riegersburg','Burg Riegersburg','burg-riegersburg','Österrike','Steiermark, Riegersburg','Borg',
  47.0010,15.9370,4,false,false,NULL,
  'Blomsterhäxan som fick blommor att slå ut mitt i vintern — och brändes som häxa 1675.',
  'Burg Riegersburg tronar på en brant vulkanklippa i Steiermark i sydöstra Österrike och är förknippad med en av landets mest kända häxor: Katharina Paldauf, "blomsterhäxan".

Katharina föddes omkring 1625 i Fürstenfeld och var gift med borgens slottsfogde. Vid tjugo års ålder trädde hon i tjänst hos Katharina Elisabeth von Galler, dåvarande ägare av Riegersburg, och odlade med stor passion en mängd blomsterarter i ett dolt litet blomsterparadis i sin kammare. Enligt traditionen lyckades hon få blommor att slå ut även mitt i vintern — en förmåga som saknar grund i processakterna men som gett henne eftervärldens namn "blomsterhäxan".

Våren 1675, då Katharina var omkring femtio år, angavs hon av en bagare på Riegersburg som påstod sig ha sett henne utöva häxeri och styra vädret. Först nekade hon, men under senare förhör erkände hon att hon deltagit i häxsabbater och "gjort väder". Hon blev den mest framträdande av offren i den stora häxprocessen i Feldbach (1673–1675).

Katharina dog troligen den 23 september 1675. På grund av sin höga sociala ställning beviljades hon en "lindring" — hon dödades innan hon brändes på bål. Inga bevarade domstolshandlingar styrker dock själva trolldomen; blomsterhäxan av Riegersburg förblir en legend, och hennes öde lever vidare i borgens häxmuseum.

Källa: steiermark.com + austria-forum.org + Engelska Wikipedia "Katharina Paldauf" + dieriegersburg.at',
  NULL,NULL,NULL,false,true,'published','web_at_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. SCHLOSS TRATZBERG (Österrike) — Teufelskammer
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'schloss-tratzberg','Schloss Tratzberg','schloss-tratzberg','Österrike','Tirol, Inntal','Slott',
  47.3760,11.7250,3,false,false,NULL,
  'Djävulen släpade en sovande riddare genom väggen — i rummet som kallas Teufelskammer.',
  'Schloss Tratzberg är ett sengotiskt slott som tronar högt över Inntal i Tirol. Det sägs vara hemsökt — i ett rum känt som Teufelskammer, "djävulskammaren".

Enligt sägnen hämtades en gång en riddare av djävulen själv. I stället för att gå till mässan föredrog han att sova — och som straff släpade den onde honom rakt genom väggen. Blodfläckarna efter dådet ska enligt legenden ha varit synliga under lång tid.

Slottet sägs alltjämt spöka i just Teufelskammer. De boende berättar om ljud från detta särskilda rum, och en barnsköterska påstod sig ha hört en dörr slå igen i rummet ovanför henne — trots att den platsen murats igen för hundratals år sedan. Den nuvarande slottsfrun har själv aldrig stött på något spöke, men hennes dotter berättade som barn om gåtfulla möten med en sedan länge död förfader.

Spökjägare som undersökt fenomenen har spelat in video av olika ljusfenomen i Teufelskammer och ljudupptagningar av stegliknande ljud. Vad som än döljer sig bakom de igenmurade väggarna förblir slottets djävulskammare en av Tirols mest omtalade spökplatser, dit besökare söker sig för att kika in i det rum där djävulen sägs ha hämtat sitt offer. Det sengotiska slottet, med sina rikt bemålade salar och sin berömda Habsburgersaal, hör annars till de bäst bevarade i hela Alperna — men det är den lilla, instängda Teufelskammer som ger Tratzberg dess kusliga rykte.

Källa: servus.com + geisterundgespenster.de + gmx.at + tirolerin.at',
  NULL,NULL,NULL,false,true,'published','web_at_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;

-- ===== 46_NETHERLANDS_SPOOKPLEKKEN_BATCH2.sql =====
-- Spökkartan — 3 fler hemsökta platser i Nederländerna (Nederland), omgång 2
-- Genererad 2026-06-09. Fortsättning på 37_NETHERLANDS_SPOOKPLEKKEN.
--
-- METOD: nederländska sökord (spookverhaal, geest, spookkasteel, gevangenis)
-- -> sidor som samlat spökhistorier (kasteeldoornenburg.nl, blokhuispoort.nl,
-- natuurmonumenten.nl, verhalenbank.nl m.fl. samt nederländska Wikipedia).
-- Skrivet på SVENSKA, 200-600 ord/plats, aldrig fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. KASTEEL DOORNENBURG (Nederländerna) — den bepansrade ryttaren
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'kasteel-doornenburg','Kasteel Doornenburg','kasteel-doornenburg','Nederländerna','Gelderland, Doornenburg','Slott',
  51.8870,5.9330,3,false,false,NULL,
  'En bepansrad ryttare i hörnet, en gungande vagga och barnröster i de tomma salarna.',
  'Kasteel Doornenburg är ett nederländskt slott från 1300-talet, beläget i östra Betuwe mitt i Gelderland, nära byn Doornenburg. I sjuhundra år har den robusta medeltidsborgen varit ett karakteristiskt landmärke i landskapet kring Lingewaard.

Sedan länge berättas att Doornenburg är hemsökt, och nederländska Paranormal Research Team rapporterar oförklarliga händelser. Vid en paranormal undersökning deltog även en andlig förening med det talande namnet "De Witte Wyven" ("de vita kvinnorna") tillsammans med forskarna.

Rapporterna beskriver en rad fenomen. I ett hörn har man ibland sett en bepansrad häst med sin ryttare. I ett av rummen har en vagga hörts gunga, tydligt och påtagligt. Från ett annat rum har barnröster ljudit, och i de övre delarna av borgen har människor känt aggressiva, fientliga förnimmelser som om någon osynlig ville driva bort dem.

Borgen har många historier att berätta efter sina sju sekler — riddare, krig och vardagsliv har avlöst varandra innanför murarna. Men det är de oförklarliga ljuden, gestalterna och känslorna som gjort Kasteel Doornenburg till ett av Gelderlands mest omtalade spökslott, dit både nyfikna och spökjägare söker sig när mörkret faller. Den mäktiga vattenborgen med sina torn, vallgravar och tjocka tegelmurar utgör en passande kuliss för berättelserna — och guiderna saknar sällan en historia att berätta för den som vågar lyssna.

Källa: kasteeldoornenburg.nl + mijngelderland.nl + Nederländska Wikipedia "Kasteel Doornenburg" + natuurlijkewezens.nl',
  NULL,NULL,NULL,false,true,'published','web_nl_spookplekken'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. KASTEEL SCHALOEN (Nederländerna) — anden Ruprecht
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'kasteel-schaloen','Kasteel Schaloen','kasteel-schaloen','Nederländerna','Limburg, Valkenburg','Slott',
  50.8650,5.8330,3,false,false,NULL,
  'Hästarna vägrade gå över bron — den onde anden Ruprecht spärrade vägen över floden Geul.',
  'Kasteel Schaloen ligger vid floden Geul nära Valkenburg i Limburg, i södra Nederländerna, och är idag ett vackert slott som rymmer hotell och brasseri. Men enligt sägnen hemsöktes det en gång av en ond ande vid namn Ruprecht, som strövade kring Schaloens skogar.

Legenden berättar att slottsherrens hästar vägrade gå över bron över Geul på grund av den onde Ruprecht. Hur herren än försökte korsa floden med sin häst hindrades han av den illvilliga anden.

Lösningen kom genom tron. På råd av en eremit från Schaelsberg lät slottsherren resa heliga bildstoder vid platsen. Den onda anden drevs bort, och därefter kunde herren passera Geul ostörd. Bildgruppen, känd som "De Drie Beeldjes" ("de tre statyerna"), är en kalvariegrupp: Jesus på korset, flankerad av Maria och Johannes. Nischerna för Maria och Johannes är de äldsta delarna, byggda 1739, medan krucifixet ersattes omkring år 1900.

Sägnen lever vidare som en del av traktens folktro och vandringsleder, och de religiösa statyerna står ännu kvar som ett minnesmärke över det övernaturliga mötet vid Kasteel Schaloen — påminnelsen om den ande som en gång spärrade vägen över floden, tills helgonbilderna tvingade honom på flykten. Idag vandrar besökare gärna kastellrutten förbi De Drie Beeldjes, och den natursköna Geuldalen med sina gamla slott och vattenkvarnar bär ännu en doft av sägen och övernaturlighet.

Källa: Nederländska Wikipedia "Kasteel Schaloen" + natuurmonumenten.nl + dbnl.org + visitzuidlimburg.nl',
  NULL,NULL,NULL,false,true,'published','web_nl_spookplekken'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. BLOKHUISPOORT (Nederländerna) — de arga fångarnas andar
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'blokhuispoort','Blokhuispoort','blokhuispoort','Nederländerna','Friesland, Leeuwarden','Fängelse',
  53.2010,5.8000,3,true,false,NULL,
  'Fängelse i 427 år — konstnärerna som flyttat in säger att de arga fångarnas vrede ännu känns.',
  'Blokhuispoort i Leeuwarden i Friesland tjänade som fängelse ända från 1580 fram till december 2007 — i mer än fyra sekler en plats för instängdhet, straff och död.

Galgen monterades ned 1824, varefter avrättningarna i stället ägde rum på en mobil schavott. Många fångar dog innanför murarna i det särskilda fängelset och häktet, av orsaker som sträckte sig från självmord till sjukdomar som tuberkulos, diabetes och demens.

Sedan fängelset stängde används byggnaden av konstnärer och musiker som ateljéer och verkstäder — och de berättar att det gamla huset tycks vara hemsökt. Det nederländska paranormala sällskapet TDPS ansökte om att få göra en spökundersökning för att söka efter de döda fångarnas andar. Undersökningen blev dock aldrig av, eftersom utrustningen som skulle användas blev stulen. Enligt en av utredarna är det forna fångar som spökar: "De är arga, och den ilskan känns i byggnaden."

Idag är Blokhuispoort ett livfullt kulturcentrum med bibliotek, vandrarhem och kreativa företag — men bakom de tjocka murarna och de gamla cellerna dröjer minnet av alla dem som satt inspärrade här, och vars rastlösa andar somliga menar aldrig riktigt lämnat platsen. Under andra världskriget ägde här dessutom "Överfallet på Leeuwarden" rum 1944, då motståndsmän befriade fångar ur det nazistkontrollerade häktet — ännu ett mörkt kapitel i byggnadens långa och tyngande historia.

Källa: blokhuispoort.nl + historischcentrumleeuwarden.nl + Nederländska Wikipedia "Blokhuispoort" + tracesofwar.nl',
  NULL,NULL,NULL,false,true,'published','web_nl_spookplekken'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;

-- ===== 47_INDIA_HAUNTED_BATCH2.sql =====
-- Spökkartan — 4 fler hemsökta platser i Indien, omgång 2
-- Genererad 2026-06-09. Fortsättning på 41_INDIA_HAUNTED.
--
-- METOD: engelska/hindi sökord (haunted, ghosts, भूत) -> sidor som samlat
-- spökhistorier (holidify.com, atlasobscura.com, amyscrypt.com, india.com m.fl.
-- samt engelska Wikipedia). Skrivet på SVENSKA, 200-600 ord/plats, aldrig fler
-- ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. DUMAS BEACH (Indien) — den svarta sandens strand
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'dumas-beach','Dumas Beach','dumas-beach','Indien','Gujarat, Surat','Naturplats',
  21.0750,72.7140,4,true,false,NULL,
  'Svart sand av aska från en gammal likbränningsplats — och resenärer som aldrig återvänt.',
  'Dumas Beach ligger drygt två mil sydväst om staden Surat i Gujarat och utmärker sig genom sin svarta sand — något ovanligt i Indien, där de flesta stränder har gyllene sand.

Man tror att Dumas en gång var en hinduisk likbränningsplats, och att andarna efter de som kremerades här hemsöker stranden. Deras brända aska sägs ha blandats med sanden och gjort den distinkt svart — och hemsökt. Spökena ska bestå av dem som inte fann frälsning, eller som dog genom självmord eller olyckor. Stranden användes också som kremeringsplats för den parsiska gemenskapen, och de bortgångnas andar sägs ännu kännas där.

Besökare har hört viskningar, skratt, gråt och andra oförklarliga ljud, särskilt nattetid, och somliga turister påstår sig ha sett spöken röra sig över sanden. Det finns också berättelser om försvinnanden — resenärer som gett sig ut på stranden om natten och aldrig återvänt.

Dagtid är Dumas en till synes vanlig, om än mörk, strand vid Arabiska havet. Men dess rykte som en av Indiens mest hemsökta platser vilar tungt, och de lokala råder bestämt mot att vandra ensam längs den svarta sanden efter mörkrets inbrott — då vågorna sägs bära med sig röster från dem som en gång brändes här.

Källa: tripoto.com + mediaindia.eu + grasshopperyatra.com + medium.com (Chronicles of Curiosity)',
  NULL,NULL,NULL,true,true,'published','web_in_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. THREE KINGS CHAPEL (Indien) — de tre förgiftade kungarna
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'three-kings-chapel','Three Kings Chapel','three-kings-chapel','Indien','Goa, Cansaulim','Kyrka',
  15.3210,73.8950,3,true,false,NULL,
  'En kung förgiftade sina två rivaler vid en måltid — alla tre vilar nu under kapellets golv.',
  'Three Kings Chapel ("de tre kungarnas kapell") ligger på Cuelim-kullen i Cansaulim i Goa, en romersk-katolsk kyrka byggd 1599 av fader Gonzalo Carvalho.

Enligt folktron styrdes kullen en gång av tre portugisiska kungar som ständigt låg i fejd. I ett försök att lägga all makt under sig bjöd den äldste, vid namn Holger, in de andra två till kapellet på en måltid — och förgiftade dem. Men gripen av skuld, eller av fruktan för undersåtarnas vrede, tog den tredje kungen sedan sitt eget liv genom att svälja det återstående giftet.

Det sägs att man begravde de tre kungarnas kroppar på kyrkans mark. Sedan dess har människor som besökt kapellet sena timmar känt en närvaro på platsen. Lokala berättelser gör gällande att de tre kungarnas andar dröjer kvar, och besökare och bybor har rapporterat oförklarliga syner och ljud efter mörkrets inbrott — vilket gjort kapellet till en av Goas mest hemsökta platser.

Intressant nog är det nästan säkert att legenden från början diktades upp enbart för att hålla förälskade par borta från denna pittoreska och avskilda plats med sin milsvida utsikt. Sann eller ej lever sägnen vidare, och kullen lockar både trogna pilgrimer och nyfikna spöksökare.

Källa: Engelska Wikipedia "Three Kings Chapel" + holidify.com + thatgoangirl.com + soultravelling.in',
  NULL,NULL,NULL,false,true,'published','web_in_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. AGRASEN KI BAOLI (Indien) — den svarta brunnen
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'agrasen-ki-baoli','Agrasen ki Baoli','agrasen-ki-baoli','Indien','Delhi','Brunn',
  28.6260,77.2245,4,true,false,NULL,
  'Det svarta vattnet i trappbrunnen lockade människor att dränka sig — själarna sägs fångade än.',
  'Agrasen ki Baoli är en 60 meter lång och 15 meter bred historisk trappbrunn i New Delhi, belägen vid Hailey Road nära Connaught Place. Den har 108 trappsteg och tre nivåer, var och en med nischade valvbågar på ömse sidor om brunnen.

Den mest spridda sägnen är den om det svarta vattnet. Berättelserna säger att brunnen en gång rymde ett svart vatten som lockade människor till sig. När de närmade sig vattnet drogs de mot det och tvingades begå självmord. Vattnet har nu torkat ut, men själarna efter dem som det krävde sägs ännu dröja kvar i brunnen, fångade i all evighet.

Somliga besökare påstår sig känna att de blir följda, trots att ingen finns i närheten — en känsla de inte kan skaka av sig, var de än står i brunnen. Andra berättar om spöklika viskningar och röster, och åter andra om skugglika gestalter som lurar i de mörka hörnen av baolin.

Arkeologiska undersökningar visar att trappbrunnen till stor del byggdes om på 1300-talet av Agarwal-gemenskapen under Delhisultanatet. Idag är den en stilla, svalkande oas mitt i storstadens larm — men dess rykte som en av Delhis mest hemsökta platser lever vidare i de djupa, ekande trappstegen.

Källa: Engelska Wikipedia "Agrasen Ki Baoli" + Atlas Obscura + thirdeyetraveller.com + amyscrypt.com',
  NULL,NULL,NULL,false,true,'published','web_in_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. BRIJ RAJ BHAVAN (Indien) — major Burtons ande
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'brij-raj-bhavan','Brij Raj Bhavan','brij-raj-bhavan','Indien','Rajasthan, Kota','Slott',
  25.1820,75.8330,3,false,true,NULL,
  'Den brittiske majoren dödades 1857 — hans ande ger ännu örfilar åt vakter som somnar i tjänst.',
  'Brij Raj Bhavan är ett palats, numera hotell, i Kota i Rajasthan. Det byggdes på 1830-talet under det brittiska väldet och blev senare maharaja Umed Singh II:s sommarpalats.

Under det indiska upproret — sepoyupproret 1857 — var den brittiske majoren Charles Burton stationerad i Kota. När sepoyer plundrade palatset barrikaderade han sig i ett av de övre rummen tillsammans med sina två söner. Efter fem timmars belägring gav de upp — och soldaterna dödade dem alla.

Sedan dess sägs majorens ande hemsöka sitt gamla palats. Enligt sägnen är det ett ofarligt spöke, trots det våldsamma slutet, men mycket strikt med disciplinen i byggnaden: det sägs att han ger örfilar åt vakter som somnar i tjänst. Major Burtons ande ska vandra genom palatset klädd i sin röda rock och med ett svärd vid sidan. Vissa gäster berättar att de sett honom i korridorerna, andra att de hört hans steg mitt i natten.

Idag är Brij Raj Bhavan ett arvshotell där gäster kan bo i den gamla brittiska officerens palats — och kanske, om de råkar slumra till på sin vakt, få en sträng men osynlig örfil från den brittiske major som vägrar lämna sin post.

Källa: india.com + Moon Mausoleum + amyscrypt.com + frightfind.com',
  NULL,NULL,NULL,false,true,'published','web_in_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;

-- ===== 48_SWITZERLAND_SPUKORTE_BATCH2.sql =====
-- Spökkartan — 3 fler hemsökta platser i Schweiz, omgång 2
-- Genererad 2026-06-09. Fortsättning på 39_SWITZERLAND_SPUKORTE.
--
-- METOD: tyska sökord (Spuk, Geister, Geisterhaus, Poltergeist, Sanatorium)
-- -> sidor som samlat spökhistorier (baublatt.ch, blick.ch, watson.ch,
-- altbasel.ch m.fl. samt tyska Wikipedia). Skrivet på SVENSKA, 200-600 ord/
-- plats, aldrig fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. SANATORIO DEL GOTTARDO (Schweiz) — det övergivna sanatoriet
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'sanatorio-del-gottardo','Sanatorio del Gottardo','sanatorio-del-gottardo','Schweiz','Tessin, Quinto','Sanatorium',
  46.5180,8.6850,4,false,false,NULL,
  '"Schweiz unheimligaste ruin" vid Gotthardpasset — rykten om galna läkare och förbjudna experiment.',
  'Sanatorio del Gottardo ligger i Piotta, en by i Leventina-dalen i norra Ticino, och öppnade 1905 som sjukhus. Den fem våningar höga byggnaden användes under namnet "Sanatorio Popolare Cantonale di Piotta" — först för sårade soldater från första världskriget, senare för tuberkulospatienter. Sedan 1962 står den övergiven.

Många spökhistorier omger sanatoriet: berättelser om andar, paranormala uppenbarelser och galna läkare som lär ha utfört förbjudna experiment på patienterna. En man från Luzern berättade att hans bil om natten av sig själv ställde sig på tvären över vägen när han utforskade sanatoriet, och rykten gör gällande att en läkare ska ha bedrivit demoniska experiment på de intagna.

Den vittrande ruinen, högt uppe vid Gotthardpasset, har blivit ett av Schweiz mest beryktade mål för "dark tourism" och urban exploration. Tomma korridorer, krossade fönster och rester av sjukhusutrustning ger platsen en kuslig atmosfär.

En kazakisk oligark, Timur Azimov, köpte fastigheten 2016 för 750 000 franc med planer på att bygga en sportskola — men projektet gick i konkurs, och sanatoriet bjöds ut på auktion för 2,4 miljoner franc. Tills vidare står den kusliga ruinen kvar, ödslig och tyst, som en av de mest skräckinjagande platserna i de schweiziska alperna.

Källa: baublatt.ch + blick.ch + maennersache.de + passportparty.ch',
  NULL,NULL,NULL,true,true,'published','web_ch_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. SPUKHAUS VON STANS (Schweiz) — Jollers poltergeist
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'spukhaus-stans','Spukhaus von Stans (Joller-Haus)','spukhaus-stans','Schweiz','Nidwalden, Stans','Hus',
  46.9580,8.3660,4,true,false,NULL,
  'Stenregn, smällande dörrar och farmoderns ande — poltergeisten som drev Melchior Joller till vansinne 1862.',
  'Spökhuset i Stans i kantonen Nidwalden är en av Schweiz mest berömda spökhistorier. Den utspelade sig 1862 kring Melchior Joller — en schweizisk publicist och politiker, född i Stans 1818 — som blev känd genom sin dagbok över de mystiska händelser och spökerier som drabbade hans hus från mitten av augusti det året.

I huset ska fönster och dörrar plötsligt ha slagit upp och igen, möbler flyttat sig, och bredvid hans barn ska ett regn av stenar ha fallit. Det poltrade så högt att folk stannade på gatan, och till och med tidningarna skrev om det. Enligt sägnen var det anden efter Jollers egen farmor, Veronika Gut, som hemsökte huset — och som 1862 drev honom till vansinne.

Under tre dagar flyttade familjen Joller ut och överlät huset åt en undersökningskommission — men under just den tiden hände ingenting alls i spökhuset. Händelserna har aldrig fått någon vetenskaplig förklaring. Joller flyttade med fru och barn till Rom, där han 1865 dog som en bruten man.

Jollerhuset revs i februari 2010. År 2003 gjordes en film om spökhistorien, som förgäves försökte klarlägga vad som egentligen hände. Trots att huset nu är borta lever berättelsen om Schweiz mest ökända poltergeist vidare i böcker och folkminne.

Källa: Tyska Wikipedia "Melchior Joller" + watson.ch + zentralplus.ch + GeisterNet',
  NULL,NULL,NULL,false,true,'published','web_ch_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. KLOSTER KLINGENTAL (Schweiz) — de syndiga nunnornas andar
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'kloster-klingental','Kloster Klingental','kloster-klingental','Schweiz','Basel','Kloster',
  47.5640,7.5930,3,false,false,NULL,
  'Soldaterna i den gamla kasernen fann ingen ro — de syndiga nunnornas andar jämrade i korridorerna.',
  'Klostret Klingental i Kleinbasel grundades 1274 som ett dominikanerinnekloster. Under senmedeltiden bodde här ett fyrtiotal adliga nunnor, och "Klingentalerinnorna" var inte bara de rikaste utan också de mäktigaste bland Basels tio kloster.

Nunnorna var ofta förmögna kvinnor av god familj som flyttade in med tjänstefolk och lyxvaror, och som använde klostret som en av få möjligheter för kvinnor på den tiden att få bildning. De värsta rykten cirkulerade dock om Klingental-nunnorna: om vilda fester, kärleksaffärer med män och utomäktenskapliga barn som påstods ha dränkts i Rhen.

När soldater senare flyttade in i klosterbyggnaden, som blivit kasern, fann de ingen ro under de långa nätterna — de syndiga nunnornas andar ställde till med allehanda ofog. Dessa rastlösa fantomer vandrade genom korridorerna nattetid, stönande, jämrande och högljutt bedjande — uppenbarligen för sent — om förlåtelse för sin syndiga tillvaro.

Enligt vittnesmål från konstnärer som under många år haft ateljéer i den gamla kasernen förekommer det än idag enstaka möten med dessa oheliga spökkvinnor. Idag rymmer byggnaden Museum Kleines Klingental, med en berömd samling av medeltida byggnadsskulptur från Basels münster — men i de uråldriga klostergångarna, bland de tysta valven vid Rhen, sägs nunnornas botgörande andar ännu vandra när natten faller över Kleinbasel och staden tystnar.

Källa: altbasel.ch + barfi.ch + kath.ch + mythische-orte.eu',
  NULL,NULL,NULL,false,true,'published','web_ch_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;

-- ===== 49_USA_HAUNTED_BATCH6.sql =====
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

-- ===== 50_USA_HAUNTED_BATCH7.sql =====
-- Spökkartan — 4 fler hemsökta platser i USA, omgång 7
-- Genererad 2026-06-09. Kompletterar tidigare USA-filer.
--
-- METOD: engelska sökord (haunted, ghosts) -> sidor som samlat spökhistorier
-- (hauntedrooms.com, usghostadventures.com, ghostcitytours.com, staugustinelighthouse.org
-- m.fl. samt engelska Wikipedia). Skrivet på SVENSKA, 200-600 ord/plats, aldrig
-- fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. SLOSS FURNACES (USA) — järnverkets döda arbetare
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'sloss-furnaces','Sloss Furnaces','sloss-furnaces','USA','Alabama, Birmingham','Industri',
  33.5210,-86.7920,4,false,true,NULL,
  'Gjutaren som föll i smält järn lovade att aldrig lämna ugnarna — 100+ polisanmälda spökerier.',
  'Sloss Furnaces i Birmingham i Alabama var ett av söderns största järnverk, grundat 1880 av översten James Sloss. Idag är den nedlagda masugnsanläggningen ett industriminne — och sägs vara en av Amerikas mest hemsökta industriplatser.

Den mest kända spökhistorien handlar om Theophilus Jowers. Den 9 september 1887 föll den 28-årige biträdande gjutaren från en plattform ned i smält järn vid det närliggande Alice-verket; bara en sko och en del av hans fot kunde bärgas. Arbetarna tog hans löfte på allvar: "Så länge det står en masugn kvar i det här landet, ska jag vara där." När Alice nr 1 revs 1905 flyttade hans ande till Alice nr 2, och 1927 till Sloss.

En annan, mer sentida gestalt är James "Slag" Wormwood — i själva verket en påhittad figur skapad för spökattraktionen Sloss Fright Furnace, en hänsynslös skiftledare som 1906 ska ha fallit i ugnen. Under den tid verket leddes av sådana förmän visar dödsregistren att 47 män miste livet i olyckor.

Över hundra anmälningar om misstänkt paranormal aktivitet vid Sloss har noterats i Birminghampolisens register — från ångvisslor som ljuder av sig själva till syner och fysiska angrepp, de flesta i september och oktober, nattetid. Idag är Sloss museum och konsertplats — men järnverkets döda arbetare sägs aldrig ha lämnat sina ugnar.

Källa: hauntedrooms.com + bhamwiki.com + hauntedus.com + thelittlehouseofhorrors.com',
  NULL,NULL,NULL,true,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. SALLIE HOUSE (USA) — den manshatande anden
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'sallie-house','Sallie House','sallie-house','USA','Kansas, Atchison','Hus',
  39.5630,-95.1210,4,false,true,NULL,
  'En flicka dog under en operation utan bedövning — hennes ande river män tills de blöder.',
  'Sallie House i Atchison i Kansas byggdes mellan 1867 och 1871 av Michael C. Finney och är idag en hemsökt turistattraktion.

Enligt sägnen hemsöks huset av anden efter en ung flicka som dog där. En flicka vid namn Sallie ska ha förts till doktor Finney av sin mor med svåra buksmärtor. Läkaren gav henne bedövning och inledde en akut operation, då han trodde att blindtarmen var nära att brista — men han gjorde det första snittet innan bedövningen hunnit verka. Medan han fortsatte skrek Sallie av smärta och förblödde, vilket dödade henne. Det finns dock inga fysiska bevis för att någon Sallie levt eller dött på platsen, och det har sagts att borgmästaren hittade på historien som ett reklamknep för att locka besökare till staden.

Den paranormala aktivitet som gjorde Sallie House berömd började 1993, när Tony Pickman och hans hustru Debra flyttade in. Den drabbade särskilt manliga boende och besökare, varav somliga påstått sig ha blivit rivna tills de blödde — vilket gett Sallie öknamnet "den manshatande anden". Andarna i huset — som tros vara fler än bara lilla Sallie — angrep fysiskt maken och anlade eldar. Vittnen berättar om rivmärken, brännskador, kvävningskänslor, skuggestalter, morrningar och en ständig känsla av att vara bevakad. Sedan 2022 är huset öppet för turer och övernattningar.

Källa: Engelska Wikipedia "Sallie House" + usghostadventures.com + travelks.com + strangeandtwisted.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. HULL HOUSE (USA) — djävulsbarnet i Chicago
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'hull-house','Hull House','hull-house','USA','Illinois, Chicago','Hus',
  41.8720,-87.6470,3,true,false,NULL,
  'Tusentals trängdes för att se "djävulsbarnet" på vinden — och en Vit dam vandrar än.',
  'Hull House i Chicago grundades 1889 av Jane Addams och Ellen Gates Starr som ett socialt settlement för stadens fattiga. Jane Addams blev en av Amerikas mest inflytelserika kvinnor — landets första socialarbetare och första amerikanska kvinna att få Nobels fredspris. Men huset är också känt för en av Chicagos mest ökända skrönor.

Våren 1913 vällde tusentals Chicagobor till Hull House, fast beslutna att få se ett rykte om ett "djävulsbarn" som påstods gömmas på vinden. Beskrivningarna var märkligt samstämmiga: ett vanskapt spädbarn med horn, kluvna hovar, spetsig svans och förmågan att svära och röka cigarr. En populär ursprungsversion handlade om en djupt katolsk kvinna gift med en ateistisk man, som slet ned en bild av jungfru Maria med orden "Jag vill hellre ha djävulens barn". Jane Addams tillbringade veckor med att personligen avvisa folk och dementera i tidningarna — men ju hårdare hon förnekade djävulsbarnet, desto mer övertygade blev folk om att hon gömde det.

Två av Hull Houses tretton byggnader anses hemsökta än idag. Husets "Lady in White" sägs vara Millicent Hull, och spökbarn ska höras springa i den övre korridoren och på gården. Berättelsen om djävulsbarnet tros ha inspirerat skräckromanen Rosemarys Baby från 1967. Idag är Hull House ett museum — men skrönan om vinden lever vidare.

Källa: hullhousemuseum.org + CBS Chicago + ghostcitytours.com + Atlas Obscura',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. ST. AUGUSTINE LIGHTHOUSE (USA) — de drunknade flickorna
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'st-augustine-lighthouse','St. Augustine Lighthouse','st-augustine-lighthouse','USA','Florida, St. Augustine','Fyr',
  29.8850,-81.2880,3,false,true,NULL,
  'Flickorna som drunknade vid fyrbygget hörs ännu skratta i tornet och knyter ihop skosnören.',
  'St. Augustine Lighthouse i Florida är en av USA:s mest omtalat hemsökta fyrar. Spökerierna kretsar främst kring de drunknade Pittee-flickorna.

Deras far Hezekiah anställdes på 1870-talet för att övervaka fyrbygget och tog med sig familjen. Barnen lekte i en järnvägsvagn som användes för att frakta byggmaterial från stranden till bygget. Den 10 juli 1873 slet vagnen sig och hamnade i vattnet. Fem barn föll i; arbetarna räddade en pojke och en flicka, men byggledarens två döttrar Mary och Eliza, samt en ung flicka, drunknade. Bara den yngsta, Carrie, överlevde, och familjen Pittee återvände till Maine för att begrava sina döttrar.

Under de 145 år som gått sedan olyckan har märkliga händelser gång på gång tillskrivits flickornas andar. De sägs höras skratta i tornet sent på natten, och den äldsta, Mary, har skymtats i samma blå sammetsklänning och blå hårrosett som hon bar när hon dog. Enligt fyrpersonalen brukar flickornas spöken knyta ihop besökarnas skosnören, busa med lysstavar som delas ut under turer och leka kurragömma.

Också en av fyrvaktarna, Joseph Andreu, ses och hörs högst uppe i tornet, mer än ett sekel efter sin död — han föll till sin död medan han målade tornets utsida, och hans ande syns ofta blicka ut från toppen.

Källa: staugustinelighthouse.org + ghostsandgravestones.com + hauntedus.com + clickorlando.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;

-- ===== 51_GERMANY_SPUKORTE_BATCH6.sql =====
-- Spökkartan — 2 fler hemsökta platser i Tyskland (Deutschland), omgång 6
-- Genererad 2026-06-09. Fortsättning på 33-36/44_GERMANY_SPUKORTE.
--
-- METOD: tyska sökord (Sage, Teufel, Geist, Folterkammer) -> sidor som samlat
-- spökhistorier/sägner (rlp-tourismus.com, marksburg.de, rakotzbruecke.de,
-- travelbook.de m.fl. samt Wikipedia). Skrivet på SVENSKA, 200-600 ord/plats,
-- aldrig fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. MARKSBURG (Tyskland) — Sankt Markus och djävulen
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'marksburg','Marksburg','marksburg','Tyskland','Rheinland-Pfalz, Braubach','Borg',
  50.2700,7.6480,3,false,false,NULL,
  'Rhens enda aldrig förstörda höjdborg — där Sankt Markus avslöjade djävulen vid altaret.',
  'Marksburg vid Braubach är den enda höjdborgen vid Rhen som aldrig förstörts sedan den uppfördes av herrarna av Eppstein. Den tronar på en 160 meter hög klippkon mellan Bingen och Koblenz. Sedan 1437 bär den namnet Marksburg, efter det Sankt Markus-kapell som grundades på den.

Enligt sägnen fick borgen sitt namn av Sankt Markus, som ska ha räddat Elisabeth av Braubach undan djävulen. Elisabeth och hennes fästman Siegbert von Lahneck drabbades av ett tragiskt öde när ett krig skilde dem åt strax före bröllopet. Efter lång tid utan livstecken dök en främling vid namn Rochus upp och påstod, med dokument som bevis, att Siegbert var död. Elisabeth blev förälskad i Rochus och de planerade att gifta sig — men under vigseln uppenbarade Sankt Markus för prästen att Rochus i själva verket var djävulen själv. Prästen höll ett kors framför hans ansikte, och Rochus drevs ned till helvetet. När Siegbert sedan återvände levande från kriget blev han så förkrossad över Elisabeths öde att han störtade sig i döden.

I det forna häststallet och borgsmedjan ligger idag tortyrkammaren. Eftersom Marksburg tidvis var maktsäte där domstolar hölls, fanns sannolikt en tortyrkammare här, även om dess exakta läge är okänt. Idag visas en samling tortyr- och bestraffningsredskap som berättar om denna mörka del av medeltidens rättsskipning.

Källa: Engelska/Tyska Wikipedia "Marksburg" + rlp-tourismus.com + burgerbe.de + marksburg.de',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. RAKOTZBRÜCKE (Tyskland) — djävulsbron i Kromlau
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'rakotzbruecke','Rakotzbrücke (Teufelsbrücke)','rakotzbruecke','Tyskland','Sachsen, Kromlau','Naturplats',
  51.5400,14.6480,2,true,false,NULL,
  'Byggherren slöt en pakt med djävulen — och lurade honom genom att skicka en hund över bron.',
  'Rakotzbrücke i landskapsparken Kromlau i Sachsen kallas i folkmun Teufelsbrücke, "djävulsbron". Smeknamnet kom av att man inte kunde föreställa sig hur en människa skulle kunna bygga en så brant brobåge — där måste djävulen ha haft sin hand med i spelet.

Bron beställdes 1860 av den lokale riddaren Friedrich Hermann Rötschke och uppfördes mellan 1863 och 1882. Den planerades från början som ett estetiskt mästerverk, till skillnad från de flesta broar som byggdes för praktiskt bruk — och utformades så att den tillsammans med sin spegelbild i vattnet under bildar en perfekt cirkel.

Enligt legenden slöt byggherren en pakt med djävulen och lovade honom själen hos den första levande varelse som gick över bron. När bygget var färdigt överlistade han dock djävulen genom att låta en hund springa över först.

Verkligheten bär också på en mörk ton: enligt krönikören Adolf Aisch kostade Rakotzbrücke "50 000 taler och ett människoliv". Den 11 september 1882, när stödbågarna slogs ut, störtade timmermannen Traugott Wolsch från Gablenz i sjön och drunknade.

Bron var länge rasfärdig och renoverades mellan 2018 och 2021. Att beträda den är fortfarande förbjudet — men spegelcirkeln och djävulssägnen har gjort den till ett av Tysklands mest fotograferade och magiska motiv, särskilt i höstens dimmor.

Källa: rakotzbruecke.de + beforewedie.de + travelbook.de + european-news-agency.de',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;

-- ===== 52_CHINA_HK_HAUNTED_BATCH3.sql =====
-- Spökkartan — 2 fler hemsökta/mörka platser i Kina/Hongkong, omgång 3
-- Genererad 2026-06-09. Kompletterar 25/43.
--
-- METOD: engelska sökord -> sidor som samlat spök-/mörka historier
-- (Atlas Obscura, zolimacitymag.com, Moon Mausoleum, SCMP m.fl. samt engelska
-- Wikipedia). Skrivet på SVENSKA, 200-600 ord/plats, aldrig fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. KOWLOON WALLED CITY (Hongkong) — mörkrets stad
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'kowloon-walled-city','Kowloon Walled City','kowloon-walled-city','Hongkong','Kowloon','Övergiven',
  22.3320,114.1900,4,true,false,NULL,
  'Jordens tätast befolkade plats — en laglös, sollös labyrint kallad "mörkrets stad".',
  'Kowloon Walled City i Hongkong var en gång den tätast befolkade platsen på jorden — en laglös enklav och en labyrint av sammanbyggda höghus utan minsta arkitektonisk tillsyn. Platsen började som en militär utpost under Songdynastin och blev 1847 ett kustfort. När New Territories arrenderades till Storbritannien 1898 undantogs den lilla staden — och förblev en juridisk ingenmansmark.

Resultatet blev en stad utanför lagen: ingen skatt, ingen reglering, ingen polis. Efter andra världskriget svällde befolkningen av flyktingar från det kinesiska inbördeskriget, och från 1960-talet växte ett virrvarr av oreglerade höghus. Fem triadgäng slog sig ned, och staden blev ett nav för tillverkning och försäljning av opium och heroin. Polisen vågade sig in endast i stora grupper.

På sin höjdpunkt bodde uppskattningsvis 50 000 människor på en hundradels kvadratkilometer — motsvarande 1,9 miljoner invånare per kvadratkilometer. På gatunivå nådde inget solljus ned i de smala, slingrande gångarna, kantade av droppande vattenrör och hängande buntar av elkablar. Platsen kallades "mörkrets stad".

År 1987 beslöts att riva staden. Efter en omfattande utrymning revs den mellan 1993 och 1994. Idag är området en parkanläggning — men minnet av den klaustrofobiska, sollösa labyrinten lever vidare som en av Asiens mörkaste och mest sägenomspunna platser.

Källa: Engelska Wikipedia "Kowloon Walled City" + Atlas Obscura + National Geographic + howstuffworks.com',
  NULL,NULL,NULL,true,true,'published','web_cn_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. MURRAY HOUSE (Hongkong) — det flyttade spökhuset
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'murray-house','Murray House','murray-house','Hongkong','Stanley','Hus',
  22.2190,114.2130,3,true,false,NULL,
  'Japanska militärpolisens tortyr- och avrättningsplats — exorcerat två gånger, sedan flyttat sten för sten.',
  'Murray House byggdes 1846 som officersbostad för Murraykasernen i centrala Hongkong. Under den japanska ockupationen blev byggnaden högkvarter för den japanska militärpolisen, med fängelseceller, tortyrkammare och avrättningsplatser där många Hongkongbor — upp till 4 000 enligt vissa uppgifter — dödades.

Med en så blodig historia är det inte underligt att Murray House länge ansågs hemsökt. Exorcismer genomfördes 1963 och 1974 i ett försök att lugna de tjänstemän som arbetade i byggnaden — somliga hotade att säga upp sig om inget gjordes åt spökena. År 1963 klagade kontorsarbetare på att andar förstörde ritningar och skadade kontorsmaskiner.

År 1982 flyttades Murray House från centrala Hongkong för att ge plats åt Bank of China Tower. Byggnaden plockades ned sten för sten och lades i förvar. Det dröjde nästan ett decennium innan regeringen beslöt att återuppföra den i Stanley, där den restaurerades och återinvigdes 2002.

Det Murray House som idag står i Stanley är i själva verket en ny betongbyggnad med stenar från originalet påklistrade. Idag rymmer huset butiker och restauranger med utsikt över havet — men dess mörka förflutna och de många dödsoffren under ockupationen gör att spökhistorierna ännu följer med byggnaden, vart den än flyttas.

Källa: Engelska Wikipedia "Murray House" + zolimacitymag.com + Moon Mausoleum + SCMP',
  NULL,NULL,NULL,false,true,'published','web_cn_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;

-- ===== 53_JAPAN_HAUNTED_BATCH3.sql =====
-- Spökkartan — 2 fler hemsökta/övergivna platser i Japan, omgång 3
-- Genererad 2026-06-09. Kompletterar 26/42.
--
-- METOD: engelska/japanska sökord (haunted, abandoned, 廃墟) -> sidor som samlat
-- spökhistorier (timetravelturtle.com, abandonedkansai.com, SoraNews24 m.fl.
-- samt engelska Wikipedia). Skrivet på SVENSKA, 200-600 ord/plats, aldrig fler
-- ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. NARA DREAMLAND (Japan) — det övergivna "japanska Disneyland"
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'nara-dreamland','Nara Dreamland','nara-dreamland','Japan','Nara','Övergiven',
  34.7080,135.8330,3,false,false,NULL,
  'Det övergivna "japanska Disneyland" — ett tyst Törnrosaslott och en rostig bergochdalbana.',
  'Nara Dreamland var en nöjespark nära Nara i Japan, starkt inspirerad av Disneyland i Kalifornien. Den öppnade 1961, sedan affärsmannen Kunizo Matsuo besökt Disneyland 1955 och blivit så imponerad att han ville skapa något liknande i Japan. Parken byggdes för att se nästan identisk ut: med en egen Main Street, ett Törnrosaslott och "Ancestorland", parkens version av Frontierland med japansk historia.

På sin höjdpunkt hade Nara Dreamland över 1,6 miljoner besökare om året. Men när Tokyo Disneyland öppnade 1983, och senare Universal Studios Japan, sjönk besökssiffrorna kraftigt, och 2006 stängde parken för gott.

Efter stängningen, men före rivningen, blev Nara Dreamland ett av Japans mest berömda mål för "haikyo" — urban exploration. Övergivna åkattraktioner, ett tyst Törnrosaslott och en rostig bergochdalbana gjorde platsen kuslig och drömlik på en gång. Somliga besökare lämnade graffiti på monorälen och attraktionerna, andra placerade parkens figurstatyer i olycksbådande poser på trasiga åkattraktioner.

Parken stod övergiven tills den revs mellan oktober 2016 och december 2017, då 30 åkattraktioner och 75 byggnader avlägsnades. Idag är det spöklika "japanska Disneyland" borta — men bilderna av den tysta, övergivna sagovärlden lever vidare som en av världens mest ikoniska lost places.

Källa: Engelska Wikipedia "Nara Dreamland" + timetravelturtle.com + abandonedspaces.com + Dezeen',
  NULL,NULL,NULL,true,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. NAKAGUSUKU HOTEL RUINS (Japan) — det förbannade hotellet
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'nakagusuku-hotel','Nakagusuku Hotel ruins','nakagusuku-hotel','Japan','Okinawa, Kitanakagusuku','Övergiven',
  26.2840,127.8050,4,false,false,NULL,
  'Munkarna varnade för de heliga gravarna — bygget förbannades och investeraren blev vansinnig.',
  'Nakagusuku Hotel — även kallat Royal Hotel eller Kogen Hotel — var ett övergivet, aldrig färdigställt hotell i Kitanakagusuku på Okinawa, beläget knappt 50 meter från murarna till Nakagusuku-borgen.

Hotellet uppfördes av en förmögen affärsman från Naha för att dra nytta av världsutställningen Okinawa Ocean Exposition 1975. Kullen söder om borgen valdes för utsikten över både Stilla havet och Östkinesiska sjön. Men munkar från ett närliggande buddhistiskt tempel varnade för att platsen rymde gravar och heliga platser, och att bygget skulle reta de andar som bodde där. Varningarna ignorerades.

Efter en rad byggolyckor vägrade arbetarna att färdigställa komplexet — de kände att platsen var förbannad. Mitt i 1975 avstannade bygget helt. Enligt legenden försökte den desperate investeraren bevisa att platsen inte var hemsökt genom att sova där varje natt tills projektet var klart. Han tillbringade tre nätter på platsen och blev vansinnig. Därefter ska hans företag ha gått i konkurs, och enligt berättelsen tog han sitt liv på ett mentalsjukhus.

En mer prosaisk förklaring är att bygget övergavs när borgruinen och området blev världsarv. Hotellruinen stod kvar som en av Okinawas mest beryktade spökplatser, ett populärt mål för djärva urban explorers, tills den revs helt år 2020.

Källa: Engelska Wikipedia "Nakagusuku Hotel ruins" + abandonedkansai.com + SoraNews24 + InsideJapan Tours',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;

-- ===== 54_INDIA_HAUNTED_BATCH3.sql =====
-- Spökkartan — 3 fler hemsökta platser i Indien, omgång 3
-- Genererad 2026-06-09. Kompletterar 41/47.
--
-- METOD: engelska/hindi sökord (haunted, ghosts, भूत) -> sidor som samlat
-- spökhistorier (india.com, Atlas Obscura, Moon Mausoleum, shimlaonline.in m.fl.).
-- Skrivet på SVENSKA, 200-600 ord/plats, aldrig fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. GP BLOCK, MEERUT (Indien) — de fyra männen och kvinnan i rött
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'gp-block-meerut','GP Block, Meerut','gp-block-meerut','Indien','Uttar Pradesh, Meerut','Övergiven',
  28.9840,77.7060,4,true,false,NULL,
  'Fyra män dricker öl kring ett ensamt ljus — och en kvinna i rött stiger upp mot taket.',
  'GP Block i Meerut i Uttar Pradesh är en av Indiens mest ökända spökplatser — tre byggnader som legat öde sedan 1930-talet.

Legenden kretsar kring två återkommande syner. Den första är de fyra männen: GP Block sägs hemsökas av spökena efter fyra män som ofta skymtas i en tvåvåningsbyggnad, sittande kring ett bord med ett enda tänt ljus, drickande öl. Den andra är kvinnan i rött: en kvinna klädd i röd klänning har ofta setts lämna byggnaden, med syner som rör sig från första våningen, till andra, och slutar på taket.

Byggnaderna ägs av de indiska försvarsstyrkorna men lämnades att förfalla någon gång i slutet av 1950-talet, eller kanske så tidigt som på 1930-talet. Den tvåvåningsbyggnad där männen ses har varit låst i många år, och folk minns inte ens längre vem som en gång bodde där, eller när.

GP Block placeras på nionde plats på listan över Indiens tio mest hemsökta platser. Trots de många berättelserna och undersökningarna har det dock aldrig funnits några konkreta belägg för paranormal aktivitet. Men förbipasserande undviker gärna de tysta, övergivna husen efter mörkrets inbrott — särskilt om ett ensamt ljus skulle skymta i ett fönster.

Källa: india.com + Moon Mausoleum + hauntedindia.blogspot.com + bookstruck.app',
  NULL,NULL,NULL,false,true,'published','web_in_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. JAMALI KAMALI (Indien) — djinnerna i Mehrauli
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'jamali-kamali','Jamali Kamali','jamali-kamali','Indien','Delhi, Mehrauli','Moské',
  28.5180,77.1820,3,true,false,NULL,
  'Inte vanliga spöken utan djinner — osynliga händer vidrör besökare i den gamla graven.',
  'Jamali Kamali är en moské och grav i Mehrauli Archaeological Park i Delhi, intill världsarvet Qutub Minar. Moskén byggdes omkring 1528–1529 under den förste mogulkejsaren Babur och är uppkallad efter Shaikh Jamali Kamboh, ett sufihelgon från 1500-talet känt för sin mystiska poesi.

Den rimmande andra halvan av namnet, Kamali, syftar på en okänd gestalt som begravts vid Jamalis sida. Enligt folktron var Kamali inte bara Jamalis lärjunge utan också hans älskade — en populär teori som historiker avvisar, men som tycks understödjas av sättet de två är begravda på.

Mycket av ryktena om paranormal aktivitet vid Jamali Kamali handlar dock inte om vanliga spöken, utan om djinner — en ras av skepnadsskiftande andar i den islamiska kosmologin. Det har rapporterats att besökare, särskilt nattetid efter stängning, kan känna sig iakttagna eller till och med vidrörda av osynliga händer. Människor har påstått sig se underliga ljus och skuggor i graven och hört något som låter som ett morrande djur eller skrattande röster.

Moskén är byggd i röd sandsten och utsmyckad med marmor, och dess valvprydda inre är majestätiskt, nästan palatsliknande. Men när Mehrauli-parkens hundratals monument höljs i mörker sägs djinnerna vakna — och få vågar dröja kvar bland de gamla gravarna.

Källa: Atlas Obscura + Moon Mausoleum + curlytales.com + vargiskhan.com',
  NULL,NULL,NULL,false,true,'published','web_in_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. TUNNEL 33 / BAROG (Indien) — den vänlige överstens ande
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'tunnel-33-barog','Tunnel 33 (Barog)','tunnel-33-barog','Indien','Himachal Pradesh, Barog','Tunnel',
  30.9150,77.0530,3,true,false,NULL,
  'Ingenjören sköt sig efter ett ödesdigert räknefel — hans vänliga ande pratar gärna med resenärer.',
  'Tunnel nr 33, även kallad Barogtunneln, är den längsta tunneln (1 143 meter) på den berömda Kalka–Shimla-järnvägen i Himachal Pradesh — och en av Indiens mest sägenomspunna spökplatser.

År 1898 fick den engelske järnvägsingenjören överste Barog i uppdrag att bygga tunneln, med en strikt tidsfrist. För att hinna lät han gräva från bergets båda sidor samtidigt, i tron att gångarna skulle mötas på mitten. Men på grund av ett ödesdigert räknefel i linjeföringen möttes de aldrig, och tunneln blev oavslutad.

Den hederlige Barog kände sig förödmjukad — och dessutom bötfälld på en rupie av den brittiska regeringen. En dag, under en promenad i sällskap med sin lilla hund, tog han sitt liv genom att skjuta sig nära den ofärdiga tunneln. Tunneln fullbordades senare och fick bära hans namn till hans ära.

Enligt lokal sägen lämnade hans ande aldrig platsen. Resenärer påstår sig höra viskningar, se en gestalt i vitt eller känna en närvaro inne i tunneln. Men Barog beskrivs som ett vänligt spöke — folk berättar gärna om hur de mött honom, satt sig ned och till och med skrattat tillsammans med honom. Det finns, sägs det, inga klagomål på överste Barog.

Källa: india.com + homegrown.co.in + shimlaonline.in + tripoto.com',
  NULL,NULL,NULL,false,true,'published','web_in_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;

-- ===== 55_GERMANY_SPUKORTE_BATCH7.sql =====
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

-- ===== 56_GERMANY_SPUKORTE_BATCH8.sql =====
-- Spökkartan — Tyskland omgång 8: Hexentanzplatz Thale (Tyskland 39 -> 40)
-- Genererad 2026-06-09.
-- METOD: tyska sökord (Sage, Hexen, Walpurgisnacht) -> harzlife.de, anderswohin.de,
-- oberharz.de m.fl. Skrivet på SVENSKA, 200-600 ord, aldrig fler ord än källan.
-- Kör i Supabase SQL Editor.

BEGIN;

-- HEXENTANZPLATZ THALE — häxornas Valborgsmässa i Harz
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'hexentanzplatz-thale','Hexentanzplatz Thale','hexentanzplatz-thale','Tyskland','Sachsen-Anhalt, Thale','Naturplats',
  51.7330,11.0330,3,true,false,NULL,
  'Här samlas Harzens häxor Valborgsmässoafton innan de flyger till Brocken för att fria till djävulen.',
  'Hexentanzplatz — "häxdansplatsen" — ligger söder om Thale, omkring 250 meter ovanför Bodetal, mitt emot den något lägre Roßtrappe-klippan. Platsen var sannolikt en gammal sachsisk-germansk kultplats.

Enligt traditionen samlades de gammalsachsiska germanstammarna här, särskilt natten mellan 30 april och 1 maj — den Walpurgisnatt som Goethe gjorde berömd i Faust — för att hylla de så kallade Hagedisen, skogs- och bergsgudinnor. Sedan frankerriket erövrat det sachsiska området förbjöd den kristna kyrkan kulten, och platsen fick namnet Hexentanzplatz, "häxornas dansplats".

Enligt myten om denna klippa samlas Harzens häxor här Valborgsmässoafton för att fira en kuslig ritual. Härifrån beger de sig tillsammans till Brocken, där de dansar kring den flammande häxbrasan och friar till djävulen. Varje år den 30 april firas Walpurgisnatt på Hexentanzplatz.

På andra sidan Bode reser sig Roßtrappe-klippan, som i graniten har en stor hovliknande fördjupning. Enligt sägnen duellerade djävulen med Gud i Thale, och vid det så kallade Roßtrappe finns spåren efter ett väldigt hopp ännu kvar i berget — somliga tillskriver dem i stället jätten Bodo.

Idag finns här en liten nöjespark, ett bergsteater och en stencirkel av klippblock som restes på 1990-talet, befolkad av en djävul, en häxa och en demon — en passande inramning för en av Tysklands mest sägenomspunna och hedniska platser.

Källa: harzlife.de + anderswohin.de + oberharz.de + harz-travel.de',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;

-- ===== 57_JAPAN_HAUNTED_BATCH4.sql =====
-- Spökkartan — 9 fler hemsökta/övergivna platser i Japan, omgång 4 (Japan 25 -> 34)
-- Genererad 2026-06-09. Del av målet ~40 platser/land.
--
-- METOD: engelska/japanska sökord (haunted, abandoned, 廃墟, hitobashira) -> sidor
-- som samlat spökhistorier (Atlas Obscura, haikyo.org, abandonedkansai.com,
-- kowabana.net, japan-guide.com m.fl. samt Wikipedia). Skrivet på SVENSKA,
-- 200-600 ord/plats, aldrig fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. TŌJINBŌ — den mördade munkens klippor
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'tojinbo-cliffs','Tōjinbō','tojinbo-cliffs','Japan','Fukui, Sakai','Naturplats',
  36.2390,136.1260,4,true,false,NULL,
  'Den mördade munkens ande rasar vid klipporna — och de självmordsdrabbades själar drar besökare i havet.',
  'Tōjinbō är en rad branta klippor vid Japanska havet i Sakai i Fukui-prefekturen, i genomsnitt 30 meter höga och drygt en kilometer långa. Klippformationen, av pelarformad pyroxenandesit, bildades för 12–13 miljoner år sedan och är en av endast tre av sitt slag i världen.

Enligt en legend kommer namnet från en utsvävande buddhistmunk vid namn Tōjinbō, som utnyttjade sin styrka till brott. Han förälskade sig i den vackra prinsessan Aya. År 1182 bjöd munkarna från Heisen-ji ut honom till klipporna. När han blivit berusad och börjat slumra knuffade en rivaliserande munk — också förälskad i Aya — ned honom i havet. Sägnen säger att Tōjinbōs hämndlystna ande därefter rasade vid samma tid varje år och vållade storm och regn, tills en kringvandrande präst förbarmade sig och höll en minnesgudstjänst, varpå ovädren upphörde.

Men än idag sägs Tōjinbōs ande hemsöka klipporna. På den närliggande ön Oshima berättas om själarna efter dem som tagit sina liv vid Tōjinbō och vars kroppar spolats upp på klipporna. Korsar man den röda bron vid midnatt kan andarna försöka dra ned en i havet, och vandrar man motsols runt ön blir man förbannad. Besökare har hört kroppslösa röster nära telefonkioskerna. Tōjinbō är ett av Japans mest ökända självmordsstup, där en pensionerad polis sedan 2000-talet patrullerat och räddat över 500 liv.

Källa: Engelska Wikipedia "Tōjinbō" + thevintagenews.com + japantoday.com + dannywithlove.com',
  NULL,NULL,NULL,true,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. KANMANGAFUCHI ABYSS — de oräkneliga Bake Jizō
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'kanmangafuchi-abyss','Kanmangafuchi Abyss','kanmangafuchi-abyss','Japan','Tochigi, Nikko','Naturplats',
  36.7480,139.5860,3,true,false,NULL,
  'Stenstatyerna sägs försvinna och dyka upp igen — räkna dem och du får aldrig samma antal två gånger.',
  'Kanmangafuchi är en flera hundra meter lång naturlig ravin längs floden Daiya i Nikko, i nordvästra Tochigi-prefekturen. Längs ravinen står omkring 70 stenstatyer av bodhisattvan Jizō på rad — Jizō är i Japan främst beskyddare av barn och resande.

Statyerna omges av en kuslig legend. På grund av sin spöklika natur sägs de ha förmågan att försvinna och dyka upp igen, och de kallas därför "Bake Jizō" — spök-Jizō. Försöker man räkna dem ska man aldrig komma fram till samma antal två gånger. Raden kallas både Narabi Jizō, "Jizō på rad", och Bake Jizō, "Jizō-spökena", just för att det sägs vara omöjligt att räkna dem lika två gånger.

Enligt traditionen skänktes statyerna av biskop Tenkais lärjungar, och från början ska de ha varit hundra till antalet. Vid en översvämning 1902 förstördes eller fördes några bort av vattnet, varför antalet idag är lägre.

Platsen är på en gång vacker och olycksbådande: mossbelupna stenfigurer i röda mössor och förkläden, vänligt leende men ändå anonyma, längs den brusande, mörka floden. När dimman ligger tät över Daiyas vatten och statyerna tycks röra sig i ögonvrån förstår man varför Kanmangafuchi räknas som en av Nikkos mest mystiska platser — där gränsen mellan de levandes och de dödas värld känns ovanligt tunn.

Källa: japan-guide.com + kanpai-japan.com + Atlas Obscura + GaijinPot',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. KEJONUMA LEISURE LAND — spökkvinnans damm
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'kejonuma-leisure-land','Kejonuma Leisure Land','kejonuma-leisure-land','Japan','Miyagi, Ōsaki','Övergiven',
  38.5390,140.8760,4,false,false,NULL,
  'Byggd vid "spökkvinnans damm", där en mor som födde ett ormbarn dränkte sig och förbannade platsen.',
  'Kejonuma Leisure Land var en nöjespark i Ōsaki i Miyagi-prefekturen, byggd 1979 i ett försök att föra tillbaka glädjen till bygden efter andra världskrigets umbäranden. På sin höjdpunkt hade parken upp till 200 000 besökare och erbjöd pariserhjul, kopp-och-fat-karusell, miniatyrtåg, gokartbana och golfrange. Efter 21 år stängde den för gott år 2000.

Namnet Kejonuma betyder "spökkvinnans damm" och syftar på en gammal regional sägen om vattnet intill. Enligt berättelsen levde en vacker ung kvinna nära en damm känd för sin myllrande mängd ormar. En dag födde hon ett barn i form av en orm, som slingrade sig ned i dammen, där dess gråt kunde höras varje natt. Driven till vansinne av ormbarnets oupphörliga jämmer dränkte sig den unga modern i dammen — och förbannade platsen med sin död.

Idag står Kejonuma Leisure Land övergiven och svårt förfallen. Bland träden rostar resterna av pariserhjulet, karusellen, gokartbanan och golfrangen, utsatta för väder och vind i decennier. Den tysta, igenvuxna parken vid den förbannade dammen har blivit ett av norra Japans mest beryktade haikyo — övergivna platser — dit urban explorers söker sig för att uppleva stämningen av glädje som vänts i kuslig tystnad, med spökkvinnans sägen vilande över det stilla vattnet.

Källa: Atlas Obscura + haikyo.org + abandonedkansai.com + urbexsession.com',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. WESTERN VILLAGE — de övergivna cowboyrobotarna
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'western-village-nikko','Western Village','western-village-nikko','Japan','Tochigi, Nikko','Övergiven',
  36.7330,139.6900,3,false,false,NULL,
  'En övergiven Vilda västern-park full av rostande animatroniska cowboyer — Westworld blivet verklighet.',
  'Western Village var en temapark i Nikko, öppnad 1973 och inspirerad av amerikanska och italienska westernfilmer — samt science fiction-westernfilmen Westworld från samma år, där en skara felfungerande robotar attackerar intet ont anande turister. Efter att parken stängt 2007 har dess overklighet bara förstärkts.

Parken är fylld av förfallande animatroniska cowboyfigurer. Byggnaderna "befolkades" en gång av animatroniska gestalter — ett handelsbiträde, en bartender, en Pony Express-anställd — många byggda för att likna kända filmstjärnor, vilket ger den övergivna parken en starkt kuslig Westworld-känsla. Här finns en kopia av Mount Rushmore, en diversehandel, barberare, kyrka, sheriffstation med fängelse och en saloon full av skurkaktiga figurer. Den falska kyrkan var faktiskt äkta — importerad hela vägen från Kalifornien.

När parken till sist stängde 2007 lämnades det mesta kvar på plats, och allt fick stå och förfalla där det stod. Ovanför den öde staden vakar en fullskalig kopia av Mount Rushmore med sina fyra väldiga presidentansikten, numera urblekta och spruckna.

Idag är platsen ett mecka för haikyo-utövare, urban explorers från Japan och hela världen, som dras till den surrealistiska och olycksbådande miljön. De rostiga, leende cowboyrobotarna, frusna mitt i en gest, stirrar tomt ut över en stad som aldrig fanns på riktigt — en spökstad i dubbel bemärkelse, där Vilda västern möter Westworlds mardröm i den japanska skogens tystnad.

Källa: Atlas Obscura + abandonedkansai.com + laughingsquid.com + Lost Collective',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 5. HACHIJŌ ROYAL HOTEL — Japans största övergivna hotell
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'hachijo-royal-hotel','Hachijō Royal Hotel','hachijo-royal-hotel','Japan','Tokyo, Hachijōjima','Övergiven',
  33.1050,139.7900,3,false,false,NULL,
  'Ett barockpalats på "Japans Hawaii" där ormbunkar nu tränger upp genom mattor, sängar och soffor.',
  'Hachijō Royal Hotel på ön Hachijōjima, omkring 290 kilometer söder om Tokyo i Izu-öarna, var en gång Japans största lyxhotell — och är idag landets största övergivna hotell.

När det öppnade 1963 förkroppsligade det allt efterkrigstidens Japan strävade efter. Ön hade av en ivrig regering döpts om till "Japans Hawaii", ett tropiskt smultronställe för Tokyobor utan kostnaden och krånglet med verkliga utlandsresor. Hotellet, inspirerat av fransk barock, öppnade som ett av landets största palats med gipskopior av grekiska statyer och pampiga fontäner.

Men på 1970-talet hävdes restriktionerna på utlandsresor; det riktiga Hawaii och Okinawa blev tillgängliga, med verkliga sandstränder som Hachijōjimas klippiga kust inte kunde mäta sig med. Hotellet försökte gång på gång återuppfinna sig — som Pricia Resort 1996, Hachijo Oriental Resort 2004 — men stängde slutgiltigt 2006.

Idag har ett träskartat område fyllt av bråte ersatt den en gång marmorklädda receptionen. En pampig trappa leder upp till en labyrint av mörka, kusliga korridorer, och i många havsvända rum frodas miniatyrdjungler i det fuktiga tropiska klimatet — ormbunkar tränger upp genom mattor, sängar och soffgrupper i ett surrealistiskt skådespel. Lokalbor säger att hotellet inte kan rivas på grund av dess många skulder, så det får stå kvar och långsamt slukas av naturen.

Källa: offbeatjapan.com + shanethoms.com + uniqhotels.com + simify.com',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 6. MAYA KANKO HOTEL — Japans mest ikoniska haikyo
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'maya-kanko-hotel','Maya Kanko Hotel','maya-kanko-hotel','Japan','Hyōgo, Kobe','Övergiven',
  34.7270,135.1960,4,false,false,NULL,
  'Ett art déco-spökhotell högt på berget Maya, oåtkomligt med väg, som långsamt växer in i berget.',
  'Maya Kanko Hotel är en övergiven art déco-byggnad inbäddad i sluttningen av berget Maya i Kobe — kanske det mest berömda haikyo, övergivna stället, i hela Japan. Här har spelats in film, musikvideor och kortfilmer, och platsen är ett populärt motiv för modefotografering.

Byggnaden uppfördes ursprungligen 1929 av Maya Cablecar Company och kallades Club Maya, tänkt att dra nytta av turistströmmen från företagets bergbana som öppnat 1925. Bergbanans trafik lades ned 1944 under andra världskriget, och hotellet användes då för luftvärnskanoner som en del av Kobes försvar.

Banan återupptogs 1955, och hotellet byggdes om och återöppnade under nytt namn 1961. Men under tyfonsäsongen 1967 skadades det åter svårt. I sitt sista skede restaurerades byggnaden och öppnade 1974 som ett studentcenter, som stängde 1993. Efter den stora Hanshin-jordbävningen 1995 bedömdes området som osäkert och spärrades av.

Sedan dess står Maya Kanko Hotel övergivet och växer långsamt tillbaka in i berget det byggdes på. Det sitter mitt på linbanans sträckning och kan inte nås med väg — bara med linbana eller en brant, farlig vandringsled med rep fästa i träd och klippor. Dess vittrande art déco-fasad, höljd i grönska och tystnad högt över Kobe, har gjort det till en ikon bland Japans urban explorers.

Källa: theghostinmymachine.com + Atlas Obscura + abandonedkansai.com + offbeatjapan.com',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 7. JOMON-TUNNELN — människopelarna i väggarna
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'jomon-tunnel','Jomon-tunneln','jomon-tunnel','Japan','Hokkaido','Tunnel',
  43.7800,143.0500,4,true,false,NULL,
  'En jordbävning blottade upprättstående skelett inmurade i väggarna — människooffer för att bära tunneln.',
  'Jomon-tunneln byggdes på Sekihoku-linjen i Hokkaido 1914 och är ökänd för rykten om människooffer. Bygget inleddes 1912 och tunneln, 507 meter lång, drogs genom Jomonåsen.

Den mörka legenden bekräftades på ett kusligt sätt 1968, då Tokachi-jordbävningen med magnituden 7,9 skadade tunnelns väggar. När reparationerna inleddes 1970 fann arbetarna ett antal mänskliga skelett — stående upprätt, inmurade i väggarna. Över hundra arbetare från det ursprungliga tunnelbygget påträffades nära ingången och i skogen intill.

Fyndet gav näring åt tron att tunneln byggts med "hitobashira" — människopelare, en gammal sed där levande människor murades in i byggnadsverk för att blidka andarna och ge konstruktionen styrka. Många, däribland tågförare, kom att frukta att tunneln var hemsökt av offrens andar.

En mindre övernaturlig förklaring är att de brutala arbetsförhållandena och den usla kosten ledde till att många arbetare — framför allt brottslingar och skuldsatta som tvingats dit mot sin vilja — drabbades av beri-beri, en dödlig nervsjukdom. Utan tillgång till medicin tros offren ha begravts levande nära bygget.

Tågförare har genom åren berättat om spöklika ljud under tunneln, som tros vara skriken från dem som murades in i väggarna för att bära upp dess grund. Än idag passerar tågen Jomon-tunneln med en kuslig historia vilande i mörkret omkring sig.

Källa: kowabana.net + pinktentacle.com + guides-japan.com + Uncanny Japan',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 8. NIIGATA RUSSIAN VILLAGE — den övergivna katedralen
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'niigata-russian-village','Niigata Russian Village','niigata-russian-village','Japan','Niigata, Agano','Övergiven',
  37.8330,139.2200,3,false,false,NULL,
  'En övergiven rysk temapark med lökkupoler och ett krossat mammutskelett bland ruinerna.',
  'Niigata Russian Village var en rysktematisk by och nöjespark i Niigata-prefekturen, öppnad 1993 för att främja relationerna mellan Japan och Ryssland.

Parken inrymde en stor katedral, ett hotell, flera teatrar, restauranger och till och med en golfbana. Bland det mest besynnerliga som lämnades kvar fanns en (falsk) ullig mammut — både uppstoppad och som skelett.

Historien blev kort och olycksam. Efter att ha öppnat 1993 stängde parken efter sex år, när banken som finansierade den kollapsade. Den återöppnade efter renovering 2002, men var då igång i bara sex månader innan bristen på besökare tvingade den att stänga på nytt. I april 2004 stängdes portarna för gott.

Sedan dess har platsen lockat både vandaler och äventyrare. En brand skadade det övergivna hotellet svårt, och vandaler slog sönder möbler och förstörde mammutskelettet. Den ödsliga katedralen, med sina lökkupoler resta mot den japanska himlen, blev en surrealistisk syn — ett stycke Ryssland som långsamt förföll på Niigatas landsbygd. Inne i de tomma teatrarna och restaurangerna stod dukade bord och scendekor kvar och samlade damm, medan snön vintertid yrde in genom krossade fönster och lade sig över de övergivna salarna.

Bland urban explorers blev Russian Village ett av Japans mest fotograferade övergivna nöjesparker, ett sällsynt exempel på rysk arkitektur i Japan som naturen sakta tog tillbaka, innan anläggningen till större delen revs omkring 2016.

Källa: haikyo.org + tokyotimes.org + Atlas Obscura + abandonedkansai.com',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 9. SUGISAWA-BYN — byn som ströks från kartan
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'sugisawa-village','Sugisawa-byn','sugisawa-village','Japan','Aomori','Övergiven',
  40.8200,140.7000,4,true,false,NULL,
  'En by där en yxmördare slaktade alla — sedan utplånad ur kartorna. "Ingen garanteras komma tillbaka levande."',
  'Sugisawa-byn (杉沢村) är namnet på en by som sägs ha funnits i Aomori-prefekturen, och är en av Japans mest kända skräcklegender.

Enligt sägnen var byn bebodd ända fram till tidig Shōwa-tid (1926–1989). En dag blev en ung man plötsligt vansinnig och började slakta byborna med en yxa. Hela byn utplånades, och bara den unge mannen lämnades kvar — som till sist också tog sitt eget liv. Händelserna var så grymma att lokala myndigheter beslöt att lämna byn öde, förneka att något någonsin hänt, och stryka varje spår av byn från kartorna.

Enligt legenden finns där en gammal torii-port med en skallformad sten under, som sägs vara ingången till Sugisawa. På vägen dit står en skylt: "Ingen som går in härifrån garanteras komma tillbaka levande."

Berättelsen bygger troligen på ett verkligt brott 1938, samma tid som legenden utspelar sig: i den lilla byn Kamo nära Tsuyama i Okayama dödade Mutsuo Toi, 21 år, trettio människor innan han tog sitt liv. Ryktena om Sugisawa spreds länge lokalt, men exploderade på internet i slutet av 1990-talet. Trots otaliga sökningar har ingen någonsin funnit legendens "verkliga" Sugisawa — och troligen kommer ingen någonsin att göra det.

Källa: kowabana.net + japan-makes-me-scared.com + theghostinmymachine.com + scaryforkids.com',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;

-- ===== 58_JAPAN_HAUNTED_BATCH5.sql =====
-- Spökkartan — 6 fler platser i Japan, omgång 5 (Japan 34 -> 40, KLART)
-- Genererad 2026-06-09. METOD: engelska/japanska sökord -> Wikipedia, haikyo.org,
-- offbeatjapan.com, kowabana.net, matsushiro.org m.fl. Svenska, 200-600 ord/plats.
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. INUNAKI-BYN — byn bortom Japans lag
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'inunaki-village','Inunaki-byn','inunaki-village','Japan','Fukuoka','Övergiven',
  33.7000,130.5670,4,true,false,NULL,
  'Vid infarten står en skylt: "Japans grundlag gäller inte bortom denna punkt." Paret som körde vilse mördades.',
  'Inunaki-byn (Inunaki-mura) är en japansk skräcklegend från 1990-talet om en fiktiv, byastor mikronation som förkastar Japans grundlag. Sägnen förlägger byn nära Inunaki-passet i Fukuoka-prefekturen. Vid infarten ska det stå en handskriven skylt: "Japans grundlag gäller inte bortom denna punkt."

Enligt legenden vägrar byns invånare att erkänna såväl Japans grundlag som den sittande regeringens legitimitet. De första omnämnandena på nätet dök upp 1999, när tv-bolaget Nippon TV fick ett anonymt brev som beskrev legenden om ett mördat par och uppmanade tv-teamet att besöka platsen. Brevet bar titeln "Byn i Japan som inte är en del av Japan".

Enligt en vanlig version av sägnen körde ett ungt par någon gång i början av 1970-talet vilse i skogen när bilen gick sönder. De kom in i den till synes övergivna Inunaki-byn, där en "galen gammal man" hälsade dem välkomna — och sedan mördade dem med en lie.

Området kring den gamla Inunaki-tunneln intill anses verkligen hemsökt på grund av flera mord; 1988 bortförde och torterade fem unga män en fabriksarbetare som de brände till döds inne i tunneln. En verklig by vid namn Inunaki, utan koppling till legenden, fanns mellan 1691 och 1889 — men det är skräcksägnen om byn bortom lagen som lever vidare på Japans internet.

Källa: Engelska Wikipedia "Inunaki Village" + japan-makes-me-scared.com + Moon Mausoleum + cijtoday.com',
  NULL,NULL,NULL,true,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. YOSHIMI HYAKUANA — de hundra grottgravarna
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'yoshimi-hyakuana','Yoshimi Hyakuana','yoshimi-hyakuana','Japan','Saitama, Yoshimi','Naturplats',
  36.0420,139.4470,3,false,false,NULL,
  'Över 200 grottgravar gapar ur berget, klädda med självlysande grön mossa — och en krigsfabriks tunnlar.',
  'Yoshimi Hyakuana — "de hundra hålen i Yoshimi" — är en gåtfull klippsida i Yoshimi i Saitama-prefekturen, prickad av över 200 grottgravar från Kofun-perioden. Sammanlagt har 219 horisontella grottgravar identifierats i sluttningen av en kulle av tuffartad sandsten, vilket ger ett alldeles unikt landskap.

Gravarna, omkring 1 400 år gamla, liknas ibland vid "forntida hyreshus", där rad efter rad av öppningar gapar ut ur berget. Platsen utsågs till nationellt historiskt minnesmärke 1923 och är ett populärt mål för historiska vandringar. Flera av gravkamrarna är så låga och trånga att besökare måste kura sig samman för att krypa in i dem, och de inte alltför klaustrofobiska kan tränga in i bergets svala, mörka inre där de döda en gång lades till vila.

Men Yoshimi Hyakuana bär också på en mörkare historia. Under Stillahavskrigets slutskede grävdes här en underjordisk militärfabrik, och tunnlar ska ha byggts för att tillverka flygplansdelar. Krig och död vilar alltså i dubbel bemärkelse över platsen.

Den kusliga stämningen förstärks av att många av grottväggarna är klädda med en sällsynt självlysande grön mossa, känd som hikarigoke — "lysmossa" — som skimrar svagt i mörkret. Kombinationen av uråldriga gravkamrar, krigets underjordiska gångar och det spöklika gröna skenet gör Yoshimi Hyakuana till en av Saitamas mest atmosfäriska och olycksbådande platser, där det förflutnas döda tycks vila tätt inpå de levande.

Källa: jeepe.jp + japantravel.com + travel-around-japan.com + donnykimball.com',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. GLUCK KINGDOM — det övergivna tyska sagoriket
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'gluck-kingdom','Gluck Kingdom','gluck-kingdom','Japan','Hokkaido, Obihiro','Övergiven',
  42.7330,143.2170,3,false,false,NULL,
  'Ett övergivet tysktematiskt sagorike i Hokkaido, hemsökt sedan en dödsolycka på en åkattraktion.',
  'Gluck Kingdom (Glücks-Königreich) var en tysktematisk nöjespark nära Obihiro flygplats i Hokkaido — historia, kultur, sagor och nöje, allt på ett ställe. Den öppnade 1 juli 1989 och stängde efter bara fjorton år.

Parken ville återskapa bröderna Grimms sagovärld. Formgivarna inspirerades av den traditionella arkitekturen i de centraltyska delstaterna Hessen och Niedersachsen: trähus från 1400- och 1600-talen, en kullerstensbelagd Marktplatz och till och med interiörer från tyska medeltidsslott återgavs noggrant. På sin höjdpunkt tog parken emot upp till 700 000 besökare om året; redan efter ett halvår hade en halv miljon kommit.

Men läget blev dess fall. Sapporo låg tre timmars bilväg bort, den närmaste järnvägsstationen stängde innan parken ens öppnat, och Obihiro hade under 200 000 invånare. Gluck Kingdom var för isolerat för långväga gäster och stängde 2003 (somliga uppger 2007).

Ryktet gör gällande att Gluck Kingdom är en av Hokkaidos mest hemsökta platser, efter en dödsolycka på en av åkattraktionerna. Sedan 2011 har platsen blivit allt populärare bland urban explorers, som vandrar genom det förfallande tyska sagoriket — övergivna fackverkshus och en tyst slottskuliss, sakta uppslukade av Hokkaidos vildmark. Inne i de tomma byggnaderna stod länge möbler, leksaker och sagofigurer kvar och samlade damm, medan snön vintertid yrde in genom krossade rutor och lade ett vitt täcke över det glömda kungariket.

Källa: offbeatjapan.com + abandonedkansai.com + haikyo.org + worldabandoned.com',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. MATSUSHIRO UNDERJORDISKA HÖGKVARTER — tvångsarbetets tunnlar
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'matsushiro-underground-hq','Matsushiro underjordiska kejserliga högkvarter','matsushiro-underground-hq','Japan','Nagano','Tunnel',
  36.5600,138.2000,4,false,false,NULL,
  'Bergstunnlar grävda av tusentals koreanska tvångsarbetare — hundratals dog i mörkret under jorden.',
  'Matsushiro underjordiska kejserliga högkvarter är ruinerna av militäranläggningar från andra världskriget, uthuggna i berg kring Matsushiro i Nagano från slutet av 1944. Tanken var att den japanska statens centrala organ — inklusive kejsaren — skulle kunna flyttas hit i händelse av en allierad invasion.

De som tvingades utföra grävarbetet var till största delen koreaner, antingen bortförda direkt från Korea eller överflyttade från byggen runt om i Japan. Det var koreanerna som tvingades ta de farligaste och tyngsta uppgifterna. Det totala antalet tvångsarbetare uppskattas till minst 6 000–7 000, men exakta siffror saknas eftersom inga register bevarats; vissa källor anger upp till 10 000.

Arbetarna utförde livsfarliga uppgifter som sprängning med dynamit i flerskift, under minimala säkerhetsåtgärder. Detta ledde till dokumenterade dödsfall genom olyckor, utmattning och sjukdom — siffror mellan 500 och 1 500 döda nämns, även om noggranna uppgifter saknas på grund av krigets förstörelse och efterkrigstidens ovilja att dokumentera.

Idag är 500 meter av anläggningen under berget Zōzan öppna för besökare, och intill ligger Matsushiro Memorial Center of Untold History, som dokumenterar tunnlarnas tillkomst och arv. I de kalla, mörka bergsgångarna, uthuggna med tvångsarbetares blod, dröjer minnet av lidandet kvar — en av Japans mörkaste krigsplatser.

Källa: Engelska Wikipedia + matsushiro.org + snowmonkeyresorts.com + tracesofwar.com',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 5. UNZEN JIGOKU — de kristna martyrernas helveten
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'unzen-jigoku','Unzen Jigoku','unzen-jigoku','Japan','Nagasaki, Unzen','Naturplats',
  32.7340,130.2620,3,true,false,NULL,
  'Kokheta källor där 33 kristna torterades till döds — översköljda med skållhett vatten tills de avföll eller dog.',
  'Unzen Jigoku — "Unzens helveten" — är ett område av kokheta källor på Shimabara-halvön i Nagasaki-prefekturen. Mellan de gamla och nya termalkällorna ligger ett band av vit jord där ånga, på sina ställen upp till 120 grader het, väller ur marken med ett oavbrutet väsande.

Men dessa kokande "helveten" bär på en fasansfull historia. Mellan 1627 och 1632 blev Unzen Jigoku en plats för kristna martyrers död. Förföljelsen sattes igång av Shimabaras feodalherre Matsukura Shigemasa och drevs vidare av Takenaka Shigeyoshi, som 1629 utsågs till magistrat i Nagasaki.

De heta källorna användes för att tortera kristna i ett försök att tvinga dem att avsvärja sin tro. Vid randen av det kokande vattnet pressades de att avfalla; de som vägrade kläddes av, bands till händer och fötter och översköljdes med skopa efter skopa av det skållheta vattnet. Sammanlagt led 33 troende martyrdöden i Unzen Jigoku mellan 1627 och 1631.

På en kulle med utsikt över det ångande, geotermiska landskapet står idag ett minnesmärke och ett kors till åminnelse av de 33 martyrerna. Bland de fräsande källorna och svavelångorna är det inte svårt att föreställa sig de plågor som utspelade sig här — en plats vars namn, "helvetet", känns dubbelt välförtjänt.

Källa: oratio.jp + ucanews.com + nippon.com + discover-nagasaki.com',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 6. NAGORO — dockbyn där dockorna är fler än de levande
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'nagoro-doll-village','Nagoro (dockbyn)','nagoro-doll-village','Japan','Tokushima, Iya-dalen','By',
  33.8830,133.9170,3,true,false,NULL,
  'I en avfolkad bergsby är 350 livsstora dockor fler än de levande — och kastar jättelika skuggor i skymningen.',
  'Nagoro i Iya-dalen på ön Shikoku i Tokushima-prefekturen är idag känt som "dockbyn" — en avfolkad bergsby där livsstora dockor är fler än de levande invånarna.

I början av 2000-talet flyttade Tsukimi Ayano, vars familj lämnat trakten när hon var barn, tillbaka för att ta hand om sin far. När fåglar grävde upp fröna i hennes trädgård tillverkade hon en fågelskrämma i sin fars avbild. Förtjust i resultatet gjorde hon fler tygdockor och ställde dem vid vägen. När förbipasserande resenärer stannade och frågade en av figurerna om vägen blev hon så road att hon beslöt att fortsätta — för att "återbefolka" den döende byn.

Sedan dess har hon gjort över 400 dockor, varav omkring 350 finns i byn. Många föreställer nuvarande eller forna invånare, andra är påhittade personer. Det tar ungefär tre dagars arbete att skapa en ny docka, och ute i väder och vind håller de omkring två år.

Byn hade en gång cirka 300 invånare, men Japans avfolkning har krympt antalet till långt under trettio. Dockorna belyser på sitt vis det allvarliga problemet med landsbygdens utdöende. Och när natten snabbt faller över den lilla byn i Tokushimas berg kastar dockorna jättelika, skrämmande skuggor — och det hela blir, ärligt talat, ganska kusligt.

Källa: Engelska Wikipedia "Nagoro" + CNN + National Geographic + kanpai-japan.com',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;

-- ===== 59_AUSTRALIA_HAUNTED_BATCH2.sql =====
-- Spökkartan — 8 fler hemsökta platser i Australien, omgång 2 (Australien 19 -> 27)
-- Genererad 2026-06-09. METOD: engelska sökord -> Wikipedia, ghosttoursaustralia.com.au,
-- amyscrypt.com, adelaidehauntedhorizons.com.au m.fl. Svenska, 200-600 ord/plats.
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. MONTE CRISTO HOMESTEAD — Australiens mest hemsökta hus
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'monte-cristo-homestead','Monte Cristo Homestead','monte-cristo-homestead','Australien','New South Wales, Junee','Herrgård',
  -34.8500,147.5830,4,false,true,NULL,
  'En gravid tjänsteflicka hoppade från balkongen och en pojke hölls kedjad i 30 år — minst tio spöken.',
  'Monte Cristo Homestead i Junee i New South Wales uppfördes 1885 av pionjären Christopher William Crawley som en tvåvånings herrgård i sen viktoriansk stil, tronande på en kulle över staden. Den marknadsför sig som "Australiens mest hemsökta hus".

Familjen Crawley bodde kvar till 1948, varefter huset stod tomt och förföll tills paret Reg och Olive Ryan köpte det 1963 och restaurerade det. Bakom det vackra yttre döljer sig flera tragedier. Crawley ska ha gjort två av sina tjänsteflickor med barn; en av dem tog livet av sig genom att hoppa från balkongen, gravid — och blekmärket efter att hennes blod tvättats bort från trappstegen sägs ännu synas. Den andra födde en son, Harold, som efter en svår huvudskada hölls kedjad i vagnshuset i över trettio år, skrikande och tjutande dagligen.

En stalldräng, Morris, brann till döds i sin säng sedan hans husbonde tänt eld på halmmadrassen för att få honom att vakna. Och Crawleys lilla barnbarn Ethel dog 1917 när barnsköterskan tappade henne i trappan — hon hävdade att hon knuffats av en osynlig kraft.

Paret Ryan rapporterade otaliga övernaturliga händelser: spökljus, djur som dog oförklarligt och minst tio spöken. Övernattande gäster berättar om underliga röster i fjärran och steg i korridorerna.

Källa: Engelska Wikipedia "Monte Cristo Homestead" + thelittlehouseofhorrors.com + pedestrian.tv + tracesmagazine.com.au',
  NULL,NULL,NULL,true,true,'published','web_au_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. ADELAIDE GAOL — 45 hängningar inom murarna
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'adelaide-gaol','Adelaide Gaol','adelaide-gaol','Australien','South Australia, Adelaide','Fängelse',
  -34.9100,138.5790,4,false,true,NULL,
  '45 män hängdes här och vilar ännu inom murarna — en seriemördares ande vandrar bland gravarna.',
  'Adelaide Gaol är en av Adelaides äldsta offentliga byggnader och tjänade som fängelse och avrättningsplats i nästan 150 år. Den räknas som en av de mest hemsökta platserna i South Australia.

Med 45 hängningar och begravningsmark för mördare är det föga förvånande att ett dussintal rastlösa andar sägs hemsöka fängelset. Den förste som hängdes i South Australia var Michael Magee, den 2 maj 1838, och den siste Glen Sabre Valance i november 1964. Av de 66 fångar som hängdes i delstaten avrättades 45 vid Adelaide Gaol, och deras kroppar vilar ännu inom murarna, på en av fängelsets två kyrkogårdar.

Ett av de oftast sedda spökena tros vara John Balaban, en sadistisk seriemördare som dödade minst fem personer — däribland sin egen hustru och sexårige son — och som avrättades 1953. William Baker Ashton, fängelsets förste direktör, sägs alltjämt hålla till i sitt forna kontor på övervåningen, där han dog; tunga steg av en kraftig man hörs ofta paca där inne. En tredje gestalt, Fred Carr, visar sig regelbundet nära trappan till de övre cellerna, prydligt klädd i mörkt och vänligt nyfiken på besökarna.

Spöksteg, röster och poltergeistaktivitet — dörrar som rör sig, elektroniska störningar och plötsliga temperaturfall — rapporteras genom hela fängelset.

Källa: adelaidegaol.org.au + amyscrypt.com + adelaidehauntedhorizons.com.au + adelaidegaol.sa.gov.au',
  NULL,NULL,NULL,false,true,'published','web_au_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. BOGGO ROAD GAOL — Ernest Austin och den trebenta spökkatten
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'boggo-road-gaol','Boggo Road Gaol','boggo-road-gaol','Australien','Queensland, Brisbane','Fängelse',
  -27.4960,153.0290,4,false,true,NULL,
  'Den siste avrättade mannens skugga ses i cellblock E — och en trebent spökkatt stryker mot besökarnas ben.',
  'Boggo Road Gaol i Brisbane öppnade 1883 och var en av Queenslands viktigaste fånganstalter i över ett sekel. Den bestod av två avdelningar: Division 1, ökänd för sina avrättningar, och Division 2, som från början hyste kvinnliga fångar. Den enda del som står kvar idag är Number Two Division, ursprungligen kvinnofängelset uppfört 1902.

Vid galgen i Division 1 hängdes 42 av landets mest avskyvärda brottslingar. Ellen Thomson var den enda kvinna som avrättats i Queensland; hon mötte sitt öde i den äldsta delen av fängelset, som revs på 1970-talet.

Mest ökänd är anden efter Ernest Austin, den siste man som avrättades i Queensland sedan han våldtagit och mördat en elvaårig flicka. Hans spöke ska ha setts åtskilliga gånger i både division 1 och 2. Sedan spökturerna startade 1998 har både besökare och personal sett skuggan av en man i cellblock E — samma plats där fångar såg Austins ande redan på 1980-talet.

Spökhistorier från vakter och fångar går tillbaka till 1930-talet. Under tjugo år har besökare svurit på att de blivit vidrörda, gripna eller till och med tilltalade av andar. Den märkligaste hemsökelsen är dock en trebent spökkatt — "Tripod" — som besökare påstår har strukit sig mot deras ben eller hörts jama.

Källa: ghosttoursaustralia.com.au + boggoroadgaol.com + redcliffetourism.com + viator.com',
  NULL,NULL,NULL,false,true,'published','web_au_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. Z WARD — "Hell Ward" för de kriminellt sinnessjuka
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'z-ward-glenside','Z Ward (Glenside)','z-ward-glenside','Australien','South Australia, Adelaide','Asyl',
  -34.9420,138.6360,4,false,true,NULL,
  'Folket kallade den "Hell Ward" — i "Scratchys rum" sägs huden slå upp i klolika rivmärken.',
  'Z Ward i Glenside i Adelaide stod färdigt 1885 och stängde 1973. Den fristående byggnaden, omgiven av en imponerande "ha-ha"-mur, hyste många av delstatens mest våldsamma och "kriminellt sinnessjuka" patienter — mördare, tjuvar och de svårast störda.

Ursprungligen hette den L Ward, men kom snart att kallas Z Ward — eller snarare "Hell Ward" i folkmun, av "Hell" i stället för "L". Den byggdes mer som ett fängelse än en asyl, med maximala säkerhetsanordningar för att ingen skulle kunna rymma. Dess syfte var att stänga inne dem som ansågs alltför farliga och psykiskt sjuka för en vanlig kriminalvårdsanstalt.

Paranormal aktivitet är vanlig inne i Z Ward, som låste in South Australias kriminellt sinnessjuka i nästan nittio år. "Aktivitet" har dokumenterats i celler på båda våningarna, däribland "Scratchys rum", där huden sägs kunna slå upp i klolika rivmärken, och "spegelrummet", där en skuggestalt sägs glida in i glaset.

Idag erbjuds åtskilliga turer i Z Ward — både kulturhistoriska turer och spökturer, drivna av National Trust och Haunted Horizons. Spökturerna har blivit populära bland dem som dras till både det paranormala och byggnadens mörka historia. I de tysta, tjockmurade cellerna känns de inspärrades förtvivlan ännu påtaglig.

Källa: adelaidehauntedhorizons.com.au + amyscrypt.com + Atlas Obscura + broadsheet.com.au',
  NULL,NULL,NULL,false,true,'published','web_au_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 5. LARUNDEL ASYLUM — speldosans toner i natten
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'larundel-asylum','Larundel Asylum','larundel-asylum','Australien','Victoria, Melbourne','Asyl',
  -37.7000,145.0670,4,false,false,NULL,
  'En flickas speldosa hörs spela sent på natten i det övergivna mentalsjukhusets korridorer.',
  'Larundel Mental Asylum i Bundoora i Melbourne började byggas 1938, men arbetet avbröts av andra världskriget. De halvfärdiga byggnaderna användes under kriget som militärsjukhus för flygvapnet och som utbildningsdepå. Femton år efter byggstarten började asylen ta emot patienter, och den stängde officiellt 2001.

Larundel är känt som det första center som behandlade den ökände australiske seriemördaren Peter Dupas, och som platsen där litium först användes för att behandla bipolär sjukdom. Efter stängningen stod den övergiven och förfallande, och sägs vara hemsökt av forna patienters andar, vilkas rastlösa själar ännu vandrar i de mörka korridorerna och viskar om det lidande de utstod.

Den mest kända legenden är speldosans. En ung flicka, som bodde många år på asylens tredje våning, ska ha haft en enda ägodel som låg henne varmt om hjärtat — en speldosa, som hon ofta spelade. Sägnen säger att man efter hennes död ofta hört de svaga tonerna av speldosan sent på natten. Somliga menar dock att musiken i själva verket kommer från en lokal glassbil, som kan höras även sent på kvällen.

Idag står Larundel som ett vidsträckt område av inhägnade ruiner, där många av de gamla sjukhusbyggnaderna restaurerats och byggts om till moderna lägenheter — men minnet av asylens mörka år dröjer kvar.

Källa: exutopia.com + amyscrypt.com + Atlas Obscura + vice.com',
  NULL,NULL,NULL,false,true,'published','web_au_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 6. HYDE PARK BARRACKS — straffångarnas spökjournal
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'hyde-park-barracks','Hyde Park Barracks','hyde-park-barracks','Australien','New South Wales, Sydney','Byggnad',
  -33.8690,151.2120,3,false,true,NULL,
  'Sydneys mest hemsökta byggnad för en regelrätt spökjournal — en kvinna i vitt vakar under fikonträdet.',
  'Hyde Park Barracks i centrala Sydney sägs vara stadens mest hemsökta byggnad. Den uppfördes 1817–1819 — ritad av straffångearkitekten Francis Greenway och byggd av fångarbete — och rymde i medeltal 600 straffångar, som om dagarna sattes i arbete och om nätterna sov i hängmattor i tolv rum. Senare tjänade byggnaden som sjukhus, kvinnofängelse och domstol, och är idag ett världsarvslistat museum.

Besökare beskriver dånande steg ovanför sig och plötsliga kalla fläckar i de gamla sovsalarna. Flera bestämda uppenbarelser har dokumenterats: en grovkäftad forna fängelseföreståndare vars svordomar tycks eka genom salarna; en "kvinna i vitt" som setts under fikonträdet på framsidan; och en man i blekt fångdräkt som driver fram i en korridor. Andra berättelser nämner en fånge som haltar i gången och två svarta gestalter som hukar vid dörren i hängmatterummet om natten.

Till skillnad från de flesta "hemsökta" platser för Hyde Park Barracks en regelrätt spökjournal, med nedteckningar av upplevelser gjorda strax efter att de inträffat. Vakter och andra som tillbringat natten i byggnaden — däribland skolbarn som sover över för att få "fångupplevelsen" — har vittnat om olika fenomen. Personalen har då och då hört oförklarliga jämmer eller sett ljus flacka av sig själva i museiflygeln.

Källa: csicop.org + australiatravelhub.com + neighbourhoodmedia.com.au + sydney100.com',
  NULL,NULL,NULL,false,true,'published','web_au_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 7. FISHERS GHOST — spöket som pekade ut sin egen mördare
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'fishers-ghost','Fishers Ghost','fishers-ghost','Australien','New South Wales, Campbelltown','Naturplats',
  -34.0650,150.8140,3,true,false,NULL,
  'Ett spöke satt på broräcket och pekade mot bäcken — där låg den mördade Fishers begravda kropp.',
  'Fishers Ghost är en av Australiens äldsta och mest berömda spökhistorier, från det tidiga 1800-talet, knuten till Campbelltown i New South Wales.

Den 17 juni 1826 försvann plötsligt Frederick Fisher, en straffånge som deporterats från London för förfalskning och som förvärvat en gård i Campbelltown. Hans granne George Worrall påstod att Fisher återvänt till England och lämnat fullmakt över sin egendom. Men en sen kväll i oktober 1826 rusade en välbärgad och aktad lantbrukare, John Farley, in på ortens värdshus i chocktillstånd och påstod att han sett Frederick Fishers spöke. Spöket satt på räcket till en bro, pekade mot en hage nere vid bäcken — och bleknade sedan bort.

Omständigheterna kring Fishers försvinnande väckte till slut tillräcklig misstanke för att polisen skulle genomsöka just den hage spöket pekat mot. Där fann man den mördade Fishers kvarlevor, begravda vid bäckkanten. George Worrall greps, erkände och hängdes.

Det är en av Australiens tidigaste nedtecknade spökhistorier — och en av få där ett spökvittnesmål föregick en fällande mordom. Sedan 1956 hålls varje november den tio dagar långa Festival of Fishers Ghost i Campbelltown, som bygger vidare på legenden om mannen vars ande pekade ut sin egen mördare.

Källa: Engelska Wikipedia "Fishers ghost" + visitcampbelltown.com.au + historysvault.com + dictionaryofsydney.org',
  NULL,NULL,NULL,false,true,'published','web_au_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 8. MIN MIN-LJUSET — outbackens spökljus
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'min-min-light','Min Min-ljuset','min-min-light','Australien','Queensland, Boulia','Naturplats',
  -22.9100,139.9000,2,true,false,NULL,
  'Spökljus som följer resenärer genom outbacken — de dödas andar vid det ökända Old Min Min Inn.',
  'Min Min-ljuset är ett ljusfenomen som ofta rapporterats i Australiens outback. Iakttagelser sträcker sig från Brewarrina i västra New South Wales i söder till Boulia i norra Queensland. Ljusen var lokalt kända som "ghost lights" — spökljus.

Berättelser om ljusen finns i flera aboriginska kulturer och föregår den europeiska koloniseringen; de har sedan blivit en del av vidare australisk folktro. Namnets ursprung är osäkert — det kan komma från ett aboriginskt språk i Cloncurry-trakten, eller från Min Min Hotel, en liten bosättning där en boskapsskötare såg ljuset 1918.

Enligt sägnen var ljusen de dödas andar, som hemsökte den övergivna platsen efter Old Min Min Inn — ett ökänt värdshus längs den gamla diligensvägen, med rykte om utspädd sprit, lättillgängliga droger och en strid ström av slagsmål och mord.

Det är osäkert om Min Min-ljusen är ett verkligt fenomen, och i så fall vad de beror på. Flera hypoteser har lagts fram: forskaren Jack Pettigrew menar att de kan vara svärmar av insekter som blivit självlysande, en art av uggla med egen bioluminiscens — eller en hägring av typen Fata Morgana, då ett varmt luftlager fångar kall, tät luft under sig och böjer ljuset. Men för outbackens resenärer förblir spökljusen en olöst gåta.

Källa: Engelska Wikipedia "Min Min light" + historicmysteries.com + adventuretours.com.au + australianhistory.net',
  NULL,NULL,NULL,false,true,'published','web_au_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;

-- ===== 60_USA_HAUNTED_BATCH8.sql =====
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
  'the-stanley-hotel','The Stanley Hotel','the-stanley-hotel','USA','Colorado, Estes Park','Hotell',
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
  'lalaurie-mansion-new-orleans','LaLaurie Mansion','lalaurie-mansion-new-orleans','USA','Louisiana, New Orleans','Herrgård',
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
  'trans-allegheny-lunatic-asylum','Trans-Allegheny Lunatic Asylum','trans-allegheny-lunatic-asylum','USA','West Virginia, Weston','Asyl',
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

-- ===== 63_USA_HAUNTED_BATCH9.sql =====
-- Spökkartan — 10 fler hemsökta platser i USA, omgång 9 (USA 22 -> 32)
-- Genererad 2026-06-10. METOD: engelska sökord -> Wikipedia, usghostadventures.com,
-- Atlas Obscura, bellwitchcave.com, hoteldel.com m.fl. Svenska, 200-600 ord/plats.
-- Koordinater landmärkesnivå (Maps/OSM ej nåbara i miljön) — finverifiera vid behov.
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. SALEM WITCH HOUSE
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'salem-witch-house','Salem Witch House','salem-witch-house','USA','Massachusetts, Salem','Museum',
  42.5220,-70.8967,3,false,true,NULL,
  'Domaren Corwins hem — enda byggnaden kvar med direkt koppling till häxprocesserna 1692.',
  'Salem Witch House i Salem i Massachusetts var hem åt domaren Jonathan Corwin (1640–1718) och är den enda kvarvarande byggnaden i Salem med direkt koppling till häxprocesserna 1692.

Mellan februari 1692 och maj 1693 anklagades över 200 människor för häxeri i kolonin Massachusetts. Trettio fälldes, och nitton av dem avrättades genom hängning — fjorton kvinnor och fem män. En man, Giles Corey, pressades till döds under stenar sedan han vägrat svara på anklagelsen, och minst fem dog i de sjukdomshärjade fängelserna utan rättegång. Avrättningsplatsen, Proctors Ledge, fick ett minnesmärke 2017.

I domare Corwins hem hölls förhören med flera anklagade, däribland Bridget Bishop. Idag är huset ett museum — och sägs vara hemsökt. Besökare berättar om kroppslösa röster och kalla kårar som kryper längs ryggen när de går genom de gamla rummen. Lokalbor påstår att man kan se anden efter Sarah Good, en av de avrättade, vandra över Corwins tomt på jakt efter domaren som dömde henne till döden.

Hela Salem är genomsyrat av häxprocessernas mörka arv, men det är det svarta, branta Witch House — med sina spröjsade fönster och dystra gavlar — som mest påtagligt för besökaren tillbaka till 1692.

Källa: Engelska Wikipedia "Salem witch trials" + usghostadventures.com + salem.org + wanderingeducators.com',
  NULL,NULL,NULL,true,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. BELL WITCH CAVE
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'bell-witch-cave','Bell Witch Cave','bell-witch-cave','USA','Tennessee, Adams','Grotta',
  36.5840,-87.0640,4,false,true,NULL,
  'Amerikas mest dokumenterade hemsökelse — anden "Kate" som svor att döda John Bell.',
  'Bell Witch Cave i Adams i Tennessee är platsen för en av Amerikas mest berömda — och mest dokumenterade — spökhistorier. Legenden kretsar kring familjen Bell, som på 1800-talet bodde vid Red River.

Enligt sägnen drabbades familjen mellan 1817 och 1821 av en mestadels osynlig kraft som kunde tala, påverka sin omgivning och skifta skepnad. Det började med underliga djur på gården och kusliga ljud i stugan, men eskalerade till en röst som hördes i varje rum — och som särskilt terroriserade den yngsta dottern Betsy med slag som lämnade henne medvetslös. Anden kallade sig "Kate" och uttryckte stark vrede när Betsy förlovade sig med en lokal yngling.

Kraften svor att döda fadern John Bell, och tog på sig ansvaret för hans död den 20 december 1820, då en flaska med en främmande vätska hittades vid hans dödsbädd. Tennessee är därmed den enda delstat som erkänt ett dödsfall som orsakat av det övernaturliga. Till och med den blivande presidenten Andrew Jackson lär ha sagt: "Hellre möter jag hela den brittiska armén än tillbringar en natt till med Bell-häxan."

Idag erbjuds turer i grottan och en rekonstruktion av familjens stuga; tusentals besökare kommer årligen för att höra historien om Bell-häxan.

Källa: Engelska Wikipedia "Bell Witch" + bellwitchcave.com + themoonlitroad.com + exploresouthernhistory.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. THE CONJURING HOUSE
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'conjuring-house','The Conjuring House','conjuring-house','USA','Rhode Island, Harrisville','Hus',
  41.9870,-71.6730,4,false,true,NULL,
  'Gården från 1736 som inspirerade skräckfilmen The Conjuring — och familjen Perrons hemsökelse.',
  'The Conjuring House — ursprungligen Arnold Estate — är en gård från 1736 vid 1677 Round Top Road i Harrisville i Rhode Island, känd som den verkliga förlagan till skräckfilmen The Conjuring (2013).

Familjen Perron — föräldrarna Roger och Carolyn och deras fem döttrar — flyttade in i januari 1971 och rapporterade snart paranormal aktivitet. I filmen knyts hemsökelsen till Bathsheba Sherman, som påstås ha varit en barnamörderska, häxa och djävulsdyrkare.

Verkligheten är dock en annan. Bathsheba Sherman bodde aldrig i Perrons gård, utan på Sherman-gården en bit bort. Enligt historiska källor levde hon ett tämligen vanligt liv som arbetsam bondhustru och dog 73 år gammal efter "en plötslig förlamning" — sannolikt en stroke. Den mörka bilden av henne tycks ha skapats av amatörmässig efterforskning och senare spätts på av familjen och de berömda ockulta utredarna Ed och Lorraine Warren, för dramatisk effekt.

Oavsett sägnens sanningshalt har huset blivit ett av USA:s mest besökta spökhus. Familjen Perron berättade om kalla fläckar, dörrar som öppnades av sig själva, dofter av ruttnande kött och en gestalt som visade sig vid sängen om natten. Det drivs idag med turer och övernattningar för paranormala utredare, som vallfärdar till den avlägsna gården för att själva uppleva det som inspirerade en av modern tids mest framgångsrika skräckfilmer.

Källa: Engelska Wikipedia "The Conjuring" + allthatsinteresting.com + bostonghosts.com + skepticalinquirer.org',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. PENNHURST STATE SCHOOL
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'pennhurst-asylum','Pennhurst State School','pennhurst-asylum','USA','Pennsylvania, Spring City','Asyl',
  40.1730,-75.5490,4,false,true,NULL,
  'En institution med ökänd vanvård — "The King" sägs strypa besökare i pannrummet.',
  'Pennhurst State School and Hospital i Pennsylvania öppnade i november 1908 som en institution för fysiskt och psykiskt funktionsnedsatta — både barn och vuxna. Ursprungligen kallad Eastern Pennsylvania State Institution for the Feeble-Minded and Epileptic, stängdes den 1987 efter 79 år av kontrovers.

Anstalten hade en djupt mörk historia. Ett avslöjande i lokala nyheter 1968 visade chockerande förhållanden: de intagna var undernärda, fastspända och utsatta för fysisk och psykisk misshandel, i en miljö präglad av svår överbeläggning och vanvård.

Platsen räknas idag som en av Amerikas mest hemsökta. I den så kallade Q-byggnaden, där barn hölls, har grupper berättat hur en plötslig vindpust släckt deras ljus innan de hört ett barns kroppslösa skratt. "The King", som tros vara anden efter en vaktmästare från 1940- och 50-talen, sägs hålla till i pannrummet i Mayflower-byggnaden och visa sig som en skuggestalt med kraft nog att röra vid — eller till och med strypa — besökare.

År 2010 öppnade den delvis renoverade administrationsbyggnaden som skräckattraktionen Pennhurst Asylum, som drivs under Halloween. Dagtid erbjuds historiska turer och nattetid paranormala utredningar i de förfallande byggnaderna — en omdiskuterad andra akt för en plats med så tungt lidande i sina väggar.

Källa: Engelska Wikipedia "Pennhurst State School and Hospital" + phillyghosts.com + usghostadventures.com + allthatsinteresting.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 5. BOBBY MACKEYS MUSIC WORLD
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'bobby-mackeys','Bobby Mackeys Music World','bobby-mackeys','USA','Kentucky, Wilder','Nattklubb',
  39.0760,-84.4870,4,true,false,NULL,
  'En blodbrunn kallad "porten till helvetet" och Pearl Bryans huvudlösa ande — Amerikas mest hemsökta nattklubb.',
  'Bobby Mackeys Music World i Wilder i Kentucky var en honky tonk och nattklubb som länge kallades USA:s mest hemsökta nattklubb. Platsen användes i början av 1800-talet som slakteri, och i byggnaden fanns en brunn som ledde blod från slaktgolvet ned till floden — en brunn som senare kom att kallas en "port till helvetet".

Enligt legenden hemsöks platsen av flera andar, däribland Pearl Bryan, vars huvudlösa kropp 1896 hittades på ett fält drygt fyra kilometer bort. Hon halshöggs av två män, Alonzo Walling och Scott Jackson, i ett av Kentuckys mest ökända mord. Någon faktisk koppling mellan mordet och platsen har dock aldrig kunnat fastställas, och det lokala historiesällskapet menar att historien ständigt överdrivs.

Countrysångaren Bobby Mackey köpte stället 1978 och gjorde det till sin nattklubb, varpå berättelserna om "porten till helvetet", spökerier och en arg ande växte sig allt starkare — och lockade tv-team som Ghost Adventures.

I mars 2024 stängde nattklubben, och i december samma år revs byggnaden för att ge plats åt en ny anläggning. Men ryktet om den blodiga brunnen och Pearl Bryans rastlösa ande lever vidare som en av Amerikas mest beryktade spökplatser.

Källa: Engelska Wikipedia "Bobby Mackeys Music World" + thelittlehouseofhorrors.com + cincinnatighosts.com + onlyinyourstate.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 6. HOTEL DEL CORONADO
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'hotel-del-coronado','Hotel del Coronado','hotel-del-coronado','USA','Kalifornien, Coronado','Hotell',
  32.6800,-117.1780,3,false,true,NULL,
  'Kate Morgan tog sitt liv i rum 3327 år 1892 — hotellets mest efterfrågade och mest hemsökta rum.',
  'Hotel del Coronado i Coronado utanför San Diego är ett av Kaliforniens mest ikoniska hotell — och hemsökt av Kate Morgan.

Kate Morgan var 24 år när hon på Thanksgiving 1892 checkade in i rum 3327 (då rum 302). Efter fem ensamma dygn tog hon sitt liv. När hennes identitet bekräftats — hon var gift men separerad från sin man — antogs hon ha kommit till hotellet i hopp om att möta en älskare som aldrig dök upp.

Sedan dess kretsar spökerierna kring hennes forna gästrum på tredje våningen. Besökare berättar om flackande lampor, en tv som slås på och av av sig själv, vindpustar från ingenstans, oförklarliga dofter och ljud, föremål som rör sig, dörrar som öppnas och stängs, plötsliga temperaturfall och steg och röster utan källa. Somliga gäster säger sig ha känt fingertoppar stryka över kinden i sömnen, eller sett Kates initialer framträda i taket.

Berättelsen om Kate Morgan fortsätter att fascinera, och hennes rum är det mest efterfrågade på hela hotellet. Också i hotellets butiker och korridorer har personal och gäster berättat om svala fläckar och föremål som faller från hyllorna utan förklaring. Fristående paranormala utredare har med infraröda kameror, mörkerseende och annan utrustning dokumenterat det de menar är övernaturlig aktivitet i det vackra, vita strandhotellet vid Stilla havet — som dessutom är en av landets största träbyggnader.

Källa: hoteldel.com + sandiegomagazine.com + historichotels.org + ghostsandgravestones.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 7. USS LEXINGTON
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'uss-lexington','USS Lexington','uss-lexington','USA','Texas, Corpus Christi','Fartyg',
  27.8150,-97.3890,3,false,true,NULL,
  '"Det blå spöket" — hangarfartyget vars döde sjöman Charlie ännu guidar besökare i maskinrummen.',
  'USS Lexington är ett hangarfartyg från andra världskriget, sjösatt 1943, som idag ligger som museifartyg i Corpus Christi i Texas. Det kallas "the Blue Ghost" — det blå spöket.

Smeknamnet kommer från japansk krigspropaganda: Lexington rapporterades sänkt inte mindre än fyra gånger, men återvände gång på gång till strid, som ett spöke. Fartyget tjänade omkring 21 månader i Stillahavskriget och bar på en av flottans mest legendariska krigshistorier.

Sedan det öppnade som museum 1992 har fartyget samlat på sig berättelser om kusliga händelser, och blivit ett av Texas mest omtalade spökmål. Den mest berömda anden är "Charlie" — en väluppfostrad sjöman med genomträngande blå ögon, klädd i en gammaldags vit flottuniform som besättningen inte längre använder. Han tros ha dödats i en kamikazeattack 1944, och sägs förvåna besökare med sin ingående kännedom om fartyget och dess maskiner.

Andra vittnen berättar om spökhänder som rört vid dem, kroppslösa röster och skrik i korridorerna, ibland med ljud av gevärseld, samt skrammel av kedjor och hissar som rör sig av sig själva. Under sin krigstjänst förlorade fartyget åtskilliga besättningsmän i strid, bränder och olyckor, och många menar att det är deras själar som ännu vakar i de trånga, stålklädda utrymmena. Idag erbjuds spökturer ombord, och varje oktober förvandlas det väldiga fartyget till södra Texas största spökhus.

Källa: hauntedus.com + visitcorpuschristi.com + hauntedrooms.com + authentictexas.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 8. ROBERT THE DOLL
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'robert-the-doll','Robert the Doll (Fort East Martello)','robert-the-doll','USA','Florida, Key West','Museum',
  24.5520,-81.7870,4,false,true,NULL,
  'Världens mest beryktade hemsökta docka — förbannar dem som fotar honom utan att fråga om lov.',
  'Robert the Doll är en av världens mest beryktade hemsökta dockor, utställd på Fort East Martello Museum i Key West i Florida.

Dockan tillhörde Robert Eugene "Gene" Otto, som fick den som ung pojke i början av 1900-talet. Enligt en version köptes den av hans morfar på en resa till Tyskland, enligt en annan gavs den av en tjänsteflicka med onda avsikter. Den halmfyllda dockan tillverkades omkring 1904, och Gene utvecklade ett ovanligt förhållande till den.

Familjen Otto ska ha hört Robert fnissa runt om i huset, och förbipasserande påstod sig se en liten docka röra sig från fönster till fönster. Enligt legenden kan dockan röra sig, ändra ansiktsuttryck och fnissa. Lokal folktro tillskriver Robert bilolyckor, benbrott, förlorade jobb, skilsmässor och en mängd andra olyckor — och besökare sägs drabbas av "olyckor efter besöket" om de inte visar honom respekt.

År 1994 skänktes dockan till museet, inrymt i ett gammalt fort från inbördeskriget, där den nu sitter bakom plexiglas och tar emot hundratals besökare i veckan. Roberts favorittilltag sägs vara att förbanna dem som fotograferar honom utan att först be om lov — och väggarna kring hans monter är täckta av brev från ångerfulla besökare som ber om förlåtelse.

Källa: Engelska Wikipedia "Robert (doll)" + Atlas Obscura + hauntedkeywest.com + kwahs.org',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 9. SORREL-WEED HOUSE
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'sorrel-weed-house','Sorrel-Weed House','sorrel-weed-house','USA','Georgia, Savannah','Herrgård',
  32.0740,-81.0980,3,false,true,NULL,
  'Två kvinnor sägs vandra här — hustrun Matilda och den förslavade Molly, funnen hängd i vagnshuset.',
  'Sorrel-Weed House på 6 West Harris Street i Savannah i Georgia uppfördes 1839–40 åt den förmögne skeppshandlaren Francis Sorrel. Det är ett av Savannahs finaste exempel på grekisk nyklassicism och Regency-arkitektur, och blev 1954 ett av delstatens första byggnadsminnen.

Huset är ökänt för sitt rykte som hemsökt. Det sägs hemsökas av två kvinnliga uppenbarelser: Matilda Sorrel, husägarens hustru, och en ung förslavad flicka vid namn Molly. Enligt sägnen ska Francis Sorrel ha haft en affär med Molly; Matilda upptäckte förhållandet och tog sitt liv, varpå Molly kort därefter hittades hängd i vagnshuset.

Historiskt är bilden mer komplicerad. Det finns tidningsartiklar som styrker Matildas död, men inga belägg för Mollys — tvärtom visar register att Francis ägde en förslavad flicka vid namn Molly som 1857 fraktades från Savannah till New York.

Besökare berättar om mörka gestalter som vandrar genom husets salar, kvinnor som skymtar i speglarna och en påtagligt ond energi, särskilt i källaren och i de gamla slavkvarteren på baksidan, där röster och steg ofta hörs. Huset har figurerat i flera tv-program om det paranormala, bland annat Ghost Hunters, vilket gjort det till ett av Savannahs mest besökta spökhus. Idag erbjuds historiska turer dagtid och spökturer efter mörkrets inbrott, samt nattliga paranormala "lock-ins" för dem som vill utforska huset med egen utrustning.

Källa: Engelska Wikipedia "Sorrel–Weed House" + usghostadventures.com + savannahghosttour.com + destinationghost.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 10. THE DRISKILL HOTEL
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'driskill-hotel','The Driskill Hotel','driskill-hotel','USA','Texas, Austin','Hotell',
  30.2685,-97.7415,3,false,true,NULL,
  'Cigarrök från en död baron och en brud i rum 525 — Austins mest hemsökta hotell.',
  'The Driskill Hotel i Austin i Texas öppnade den 20 december 1886 och blev snabbt ett av söderns mest storslagna hotell. Det byggdes av boskapsbaronen överste Jesse Driskill — som dog redan 1890 och fick föga tid att njuta av sitt hotell, vilket kanske är skälet till att hans ande sägs dröja kvar.

Driskill rökte ständigt cigarr, och många har känt doften av cigarrök i lobbyn trots att hotellet sedan länge är rökfritt. En anställd som försökte spåra lukten hörde en röst bakom sig be om en tändsticka — men ingen fanns där.

Mest ökänt är rum 525, där två tragedier utspelat sig med ett sekel emellan. På 1800-talet tog en brud sitt liv i rummet sedan hennes blivande make ställt in bröllopet; sedan dess har gäster sett en kvinna i viktoriansk brudklänning i korridoren utanför. År 1991 sköt en jiltad societetskvinna från Houston sig i rummets badkar efter att ha shoppat på sin före detta fästmans bekostnad.

En annan ande sägs vara fyraåriga Samantha Houston, dotter till en senator, som omkom i en olycka i hotellets stora trappa 1887; hennes skratt och studsande boll hörs ibland i trappan. Gäster har även berättat om tavlor vars motiv tycks röra sig, hissar som stannar på fel våning och en känsla av att bli iakttagen i de pampiga korridorerna. År 2022 toppade Driskill Yelps lista över Austins mest hemsökta hotell.

Källa: austinghosts.com + usghostadventures.com + moonmausoleum.com + hauntedus.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;

-- ===== 64_USA_HAUNTED_BATCH10.sql =====
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

-- ===== FUNKTIONSMIGRATIONER =====
-- Spökkartan — migration: användarförslag på nya platser ("Föreslå plats")
-- Skapar tabellen place_suggestions + Row Level Security.
--
-- FLÖDE:
--   1. Vem som helst (utloggad eller inloggad) kan SKICKA IN ett förslag (INSERT).
--   2. Endast admin (din inloggning) kan LÄSA/ÄNDRA förslag (inkorgen).
--   3. När ett förslag godkänns kompletterar vi koordinater/info/bild och lägger
--      in platsen i places-tabellen (som vanligt via SQL eller admin).
--
-- Kör i Supabase SQL Editor EN gång.

create table if not exists public.place_suggestions (
  id            uuid primary key default gen_random_uuid(),
  name          text not null,
  country       text,
  region        text,
  type          text,
  lat           double precision,
  lng           double precision,
  description   text,
  why           text,                       -- "varför är platsen hemsökt/intressant?"
  submitter_name  text,
  submitter_email text,
  user_id       uuid references auth.users(id) on delete set null,
  status        text not null default 'new', -- new | reviewing | approved | rejected | published
  admin_notes   text,
  created_at    timestamptz not null default now(),
  updated_at    timestamptz not null default now()
);

create index if not exists place_suggestions_status_idx on public.place_suggestions(status);
create index if not exists place_suggestions_created_idx on public.place_suggestions(created_at desc);

alter table public.place_suggestions enable row level security;

-- Vem som helst får skicka in ett förslag.
drop policy if exists "suggestions_insert_anyone" on public.place_suggestions;
create policy "suggestions_insert_anyone"
  on public.place_suggestions for insert
  to anon, authenticated
  with check (true);

-- Endast admin (ditt konto) får läsa inkorgen.
drop policy if exists "suggestions_select_admin" on public.place_suggestions;
create policy "suggestions_select_admin"
  on public.place_suggestions for select
  to authenticated
  using ((auth.jwt() ->> 'email') = 'fredrik.lundberg@grantigo.com');

-- Endast admin får ändra status / lägga noteringar.
drop policy if exists "suggestions_update_admin" on public.place_suggestions;
create policy "suggestions_update_admin"
  on public.place_suggestions for update
  to authenticated
  using ((auth.jwt() ->> 'email') = 'fredrik.lundberg@grantigo.com')
  with check ((auth.jwt() ->> 'email') = 'fredrik.lundberg@grantigo.com');

-- Endast admin får radera.
drop policy if exists "suggestions_delete_admin" on public.place_suggestions;
create policy "suggestions_delete_admin"
  on public.place_suggestions for delete
  to authenticated
  using ((auth.jwt() ->> 'email') = 'fredrik.lundberg@grantigo.com');

-- Håll updated_at aktuell.
create or replace function public.touch_place_suggestions()
returns trigger language plpgsql as $$
begin new.updated_at = now(); return new; end; $$;

drop trigger if exists trg_touch_place_suggestions on public.place_suggestions;
create trigger trg_touch_place_suggestions
  before update on public.place_suggestions
  for each row execute function public.touch_place_suggestions();

-- Spökkartan — migration: web-push-prenumerationer (notiser till alla)
-- Lagrar varje webbläsares push-prenumeration. Utskick sker server-side i
-- api/send-push.js med service role-nyckeln (förbi RLS).
--
-- Kör i Supabase SQL Editor EN gång.

create table if not exists public.push_subscriptions (
  id          uuid primary key default gen_random_uuid(),
  endpoint    text not null unique,
  p256dh      text not null,
  auth        text not null,
  user_id     uuid references auth.users(id) on delete set null,
  countries   text[] default '{}',          -- tomt = alla länder
  frequency   text default 'instant',
  user_agent  text,
  created_at  timestamptz not null default now()
);

create index if not exists push_subscriptions_endpoint_idx on public.push_subscriptions(endpoint);

alter table public.push_subscriptions enable row level security;

-- Vem som helst får registrera/uppdatera sin egen prenumeration (upsert på endpoint).
drop policy if exists "push_insert_anyone" on public.push_subscriptions;
create policy "push_insert_anyone"
  on public.push_subscriptions for insert
  to anon, authenticated
  with check (true);

drop policy if exists "push_update_anyone" on public.push_subscriptions;
create policy "push_update_anyone"
  on public.push_subscriptions for update
  to anon, authenticated
  using (true) with check (true);

-- Får ta bort sin prenumeration (t.ex. vid avstängning).
drop policy if exists "push_delete_anyone" on public.push_subscriptions;
create policy "push_delete_anyone"
  on public.push_subscriptions for delete
  to anon, authenticated
  using (true);

-- OBS: ingen SELECT-policy -> ingen anon/authenticated kan läsa prenumerationer.
-- Utskicksfunktionen läser med service role-nyckeln som kringgår RLS.
