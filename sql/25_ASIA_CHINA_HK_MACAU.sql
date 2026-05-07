-- Spökkartan — Asien: Kina, Hongkong, Macau (20 platser)
-- Genererad 2026-05-06. Källa: Användarens forskningsrapport.
-- VIKTIGT: Detaljerade beskrivningar kommer från användarens rapport.
-- Platser med kort grundtext kan berikas vidare när Wikipedia är på allowlist.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. CHAONEI 81 (Peking)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'chaonei-81','Chaonei 81','chaonei-81','Kina','Peking','Herrgård',
  39.9221,116.4258,5,true,false,NULL,
  'Övergivet barockresidens i centrala Peking — en av Kinas mest seglivade urbana legender.',
  'Denna barockinspirerade herrgård i centrala Peking är föremål för en av landets mest seglivade urbana legender. Den historiska grunden vilar på berättelsen om en officer inom Kuomintang som flydde till Taiwan 1949 och lämnade kvar sin fru eller konkubin i den kaosartade slutfasen av det kinesiska inbördeskriget. Kvinnan, som kände sig sviken och lämnad åt de framryckande kommuniststyrkorna, sägs ha tagit sitt liv genom hängning i byggnadens övre våningar.

Sedan dess har lokala invånare och besökare rapporterat om oförklarliga fenomen, särskilt under kalla och blåsiga nätter. Vittnesmål beskriver genomträngande skrik som ekar genom de tomma korridorerna och ljudet av glas som krossas, trots att byggnaden varit förseglad. En intressant detalj är rapporterna om temperaturfall — det hävdas att temperaturen vid ingången till huset är flera grader lägre än i den omedelbara omgivningen, även under Pekings heta sommarmånader.

En incident från 2001 involverade tre byggarbetare som arbetade vid den närliggande Senhao-byggnaden. De ska ha tagit sig in i Chaonei 81:s källare på fyllan och aldrig setts till igen, vilket ytterligare har stärkt platsens rykte som en "mörk portal" i stadens hjärta.',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. FÖRBJUDNA STADEN (Peking)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'forbidden-city','Förbjudna Staden','forbidden-city','Kina','Peking','Palats',
  39.9163,116.3972,4,false,false,NULL,
  '600 år av intriger, lönnmord och förgiftningar — kejserliga andar dröjer kvar.',
  'Under mer än 600 år fungerade detta massiva palatskomplex som det absoluta maktcentrumet för Ming- och Qing-dynastierna. En miljö mättad med intriger, lönnmord, brutala avrättningar av tjänare och förgiftningar av rivaliserande konkubiner har skapat ett landskap där historien sägs dröja sig kvar i form av yin-energi.

Nattvakter har genom årtionden rapporterat om en kvinna med långt, korpsvart hår som flyr genom de inre palatsgårdarna, ofta bärande på en vit scarf. En specifik och välkänd rapport från mitten av 1990-talet beskriver hur vakter försökte genskjuta en kvinna de trodde var en tjuv, bara för att se henne springa rakt in i en låst vägg och försvinna.

Tron på dessa andar är så stark att vissa delar av palatset hålls stängda för allmänheten, delvis på grund av gamla vidskepelser. Man talar även om "spökprocessioner" där ljudet av hovfolkets musik och röster sägs höras under stormiga nätter, då atmosfäriska förhållanden påstås "spela upp" ljud som lagrats i de gamla stenmurarna.',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. LIWAN PLAZA (Guangzhou)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'liwan-plaza','Liwan Plaza','liwan-plaza','Kina','Guangzhou','Köpcentrum',
  23.1167,113.2428,5,true,false,NULL,
  'Modernt köpcentrum byggt på antik gravplats — namnet betyder "kistor" på dialekt.',
  'Detta moderna köpcentrum i Guangzhou är platsen för en av de mest olycksbådande urbana legenderna i södra Kina. Byggnadens namn skrivs på ett sätt som i vissa dialekter kan läsas som "Liwan Corpse Plaza". Arkitekturen har kritiserats skarpt av feng shui-experter som menar att de åtta huskropparna uppifrån ser ut som åtta kistor, och att byggnaden placerades ovanpå en antik gravplats utan korrekt rituell rening.

Sedan byggnaden stod klar har den varit platsen för ett ovanligt högt antal självmord; dussintals människor har hoppat från de inre balkongerna mot det hårda marmorgolvet i lobbyn. Lokala legender hävdar att de döda själarna lockar nya offer till att ta sina liv för att själva kunna bli "utlösta" från platsen. Besökare har rapporterat om en tung, tryckande atmosfär och att de känt osynliga händer som knuffat dem nära räcken.',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. WUKANG MANSION (Shanghai)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'wukang-mansion','Wukang Mansion','wukang-mansion','Kina','Shanghai','Bostadshus',
  31.2017,121.4356,4,true,false,NULL,
  '"Hopptornet" — där förföljda intellektuella tog sina liv under kulturrevolutionen.',
  'Denna ikoniska byggnad, även känd som Normandie Apartments, ritades av den berömda arkitekten László Hudec. Under kulturrevolutionen fick byggnaden det dystra smeknamnet "The Diving Board" på grund av det stora antalet intellektuella och konstnärer som valde att hoppa från huset för att undkomma förföljelse och förnedring.

