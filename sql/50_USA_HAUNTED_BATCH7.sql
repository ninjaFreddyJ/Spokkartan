-- Spökkartan — 4 fler hemsökta platser i USA, omgång 7
-- Genererad 2026-06-09. Kompletterar tidigare USA-filer.
--
-- METOD: engelska sökord (haunted, ghosts) -> sidor som samlat spökhistorier
-- (hauntedrooms.com, usghostadventures.com, ghostcitytours.com, staugustinelighthouse.org
-- m.fl. samt engelska Wikipedia). Skrivet på SVENSKA, 200-600 ord/plats, aldrig
-- fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. SLOSS FURNACES (USA) — järnverkets döda arbetare
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'sloss-furnaces','Sloss Furnaces','sloss-furnaces','USA','Alabama, Birmingham','Industri',
  33.5210,-86.7920,4,false,true,NULL,
  'Gjutaren som föll i smält järn lovade att aldrig lämna ugnarna — 100+ polisanmälda spökerier.',
  'Sloss Furnaces i Birmingham i Alabama var ett av söderns största järnverk, grundat 1880 av översten James Sloss. Idag är den nedlagda masugnsanläggningen ett industriminne — och sägs vara en av Amerikas mest hemsökta industriplatser.

Den mest kända spökhistorien handlar om Theophilus Jowers. Den 9 september 1887 föll den 28-årige biträdande gjutaren från en plattform ned i smält järn vid det närliggande Alice-verket; bara en sko och en del av hans fot kunde bärgas. Arbetarna tog hans löfte på allvar: "Så länge det står en masugn kvar i det här landet, ska jag vara där." När Alice nr 1 revs 1905 flyttade hans ande till Alice nr 2, och 1927 till Sloss.

En annan, mer sentida gestalt är James "Slag" Wormwood — i själva verket en påhittad figur skapad för spökattraktionen Sloss Fright Furnace, en hänsynslös skiftledare som 1906 ska ha fallit i ugnen. Under den tid verket leddes av sådana förmän visar dödsregistren att 47 män miste livet i olyckor.

Över hundra anmälningar om misstänkt paranormal aktivitet vid Sloss har noterats i Birminghampolisens register — från ångvisslor som ljuder av sig själva till syner och fysiska angrepp, de flesta i september och oktober, nattetid. Idag är Sloss museum och konsertplats — men järnverkets döda arbetare sägs aldrig ha lämnat sina ugnar.

Källa: hauntedrooms.com + bhamwiki.com + hauntedus.com + thelittlehouseofhorrors.com',
  NULL,NULL,NULL,true,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. SALLIE HOUSE (USA) — den manshatande anden
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'sallie-house','Sallie House','sallie-house','USA','Kansas, Atchison','Hus',
  39.5630,-95.1210,4,false,true,NULL,
  'En flicka dog under en operation utan bedövning — hennes ande river män tills de blöder.',
  'Sallie House i Atchison i Kansas byggdes mellan 1867 och 1871 av Michael C. Finney och är idag en hemsökt turistattraktion.

Enligt sägnen hemsöks huset av anden efter en ung flicka som dog där. En flicka vid namn Sallie ska ha förts till doktor Finney av sin mor med svåra buksmärtor. Läkaren gav henne bedövning och inledde en akut operation, då han trodde att blindtarmen var nära att brista — men han gjorde det första snittet innan bedövningen hunnit verka. Medan han fortsatte skrek Sallie av smärta och förblödde, vilket dödade henne. Det finns dock inga fysiska bevis för att någon Sallie levt eller dött på platsen, och det har sagts att borgmästaren hittade på historien som ett reklamknep för att locka besökare till staden.

Den paranormala aktivitet som gjorde Sallie House berömd började 1993, när Tony Pickman och hans hustru Debra flyttade in. Den drabbade särskilt manliga boende och besökare, varav somliga påstått sig ha blivit rivna tills de blödde — vilket gett Sallie öknamnet "den manshatande anden". Andarna i huset — som tros vara fler än bara lilla Sallie — angrep fysiskt maken och anlade eldar. Vittnen berättar om rivmärken, brännskador, kvävningskänslor, skuggestalter, morrningar och en ständig känsla av att vara bevakad. Sedan 2022 är huset öppet för turer och övernattningar.

