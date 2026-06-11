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