Det sägs att deras andar fortfarande hemsöker trapphusen och att man under tysta nätter kan höra ekot av tunga fall mot trottoaren utanför.',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 5. HUGUANG HUIGUAN (Peking)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'huguang-huiguan','Huguang Huiguan','huguang-huiguan','Kina','Peking','Operahus',
  39.8864,116.3775,3,true,false,NULL,
  'Historiskt operahus i Peking med rykte om paranormal aktivitet.',
  'Huguang Huiguan är ett av Pekings äldsta bevarade operahus, beläget i Xuanwu-distriktet. Byggnaden är förknippad med urbana spökhistorier kopplade till de många tragedier som utspelat sig på och kring scenen genom århundradena. Lokala berättelser nämner ekon av historisk operamusik och röster från artister som inte längre finns där.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 6. TUEN MUN ROAD (Hongkong)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'tuen-mun-road','Tuen Mun Road','tuen-mun-road','Hongkong','New Territories','Motorväg',
  22.3731,113.9742,3,true,false,NULL,
  'Hongkongs mest hemsökta motorväg — många dödsolyckor och rapporter om uppenbarelser.',
  'Tuen Mun Road är en av Hongkongs mest trafikerade motorvägar och har historiskt varit platsen för många allvarliga olyckor. Förare har rapporterat om plötsliga uppenbarelser i vägbanan, fordon som tycks följa efter utan ljus och oförklarliga köldkänslor under nattkörning genom vissa tunnelpartier.

