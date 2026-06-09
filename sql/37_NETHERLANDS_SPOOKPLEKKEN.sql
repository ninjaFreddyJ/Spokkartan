-- Spökkartan — 3 hemsökta platser i Nederländerna (Nederland)
-- Genererad 2026-06-09. Samma generella metod, nu Nederländerna.
--
-- METOD: översatte nyckelorden till nederländska (hemsökta platser ->
-- spookplekken/spookhuizen, spöken -> spoken/geesten; relaterat: spookkasteel,
-- spookverhalen, witte wieven, legende) och sökte sidor som SAMLAT spökhistorier
-- (kasteelhoensbroek.nl, visittwente.nl, verhalenbank.nl, dutch-folklore.fandom.com,
-- mijngelderland.nl m.fl. samt nederländska/engelska Wikipedia). Skrivet på
-- SVENSKA, 200-600 ord/plats, aldrig fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. KASTEEL HOENSBROEK (Nederländerna) — de Blauwe Dame
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'kasteel-hoensbroek','Kasteel Hoensbroek','kasteel-hoensbroek','Nederländerna','Limburg, Heerlen','Slott',
  50.9200,5.9270,3,false,false,NULL,
  'Den Blå damen som fick 24 barn — varje 5 november återvänder hon för att söka sina inmurade små.',
  'Kasteel Hoensbroek i Heerlen i Limburg är ett av Nederländernas största och bäst bevarade medeltidsslott. Det är framför allt känt för legenden om den Blå damen (de Blauwe Dame).

Den blå damen var i verkligheten Anna Catharina, riksgrevinna von Schönborn, som 1720 gifte sig med markisen Frans Arnold van Hoensbroek. Tillsammans fick de hela 24 barn — men av dessa överlevde bara sex. Två av barnen som dog vid födseln murades, enligt 1700-talets sed, in i slottets väggar.

Anna Catharina dog den 5 november 1760. Sägnen berättar att hon varje år på just denna dag återvänder till slottet för att söka efter sina inmurade barn. Efter sin död har hon setts vandra genom slottets gångar nattetid, klädd i sin blå klänning. Högst uppe i slottets runda torn märker förbipasserande då och då ett blått ljus.

Man har försökt komma sägnen på spåren med slagrutor och pendlar. En viss källarmur väckte särskild uppmärksamhet — men tillstånd att bryta upp den medeltida muren gavs aldrig. Så förblir gåtan olöst, och den Blå damen fortsätter sin sorgsna vandring. Spökhistorien har fängslat besökare i sekler och är än idag en av de mest älskade legenderna kring Kasteel Hoensbroek.

Källa: kasteelhoensbroek.nl + thelittlewalkofhorrors.com + adremlimburg.nl + indeheiligestede.nl',
  NULL,NULL,NULL,true,true,'published','web_nl_spookplekken'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. SINGRAVEN (Nederländerna) — den inmurade nunnan
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'singraven','Huis Singraven','singraven','Nederländerna','Overijssel, Denekamp','Slott',
  52.3760,7.0030,3,false,false,NULL,
  'En nunna murades in levande i klostermuren — hennes jämmer ekar ännu vid vattenkvarnen.',
  'Singraven är ett herrgårdsgods vid floden Dinkel nära Denekamp i Twente, i provinsen Overijssel. I en avlägsen forntid tjänade godset under ett tiotal år som nunnekloster, och kring år 1506 ska en av nunnorna ha murats in levande i klostermuren.

Enligt sägnen hade en av nunnorna ett gott förhållande till byborna och bröt mot reglerna genom att besöka den lokala krogen. När de övriga nunnorna upptäckte detta anklagades hon för okyskt leverne och skulle straffas av abbedissan. Domen blev att hon murades in levande i en av byggnadens väggar. Varje dag ekade hennes jämmer och skrik genom korridorerna.

Sedan dess sägs en spöklik gestalt, lik en nunna, vandra runt på Singraven. Hon syns regelbundet sväva ovanför det forsande vattnet vid den gamla vattenkvarnen, och hennes ande ska ha bringat olycka över godsets invånare.

Historiker påpekar att abbedissan knappast hade laglig rätt att verkställa en sådan dödsdom — hon kunde straffa, men i princip inte gå längre än till fängelse, och Singraven var kloster i bara tio år. Sann eller ej är "Non van Singraven" — nunnan från Singraven — en av Twentes mest kända och seglivade sägner, alltjämt levande i teater, böcker och lokalt folkminne, och få vågar vandra ensamma längs Dinkels stränder när skymningen faller över det gamla godset.

Källa: visittwente.nl + reisreport.nl + verhalenbank.nl + Nederländska Wikipedia "Singraven"',
  NULL,NULL,NULL,false,true,'published','web_nl_spookplekken'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. WITTE WIEVEN / WITTEWIJVENKUIL (Nederländerna) — folktrons dimandar
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'wittewijvenkuil-barchem','Wittewijvenkuil (Witte Wieven)','wittewijvenkuil-barchem','Nederländerna','Gelderland, Barchem','Naturplats',
  52.1460,6.3470,2,true,false,NULL,
  'De vita kvinnorna — kloka örtkvinnors andar som svävar i höstdimman över Achterhoeks hedar.',
  'Witte Wieven ("vita kvinnorna") är gestalter ur nederländsk folktro — dimmiga kvinnliga andar vars sägner går tillbaka åtminstone till förkristen tid, omkring 600-talet. De är mest kända i östra och norra Nederländerna, särskilt i Drenthe, Overijssel och Gelderland, med trakterna Twente, Achterhoek och Veluwe.

Trots att namnet bokstavligen betyder "vita", tolkas "witte" ofta som "vita" i betydelsen visa. Ursprungligen tänktes Witte Wieven vara kloka örtkvinnor och läkekunniga som botade människors krämpor till kropp och själ, och som dessutom hade gåvan att spå och se in i framtiden.

Andarna förknippas starkt med dimma. Man trodde att dimma vid en grav var tecken på att en ande visade sig, och förr menade folk sig ofta se Witte Wieven i dimstråken när hösten kom och kvällsdimman steg ur markerna.

Nära byn Barchem i Gelderland ligger Wittewijvenkuil — "de vita kvinnornas grop" — en sänka mellan två kullar där tre vita kvinnor enligt sägnen bodde. Liknande gropar finns på flera håll i Veluwe, bland annat vid Bathmen och Luttenberg. När höstdimman lägger sig över de östnederländska hedarna och skogarna är det inte svårt att förstå hur sägnen om de vita, svävande kvinnorna en gång föddes.

Källa: Engelska Wikipedia "Witte Wieven" + dutch-folklore.fandom.com + mijngelderland.nl + pansophia.nl',
  NULL,NULL,NULL,false,true,'published','web_nl_spookplekken'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
