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
  'beelitz-heilstaetten','Beelitz-Heilstätten','beelitz-heilstaetten','Tyskland','Brandenburg, Beelitz','Sanatorium',
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