Källa: Engelska Wikipedia "Sallie House" + usghostadventures.com + travelks.com + strangeandtwisted.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. HULL HOUSE (USA) — djävulsbarnet i Chicago
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'hull-house','Hull House','hull-house','USA','Illinois, Chicago','Hus',
  41.8720,-87.6470,3,true,false,NULL,
  'Tusentals trängdes för att se "djävulsbarnet" på vinden — och en Vit dam vandrar än.',
  'Hull House i Chicago grundades 1889 av Jane Addams och Ellen Gates Starr som ett socialt settlement för stadens fattiga. Jane Addams blev en av Amerikas mest inflytelserika kvinnor — landets första socialarbetare och första amerikanska kvinna att få Nobels fredspris. Men huset är också känt för en av Chicagos mest ökända skrönor.

Våren 1913 vällde tusentals Chicagobor till Hull House, fast beslutna att få se ett rykte om ett "djävulsbarn" som påstods gömmas på vinden. Beskrivningarna var märkligt samstämmiga: ett vanskapt spädbarn med horn, kluvna hovar, spetsig svans och förmågan att svära och röka cigarr. En populär ursprungsversion handlade om en djupt katolsk kvinna gift med en ateistisk man, som slet ned en bild av jungfru Maria med orden "Jag vill hellre ha djävulens barn". Jane Addams tillbringade veckor med att personligen avvisa folk och dementera i tidningarna — men ju hårdare hon förnekade djävulsbarnet, desto mer övertygade blev folk om att hon gömde det.

Två av Hull Houses tretton byggnader anses hemsökta än idag. Husets "Lady in White" sägs vara Millicent Hull, och spökbarn ska höras springa i den övre korridoren och på gården. Berättelsen om djävulsbarnet tros ha inspirerat skräckromanen Rosemarys Baby från 1967. Idag är Hull House ett museum — men skrönan om vinden lever vidare.

Källa: hullhousemuseum.org + CBS Chicago + ghostcitytours.com + Atlas Obscura',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. ST. AUGUSTINE LIGHTHOUSE (USA) — de drunknade flickorna
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'st-augustine-lighthouse','St. Augustine Lighthouse','st-augustine-lighthouse','USA','Florida, St. Augustine','Fyr',
  29.8850,-81.2880,3,false,true,NULL,
  'Flickorna som drunknade vid fyrbygget hörs ännu skratta i tornet och knyter ihop skosnören.',
  'St. Augustine Lighthouse i Florida är en av USA:s mest omtalat hemsökta fyrar. Spökerierna kretsar främst kring de drunknade Pittee-flickorna.

Deras far Hezekiah anställdes på 1870-talet för att övervaka fyrbygget och tog med sig familjen. Barnen lekte i en järnvägsvagn som användes för att frakta byggmaterial från stranden till bygget. Den 10 juli 1873 slet vagnen sig och hamnade i vattnet. Fem barn föll i; arbetarna räddade en pojke och en flicka, men byggledarens två döttrar Mary och Eliza, samt en ung flicka, drunknade. Bara den yngsta, Carrie, överlevde, och familjen Pittee återvände till Maine för att begrava sina döttrar.

Under de 145 år som gått sedan olyckan har märkliga händelser gång på gång tillskrivits flickornas andar. De sägs höras skratta i tornet sent på natten, och den äldsta, Mary, har skymtats i samma blå sammetsklänning och blå hårrosett som hon bar när hon dog. Enligt fyrpersonalen brukar flickornas spöken knyta ihop besökarnas skosnören, busa med lysstavar som delas ut under turer och leka kurragömma.

Också en av fyrvaktarna, Joseph Andreu, ses och hörs högst uppe i tornet, mer än ett sekel efter sin död — han föll till sin död medan han målade tornets utsida, och hans ande syns ofta blicka ut från toppen.

Källa: staugustinelighthouse.org + ghostsandgravestones.com + hauntedus.com + clickorlando.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
