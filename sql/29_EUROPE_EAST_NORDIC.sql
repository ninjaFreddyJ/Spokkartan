-- Spökkartan — Östeuropa, Norden, Centraleuropa (16 platser)
-- Genererad 2026-05-06. Källa: Användarens forskningsrapport.
-- Hoppar över Bran, Hoia-Baciu, Borgvattnet, Häringe, Glimmingehus (redan i db).
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. MOOSHAM CASTLE (Österrike)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'moosham-castle','Moosham Castle','moosham-castle','Österrike','Salzburg, Lungau','Slott',
  47.1011,13.7011,5,false,false,NULL,
  '"Häxornas slott" — över 100 människor torterades ihjäl i häxprocesserna.',
  'Detta slott bar på 1600-talet smeknamnet "Häxornas slott". Det fungerade som administrativt centrum under Salzburgs häxprocesser, där över 100 personer avrättades efter systematisk tortyr. De flesta av de anklagade var fattiga tiggare eller hemlösa som offrades för att blidka kyrkan och aristokratin. De torterades i slottets djupa källarvalv.

Idag rapporterar guider om syner av gestalter i trasiga kläder och ljudet av klagande röster som ber om nåd. Platsen sägs även vara hemsökt av varulvar, en rest av den lokala folktron som blomstrade under rättegångarna.',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. TORPA STENHUS (Sverige)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'torpa-stenhus','Torpa Stenhus','torpa-stenhus','Sverige','Västergötland, Länghem','Borg',
  57.6511,13.2842,4,false,false,NULL,
  'Medeltida borg vid Åsunden — den inmurade flickan och Grå frun.',
  'Denna medeltida borg vid sjön Åsunden är hem för flera klassiska spökhistorier. En av de mest tragiska handlar om "Den inmurade flickan". Enligt legenden lät en slottsherre mura in sin dotter levande efter att hon återvänt från en resa till Danmark, där pesten härjade, av rädsla för att hon skulle sprida smittan. Hennes ande sägs vandra i slottets salar under nätterna.

En annan känd uppenbarelse är "Grå frun", en dotter till en tidigare ägare som dog av sorg efter att hennes far dödat hennes älskade. Slottet fungerar idag som museum, men personalen vittnar ofta om oförklarliga fotsteg och dörrar som öppnas av sig själva.',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. HILL OF CROSSES (Litauen)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'hill-of-crosses','Hill of Crosses (Kryžių kalnas)','hill-of-crosses','Litauen','Šiauliai','Pilgrimsmål',
  56.0153,23.4164,3,true,false,NULL,
  'Litauens kullen med över 100 000 kors — en plats där döda hörs viska under stormiga nätter.',
  'Korsens kulle utanför Šiauliai i Litauen är ett av Europas mest unika religiösa pilgrimsmål, med uppskattningsvis över 100 000 kors. Platsen har djup symbolisk betydelse efter sovjettidens religiösa förtryck och förknippas med en starkt andlig atmosfär.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. ZVÍKOV CASTLE (Tjeckien)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'zvikov-castle','Zvíkov Castle','zvikov-castle','Tjeckien','Södra Böhmen','Slott',
  49.4392,14.1928,4,false,false,NULL,
  'Tjeckiens "kungars slott" från 1200-talet — Markrabbe-tornet är källan till oförklarade fenomen.',
  'Zvíkov är ett av Tjeckiens äldsta gotiska slott (byggt på 1200-talet) vid floden Vltavas möte med Otavan. Slottets Markrabbe-torn (Hláska) är förknippat med en rad paranormala anekdoter — elektronik fungerar inte och husdjur vägrar gå in.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 5. SEDLEC OSSUARY (Tjeckien)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'sedlec-ossuary','Sedlec Ossuary','sedlec-ossuary','Tjeckien','Kutná Hora','Benkyrka',
  49.9617,15.2883,4,false,false,NULL,
  'Tjeckiens "benkyrka" — 40 000 människors skelett dekorerar interiören.',
  'Sedlec Ossuary i Kutná Hora är en romersk-katolsk kapell utsmyckad med skelettben från cirka 40 000 människor — bland annat en gigantisk ljuskrona av människoben. Kvarlevorna kommer främst från digerdöden och Hussitkrigen.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 6. KALMAR SLOTT (Sverige)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'kalmar-slott','Kalmar Slott','kalmar-slott','Sverige','Småland, Kalmar','Slott',
  56.6583,16.3556,3,false,false,NULL,
  'Renässansslott från 1100-talet — Kalmarunionens vagga med flera spökhistorier.',
  'Kalmar Slott är en av Sveriges bäst bevarade renässansslott (grundat på 1100-talet). Det var här Kalmarunionen ingicks 1397. Slottet är förknippat med flera klassiska spökhistorier.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 7. VARBERGS FÄSTNING (Sverige)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'varbergs-fastning','Varbergs Fästning','varbergs-fastning','Sverige','Halland','Fästning',
  57.1056,12.2411,3,false,true,NULL,
  '1200-talsfästning vid Hallandskusten — hem för "Bockstensmannen" och flera spökhistorier.',
  'Varbergs Fästning är en medeltida fästning från 1200-talet som idag rymmer ett museum och vandrarhem. Här finns Bockstensmannen — Sveriges äldsta välbevarade lik från 1300-talet — och en rad lokala spökhistorier.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 8. SKOKLOSTERS SLOTT (Sverige)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'skoklosters-slott','Skoklosters Slott','skoklosters-slott','Sverige','Uppland','Slott',
  59.7042,17.6211,3,false,false,NULL,
  'Barockslott från 1600-talet — det stora slottet som aldrig färdigställdes.',
  'Skoklosters Slott är en av Europas mest bevarade barockslott från 1600-talet — det blev aldrig färdigbyggt vilket bevarar en unik tidskapsel av byggprocesser. Slottet är förknippat med flera spökhistorier.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 9. LANDSKRONA CITADELL (Sverige)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'landskrona-citadell','Landskrona Citadell','landskrona-citadell','Sverige','Skåne, Landskrona','Citadell/Fängelse',
  55.8711,12.8211,3,false,false,NULL,
  'Renässansfästning från 1500-talet — sedermera kvinnofängelse och spinnhus.',
  'Landskrona Citadell är ett renässansfästning från 1500-talet som senare användes som kvinnofängelse och spinnhus. De bevarade cellerna och vallgravarna ger platsen en tung historisk atmosfär.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 10. ERICSBERGS SLOTT (Sverige)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'ericsbergs-slott','Ericsbergs Slott','ericsbergs-slott','Sverige','Sörmland','Slott',
  58.9711,16.2111,3,false,false,NULL,
  'Sörmländskt slott med medeltida ursprung — privat ägt med många spökhistorier.',
  'Ericsbergs Slott i Sörmland har medeltida ursprung och är fortfarande privatägt. Slottet är förknippat med klassiska svenska spökhistorier.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 11. GRIPSHOLMS VÄRDSHUS (Sverige)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'gripsholms-vardshus','Gripsholms Värdshus','gripsholms-vardshus','Sverige','Sörmland, Mariefred','Hotell/Värdshus',
  59.2583,17.2211,3,false,true,NULL,
  'Sveriges äldsta värdshus (1623) i skuggan av Gripsholms slott.',
  'Gripsholms Värdshus i Mariefred är Sveriges äldsta värdshus, drivet sedan 1623. Värdshuset, beläget intill Gripsholms slott, är förknippat med klassiska svenska spökhistorier.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 12. SLUSSENS PENSIONAT (Sverige)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'slussens-pensionat','Slussens Pensionat','slussens-pensionat','Sverige','Bohuslän','Hotell',
  58.2111,11.6111,3,false,true,NULL,
  'Bohuslänskt pensionat med rapporter om paranormal aktivitet.',
  'Slussens Pensionat i Bohuslän är ett historiskt pensionat med rapporter om paranormal aktivitet bland gäster och personal.

