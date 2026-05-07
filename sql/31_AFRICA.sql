-- Spökkartan — Afrika: Sydafrika, Egypten, Namibia, Moçambique (19 platser)
-- Genererad 2026-05-06. Källa: Användarens forskningsrapport.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. CASTLE OF GOOD HOPE (Sydafrika)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'castle-good-hope','Castle of Good Hope','castle-good-hope','Sydafrika','Western Cape, Kapstaden','Fästning',
  -33.9258,18.4311,5,false,false,NULL,
  'Sydafrikas äldsta byggnad — guvernör van Noodts förbannelse efter sju soldaters avrättning.',
  'Detta femkantiga fort i Kapstaden är landets äldsta existerande byggnad, uppfört av det holländska Ostindiska kompaniet på 1600-talet. Fortet var en central plats för både försvar och brutala bestraffningar av slavar och soldater.

Den mest kända hemsökelsen är guvernör Pieter Gysbert van Noodt, som var känd för sin grymhet. Enligt legenden dömde han sju soldater till döden för desertering, men vägrade dem nåd trots att han hade rätten att ge den. Vid galgen ska en av de dömda ha ropat en förbannelse över guvernören och krävt att han skulle inställa sig inför Guds domstol. Samma dag hittades van Noodt död vid sitt skrivbord med ett uttryck av ren terror i ansiktet.

Hans röst hörs ofta klaga i fortets trånga korridorer. Ett annat fenomen är en spöklik svart hund som sägs dyka upp på borggården och attackera väktare innan den går upp i rök.',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. KEMPTON PARK HOSPITAL (Sydafrika)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'kempton-park-hospital','Kempton Park Hospital','kempton-park-hospital','Sydafrika','Gauteng, Johannesburg','Övergivet sjukhus',
  -26.0967,28.2311,5,true,false,NULL,
  'Stängdes oväntat på annandag jul 1996 — allt lämnades kvar.',
  'Detta sjukhus i Johannesburg stängdes oväntat på annandag jul 1996 och har sedan dess lämnats i ett tillstånd av förfall. Det unika med sjukhuset är att nästan allt lämnades kvar: operationsbord, sjukhusjournaler och mediciner.

Det har blivit en av de mest populära platserna för urbana utforskare och spökjägare. Besökare har filmat sängar som rör sig av sig själva och rapporterat om syner av sjuksköterskor i gammaldags uniformer som vandrar i de mörka korridorerna. En särskild rädsla finns kring den gamla barnavdelningen, där ljudet av spädbarn som gråter ofta hörs trots att byggnaden är tom.

Den tunga energin på platsen sägs vara en manifestation av de tusentals liv som passerat genom sjukhuset under dess verksamma tid.',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. BARON EMPAIN PALACE (Egypten)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'baron-empain-palace','Baron Empain Palace','baron-empain-palace','Egypten','Heliopolis, Kairo','Palats',
  30.0867,31.3311,4,false,false,NULL,
  'Belgisk barons palats i Kairo inspirerat av Angkor Wat — sataniska ritualer på 1990-talet.',
  'Detta palats i Heliopolis, Kairo, ritades av den belgiske baronen Édouard Empain och inspirerades av templen i Angkor Wat och hinduiska helgedomar. Efter baronens död 1929 lämnades palatset att förfalla, vilket födde rykten om hemsökelser.

Det sägs att baronen och hans syster, som dog under oklara omständigheter i palatset, fortfarande vandrar där. Under 1990-talet blev palatset centrum för en nationell skandal då ungdomar anklagades för att utföra "sataniska riter" i dess källare.

Grannar har rapporterat om ljus som tänds och släcks i de tomma rummen och doften av rökelse som sprider sig från trädgården nattetid.',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. KOLMANSKOP (Namibia)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'kolmanskop','Kolmanskop','kolmanskop','Namibia','Karas','Spökstad',
  -26.7042,15.2311,5,false,false,NULL,
  'Tysk diamantgruvstad halvbegravd i öknen — surrealistisk spökstad övergiven på 1950-talet.',
  'Denna stad var en gång ett blomstrande centrum för diamantbrytning i den namibiska öknen. När diamanterna tog slut på 1950-talet övergavs staden helt till öknen. Idag är de ståtliga tyska husen halvfulla med sand.

