-- Spökkartan — 10 fler hemsökta platser i USA, omgång 9 (USA 22 -> 32)
-- Genererad 2026-06-10. METOD: engelska sökord -> Wikipedia, usghostadventures.com,
-- Atlas Obscura, bellwitchcave.com, hoteldel.com m.fl. Svenska, 200-600 ord/plats.
-- Koordinater landmärkesnivå (Maps/OSM ej nåbara i miljön) — finverifiera vid behov.
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. SALEM WITCH HOUSE
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'salem-witch-house','Salem Witch House','salem-witch-house','USA','Massachusetts, Salem','Museum',
  42.5220,-70.8967,3,false,true,NULL,
  'Domaren Corwins hem — enda byggnaden kvar med direkt koppling till häxprocesserna 1692.',
  'Salem Witch House i Salem i Massachusetts var hem åt domaren Jonathan Corwin (1640–1718) och är den enda kvarvarande byggnaden i Salem med direkt koppling till häxprocesserna 1692.

Mellan februari 1692 och maj 1693 anklagades över 200 människor för häxeri i kolonin Massachusetts. Trettio fälldes, och nitton av dem avrättades genom hängning — fjorton kvinnor och fem män. En man, Giles Corey, pressades till döds under stenar sedan han vägrat svara på anklagelsen, och minst fem dog i de sjukdomshärjade fängelserna utan rättegång. Avrättningsplatsen, Proctors Ledge, fick ett minnesmärke 2017.

I domare Corwins hem hölls förhören med flera anklagade, däribland Bridget Bishop. Idag är huset ett museum — och sägs vara hemsökt. Besökare berättar om kroppslösa röster och kalla kårar som kryper längs ryggen när de går genom de gamla rummen. Lokalbor påstår att man kan se anden efter Sarah Good, en av de avrättade, vandra över Corwins tomt på jakt efter domaren som dömde henne till döden.

Hela Salem är genomsyrat av häxprocessernas mörka arv, men det är det svarta, branta Witch House — med sina spröjsade fönster och dystra gavlar — som mest påtagligt för besökaren tillbaka till 1692.

Källa: Engelska Wikipedia "Salem witch trials" + usghostadventures.com + salem.org + wanderingeducators.com',
  NULL,NULL,NULL,true,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. BELL WITCH CAVE
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'bell-witch-cave','Bell Witch Cave','bell-witch-cave','USA','Tennessee, Adams','Grotta',
  36.5840,-87.0640,4,false,true,NULL,
  'Amerikas mest dokumenterade hemsökelse — anden "Kate" som svor att döda John Bell.',
  'Bell Witch Cave i Adams i Tennessee är platsen för en av Amerikas mest berömda — och mest dokumenterade — spökhistorier. Legenden kretsar kring familjen Bell, som på 1800-talet bodde vid Red River.

Enligt sägnen drabbades familjen mellan 1817 och 1821 av en mestadels osynlig kraft som kunde tala, påverka sin omgivning och skifta skepnad. Det började med underliga djur på gården och kusliga ljud i stugan, men eskalerade till en röst som hördes i varje rum — och som särskilt terroriserade den yngsta dottern Betsy med slag som lämnade henne medvetslös. Anden kallade sig "Kate" och uttryckte stark vrede när Betsy förlovade sig med en lokal yngling.

Kraften svor att döda fadern John Bell, och tog på sig ansvaret för hans död den 20 december 1820, då en flaska med en främmande vätska hittades vid hans dödsbädd. Tennessee är därmed den enda delstat som erkänt ett dödsfall som orsakat av det övernaturliga. Till och med den blivande presidenten Andrew Jackson lär ha sagt: "Hellre möter jag hela den brittiska armén än tillbringar en natt till med Bell-häxan."

Idag erbjuds turer i grottan och en rekonstruktion av familjens stuga; tusentals besökare kommer årligen för att höra historien om Bell-häxan.

