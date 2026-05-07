-- Spökkartan — Sydamerika: Brasilien, Chile, Argentina, Peru (15 platser)
-- Genererad 2026-05-06. Källa: Användarens forskningsrapport.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. EDIFÍCIO JOELMA (Brasilien)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'edificio-joelma','Edifício Joelma','edificio-joelma','Brasilien','São Paulo','Kontorshus',
  -23.5511,-46.6389,5,true,false,NULL,
  'Branden 1974 dödade 189 människor — och innan dess "Brunnsmordet" på 1940-talet.',
  'Denna byggnad i São Paulo är känd för en av de största civila katastroferna i landets historia. 1974 bröt en brand ut i kontorshuset som krävde 189 människors liv. Innan katastrofen inträffade hade platsen redan ett mörkt rykte. På 1940-talet hade en professor mördat sin mor och sina systrar på samma plats och dumpat kropparna i en brunn på bakgården, ett dåd som blev känt som "Brunnsmordet".

De som överlevde branden och senare hyresgäster har rapporterat om skepnader av människor som försöker fly undan lågorna, ljudet av desperation i hissarna och synen av de så kallade "13 själarna" — personer som dog instängda i en hiss och vars identiteter aldrig fastställdes.',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. PISAGUA (Chile)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'pisagua','Pisagua','pisagua','Chile','Tarapacá','Övergiven stad',
  -19.5931,-70.2131,4,true,false,NULL,
  'Pinochets koncentrationsläger — massgravarna upptäcktes först 1990.',
  'Denna lilla stad i norra Chile fungerade som ett koncentrationsläger under Pinochets diktatur på 1970-talet, samt vid tidigare tillfällen för politiska fångar. Många av de "försvunna" avrättades här och begravdes i anonyma massgravar som upptäcktes först på 1990-talet.

Staden beskrivs av besökare som en plats med en nästan fysiskt påtaglig tyngd av sorg. Vittnen har rapporterat om ljudet av marscherande fötter, skrik av agony från de gamla barackerna och syner av fångar som står längs stranden och stirrar ut över havet. Pisagua är idag en plats där politiskt minne och paranormala upplevelser smälter samman.',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. LA NORIA (Chile)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'la-noria-chile','La Noria','la-noria-chile','Chile','Atacamaöknen','Gruvstad/Ruin',
  -20.3011,-69.7842,5,true,false,NULL,
  'Övergiven salpetergruvstad i Atacamaöknen — gravar har grävts upp och kvarlevor exponeras.',
  'En övergiven salpetergruvstad mitt i Atacamaöknen. Livet här var brutalt för de arbetare som levde under förhållanden som gränsade till slaveri under 1800-talet. Barnarbete och dödsolyckor var vardag.

Gruvkyrkogården är särskilt skrämmande eftersom många gravar har grävts upp av gravplundrare, vilket lämnat mänskliga kvarlevor exponerade för solen. Legenden säger att de döda stiger upp ur sina gravar på natten och vandrar in i den tomma staden.

Turister har tagit fotografier som sägs visa skugglika gestalter som rör sig bland ruinerna, och rösterna från arbetare sägs fortfarande höras från de djupa schaktens ingångar.',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. VALE DO ANHANGABAÚ (Brasilien)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'vale-do-anhangabau','Vale do Anhangabaú','vale-do-anhangabau','Brasilien','São Paulo','Park/Torg',
  -23.5472,-46.6358,4,true,false,NULL,
  '"Djävulens flod" på tupi — São Paulos centrala dal med koppling till självmord och ursprungsbefolkningens lidande.',
  'Namnet på detta centrala område i São Paulo kommer från språket tupi och betyder "Djävulens flod" eller "Andens dal". Enligt lokala legender är dalen förbannad sedan ursprungsbefolkningens tid, då många dog i strider mot kolonisatörer vid den bäck som då rann genom dalen.

