-- Spökkartan — 6 fler platser i Japan, omgång 5 (Japan 34 -> 40, KLART)
-- Genererad 2026-06-09. METOD: engelska/japanska sökord -> Wikipedia, haikyo.org,
-- offbeatjapan.com, kowabana.net, matsushiro.org m.fl. Svenska, 200-600 ord/plats.
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. INUNAKI-BYN — byn bortom Japans lag
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'inunaki-village','Inunaki-byn','inunaki-village','Japan','Fukuoka','Övergiven',
  33.7000,130.5670,4,true,false,NULL,
  'Vid infarten står en skylt: "Japans grundlag gäller inte bortom denna punkt." Paret som körde vilse mördades.',
  'Inunaki-byn (Inunaki-mura) är en japansk skräcklegend från 1990-talet om en fiktiv, byastor mikronation som förkastar Japans grundlag. Sägnen förlägger byn nära Inunaki-passet i Fukuoka-prefekturen. Vid infarten ska det stå en handskriven skylt: "Japans grundlag gäller inte bortom denna punkt."

Enligt legenden vägrar byns invånare att erkänna såväl Japans grundlag som den sittande regeringens legitimitet. De första omnämnandena på nätet dök upp 1999, när tv-bolaget Nippon TV fick ett anonymt brev som beskrev legenden om ett mördat par och uppmanade tv-teamet att besöka platsen. Brevet bar titeln "Byn i Japan som inte är en del av Japan".

Enligt en vanlig version av sägnen körde ett ungt par någon gång i början av 1970-talet vilse i skogen när bilen gick sönder. De kom in i den till synes övergivna Inunaki-byn, där en "galen gammal man" hälsade dem välkomna — och sedan mördade dem med en lie.

Området kring den gamla Inunaki-tunneln intill anses verkligen hemsökt på grund av flera mord; 1988 bortförde och torterade fem unga män en fabriksarbetare som de brände till döds inne i tunneln. En verklig by vid namn Inunaki, utan koppling till legenden, fanns mellan 1691 och 1889 — men det är skräcksägnen om byn bortom lagen som lever vidare på Japans internet.

Källa: Engelska Wikipedia "Inunaki Village" + japan-makes-me-scared.com + Moon Mausoleum + cijtoday.com',
  NULL,NULL,NULL,true,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. YOSHIMI HYAKUANA — de hundra grottgravarna
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'yoshimi-hyakuana','Yoshimi Hyakuana','yoshimi-hyakuana','Japan','Saitama, Yoshimi','Naturplats',
  36.0420,139.4470,3,false,false,NULL,
  'Över 200 grottgravar gapar ur berget, klädda med självlysande grön mossa — och en krigsfabriks tunnlar.',
  'Yoshimi Hyakuana — "de hundra hålen i Yoshimi" — är en gåtfull klippsida i Yoshimi i Saitama-prefekturen, prickad av över 200 grottgravar från Kofun-perioden. Sammanlagt har 219 horisontella grottgravar identifierats i sluttningen av en kulle av tuffartad sandsten, vilket ger ett alldeles unikt landskap.

Gravarna, omkring 1 400 år gamla, liknas ibland vid "forntida hyreshus", där rad efter rad av öppningar gapar ut ur berget. Platsen utsågs till nationellt historiskt minnesmärke 1923 och är ett populärt mål för historiska vandringar. Flera av gravkamrarna är så låga och trånga att besökare måste kura sig samman för att krypa in i dem, och de inte alltför klaustrofobiska kan tränga in i bergets svala, mörka inre där de döda en gång lades till vila.

Men Yoshimi Hyakuana bär också på en mörkare historia. Under Stillahavskrigets slutskede grävdes här en underjordisk militärfabrik, och tunnlar ska ha byggts för att tillverka flygplansdelar. Krig och död vilar alltså i dubbel bemärkelse över platsen.

Den kusliga stämningen förstärks av att många av grottväggarna är klädda med en sällsynt självlysande grön mossa, känd som hikarigoke — "lysmossa" — som skimrar svagt i mörkret. Kombinationen av uråldriga gravkamrar, krigets underjordiska gångar och det spöklika gröna skenet gör Yoshimi Hyakuana till en av Saitamas mest atmosfäriska och olycksbådande platser, där det förflutnas döda tycks vila tätt inpå de levande.

