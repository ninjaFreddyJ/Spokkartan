-- Spökkartan — 4 fler hemsökta platser i Österrike (Österreich), omgång 2
-- Genererad 2026-06-09. Fortsättning på 38_AUSTRIA_SPUKORTE.
--
-- METOD: tyska sökord (Hexenprozesse, Spuk, Geist, Teufelskammer, Sage) ->
-- sidor som samlat spökhistorier (travelbook.de, schlossmoosham.at,
-- steiermark.com, servus.com m.fl. samt tyska/engelska Wikipedia). Skrivet på
-- SVENSKA, 200-600 ord/plats, aldrig fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. SCHLOSS MOOSHAM (Österrike) — häxborgen
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'schloss-moosham','Schloss Moosham','schloss-moosham','Österrike','Salzburg, Lungau','Slott',
  47.1280,13.7770,5,false,false,NULL,
  '"Österrikes häxborg" — 66 avrättningar, tortyrkammare och varulvsprocesser i Lungau.',
  'Schloss Moosham i Unternberg i Lungau i Salzburg kallas ofta "Österrikes häxborg". På 1300-talet blev slottet säte för blods- och pleggerätten i Lungau, där de svåraste brotten avgjordes — däribland häxprocesser.

Mellan 1534 och 1762 ägde 66 avrättningar rum, varav 44 gällde personer anklagade för trolldom och häxeri. I Lungau krävde häxprocesserna 13 manliga och 22 kvinnliga offer. De anklagade hölls i fängelseceller i häxtornet, intill den bevarade tortyrkammaren med sträckbänk, munsperrar, tumskruvar och ett rep i vilket människor hissades upp baklänges.

Två unga tiggare bekände under tortyr att de fått en svart salva av djävulen, smort in sig och förvandlats till varulvar; domen blev livstids slavtjänst på venetianska galärer. När en bekännelse pressats fram och domen fallit rullade rackarkärran till avrättningsplatsen vid Passeggen nära Tamsweg, där skarprättaren väntade med rättssvärdet.

Kring Schloss Moosham ringlar sig många spökhistorier. Besökare i tortyrkammaren berättar om spöklika beröringar av osynliga händer och möbler som rör sig av sig själva. Med tanke på allt det dokumenterade lidandet är det inte underligt att slottet räknas till Österrikes mest hemsökta — en plats där historiens grymhet tycks sitta kvar i de kalla murarna. Många besökare beskriver en tryckande, olustig känsla redan i borggården, och guiderna har samlat på sig otaliga berättelser om oförklarliga ljud, skuggor och kyla i de gamla domstols- och tortyrutrymmena.

Källa: travelbook.de + schlossmoosham.at + Tyska Wikipedia "Schloss Moosham" + sn.at',
  NULL,NULL,NULL,true,true,'published','web_at_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. SCHLOSS SCHÖNBRUNN (Österrike) — Sisis rastlösa ande
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'schloss-schoenbrunn','Schloss Schönbrunn','schloss-schoenbrunn','Österrike','Wien','Slott',
  48.1845,16.3120,2,false,false,NULL,
  'Kejsarinnan Sisi flydde sin gyllene bur — och sägs vandra i slottet ännu efter sin död.',
  'Schloss Schönbrunn i Wien, habsburgarnas väldiga sommarresidens, är inte bara ett av Europas mest besökta slott — det sägs också vara hemsökt.

Kejsarinnan Elisabeth, "Sisi", upplevde under sin livstid Schönbrunn som en gyllene bur som hon ständigt försökte fly. Det lyckades aldrig riktigt — vare sig i livet eller efter döden. Otaliga berättelser gör gällande att den vackra kejsarinnan ännu hemsöker slottet.

Tre guider påstår sig upprepade gånger ha sett Sisis bleka gestalt tillsammans med hennes kammarfriserska Fanny Feifalik i kejsarinnans toalettrum. Besökare berättar gång på gång om två kvinnogestalter i just det rummet, varav den ena tycks vara en hårfriserska.

Men Sisi är inte ensam. Enligt kejsarinnan Zita, gift med kejsar Karl I, lär ännu en adelsdam regelbundet besöka slottet: grevinnan Wilhelmine Auersperg, som sägs ha svävat omkring i salarna långt efter sin död. Dessa berättelser förblir folktro och spökhistorier snarare än bekräftade fenomen — men de ger en mörkare, mer melankolisk klang åt det praktfulla kejsarslottet med sina 1 441 rum. Sisi, vars liv präglades av rastlöshet, depression och till slut mordet i Genève 1898, sägs vandra ännu i just de gyllene rum hon en gång längtade bort ifrån, och för många besökare är det den olyckliga kejsarinnans skugga, snarare än prakten, som dröjer kvar längst i minnet.

