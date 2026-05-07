-- Spökkartan — Sydeuropa: Italien, Spanien, Portugal (18 platser)
-- Genererad 2026-05-06. Källa: Användarens forskningsrapport.
-- Hoppar över Poveglia (redan i db).
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. CORTIJO JURADO (Spanien)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'cortijo-jurado','Cortijo Jurado','cortijo-jurado','Spanien','Andalusien, Málaga','Herrgård',
  36.7211,-4.5511,5,true,false,NULL,
  'Andalusiens "hemsökta hus" — legend om rituella mord på unga kvinnor i underjordiska gångar.',
  'Denna herrgård i närheten av Málaga är känd som "det hemsökta huset". Den byggdes av familjen Heredia, en av regionens rikaste familjer, under 1800-talet. Enligt lokala legender var familjen inblandad i rituella mord på unga kvinnor som ska ha kidnappats och hållits fångna i hemliga underjordiska gångar.

Paranormala utredare har genom åren rapporterat om oförklarliga ljud av tunga kedjor som släpas över golven, syner av flickor i vita klänningar och ljudet av hjärtskärande skrik från källaren. Byggnaden står idag som en ruin och fungerar som en mörk påminnelse om maktens korruption.',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. BELCHITE (Spanien)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'belchite','Belchite (ruinstad)','belchite','Spanien','Aragón, Zaragoza','Ruinstad',
  41.3033,-0.7511,5,false,false,NULL,
  'Stad utplånad i spanska inbördeskriget 1937 — Franco lät ruinerna stå som monument.',
  'Under det spanska inbördeskriget 1937 utplånades staden Belchite i ett av krigets blodigaste slag. Över 5 000 människor dog i spillrorna. Istället för att riva ruinerna lät Franco-regimen dem stå kvar som ett monument.

Idag är Belchite ett centrum för paranormal forskning. EVP-inspelningar (Electronic Voice Phenomena) gjorda på platsen sägs innehålla ljudet av flygplan, bomber som faller och desperata rop på hjälp från soldater. Besökare har vittnat om syner av två kvinnor i kläder från 1930-talet som plötsligt dyker upp vid ruinerna av kyrkan San Martín bara för att sekunderna senare lösas upp i intet.',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. CAPELA DOS OSSOS (Portugal)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'capela-dos-ossos-evora','Capela dos Ossos','capela-dos-ossos-evora','Portugal','Évora','Benkapell',
  38.5689,-7.9108,4,false,false,NULL,
  '5 000 munk- och invånarbeen i kapellets väggar — "vi väntar på dina".',
  'Belägen i Évora, byggdes denna kapell av en franciskansk munk på 1500-talet som ville påminna stadens invånare om livets förgänglighet (memento mori). Väggarna och pelarna är täckta av ben och kranier från över 5 000 munkar och invånare.

Trots sin roll som en plats för kontemplation, rapporterar många besökare om en tung energi och syner av spöklika gestalter som rör sig mellan benpelarna. Inskriptionen vid ingången — "Vi ben som är här, väntar på dina" — sätter tonen för en upplevelse som för många gränsar till det övernaturliga.',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. COLOSSEUM (Italien)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'colosseum','Colosseum','colosseum','Italien','Rom','Antik ruin',
  41.8902,12.4922,3,false,false,NULL,
  'Romarrikets blodiga arena — 500 000 människor och miljontals djur dödades här.',
  'Colosseum i Rom var arenan för gladiatorspel under det romerska riket. Det uppskattas att över 500 000 människor och miljontals djur dödades på platsen under dess driftstid. Andetro och paranormala anekdoter har funnits i århundraden.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 5. HOTEL BURCHIANTI (Italien)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'hotel-burchianti','Hotel Burchianti','hotel-burchianti','Italien','Florens, Toscana','Hotell',
  43.7742,11.2511,3,false,true,NULL,
  'Hotell i centrala Florens — gäster rapporterar regelbundet om paranormal aktivitet.',
  'Hotel Burchianti i Florens är ett historiskt hotell där gäster rapporterar paranormal aktivitet, bland annat en "Dam i blått" som förekommer i de äldre rummen.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 6. CATACOMBE DEI CAPPUCCINI (Italien)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'catacombe-cappuccini','Catacombe dei Cappuccini','catacombe-cappuccini','Italien','Palermo, Sicilien','Ossuarium',
  38.1117,13.3392,5,false,false,NULL,
  '8 000 mumifierade lik i Palermos kapucinerkatakomber.',
  'Catacombe dei Cappuccini i Palermo är ett av världens mest beryktade ossuarier. Mer än 8 000 mumifierade kroppar visas hängande på väggarna eller liggande i öppna kistor — många i sina ursprungliga kläder.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 7. LA MUSSARA (Spanien)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'la-mussara','La Mussara','la-mussara','Spanien','Tarragona, Katalonien','Övergiven by',
  41.2511,1.0542,4,true,false,NULL,
  'Övergiven katalansk by med rykte som en plats där tiden och rymden förvrids.',
  'La Mussara är en övergiven by i bergen i Tarragona-provinsen. Byn är förknippad med urbana legender om att människor försvinner och tiden förvrids.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 8. PALACIO DE LINARES (Spanien)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'palacio-de-linares','Palacio de Linares','palacio-de-linares','Spanien','Madrid','Palats',
  40.4194,-3.6925,4,false,false,NULL,
  'Madrids hemsökta palats — legenden om en flicka instängd i en hemlig kammare.',
  'Palacio de Linares (idag Casa de América) i Madrid är ett av Spaniens mest beryktade hemsökta palats. EVP-inspelningar gjorda i palatset under 1990-talet skapade nationell uppmärksamhet.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 9. PREVENTORIO BUSOT (Spanien)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'preventorio-busot','Preventorio Busot','preventorio-busot','Spanien','Alicante','Tidigare sanatorium',
  38.4811,-0.4211,4,true,false,NULL,
  'Övergivet sanatorium i Alicante — tuberkulospatienter dog här i tusental.',
  'Preventorio Busot var ett tuberkulossanatorium under tidigt 1900-tal i Alicante. Komplexet är delvis övergivet och förknippat med urbana legender.