Under 1900-talet har Viaduto do Chá blivit en ökänd plats för självmord. Människor som arbetar i området nattetid rapporterar om en känsla av plötslig och oförklarlig depression, syner av ursprungsfolk som stirrar från skuggorna och ljudet av trummor som tycks komma från marken.',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 5. EDIFÍCIO MARTINELLI (Brasilien)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'edificio-martinelli','Edifício Martinelli','edificio-martinelli','Brasilien','São Paulo','Skyskrapa',
  -23.5456,-46.6331,3,true,false,NULL,
  'São Paulos första skyskrapa (1929) — italienska arbetares spöken sägs vandra i tornet.',
  'Edifício Martinelli är São Paulos första skyskrapa, byggd 1929 av den italienska invandraren Giuseppe Martinelli. Byggnaden är förknippad med urbana legender om de italienska arbetare som dog under bygget.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 6. BAIRRO DA LIBERDADE (Brasilien)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'bairro-da-liberdade','Bairro da Liberdade','bairro-da-liberdade','Brasilien','São Paulo','Stadskvarter',
  -23.5583,-46.6358,3,true,false,NULL,
  'São Paulos japanska kvarter — byggt på en gammal galge och avrättningsplats.',
  'Bairro da Liberdade i São Paulo är idag stadens japanska kvarter, men har en mörk historia som plats för avrättningar under kolonialtiden. Många hängdes på galgen där Largo da Liberdade ligger idag.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 7. CASTELINHO DO FLAMENGO (Brasilien)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'castelinho-flamengo','Castelinho do Flamengo','castelinho-flamengo','Brasilien','Rio de Janeiro','Tidigare bostad',
  -22.9392,-43.1767,3,false,false,NULL,
  'Rios "lilla slott" — herrgård byggd 1916 med rapporter om paranormal aktivitet.',
  'Castelinho do Flamengo (även känt som Casa Joaquim da Silva Cardoso) är en herrgård i Rio de Janeiro byggd 1916 med en mörk historia kopplad till sin första ägare.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 8. ARCO DO TELLES (Brasilien)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'arco-do-telles','Arco do Telles','arco-do-telles','Brasilien','Rio de Janeiro','Gränd',
  -22.9031,-43.1742,3,true,false,NULL,
  'Historisk gränd i Rio centro — legender om "Donna Branca" och kolonialtidens lidande.',
  'Arco do Telles är en historisk gränd i Rio de Janeiros centrum, byggd på 1700-talet. Området är förknippat med flera urbana legender, bland annat den om "Donna Branca".

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 9. RECOLETA CEMETERY (Argentina)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'recoleta-cemetery','Recoleta Cemetery','recoleta-cemetery','Argentina','Buenos Aires','Kyrkogård',
  -34.5811,-58.3931,3,false,false,NULL,
  'Buenos Aires berömda kyrkogård — Eva Peróns vilorum och Rufina Cambacéres tragiska legend.',
  'Recoleta Cemetery i Buenos Aires är en av världens vackraste kyrkogårdar med över 4 600 mausoleer, bland annat Eva Peróns. Den är förknippad med flera klassiska spökhistorier, framför allt om Rufina Cambacéres som påstås ha begravts levande 1902.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 10. CASA MATUSITA (Peru)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'casa-matusita','Casa Matusita','casa-matusita','Peru','Lima','Kontorsbyggnad',
  -12.0558,-77.0358,4,true,false,NULL,
  'Limas mest hemsökta byggnad — människor påstås bli galna efter att ha besökt andra våningen.',
  'Casa Matusita i Lima, Peru, är en av Sydamerikas mest beryktade hemsökta byggnader. Lokala legender hävdar att människor som besökt andra våningen blivit galna eller försvunnit.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 11. SAN FRANCISCO CATACOMB (Peru)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'san-francisco-catacomb','San Francisco-katakomberna','san-francisco-catacomb','Peru','Lima','Katakomber',
  -12.0453,-77.0272,4,false,false,NULL,
  'Limas franciskanerkatakomber — kvarlevor från 25 000 personer i geometriska mönster.',
  'San Francisco-klostret i Lima har ett av Sydamerikas mest sevärda ossuarier — katakomberna innehåller skelettkvarlevor från cirka 25 000 personer arrangerade i geometriska mönster.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 12. PALACIO DE AGUAS (Argentina)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'palacio-de-aguas','Palacio de Aguas Corrientes','palacio-de-aguas','Argentina','Buenos Aires','Palats',
  -34.6011,-58.3942,3,false,false,NULL,
  'Buenos Aires "vattenpalats" från 1894 — ett av världens vackraste industribyggnader.',
  'Palacio de Aguas Corrientes är en spektakulär vattenreserv från 1894 i Buenos Aires, känt som ett av världens vackraste industribyggnader. Den är förknippad med lokala paranormala anekdoter.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 13. HUMBERSTONE (Chile)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'humberstone','Humberstone','humberstone','Chile','Tarapacá','Gruvstad/Ruin',
  -20.2033,-69.7942,4,true,false,NULL,
  'UNESCO-skyddad spökstad i Atacamaöknen — övergiven 1960 efter salpetermarknadens kollaps.',
  'Humberstone är en av världens bäst bevarade salpeterbrytarstäder, övergiven 1960 efter att marknaden kollapsat. Den är ett UNESCO-världsarv och en populär plats för paranormala undersökningar.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 14. IGREJA N.S. DAS DORES (Brasilien)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'igreja-ns-das-dores','Igreja N.S. das Dores','igreja-ns-das-dores','Brasilien','Porto Alegre','Kyrka',
  -30.0342,-51.2331,3,true,false,NULL,
  'Porto Alegres "smärtornas kyrka" — den mest klassiska brasilianska spökhistorien om huvudet i tornet.',
  'Igreja Nossa Senhora das Dores i Porto Alegre är förknippad med en klassisk brasiliansk spökhistoria om ett mumifierat huvud som sägs ha förvarats i kyrkans torn.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 15. CHACO CANYON SHIP (legend)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'chaco-canyon-ship','Chaco Canyon Ship (Legend)','chaco-canyon-ship','Brasilien','Mato Grosso','Spökskepp (legend)',
  -16.0111,-56.0111,3,true,false,NULL,
  'Legend om ett spökskepp i Mato Grossos våtmarker — sett av flodfolket vid fullmåne.',
  'Lokal legend i Mato Grosso om ett spökskepp som ska synas vid fullmåne i Pantanal-områdets våtmarker.

(Kort grundtext — kan berikas med lokala källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