Källa: jeepe.jp + japantravel.com + travel-around-japan.com + donnykimball.com',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. GLUCK KINGDOM — det övergivna tyska sagoriket
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'gluck-kingdom','Gluck Kingdom','gluck-kingdom','Japan','Hokkaido, Obihiro','Övergiven',
  42.7330,143.2170,3,false,false,NULL,
  'Ett övergivet tysktematiskt sagorike i Hokkaido, hemsökt sedan en dödsolycka på en åkattraktion.',
  'Gluck Kingdom (Glücks-Königreich) var en tysktematisk nöjespark nära Obihiro flygplats i Hokkaido — historia, kultur, sagor och nöje, allt på ett ställe. Den öppnade 1 juli 1989 och stängde efter bara fjorton år.

Parken ville återskapa bröderna Grimms sagovärld. Formgivarna inspirerades av den traditionella arkitekturen i de centraltyska delstaterna Hessen och Niedersachsen: trähus från 1400- och 1600-talen, en kullerstensbelagd Marktplatz och till och med interiörer från tyska medeltidsslott återgavs noggrant. På sin höjdpunkt tog parken emot upp till 700 000 besökare om året; redan efter ett halvår hade en halv miljon kommit.

Men läget blev dess fall. Sapporo låg tre timmars bilväg bort, den närmaste järnvägsstationen stängde innan parken ens öppnat, och Obihiro hade under 200 000 invånare. Gluck Kingdom var för isolerat för långväga gäster och stängde 2003 (somliga uppger 2007).

Ryktet gör gällande att Gluck Kingdom är en av Hokkaidos mest hemsökta platser, efter en dödsolycka på en av åkattraktionerna. Sedan 2011 har platsen blivit allt populärare bland urban explorers, som vandrar genom det förfallande tyska sagoriket — övergivna fackverkshus och en tyst slottskuliss, sakta uppslukade av Hokkaidos vildmark. Inne i de tomma byggnaderna stod länge möbler, leksaker och sagofigurer kvar och samlade damm, medan snön vintertid yrde in genom krossade rutor och lade ett vitt täcke över det glömda kungariket.

Källa: offbeatjapan.com + abandonedkansai.com + haikyo.org + worldabandoned.com',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. MATSUSHIRO UNDERJORDISKA HÖGKVARTER — tvångsarbetets tunnlar
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'matsushiro-underground-hq','Matsushiro underjordiska kejserliga högkvarter','matsushiro-underground-hq','Japan','Nagano','Tunnel',
  36.5600,138.2000,4,false,false,NULL,
  'Bergstunnlar grävda av tusentals koreanska tvångsarbetare — hundratals dog i mörkret under jorden.',
  'Matsushiro underjordiska kejserliga högkvarter är ruinerna av militäranläggningar från andra världskriget, uthuggna i berg kring Matsushiro i Nagano från slutet av 1944. Tanken var att den japanska statens centrala organ — inklusive kejsaren — skulle kunna flyttas hit i händelse av en allierad invasion.

De som tvingades utföra grävarbetet var till största delen koreaner, antingen bortförda direkt från Korea eller överflyttade från byggen runt om i Japan. Det var koreanerna som tvingades ta de farligaste och tyngsta uppgifterna. Det totala antalet tvångsarbetare uppskattas till minst 6 000–7 000, men exakta siffror saknas eftersom inga register bevarats; vissa källor anger upp till 10 000.

Arbetarna utförde livsfarliga uppgifter som sprängning med dynamit i flerskift, under minimala säkerhetsåtgärder. Detta ledde till dokumenterade dödsfall genom olyckor, utmattning och sjukdom — siffror mellan 500 och 1 500 döda nämns, även om noggranna uppgifter saknas på grund av krigets förstörelse och efterkrigstidens ovilja att dokumentera.