Källa: Engelska Wikipedia "Bell Witch" + bellwitchcave.com + themoonlitroad.com + exploresouthernhistory.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. THE CONJURING HOUSE
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'conjuring-house','The Conjuring House','conjuring-house','USA','Rhode Island, Harrisville','Hus',
  41.9870,-71.6730,4,false,true,NULL,
  'Gården från 1736 som inspirerade skräckfilmen The Conjuring — och familjen Perrons hemsökelse.',
  'The Conjuring House — ursprungligen Arnold Estate — är en gård från 1736 vid 1677 Round Top Road i Harrisville i Rhode Island, känd som den verkliga förlagan till skräckfilmen The Conjuring (2013).

Familjen Perron — föräldrarna Roger och Carolyn och deras fem döttrar — flyttade in i januari 1971 och rapporterade snart paranormal aktivitet. I filmen knyts hemsökelsen till Bathsheba Sherman, som påstås ha varit en barnamörderska, häxa och djävulsdyrkare.

Verkligheten är dock en annan. Bathsheba Sherman bodde aldrig i Perrons gård, utan på Sherman-gården en bit bort. Enligt historiska källor levde hon ett tämligen vanligt liv som arbetsam bondhustru och dog 73 år gammal efter "en plötslig förlamning" — sannolikt en stroke. Den mörka bilden av henne tycks ha skapats av amatörmässig efterforskning och senare spätts på av familjen och de berömda ockulta utredarna Ed och Lorraine Warren, för dramatisk effekt.

Oavsett sägnens sanningshalt har huset blivit ett av USA:s mest besökta spökhus. Familjen Perron berättade om kalla fläckar, dörrar som öppnades av sig själva, dofter av ruttnande kött och en gestalt som visade sig vid sängen om natten. Det drivs idag med turer och övernattningar för paranormala utredare, som vallfärdar till den avlägsna gården för att själva uppleva det som inspirerade en av modern tids mest framgångsrika skräckfilmer.

Källa: Engelska Wikipedia "The Conjuring" + allthatsinteresting.com + bostonghosts.com + skepticalinquirer.org',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. PENNHURST STATE SCHOOL
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'pennhurst-asylum','Pennhurst State School','pennhurst-asylum','USA','Pennsylvania, Spring City','Asyl',
  40.1730,-75.5490,4,false,true,NULL,
  'En institution med ökänd vanvård — "The King" sägs strypa besökare i pannrummet.',
  'Pennhurst State School and Hospital i Pennsylvania öppnade i november 1908 som en institution för fysiskt och psykiskt funktionsnedsatta — både barn och vuxna. Ursprungligen kallad Eastern Pennsylvania State Institution for the Feeble-Minded and Epileptic, stängdes den 1987 efter 79 år av kontrovers.

Anstalten hade en djupt mörk historia. Ett avslöjande i lokala nyheter 1968 visade chockerande förhållanden: de intagna var undernärda, fastspända och utsatta för fysisk och psykisk misshandel, i en miljö präglad av svår överbeläggning och vanvård.

Platsen räknas idag som en av Amerikas mest hemsökta. I den så kallade Q-byggnaden, där barn hölls, har grupper berättat hur en plötslig vindpust släckt deras ljus innan de hört ett barns kroppslösa skratt. "The King", som tros vara anden efter en vaktmästare från 1940- och 50-talen, sägs hålla till i pannrummet i Mayflower-byggnaden och visa sig som en skuggestalt med kraft nog att röra vid — eller till och med strypa — besökare.

År 2010 öppnade den delvis renoverade administrationsbyggnaden som skräckattraktionen Pennhurst Asylum, som drivs under Halloween. Dagtid erbjuds historiska turer och nattetid paranormala utredningar i de förfallande byggnaderna — en omdiskuterad andra akt för en plats med så tungt lidande i sina väggar.

