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