Idag är 500 meter av anläggningen under berget Zōzan öppna för besökare, och intill ligger Matsushiro Memorial Center of Untold History, som dokumenterar tunnlarnas tillkomst och arv. I de kalla, mörka bergsgångarna, uthuggna med tvångsarbetares blod, dröjer minnet av lidandet kvar — en av Japans mörkaste krigsplatser.

Källa: Engelska Wikipedia + matsushiro.org + snowmonkeyresorts.com + tracesofwar.com',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 5. UNZEN JIGOKU — de kristna martyrernas helveten
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'unzen-jigoku','Unzen Jigoku','unzen-jigoku','Japan','Nagasaki, Unzen','Naturplats',
  32.7340,130.2620,3,true,false,NULL,
  'Kokheta källor där 33 kristna torterades till döds — översköljda med skållhett vatten tills de avföll eller dog.',
  'Unzen Jigoku — "Unzens helveten" — är ett område av kokheta källor på Shimabara-halvön i Nagasaki-prefekturen. Mellan de gamla och nya termalkällorna ligger ett band av vit jord där ånga, på sina ställen upp till 120 grader het, väller ur marken med ett oavbrutet väsande.

Men dessa kokande "helveten" bär på en fasansfull historia. Mellan 1627 och 1632 blev Unzen Jigoku en plats för kristna martyrers död. Förföljelsen sattes igång av Shimabaras feodalherre Matsukura Shigemasa och drevs vidare av Takenaka Shigeyoshi, som 1629 utsågs till magistrat i Nagasaki.

De heta källorna användes för att tortera kristna i ett försök att tvinga dem att avsvärja sin tro. Vid randen av det kokande vattnet pressades de att avfalla; de som vägrade kläddes av, bands till händer och fötter och översköljdes med skopa efter skopa av det skållheta vattnet. Sammanlagt led 33 troende martyrdöden i Unzen Jigoku mellan 1627 och 1631.

På en kulle med utsikt över det ångande, geotermiska landskapet står idag ett minnesmärke och ett kors till åminnelse av de 33 martyrerna. Bland de fräsande källorna och svavelångorna är det inte svårt att föreställa sig de plågor som utspelade sig här — en plats vars namn, "helvetet", känns dubbelt välförtjänt.

Källa: oratio.jp + ucanews.com + nippon.com + discover-nagasaki.com',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 6. NAGORO — dockbyn där dockorna är fler än de levande
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'nagoro-doll-village','Nagoro (dockbyn)','nagoro-doll-village','Japan','Tokushima, Iya-dalen','By',
  33.8830,133.9170,3,true,false,NULL,
  'I en avfolkad bergsby är 350 livsstora dockor fler än de levande — och kastar jättelika skuggor i skymningen.',
  'Nagoro i Iya-dalen på ön Shikoku i Tokushima-prefekturen är idag känt som "dockbyn" — en avfolkad bergsby där livsstora dockor är fler än de levande invånarna.

I början av 2000-talet flyttade Tsukimi Ayano, vars familj lämnat trakten när hon var barn, tillbaka för att ta hand om sin far. När fåglar grävde upp fröna i hennes trädgård tillverkade hon en fågelskrämma i sin fars avbild. Förtjust i resultatet gjorde hon fler tygdockor och ställde dem vid vägen. När förbipasserande resenärer stannade och frågade en av figurerna om vägen blev hon så road att hon beslöt att fortsätta — för att "återbefolka" den döende byn.

Sedan dess har hon gjort över 400 dockor, varav omkring 350 finns i byn. Många föreställer nuvarande eller forna invånare, andra är påhittade personer. Det tar ungefär tre dagars arbete att skapa en ny docka, och ute i väder och vind håller de omkring två år.

Byn hade en gång cirka 300 invånare, men Japans avfolkning har krympt antalet till långt under trettio. Dockorna belyser på sitt vis det allvarliga problemet med landsbygdens utdöende. Och när natten snabbt faller över den lilla byn i Tokushimas berg kastar dockorna jättelika, skrämmande skuggor — och det hela blir, ärligt talat, ganska kusligt.

Källa: Engelska Wikipedia "Nagoro" + CNN + National Geographic + kanpai-japan.com',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