Källa: Engelska Wikipedia "Pennhurst State School and Hospital" + phillyghosts.com + usghostadventures.com + allthatsinteresting.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 5. BOBBY MACKEYS MUSIC WORLD
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'bobby-mackeys','Bobby Mackeys Music World','bobby-mackeys','USA','Kentucky, Wilder','Nattklubb',
  39.0760,-84.4870,4,true,false,NULL,
  'En blodbrunn kallad "porten till helvetet" och Pearl Bryans huvudlösa ande — Amerikas mest hemsökta nattklubb.',
  'Bobby Mackeys Music World i Wilder i Kentucky var en honky tonk och nattklubb som länge kallades USA:s mest hemsökta nattklubb. Platsen användes i början av 1800-talet som slakteri, och i byggnaden fanns en brunn som ledde blod från slaktgolvet ned till floden — en brunn som senare kom att kallas en "port till helvetet".

Enligt legenden hemsöks platsen av flera andar, däribland Pearl Bryan, vars huvudlösa kropp 1896 hittades på ett fält drygt fyra kilometer bort. Hon halshöggs av två män, Alonzo Walling och Scott Jackson, i ett av Kentuckys mest ökända mord. Någon faktisk koppling mellan mordet och platsen har dock aldrig kunnat fastställas, och det lokala historiesällskapet menar att historien ständigt överdrivs.

Countrysångaren Bobby Mackey köpte stället 1978 och gjorde det till sin nattklubb, varpå berättelserna om "porten till helvetet", spökerier och en arg ande växte sig allt starkare — och lockade tv-team som Ghost Adventures.

I mars 2024 stängde nattklubben, och i december samma år revs byggnaden för att ge plats åt en ny anläggning. Men ryktet om den blodiga brunnen och Pearl Bryans rastlösa ande lever vidare som en av Amerikas mest beryktade spökplatser.

Källa: Engelska Wikipedia "Bobby Mackeys Music World" + thelittlehouseofhorrors.com + cincinnatighosts.com + onlyinyourstate.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 6. HOTEL DEL CORONADO
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'hotel-del-coronado','Hotel del Coronado','hotel-del-coronado','USA','Kalifornien, Coronado','Hotell',
  32.6800,-117.1780,3,false,true,NULL,
  'Kate Morgan tog sitt liv i rum 3327 år 1892 — hotellets mest efterfrågade och mest hemsökta rum.',
  'Hotel del Coronado i Coronado utanför San Diego är ett av Kaliforniens mest ikoniska hotell — och hemsökt av Kate Morgan.

Kate Morgan var 24 år när hon på Thanksgiving 1892 checkade in i rum 3327 (då rum 302). Efter fem ensamma dygn tog hon sitt liv. När hennes identitet bekräftats — hon var gift men separerad från sin man — antogs hon ha kommit till hotellet i hopp om att möta en älskare som aldrig dök upp.

Sedan dess kretsar spökerierna kring hennes forna gästrum på tredje våningen. Besökare berättar om flackande lampor, en tv som slås på och av av sig själv, vindpustar från ingenstans, oförklarliga dofter och ljud, föremål som rör sig, dörrar som öppnas och stängs, plötsliga temperaturfall och steg och röster utan källa. Somliga gäster säger sig ha känt fingertoppar stryka över kinden i sömnen, eller sett Kates initialer framträda i taket.

Berättelsen om Kate Morgan fortsätter att fascinera, och hennes rum är det mest efterfrågade på hela hotellet. Också i hotellets butiker och korridorer har personal och gäster berättat om svala fläckar och föremål som faller från hyllorna utan förklaring. Fristående paranormala utredare har med infraröda kameror, mörkerseende och annan utrustning dokumenterat det de menar är övernaturlig aktivitet i det vackra, vita strandhotellet vid Stilla havet — som dessutom är en av landets största träbyggnader.