(Kort grundtext — kan berikas med lokala källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 7. NAM KOO TERRACE (Hongkong)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'nam-koo-terrace','Nam Koo Terrace','nam-koo-terrace','Hongkong','Wan Chai','Historisk byggnad',
  22.2747,114.1722,4,true,false,NULL,
  'Övergiven röd herrgård i Wan Chai — anses vara en av Hongkongs mest hemsökta byggnader.',
  'Nam Koo Terrace är en historisk röd tegelbyggnad från tidigt 1900-tal, belägen i Wan Chai. Den används idag inte längre som bostad och har stått tom under långa perioder, vilket gett upphov till en mängd lokala spökhistorier. Byggnaden är listad som ett historiskt monument klass I i Hongkong.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 8. SAI YING PUN (Hongkong)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'sai-ying-pun-asylum','Sai Ying Pun (Old Mental Hospital)','sai-ying-pun-asylum','Hongkong','Sai Ying Pun','Tidigare psykiatriskt sjukhus',
  22.2858,114.1425,4,true,false,NULL,
  'Den övergivna fasaden av Old Mental Hospital — Hongkongs mest beryktade hemsökta plats.',
  'Sai Ying Pun-området rymmer den bevarade fasaden av Old Mental Hospital, en kolonial byggnad som senare användes som psykiatriskt sjukhus. Området har under lång tid varit ett av Hongkongs mest omtalade hemsökta platser med rapporter om uppenbarelser och oförklarliga ljud.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 9. TAT TAK SCHOOL (Hongkong)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'tat-tak-school','Tat Tak School','tat-tak-school','Hongkong','Yuen Long','Övergiven skola',
  22.4452,114.0041,5,true,false,NULL,
  'Övergiven skola i Yuen Long — anses ofta vara Hongkongs mest hemsökta plats.',
  'Tat Tak School är en sedan länge stängd skolbyggnad i Yuen Long, ofta omnämnd som en av Hongkongs mest hemsökta platser. Området kring skolan är förknippat med en rad urbana legender och rapporter om paranormala fenomen.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 10. PRINCE GONG'S MANSION (Peking)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'prince-gong-mansion','Prince Gong''s Mansion','prince-gong-mansion','Kina','Peking','Residens',
  39.9372,116.3811,3,false,false,NULL,
  'Det största bevarade Qing-residenset i Peking — fyllt av historisk dramatik.',
  'Prince Gong''s Mansion är ett av de bäst bevarade residensen från Qing-dynastin och har en lång och dramatisk historia kopplad till kejserliga politiker och rikedom. Platsen är ett populärt museum men sägs av lokalbefolkning vara hemsökt av ägarens andar.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 11. TOMB OF GENERAL YUAN (Peking)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'tomb-general-yuan','General Yuan Chonghuans grav','tomb-general-yuan','Kina','Peking','Gravplats',
  39.8967,116.4172,3,true,false,NULL,
  'Graven över Ming-generalen som avrättades på falska anklagelser — vakterna sägs vara dömda till evigt försvar.',
  'Graven över Yuan Chonghuan, en stor Ming-general som avrättades 1630 på falska anklagelser om förräderi. Platsen vaktas än idag av en familj som enligt legend dömt sig själva till evigt skydd av graven sedan 1600-talet.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 12. CAOBAO ROAD STATION (Shanghai)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'caobao-road-station','Caobao Road Station','caobao-road-station','Kina','Shanghai','Tunnelbanestation',
  31.1681,121.4308,3,false,false,NULL,
  'Tunnelbanestation i Shanghai förknippad med urbana spökhistorier.',
  'Caobao Road Station tillhör Shanghais tunnelbanenät och är förknippad med en rad lokala urbana legender om paranormal aktivitet, särskilt nattetid.

(Kort grundtext — kan berikas med lokala källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 13. FENGMEN VILLAGE (Henan)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'fengmen-village','Fengmen Village','fengmen-village','Kina','Henan','Övergiven by',
  35.1972,112.9231,3,true,false,NULL,
  'Övergiven by i Henan — föremål för lokal folktro och legender.',
  'Fengmen Village är en övergiven by i Henan-provinsen som föremål för lokal folktro och legender om varför invånarna lämnade platsen.

(Kort grundtext — kan berikas med lokala källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 14. YUN SHAN FAN DIAN (Chengde)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'yun-shan-fan-dian','Yun Shan Fan Dian','yun-shan-fan-dian','Kina','Chengde, Hebei','Hotell',
  40.9711,117.9333,3,true,false,NULL,
  'Hotell i Chengde med rykte om paranormala fenomen.',
  'Hotell i Chengde, Hebei-provinsen, med lokal ryktbarhet kring paranormal aktivitet bland gäster och personal.

(Kort grundtext — kan berikas med lokala källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 15. TSUNG TSAI YUEN (Hongkong)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'tsung-tsai-yuen','Tsung Tsai Yuen','tsung-tsai-yuen','Hongkong','New Territories','Minnesplats',
  22.4344,114.1856,3,true,false,NULL,
  'Minnesplats i New Territories med lokal hemsökelse-historia.',
  'Tsung Tsai Yuen är en minnesplats i Hongkongs New Territories som ingår i den lokala paranormala folktron.

(Kort grundtext — kan berikas med lokala källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 16. GRANVILLE ROAD NO. 31 (Hongkong)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'granville-road-31','Granville Road No. 31','granville-road-31','Hongkong','Tsim Sha Tsui','Tidigare lägenhet',
  22.3001,114.1741,3,true,false,NULL,
  'Adress i Tsim Sha Tsui kopplad till en av Hongkongs mest beryktade urbana legender.',
  'Adressen Granville Road 31 i Tsim Sha Tsui är förknippad med en av Hongkongs mest seglivade urbana legender om en hemsökt lägenhet.

(Kort grundtext — kan berikas med lokala källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 17. CALÇADA DO AMPARO (Macau)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'calcada-do-amparo','Calçada do Amparo','calcada-do-amparo','Macau','Macau','Gränd',
  22.1978,113.5411,3,true,false,NULL,
  'Gränd i gamla Macau förknippad med portugisiska kolonialtidens spökhistorier.',
  'Smal gränd i Macaus historiska gamla stad, känd i lokal folktro för sin koppling till Macaus portugisiska kolonialtid och dess paranormala anekdoter.

(Kort grundtext — kan berikas med lokala källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 18. GUIA HILL (Macau)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'guia-hill','Guia Hill','guia-hill','Macau','Macau','Fästning/Park',
  22.1964,113.5492,3,false,false,NULL,
  'Macaus högsta punkt med 1600-talsfästning — kolonialt arv och lokala spökhistorier.',
  'Guia Hill är Macaus högsta punkt och hyser den bevarade Guia-fästningen från 1600-talet samt en kapell och fyrtorn. Området ingår i Macaus UNESCO-världsarv.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 19. ESTRADA DO REPOUSO (Macau)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'estrada-do-repouso','Estrada do Repouso','estrada-do-repouso','Macau','Macau','Väg',
  22.2011,113.5456,3,true,false,NULL,
  'Vägsträcka i Macau med lokala spökhistorier.',
  'Vägsträcka i Macau som är förknippad med lokala paranormala anekdoter.

(Kort grundtext — kan berikas med lokala källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 20. TAP SAC SQUARE (Macau)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'tap-sac-square','Tap Sac Square','tap-sac-square','Macau','Macau','Torg',
  22.1983,113.5467,3,true,false,NULL,
  'Centralt torg i Macau med kolonialarkitektur och lokala spökhistorier.',
  'Centralt torg i Macau med portugisisk kolonialarkitektur som ingår i Macaus UNESCO-världsarv.

(Kort grundtext — kan berikas med lokala källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
