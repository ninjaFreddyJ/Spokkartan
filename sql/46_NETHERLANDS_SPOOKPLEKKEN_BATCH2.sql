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