Källa: hoteldel.com + sandiegomagazine.com + historichotels.org + ghostsandgravestones.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 7. USS LEXINGTON
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'uss-lexington','USS Lexington','uss-lexington','USA','Texas, Corpus Christi','Fartyg',
  27.8150,-97.3890,3,false,true,NULL,
  '"Det blå spöket" — hangarfartyget vars döde sjöman Charlie ännu guidar besökare i maskinrummen.',
  'USS Lexington är ett hangarfartyg från andra världskriget, sjösatt 1943, som idag ligger som museifartyg i Corpus Christi i Texas. Det kallas "the Blue Ghost" — det blå spöket.

Smeknamnet kommer från japansk krigspropaganda: Lexington rapporterades sänkt inte mindre än fyra gånger, men återvände gång på gång till strid, som ett spöke. Fartyget tjänade omkring 21 månader i Stillahavskriget och bar på en av flottans mest legendariska krigshistorier.

Sedan det öppnade som museum 1992 har fartyget samlat på sig berättelser om kusliga händelser, och blivit ett av Texas mest omtalade spökmål. Den mest berömda anden är "Charlie" — en väluppfostrad sjöman med genomträngande blå ögon, klädd i en gammaldags vit flottuniform som besättningen inte längre använder. Han tros ha dödats i en kamikazeattack 1944, och sägs förvåna besökare med sin ingående kännedom om fartyget och dess maskiner.

Andra vittnen berättar om spökhänder som rört vid dem, kroppslösa röster och skrik i korridorerna, ibland med ljud av gevärseld, samt skrammel av kedjor och hissar som rör sig av sig själva. Under sin krigstjänst förlorade fartyget åtskilliga besättningsmän i strid, bränder och olyckor, och många menar att det är deras själar som ännu vakar i de trånga, stålklädda utrymmena. Idag erbjuds spökturer ombord, och varje oktober förvandlas det väldiga fartyget till södra Texas största spökhus.

Källa: hauntedus.com + visitcorpuschristi.com + hauntedrooms.com + authentictexas.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 8. ROBERT THE DOLL
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'robert-the-doll','Robert the Doll (Fort East Martello)','robert-the-doll','USA','Florida, Key West','Museum',
  24.5520,-81.7870,4,false,true,NULL,
  'Världens mest beryktade hemsökta docka — förbannar dem som fotar honom utan att fråga om lov.',
  'Robert the Doll är en av världens mest beryktade hemsökta dockor, utställd på Fort East Martello Museum i Key West i Florida.

Dockan tillhörde Robert Eugene "Gene" Otto, som fick den som ung pojke i början av 1900-talet. Enligt en version köptes den av hans morfar på en resa till Tyskland, enligt en annan gavs den av en tjänsteflicka med onda avsikter. Den halmfyllda dockan tillverkades omkring 1904, och Gene utvecklade ett ovanligt förhållande till den.

Familjen Otto ska ha hört Robert fnissa runt om i huset, och förbipasserande påstod sig se en liten docka röra sig från fönster till fönster. Enligt legenden kan dockan röra sig, ändra ansiktsuttryck och fnissa. Lokal folktro tillskriver Robert bilolyckor, benbrott, förlorade jobb, skilsmässor och en mängd andra olyckor — och besökare sägs drabbas av "olyckor efter besöket" om de inte visar honom respekt.

År 1994 skänktes dockan till museet, inrymt i ett gammalt fort från inbördeskriget, där den nu sitter bakom plexiglas och tar emot hundratals besökare i veckan. Roberts favorittilltag sägs vara att förbanna dem som fotograferar honom utan att först be om lov — och väggarna kring hans monter är täckta av brev från ångerfulla besökare som ber om förlåtelse.

