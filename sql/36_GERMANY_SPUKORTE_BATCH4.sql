-- Spökkartan — 3 fler hemsökta platser i Tyskland (Deutschland), omgång 4 (sista)
-- Genererad 2026-06-09. Avslutar Tysklandsserien (33-36).
--
-- METOD (samma generella lösning): tyska sökord (Lost Place, Lochgefängnis,
-- Folterkammer, Teufel, Sage) -> sidor som samlat spökhistorier/sägner
-- (verlassenes.de, museen.nuernberg.de, harzlife.de, harzwelten.online,
-- travelbook.de m.fl. samt tyska Wikipedia). Svenska, 200-600 ord/plats,
-- aldrig fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. OLYMPISCHES DORF ELSTAL (Tyskland) — den övergivna OS-byn 1936
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'olympisches-dorf-elstal','Olympisches Dorf Elstal','olympisches-dorf-elstal','Tyskland','Brandenburg, Wustermark','Övergiven',
  52.5390,12.9640,3,false,true,NULL,
  'Den övergivna olympiska byn från Berlin-OS 1936 — tysta salar där historiens skuggor vilar tunga.',
  'Den olympiska byn i Elstal, omkring 18 kilometer väster om Berlin i Brandenburg, byggdes inför sommar-OS i Berlin 1936. Anläggningen — drygt 540 000 kvadratmeter — ritades av arkitekten Werner March, samme man som ritade Reichssportfeld och olympiastadion. Den utformades som en rofylld oas långt från storstadens larm, men planlades helt enligt den nazistiska ledningens idéer. Under spelen 1–16 augusti 1936 bodde här omkring 3 600 manliga idrottare med ledare och personal, medan de cirka 330 kvinnliga deltagarna inkvarterades vid Reichssportfeld.

Efter kriget, 1945, flyttade Röda armén in och använde idrottsanläggningarna som prestationscentrum för den sovjetiska armésportklubben SASK. Först sommaren 1992 lämnade de sista ryska trupperna byn, som därefter till stora delar lämnades att förfalla.

På grund av sin historiska och arkitektoniska betydelse, och då den hotades av förfall, är området kulturminnesskyddat sedan 1993. De övergivna, vittrande byggnaderna — med igenvuxna gårdar och tomma salar — har blivit en av Berlinområdets mest besökta "lost places", en kuslig kuliss där historiens skuggor vilar tunga. En del av byn har på senare år moderniserats till en trädgårdsstad med stadsradhus, men många huskroppar står ännu öde och tysta. Bland de övergivna byggnaderna finns det runda matsalshuset, simhallen och idrottarnas boningar, där putsen flagnar och naturen långsamt tar tillbaka korridorerna — en plats som drar till sig både historieintresserade och de som söker det olycksbådande i tystnaden efter ett av historiens mest laddade idrottsspel.

Källa: verlassenes.de + berlinstaiga.de + t-online.de + geschichtsspuren.de',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. NÜRNBERGER LOCHGEFÄNGNISSE (Tyskland) — medeltidens tortyrhålor
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'nuernberger-lochgefaengnisse','Nürnberger Lochgefängnisse','nuernberger-lochgefaengnisse','Tyskland','Bayern, Nürnberg','Fängelse',
  49.4548,11.0775,4,false,true,NULL,
  'Under rådhuset gömmer sig tolv mörka celler och en tortyrkammare — de torterades skrik nådde upp till torget.',
  'Under det gamla rådhuset i Nürnberg, i Bayern, döljer sig "Nürnberger Loch" — en av Tysklands största och bäst bevarade medeltida stadsfängelser. När nürnbergarna från 1332 anlade torget Hauptmarkt som ny stadskärna byggde de om bakhuset till rådhus och höjde marken runtomkring, så att bottenvåningen blev källare och de gamla butikerna blev fängelsehålor.

Idag kan man fortfarande se tolv celler. Med bara två meters längd, bredd och höjd kedjades ofta två fångar samtidigt fast i fullständigt mörker. Vissa förbrytare — som mordbrännare och förtalare — hade särskilt utmärkta celler reserverade för sig.

Det så kallade kapellet tjänade som tortyrkammare, där bekännelser pressades fram. Enligt sägnen trängde de torterades skrik ända upp genom myllret på Hauptmarkt ovanför. Celler, tortyrkammare, smedja, fängelseköket och brunnskammaren ger än idag en levande — och kuslig — bild av medeltidens rättsskipning.

Den som stiger ned i de trånga, fuktiga valven känner snabbt tyngden av allt det lidande murarna bevittnat. Idag förs guidade turer ned i mörkret varje timme mellan klockan 11 och 18 — men barn under tio år släpps inte in. Platsen räknas till Nürnbergs mest skräckinjagande hörn, en stum påminnelse om en tid då tortyren var en del av lagen.

Källa: museen.nuernberg.de + tourismus.nuernberg.de + travelbook.de + infranken.de',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. TEUFELSMAUER (Tyskland) — djävulens misslyckade mur
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'teufelsmauer-harz','Teufelsmauer','teufelsmauer-harz','Tyskland','Sachsen-Anhalt, Harz','Naturplats',
  51.7870,10.9460,2,true,false,NULL,
  'Djävulens gränsmur — som han slog sönder i raseri när tuppen gol för tidigt och Harz gick förlorat.',
  'Teufelsmauer ("Djävulsmuren") är en omkring 20 kilometer lång formation av härdade sandstensklippor i norra Harz, i Sachsen-Anhalt, som reser sig som en taggig mur ur landskapet. Kring den ringlar sig en av regionens mest kända djävulssägner.

Enligt legenden begärde djävulen efter skapelsen en del av världen — särskilt Harzbergen, hans käraste trakt. Efter mycket om och men gick Gud med på att dela landet, men på ett villkor: djävulen måste resa en gränsmur färdig innan den första tuppen gol nästa morgon. Frenetiskt byggde den onde genom natten.

Men just som bara den sista stenen återstod snubblade i gryningen en bondkvinna från Timmenrode, på väg till marknaden, över muren — en tupp hade nämligen galt för tidigt, och skulden låg helt på henne. Därmed var natten över och Harz förlorat för djävulen. Rasande slungade mörkrets furste den sista stenen långt ut över Harzförlandet, kallade på blixt och dunder och slog sönder den nästan färdiga muren. Spillrorna blev stående som ett vittnesbörd om den Högstes allmakt.

I verkligheten uppstod Teufelsmauer genom bergsförskjutningar under kritperioden, då hårdare sandstenslager blottlades när de mjukare vittrade bort. Men för folktron förblir klipporna djävulens misslyckade mur — och nära ligger också den så kallade Hexenaltar, häxaltaret.

Källa: harzlife.de + harzwelten.online + Tyska Wikipedia "Teufelsmauer (Harz)" + travelbook.de + scinexx.de',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
