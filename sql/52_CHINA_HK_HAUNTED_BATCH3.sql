-- Spökkartan — 2 fler hemsökta/mörka platser i Kina/Hongkong, omgång 3
-- Genererad 2026-06-09. Kompletterar 25/43.
--
-- METOD: engelska sökord -> sidor som samlat spök-/mörka historier
-- (Atlas Obscura, zolimacitymag.com, Moon Mausoleum, SCMP m.fl. samt engelska
-- Wikipedia). Skrivet på SVENSKA, 200-600 ord/plats, aldrig fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. KOWLOON WALLED CITY (Hongkong) — mörkrets stad
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'kowloon-walled-city','Kowloon Walled City','kowloon-walled-city','Hongkong','Kowloon','Övergiven',
  22.3320,114.1900,4,true,false,NULL,
  'Jordens tätast befolkade plats — en laglös, sollös labyrint kallad "mörkrets stad".',
  'Kowloon Walled City i Hongkong var en gång den tätast befolkade platsen på jorden — en laglös enklav och en labyrint av sammanbyggda höghus utan minsta arkitektonisk tillsyn. Platsen började som en militär utpost under Songdynastin och blev 1847 ett kustfort. När New Territories arrenderades till Storbritannien 1898 undantogs den lilla staden — och förblev en juridisk ingenmansmark.

Resultatet blev en stad utanför lagen: ingen skatt, ingen reglering, ingen polis. Efter andra världskriget svällde befolkningen av flyktingar från det kinesiska inbördeskriget, och från 1960-talet växte ett virrvarr av oreglerade höghus. Fem triadgäng slog sig ned, och staden blev ett nav för tillverkning och försäljning av opium och heroin. Polisen vågade sig in endast i stora grupper.

På sin höjdpunkt bodde uppskattningsvis 50 000 människor på en hundradels kvadratkilometer — motsvarande 1,9 miljoner invånare per kvadratkilometer. På gatunivå nådde inget solljus ned i de smala, slingrande gångarna, kantade av droppande vattenrör och hängande buntar av elkablar. Platsen kallades "mörkrets stad".

År 1987 beslöts att riva staden. Efter en omfattande utrymning revs den mellan 1993 och 1994. Idag är området en parkanläggning — men minnet av den klaustrofobiska, sollösa labyrinten lever vidare som en av Asiens mörkaste och mest sägenomspunna platser.

Källa: Engelska Wikipedia "Kowloon Walled City" + Atlas Obscura + National Geographic + howstuffworks.com',
  NULL,NULL,NULL,true,true,'published','web_cn_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. MURRAY HOUSE (Hongkong) — det flyttade spökhuset
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'murray-house','Murray House','murray-house','Hongkong','Stanley','Hus',
  22.2190,114.2130,3,true,false,NULL,
  'Japanska militärpolisens tortyr- och avrättningsplats — exorcerat två gånger, sedan flyttat sten för sten.',
  'Murray House byggdes 1846 som officersbostad för Murraykasernen i centrala Hongkong. Under den japanska ockupationen blev byggnaden högkvarter för den japanska militärpolisen, med fängelseceller, tortyrkammare och avrättningsplatser där många Hongkongbor — upp till 4 000 enligt vissa uppgifter — dödades.

Med en så blodig historia är det inte underligt att Murray House länge ansågs hemsökt. Exorcismer genomfördes 1963 och 1974 i ett försök att lugna de tjänstemän som arbetade i byggnaden — somliga hotade att säga upp sig om inget gjordes åt spökena. År 1963 klagade kontorsarbetare på att andar förstörde ritningar och skadade kontorsmaskiner.

År 1982 flyttades Murray House från centrala Hongkong för att ge plats åt Bank of China Tower. Byggnaden plockades ned sten för sten och lades i förvar. Det dröjde nästan ett decennium innan regeringen beslöt att återuppföra den i Stanley, där den restaurerades och återinvigdes 2002.

Det Murray House som idag står i Stanley är i själva verket en ny betongbyggnad med stenar från originalet påklistrade. Idag rymmer huset butiker och restauranger med utsikt över havet — men dess mörka förflutna och de många dödsoffren under ockupationen gör att spökhistorierna ännu följer med byggnaden, vart den än flyttas.

Källa: Engelska Wikipedia "Murray House" + zolimacitymag.com + Moon Mausoleum + SCMP',
  NULL,NULL,NULL,false,true,'published','web_cn_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