Källa: Engelska Wikipedia "Robert (doll)" + Atlas Obscura + hauntedkeywest.com + kwahs.org',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 9. SORREL-WEED HOUSE
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'sorrel-weed-house','Sorrel-Weed House','sorrel-weed-house','USA','Georgia, Savannah','Herrgård',
  32.0740,-81.0980,3,false,true,NULL,
  'Två kvinnor sägs vandra här — hustrun Matilda och den förslavade Molly, funnen hängd i vagnshuset.',
  'Sorrel-Weed House på 6 West Harris Street i Savannah i Georgia uppfördes 1839–40 åt den förmögne skeppshandlaren Francis Sorrel. Det är ett av Savannahs finaste exempel på grekisk nyklassicism och Regency-arkitektur, och blev 1954 ett av delstatens första byggnadsminnen.

Huset är ökänt för sitt rykte som hemsökt. Det sägs hemsökas av två kvinnliga uppenbarelser: Matilda Sorrel, husägarens hustru, och en ung förslavad flicka vid namn Molly. Enligt sägnen ska Francis Sorrel ha haft en affär med Molly; Matilda upptäckte förhållandet och tog sitt liv, varpå Molly kort därefter hittades hängd i vagnshuset.

Historiskt är bilden mer komplicerad. Det finns tidningsartiklar som styrker Matildas död, men inga belägg för Mollys — tvärtom visar register att Francis ägde en förslavad flicka vid namn Molly som 1857 fraktades från Savannah till New York.

Besökare berättar om mörka gestalter som vandrar genom husets salar, kvinnor som skymtar i speglarna och en påtagligt ond energi, särskilt i källaren och i de gamla slavkvarteren på baksidan, där röster och steg ofta hörs. Huset har figurerat i flera tv-program om det paranormala, bland annat Ghost Hunters, vilket gjort det till ett av Savannahs mest besökta spökhus. Idag erbjuds historiska turer dagtid och spökturer efter mörkrets inbrott, samt nattliga paranormala "lock-ins" för dem som vill utforska huset med egen utrustning.

Källa: Engelska Wikipedia "Sorrel–Weed House" + usghostadventures.com + savannahghosttour.com + destinationghost.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 10. THE DRISKILL HOTEL
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'driskill-hotel','The Driskill Hotel','driskill-hotel','USA','Texas, Austin','Hotell',
  30.2685,-97.7415,3,false,true,NULL,
  'Cigarrök från en död baron och en brud i rum 525 — Austins mest hemsökta hotell.',
  'The Driskill Hotel i Austin i Texas öppnade den 20 december 1886 och blev snabbt ett av söderns mest storslagna hotell. Det byggdes av boskapsbaronen överste Jesse Driskill — som dog redan 1890 och fick föga tid att njuta av sitt hotell, vilket kanske är skälet till att hans ande sägs dröja kvar.

Driskill rökte ständigt cigarr, och många har känt doften av cigarrök i lobbyn trots att hotellet sedan länge är rökfritt. En anställd som försökte spåra lukten hörde en röst bakom sig be om en tändsticka — men ingen fanns där.

Mest ökänt är rum 525, där två tragedier utspelat sig med ett sekel emellan. På 1800-talet tog en brud sitt liv i rummet sedan hennes blivande make ställt in bröllopet; sedan dess har gäster sett en kvinna i viktoriansk brudklänning i korridoren utanför. År 1991 sköt en jiltad societetskvinna från Houston sig i rummets badkar efter att ha shoppat på sin före detta fästmans bekostnad.

En annan ande sägs vara fyraåriga Samantha Houston, dotter till en senator, som omkom i en olycka i hotellets stora trappa 1887; hennes skratt och studsande boll hörs ibland i trappan. Gäster har även berättat om tavlor vars motiv tycks röra sig, hissar som stannar på fel våning och en känsla av att bli iakttagen i de pampiga korridorerna. År 2022 toppade Driskill Yelps lista över Austins mest hemsökta hotell.

Källa: austinghosts.com + usghostadventures.com + moonmausoleum.com + hauntedus.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