(Kort grundtext — kan berikas med lokala källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 10. QUINTA DA JUNCOSA (Portugal)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'quinta-da-juncosa','Quinta da Juncosa','quinta-da-juncosa','Portugal','Penafiel','Herrgård',
  41.2011,-8.2811,4,true,false,NULL,
  'Övergiven portugisisk herrgård — en av Portugals mest omtalade hemsökta platser.',
  'Quinta da Juncosa är en övergiven herrgård i norra Portugal som är välkänd i portugisisk paranormal folktro.

(Kort grundtext — kan berikas med lokala källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 11. BEAU-SÉJOUR PALACE (Portugal)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'beau-sejour-palace','Beau-Séjour Palace','beau-sejour-palace','Portugal','Lissabon','Palats',
  38.7411,-9.1811,3,false,false,NULL,
  'Lissabons palats med rapporter om paranormal aktivitet.',
  'Beau-Séjour Palace är ett historiskt palats i Lissabon med koppling till lokala paranormala anekdoter.

(Kort grundtext — kan berikas med lokala källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 12. CASTELINHO ESTORIL (Portugal)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'castelinho-estoril','Castelinho do Estoril','castelinho-estoril','Portugal','Estoril','Villa',
  38.7011,-9.3942,3,true,false,NULL,
  'Övergiven villa nära Lissabon — populär plats för paranormala undersökningar.',
  'Castelinho do Estoril är en övergiven villa nära Lissabon som ofta nämns i portugisiska sammanställningar av hemsökta platser.

(Kort grundtext — kan berikas med lokala källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 13. CRACO (Italien)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'craco','Craco (övergiven stad)','craco','Italien','Basilicata','Övergiven stad',
  40.3783,16.4411,4,true,false,NULL,
  'Italiensk spökstad övergiven efter jordskred — använd som filmscen i Passionen och 007.',
  'Craco är en medeltida stad i Basilicata som övergavs efter jordskred och jordbävningar. Idag står den tom som en spökstad och har använts som filmscen för bl.a. Mel Gibsons Passionen och Quantum of Solace.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 14. PENTEDATTILO (Italien)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'pentedattilo','Pentedattilo','pentedattilo','Italien','Kalabrien','Spökstad',
  37.9542,15.7511,4,true,false,NULL,
  'Spökstad i Kalabrien — legend om en bröllopsmassaker 1686.',
  'Pentedattilo är en delvis övergiven by i Kalabrien som är förknippad med legenden om Alberti-massakern 1686, då en lokal feodalherre lät döda flera medlemmar av en rivaliserande familj på bröllopsdagen.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 15. BUSSANA VECCHIA (Italien)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'bussana-vecchia','Bussana Vecchia','bussana-vecchia','Italien','Ligurien','Konstnärsby/Ruin',
  43.8311,7.8211,3,true,false,NULL,
  'Stad övergiven efter jordbävningen 1887 — idag konstnärskoloni i ruinerna.',
  'Bussana Vecchia övergavs efter en förödande jordbävning 1887. På 1960-talet etablerades en internationell konstnärskoloni i ruinerna.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 16. CONSONNO (Italien)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'consonno','Consonno','consonno','Italien','Lombardiet','Övergivet nöjesfält',
  45.8111,9.4011,4,true,false,NULL,
  'Italiens Las Vegas — drömnöjesstad övergiven efter jordskred 1976.',
  'Consonno var en italiensk nöjesstad i Lombardiet som byggdes på 1960-talet av en excentrisk affärsman. Efter ett jordskred 1976 övergavs den och står idag som en surrealistisk ruin.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 17. SANT'ANNA DI STAZZEMA (Italien)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'santanna-stazzema','Sant''Anna di Stazzema (minnesplats)','santanna-stazzema','Italien','Toscana','Minnesplats/Ruin',
  43.9711,10.2711,3,true,false,NULL,
  'Toskansk by där SS massakrerade 560 civila 1944 — idag minnesplats.',
  'Sant''Anna di Stazzema är en by i Toscana där tyska SS-trupper mördade 560 civila den 12 augusti 1944. Idag är platsen ett officiellt minnesmonument. OBS: Bör behandlas med respekt som minnesplats, inte som spökattraktion.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 18. BALESTRINO (Italien)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'balestrino','Balestrino','balestrino','Italien','Ligurien','Övergiven stad',
  44.1242,8.1711,4,true,false,NULL,
  'Spökby på en bergssluttning i Ligurien — övergavs efter jordbävningen 1887.',
  'Balestrino är en övergiven medeltida by i Ligurien som lämnades efter jordbävningen 1887. Idag är den övre delen av byn helt obebodd.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