Denna surrealistiska miljö sägs vara hemsökt av de gruvarbetare som dog under hårda förhållanden och av tyska kolonisatörer som inte velat lämna sina forna hem. Besökare har beskrivit ljudet av röster som talar tyska på vinden i det gamla sjukhuset och syner av människor i tidstypiska kläder som ser ut genom de krossade fönstren innan de försvinner i sanden.',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 5. LORD MILNER HOTEL (Sydafrika)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'lord-milner-hotel','Lord Milner Hotel','lord-milner-hotel','Sydafrika','Western Cape, Matjiesfontein','Hotell',
  -33.2242,20.5842,3,false,true,NULL,
  'Viktorianskt hotell från 1899 i Karoo — sägs vara hemsökt av en kvinna i blått.',
  'Lord Milner Hotel i Matjiesfontein är ett bevarat viktorianskt hotell från 1899 som är förknippat med klassiska sydafrikanska spökhistorier, bl.a. om en kvinna i blått som sägs vandra i korridorerna.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 6. NOTTINGHAM ROAD HOTEL (Sydafrika)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'nottingham-road-hotel','Rawdons / Nottingham Road Hotel','nottingham-road-hotel','Sydafrika','KwaZulu-Natal','Hotell',
  -29.3511,30.0011,3,false,true,NULL,
  'Hotell i KwaZulu-Natal hemsökt av "Charlotte" — en prostituerad som dog 1880-talet.',
  'Hotellet i Nottingham Road i KwaZulu-Natal är förknippat med spökhistorien om Charlotte, en kvinna som dog där på 1880-talet. Rum 10 är välkänt för paranormala anekdoter.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 7. ERASMUS CASTLE (Sydafrika)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'erasmus-castle','Erasmus Castle','erasmus-castle','Sydafrika','Pretoria','Palats/Villa',
  -25.8111,28.2511,3,false,false,NULL,
  'Pretorias slottsliknande villa från 1903 — barnaande sägs spela piano nattetid.',
  'Erasmus Castle i Pretoria är en slottsliknande villa byggd 1903 av familjen Erasmus. Lokala legender berättar om ett barn som spelar piano nattetid.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 8. OLD PRESIDENCY (Sydafrika)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'old-presidency','Old Presidency','old-presidency','Sydafrika','Free State, Bloemfontein','Tidigare residens',
  -29.1111,26.2111,3,false,false,NULL,
  'Boerrepublikens presidentvilla från 1885 — viktorianskt residens med klassiska spökhistorier.',
  'Old Presidency i Bloemfontein är ett bevarat presidentresidens från 1885 — den f.d. Oranje-fristatens regeringssäte. Idag museum med flera klassiska spökhistorier.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 9. SOMERSET HOSPITAL (Sydafrika)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'somerset-hospital','Somerset Hospital','somerset-hospital','Sydafrika','Western Cape, Kapstaden','Sjukhus',
  -33.9042,18.4111,3,false,false,NULL,
  'Sydafrikas äldsta sjukhus (1818) — många klassiska sjukhusspökhistorier.',
  'Somerset Hospital är Sydafrikas äldsta sjukhus, byggt 1818 i Kapstaden. Sjukhuset är förknippat med klassiska spökhistorier från koloniala tiden.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 10. GREY HIGH SCHOOL (Sydafrika)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'grey-high-school','Grey High School','grey-high-school','Sydafrika','Eastern Cape, Port Elizabeth','Skola',
  -33.9511,25.5942,3,false,false,NULL,
  'Sydafrikas äldsta pojkskola (1856) — sägs ha en lärar-ande som vandrar i korridorerna.',
  'Grey High School i Port Elizabeth är Sydafrikas äldsta pojkskola, grundad 1856. Skolan är förknippad med lokala spökhistorier.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 11. FORT FREDERICK (Sydafrika)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'fort-frederick','Fort Frederick','fort-frederick','Sydafrika','Eastern Cape, Port Elizabeth','Fästning',
  -33.9611,25.6111,3,true,false,NULL,
  'Brittisk fästning från 1799 i Port Elizabeth — den äldsta brittiska byggnaden i Sydafrika.',
  'Fort Frederick byggdes 1799 av brittiska trupper och är den äldsta brittiska byggnaden i Sydafrika. Fortet är förknippat med lokala paranormala anekdoter.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 12. VALLEY OF THE KINGS (Egypten)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'valley-of-the-kings','Konungarnas dal','valley-of-the-kings','Egypten','Luxor','Gravområde',
  25.7402,32.6014,4,false,false,NULL,
  'Egyptens kungars vilorum — Tutankhamons förbannelse och egyptologins mest kända spökhistorier.',
  'Konungarnas dal vid Luxor är gravplatsen för faraonerna under det egyptiska Nya Riket. Området är förknippat med klassiska egyptologiska spökhistorier — främst Tutankhamons förbannelse efter Howard Carters upptäckt 1922.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 13. PYRAMIDS OF GIZA (Egypten)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'pyramids-of-giza','Pyramiderna i Giza','pyramids-of-giza','Egypten','Giza','Monument',
  29.9792,31.1342,3,false,false,NULL,
  'Världens äldsta monument — paranormala anekdoter sedan antikens tid.',
  'Pyramiderna i Giza är världens äldsta bevarade monument och har varit föremål för paranormala anekdoter och teorier sedan antikens tid.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 14. ELIZABETH BAY (Namibia)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'elizabeth-bay','Elizabeth Bay','elizabeth-bay','Namibia','Karas','Spökstad',
  -26.9211,15.1811,4,false,false,NULL,
  'Övergiven diamantgruvstad i Namibias spärrade Diamond Area — sand sväljer den långsamt.',
  'Elizabeth Bay är en övergiven diamantgruvstad i Namibias Sperrgebiet (spärrade diamantområde). Liksom Kolmanskop övergavs den när diamanterna tog slut.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 15. SKELETON COAST RIG (Namibia)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'skeleton-coast-rig','Skeleton Coast Rig (övergiven oljerigg)','skeleton-coast-rig','Namibia','Skeleton Coast','Övergiven oljerigg',
  -20.0011,13.0011,3,true,false,NULL,
  'Övergiven oljerigg på Skeleton Coast — kustlinjen där skepp och människor försvunnit i sekler.',
  'Övergiven oljerigg på Skeleton Coast — den ökända "Skelettkusten" i Namibia där hundratals skeppsvrak och historier om försvunna besättningar gett kuststräckan dess namn.

