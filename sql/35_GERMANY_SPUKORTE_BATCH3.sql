-- Spökkartan — 3 fler hemsökta platser i Tyskland (Deutschland), omgång 3
-- Genererad 2026-06-09. Fortsättning på 33/34_GERMANY_SPUKORTE.
--
-- METOD (samma generella lösning): tyska sökord (Spukhaus, Hexenkeller,
-- Hexenverfolgung, Sage, Geist, Lost Place, Drache/Nibelungen) -> sidor som
-- samlat spökhistorier (travelbook.de, alte-burg.amt-penzliner-land.de,
-- drachenwolke.com, koeln.mitvergnuegen.com m.fl. samt tyska Wikipedia/
-- Wikisource). Svenska, 200-600 ord/plats, aldrig fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. ALTE BURG PENZLIN (Tyskland) — häxkällaren
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'alte-burg-penzlin','Alte Burg Penzlin','alte-burg-penzlin','Tyskland','Mecklenburg-Vorpommern, Penzlin','Borg',
  53.5046,13.0814,4,false,false,NULL,
  'Europas enda bevarade häxfängelse från 1560 — i de djupaste valven hörde ingen de torterades skrik.',
  'Alte Burg Penzlin ligger i staden Penzlin sydväst om Neubrandenburg i Mecklenburg-Vorpommern och rymmer en av Europas mest skräckinjagande källare. År 1560 byggdes här en så kallad Hexenkeller — en häxkällare och tortyrkällare. I de djupaste valven finns Europas enda bevarade häxfängelse från tidigmodern tid som exakt följde reglerna i Malleus Maleficarum, "Häxhammaren".

Djupt under jorden, dit inga skrik nådde upp, torterades de anklagade. Bland redskapen fanns stolar besatta med spikar. I det understa fängelsehålet finns flera stora väggnischer som i sekler kallats "häxnischerna" — man misstänker att människor kedjades fast i dem bakom kraftiga trädörrar.

Häxförföljelserna i Mecklenburg krävde fram till sitt slut uppemot 2 000 människors liv på bålet. Rättegången mot Benigna Schultzen i Penzlin har fått överregional betydelse som en av de längsta: hennes inkvisitions- och revisionsprocess sträckte sig över tolv år, från 1699 till 1711.

Sedan 1994 inhyser borgen ett specialmuseum för magi och häxförföljelser i Mecklenburg. Besökare berättar om en tryckande, iskall stämning i de underjordiska valven — som om de torterade själarna aldrig riktigt lämnat platsen. Få murar i Tyskland bär på ett så konkret och dokumenterat lidande som Penzlins häxkällare.

Källa: travelbook.de + alte-burg.amt-penzliner-land.de + Tyska Wikipedia "Alte Burg Penzlin" + Gerda Henkel Stiftung (lisa.gerda-henkel-stiftung.de)',
  NULL,NULL,NULL,true,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. DRACHENFELS (Tyskland) — Siegfried och draken
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'drachenfels','Drachenfels','drachenfels','Tyskland','Nordrhein-Westfalen, Königswinter','Ruin',
  50.6680,7.2070,2,true,false,NULL,
  'Drakklippan vid Rhen — här ska Siegfried ha dräpt draken och badat i dess blod.',
  'Drachenfels ("Drakklippan") är ett berg i Siebengebirge mellan Königswinter och Bad Honnef vid Rhen, krönt av en medeltida borgruin. Namnet bär på en av Tysklands äldsta sägner.

Enligt Nibelungensägnen dödade hjälten Siegfried av Xanten en drake som levde i en håla på Drachenfels. Efter segern badade han i drakens blod, vilket gjorde honom osårbar — men ett lindlöv föll på hans skuldra och lämnade en enda sårbar fläck, den som långt senare blev hans död. I vissa versioner kallas draken Fafnir.

Vid bergets fot ligger Nibelungenhalle i Königswinter, invigd 1913 till hundraårsminnet av Richard Wagners födelse. Tolv mystiska väggmålningar skildrar scener ur Wagners "Nibelungens ring", och en stor drakskulptur vaktar platsen. Sedan 1883 förbinder Drachenfelsbahn — Tysklands äldsta ännu drivna kuggstångsjärnväg — staden med berget.

Drachenfels är en av de mest besjungna Rhenklipporna, romantiserad av diktare och målare genom seklen. När dimman lägger sig kring den uråldriga ruinen är det inte svårt att föreställa sig draken i sin håla — och hjälten som steg ned i mörkret för att möta den. Sägnen om Siegfried och draken har gjort berget till en av hela Rhendalens mest sägenomspunna platser.

Källa: varta-guide.de + drachenwolke.com + travelbook.de + Tyska Wikisource "Siegfried auf dem Drachenfelsen"',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. HAUS FÜHLINGEN (Tyskland) — Kölns spökvilla
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'haus-fuehlingen','Haus Fühlingen','haus-fuehlingen','Tyskland','Nordrhein-Westfalen, Köln','Övergiven',
  51.0330,6.8850,4,false,false,NULL,
  'Kölns beryktade gruselvilla, byggd på en blodåker — tre män har hängt sig i samma våning.',
  'Haus Fühlingen i Köln byggdes 1888 som sommarresidens åt Eduard friherre von Oppenheim, ur familjen bakom Kölnbanken Sal. Oppenheim. Idag är den en gång eleganta villan en övergiven ruin med en mörk och delvis fullt verklig historia.

Huset restes på den så kallade Blutacker ("blodåkern") — marken där mer än 1 000 människor stupade i slaget vid Worringen 1288. Enligt sägnen spökar här anden efter en polsk tvångsarbetare som mördades av nazisterna 1943: den då 19-årige Edward Margol, som offentligt hängdes av Gestapo i ett gammalt tegelbruk nära villan.

Till legenden hör flera verkliga tragedier. Nyårsnatten 1962 ska en man vid namn van Kempen ha hängt sig på husets andra våning. Hans änka levde kvar som villans sista invånare ensam ända till år 2000. Och 2007, 45 år efter van Kempens självmord och långt efter att villan övergivits, hängde sig ännu en man på exakt samma andra våning.

Dessa dystra dödsfall har gjort Haus Fühlingen till en av Kölns mest beryktade "gruselvillor", omsusad av spökhistorier om röster, skuggor och plötslig kyla. I maj 2023 strök staden Köln slutligen villan från kulturminneslistan — vilket innebär att det förfallna spökhuset nu i teorin får rivas.

Källa: koeln.mitvergnuegen.com + t-online.de (koeln.t-online.de) + verliebtinkoeln.com + travelbook.de',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