Källa: schoenbrunn.at + servus.com + web.de + gmx.at',
  NULL,NULL,NULL,false,true,'published','web_at_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. BURG RIEGERSBURG (Österrike) — blomsterhäxan
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'burg-riegersburg','Burg Riegersburg','burg-riegersburg','Österrike','Steiermark, Riegersburg','Borg',
  47.0010,15.9370,4,false,false,NULL,
  'Blomsterhäxan som fick blommor att slå ut mitt i vintern — och brändes som häxa 1675.',
  'Burg Riegersburg tronar på en brant vulkanklippa i Steiermark i sydöstra Österrike och är förknippad med en av landets mest kända häxor: Katharina Paldauf, "blomsterhäxan".

Katharina föddes omkring 1625 i Fürstenfeld och var gift med borgens slottsfogde. Vid tjugo års ålder trädde hon i tjänst hos Katharina Elisabeth von Galler, dåvarande ägare av Riegersburg, och odlade med stor passion en mängd blomsterarter i ett dolt litet blomsterparadis i sin kammare. Enligt traditionen lyckades hon få blommor att slå ut även mitt i vintern — en förmåga som saknar grund i processakterna men som gett henne eftervärldens namn "blomsterhäxan".

Våren 1675, då Katharina var omkring femtio år, angavs hon av en bagare på Riegersburg som påstod sig ha sett henne utöva häxeri och styra vädret. Först nekade hon, men under senare förhör erkände hon att hon deltagit i häxsabbater och "gjort väder". Hon blev den mest framträdande av offren i den stora häxprocessen i Feldbach (1673–1675).

Katharina dog troligen den 23 september 1675. På grund av sin höga sociala ställning beviljades hon en "lindring" — hon dödades innan hon brändes på bål. Inga bevarade domstolshandlingar styrker dock själva trolldomen; blomsterhäxan av Riegersburg förblir en legend, och hennes öde lever vidare i borgens häxmuseum.

Källa: steiermark.com + austria-forum.org + Engelska Wikipedia "Katharina Paldauf" + dieriegersburg.at',
  NULL,NULL,NULL,false,true,'published','web_at_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. SCHLOSS TRATZBERG (Österrike) — Teufelskammer
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'schloss-tratzberg','Schloss Tratzberg','schloss-tratzberg','Österrike','Tirol, Inntal','Slott',
  47.3760,11.7250,3,false,false,NULL,
  'Djävulen släpade en sovande riddare genom väggen — i rummet som kallas Teufelskammer.',
  'Schloss Tratzberg är ett sengotiskt slott som tronar högt över Inntal i Tirol. Det sägs vara hemsökt — i ett rum känt som Teufelskammer, "djävulskammaren".

Enligt sägnen hämtades en gång en riddare av djävulen själv. I stället för att gå till mässan föredrog han att sova — och som straff släpade den onde honom rakt genom väggen. Blodfläckarna efter dådet ska enligt legenden ha varit synliga under lång tid.

Slottet sägs alltjämt spöka i just Teufelskammer. De boende berättar om ljud från detta särskilda rum, och en barnsköterska påstod sig ha hört en dörr slå igen i rummet ovanför henne — trots att den platsen murats igen för hundratals år sedan. Den nuvarande slottsfrun har själv aldrig stött på något spöke, men hennes dotter berättade som barn om gåtfulla möten med en sedan länge död förfader.

Spökjägare som undersökt fenomenen har spelat in video av olika ljusfenomen i Teufelskammer och ljudupptagningar av stegliknande ljud. Vad som än döljer sig bakom de igenmurade väggarna förblir slottets djävulskammare en av Tirols mest omtalade spökplatser, dit besökare söker sig för att kika in i det rum där djävulen sägs ha hämtat sitt offer. Det sengotiska slottet, med sina rikt bemålade salar och sin berömda Habsburgersaal, hör annars till de bäst bevarade i hela Alperna — men det är den lilla, instängda Teufelskammer som ger Tratzberg dess kusliga rykte.

Källa: servus.com + geisterundgespenster.de + gmx.at + tirolerin.at',
  NULL,NULL,NULL,false,true,'published','web_at_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
