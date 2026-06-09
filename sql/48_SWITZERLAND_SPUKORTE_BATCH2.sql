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
