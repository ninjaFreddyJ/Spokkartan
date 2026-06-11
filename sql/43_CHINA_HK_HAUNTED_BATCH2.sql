-- Spökkartan — 4 fler hemsökta platser i Kina och Hongkong
-- Genererad 2026-06-09. Kompletterar 25_ASIA_CHINA_HK_MACAU (Chaonei 81,
-- Förbjudna Staden, Nam Koo Terrace, Tat Tak School m.fl. — utelämnas här).
--
-- METOD: engelska/kinesiska sökord (haunted, ghosts, 鬼) -> sidor som samlat
-- spökhistorier (ancient-origins.net, thebeijinger.com, hongkongliving.com,
-- ghoststories.sg m.fl. samt engelska Wikipedia). Skrivet på SVENSKA,
-- 200-600 ord/plats, aldrig fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. FENGDU GHOST CITY (Kina) — dödsrikets stad
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'fengdu-ghost-city','Fengdu Ghost City','fengdu-ghost-city','Kina','Chongqing, Fengdu','Tempel',
  29.8920,107.7300,3,false,false,NULL,
  'Dödsrikets stad vid Yangtze — där själen prövas vid hjälplöshetens bro och spökporten.',
  'Fengdu Ghost City — "spökstaden" — är ett vidsträckt komplex av helgedomar, tempel och kloster tillägnade livet efter detta, beläget på Mingberget i Fengdu i Chongqing, omkring 170 kilometer nedströms längs Yangtzefloden.

Enligt sägnen fick Fengdu sitt namn under östra Han-dynastin, då två kejserliga ämbetsmän, Yin Changsheng och Wang Fangping, kom till Mingberget för att utöva taoism och därvid blev odödliga. Deras sammanslagna namn, "Yinwang", betyder "dödsrikets kung" — och därmed började platsens inriktning mot underjorden.

Komplexet förenar konfucianism, taoism och buddhism och kretsar helt kring döden. Många av templen visar målningar och skulpturer av människor som torteras för sina synder. Tre prov måste den dödes själ klara på vägen genom dödsriket. Naihebron, "hjälplöshetens bro", byggd under Mingdynastin, sägs förbinda de levandes värld med underjorden. Vid Guimen-porten, "spökporten", anmäler sig de dödas själar inför dödsrikets kung för att dömas och få ett vägpass som bevis för att registreras i livet efter detta. Det sista provet sker i Tianzi-palatset, kejsarpalatset, vars nuvarande byggnad härrör från tidig Qingtid.

Idag är Fengdu en av de populäraste hållplatserna på Yangtze-kryssningarna — en plats där hela den kinesiska föreställningen om dödsriket gjutits i sten, tegel och färg, och där besökaren själv kan vandra den väg själarna sägs ta efter döden.

Källa: Engelska Wikipedia "Fengdu Ghost City" + Ancient Origins + silkroadtravel.com + ichongqing.info',
  NULL,NULL,NULL,true,true,'published','web_cn_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. BUSS 375 (Kina) — Pekings spökbuss
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'beijing-bus-375','Buss 375 (Xiangshan)','beijing-bus-375','Kina','Peking, Xiangshan','Vägsträcka',
  39.9920,116.1880,4,true,false,NULL,
  'Nattens sista buss tog ombord tre fotsida gestalter — utan ben. Sedan försvann den spårlöst.',
  'Buss 375 är en av Kinas mest kända spökhistorier, sägs ha utspelat sig vid midnatt den 14 november 1995 i Peking. Det var nattens sista buss, som lämnade hållplatsen vid Yuanmingyuan med Xiangshan ("Doftkullarna") som mål.

Vid Sommarpalatsets sydport steg fyra passagerare på: en gammal kvinna, ett ungt par och en ung man. Efter en stund fick föraren syn på två skuggor vid vägkanten som vinkade åt bussen. Han stannade, dörrarna öppnades och tre personer steg på — klädda i långa, fotsida dräkter. När vinden lyfte deras rockar såg den gamla kvinnan att de saknade ben.

Nästa dag rapporterade buss 375 aldrig in till stationen. Den hade försvunnit tillsammans med föraren och konduktrisen. Polisen genomsökte hela staden utan att finna ett spår. Två dagar senare hittades bussen till slut — sjunken i Miyun-reservoaren, omkring tio mil från Xiangshan. Inuti låg tre svårt förmultnade kroppar: föraren, konduktrisen och en oidentifierad man.