(Kort grundtext — kan berikas med lokala källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 13. HOTELL BILAN (Sverige)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'hotell-bilan','Hotell Bilan','hotell-bilan','Sverige','Värmland, Karlstad','Tidigare fängelse',
  59.3811,13.5111,3,false,true,NULL,
  'Karlstads gamla länsfängelse — idag hotell med klassisk svensk spökhistoria.',
  'Hotell Bilan i Karlstad är inrymt i det gamla länsfängelset från 1800-talet. Idag är det ett hotell med rapporter om paranormal aktivitet i de gamla cellerna.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 14. SCHEFFLERSKA PALATSET (Sverige)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'schefflerska-palatset','Schefflerska Palatset','schefflerska-palatset','Sverige','Stockholm','Palats',
  59.3394,18.0583,3,false,false,NULL,
  '"Spökslottet" på Drottninggatan i Stockholm — en av Sveriges mest klassiska spökhistorier.',
  'Schefflerska Palatset (även kallat "Spökslottet") på Drottninggatan i Stockholm har en av Sveriges mest klassiska spökhistorier — om alkemisten Wolfgang Scheffler och hans dotter.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 15. FRAMMEGÅRDEN (Sverige)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'frammegarden','Frammegården','frammegarden','Sverige','Värmland','Historisk gård',
  59.8411,12.0211,3,true,false,NULL,
  'Värmländsk historisk gård med lokala spökhistorier.',
  'Frammegården i Värmland är en historisk gård som är förknippad med lokala spökhistorier.

(Kort grundtext — kan berikas med lokala källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 16. NATIONAL FILM ARCHIVE (Australien — anatomisinst.)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'national-film-archive-canberra','National Film Archive (tidigare anatomisinst.)','national-film-archive-canberra','Australien','ACT, Canberra','Tidigare anatomisinst.',
  -35.2831,149.1214,3,false,false,NULL,
  'Australiens filmsamling i tidigare anatomiskt institut — kvarlevor från forskning vilar fortfarande i källaren.',
  'National Film and Sound Archive i Canberra är inrymt i en byggnad som tidigare var Australiens centrala anatomiska institut. Mänskliga kvarlevor från äldre forskning sägs fortfarande finnas i källarvalven.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
