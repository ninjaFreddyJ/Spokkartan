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