Det bör påpekas att busslinjen i verkligheten aldrig har existerat, vilket talar för att det rör sig om en modern skröna. Historien spreds via nattliga radioprogram, tv-shower och till och med av den berömda sångerskan Na Ying i Taiwan under 1990-talet — och har sedan dess blivit en av den kinesiska internetkulturens mest seglivade spökberättelser.

Källa: thebeijinger.com + scaryforkids.com + newstrack.com + urban-folklores.blogspot.com',
  NULL,NULL,NULL,false,true,'published','web_cn_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. DRAGON LODGE (Hongkong) — Peaks mest hemsökta hus
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'dragon-lodge','Dragon Lodge','dragon-lodge','Hongkong','Victoria Peak','Övergiven',
  22.2710,114.1450,4,true,false,NULL,
  'Den övergivna herrgården på Peak — där byggarbetare flytt för en osynlig barngråt.',
  'Dragon Lodge är en herrgård från tiden före andra världskriget på adressen 32 Lugard Road, högt uppe på Victoria Peak i Hongkong, med en oöverträffad utsikt över skyline och Victoria Harbour. Sedan många år står den tom — och kallas ofta "Hongkongs mest hemsökta hus".

Flera sägner omger huset. Det sägs att den ursprunglige ägaren gick i konkurs, och att den andre ägaren dog inne i huset. Under andra världskriget ska japanska soldater ha använt egendomen för sina operationer, och enligt en utbredd men ospårbar historia ska de ha halshuggit flera katolska nunnor på innergården. Var berättelsen har sitt ursprung tycks dock ingen veta.

Efter 1980-talet växte de inre vägarna igen, och Dragon Lodge fick sitt rykte som Hongkongs mest hemsökta hus. Byggnadsarbetare som försökt utföra arbeten på egendomen berättar om en osynlig barngråt som ekat genom huset och fått modet att svikta.

Idag är herrgården fortfarande öde och obebodd, avspärrad med taggtråd och nästan uppslukad av den frodiga grönskan på bergssidan. Den som kikar in förbi stängslet ser inte längre ett ståtligt hem för de stenrika, utan en förfallande ruin med tomma fönstergluggar — en kuslig kvarleva av Peaks förflutna, omsusad av historier om konkurs, död, halshuggna nunnor och ett gråtande barn som ingen riktigt kan förklara. För många vandrare på den natursköna Lugard Road är den övergivna villan höjdpunkten — och mardrömmen.

Källa: hongkongliving.com + theghostinmymachine.com + culture-hongkong.com + Gwulo',
  NULL,NULL,NULL,false,true,'published','web_cn_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. BRIDES POOL (Hongkong) — den drunknade bruden
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'brides-pool','Brides Pool (Bruddammen)','brides-pool','Hongkong','New Territories, Tai Po','Naturplats',
  22.4830,114.2330,3,true,false,NULL,
  'Bruden föll ur bärstolen och drunknade — en kvinna i rött kammar ännu sitt hår vid vattnet.',
  'Brides Pool (bruddammen) är en liten flod i de nordöstra New Territories i Hongkong, nära Tai Mei Tuk i Plover Cove Country Park. Bakom det vackra vattenfallet döljer sig en av territoriets mest tragiska sägner.

Enligt legenden bars en brud i en bärstol av fyra bärare på väg till sin brudgum, i ett rasande oväder. När de passerade vattensamlingen halkade en av bärarna, och bruden föll i. Nedtyngd av sina tunga ceremoniella kläder drunknade hon i poolen nedanför. Byborna lyckades aldrig återfinna vare sig hennes kropp eller bärstolen.

Man tror att hennes ande ännu dröjer kvar i trakten. Lokalbor och vandrare säger sig ha sett en kvinna i röd klänning som kammar sitt långa hår vid vattenbrynet eller i spegelbilden i den närliggande Mirror Pool. Övergivna andetavlor har skymtats i trädens skugga, och till och med kremerade kvarlevor i själva poolen.

En spökhistoria varnar för att besöka platsen nattetid, då somliga tror att onda andar i vattnet alltjämt söker efter någon att dra med sig ned. Trots — eller tack vare — sitt dystra rykte är Brides Pool ett populärt vandringsmål om dagen, och räknas till Hongkongs mest hemsökta platser.

Källa: Engelska Wikipedia "Brides Pool" + ghoststories.sg + SCMP (scmp.com) + timeout.com',
  NULL,NULL,NULL,false,true,'published','web_cn_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