(Kort grundtext — kan berikas med lokala källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 16. GRANDE HOTEL BEIRA (Moçambique)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'grande-hotel-beira','Grande Hotel Beira','grande-hotel-beira','Moçambique','Beira, Sofala','Övergivet hotell',
  -19.8311,34.8311,4,true,false,NULL,
  'Övergivet 5-stjärnigt lyxhotell från 1950-talet — bebos nu av över 3 000 hemlösa.',
  'Grande Hotel i Beira byggdes på 1950-talet som ett 5-stjärnigt lyxhotell men gick i konkurs efter bara några år. Idag bebos den övergivna byggnaden av tusentals hemlösa människor och är förknippad med en mängd urbana legender.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 17. VREDEHOEK QUARRY (Sydafrika)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'vredehoek-quarry','Vredehoek Quarry','vredehoek-quarry','Sydafrika','Western Cape, Kapstaden','Gruva',
  -33.9442,18.4211,3,true,false,NULL,
  'Övergiven gruva vid Tafelbergets fot — lokala spökhistorier kopplade till olyckor.',
  'Vredehoek Quarry är ett övergivet stenbrott vid Tafelbergets fot i Kapstaden, förknippat med lokala spökhistorier om dödsolyckor under driften.

(Kort grundtext — kan berikas med lokala källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 18. AFRICANA LIBRARY (Sydafrika)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'africana-library','Africana Library','africana-library','Sydafrika','Northern Cape, Kimberley','Bibliotek',
  -28.7411,24.7642,3,false,false,NULL,
  'Diamantstadens viktorianska bibliotek från 1882 — ovanliga ljudfenomen rapporteras nattetid.',
  'Africana Library i Kimberley är ett av Sydafrikas viktigaste viktorianska bibliotek (byggt 1882) och innehåller en av kontinentens viktigaste samlingar afrikansk litteratur.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 19. TOKAI MANOR HOUSE (Sydafrika)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'tokai-manor-house','Tokai Manor House','tokai-manor-house','Sydafrika','Western Cape, Kapstaden','Herrgård',
  -34.0583,18.4256,4,true,false,NULL,
  'Cape Dutch-herrgård från 1796 — den galopperande ryttaren som dog på vadslagning.',
  'Tokai Manor House är en bevarad Cape Dutch-herrgård från 1796 utanför Kapstaden. Den klassiska spökhistorien handlar om Frederick Eksteen som dog när han på vadslagning red sin häst uppför husets trappa nyårsafton 1791.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
