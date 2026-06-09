-- Spökkartan — 4 fler hemsökta platser i USA (haunted places)
-- Genererad 2026-06-09. Kompletterar 21/22_USA_PLACES (Stanley, Myrtles,
-- Winchester, Lizzie Borden, Trans-Allegheny, LaLaurie, Amityville, Eastern
-- State, Alcatraz, Waverly Hills, Bell Witch, Gettysburg — utelämnas här).
--
-- METOD: engelska sökord (haunted places, ghosts, most haunted) -> sidor som
-- samlat spökhistorier (hauntedrooms.com, usghostadventures.com, ghostcitytours.com,
-- Atlas Obscura, Smithsonian m.fl. samt engelska Wikipedia). Skrivet på SVENSKA,
-- 200-600 ord/plats, aldrig fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. RMS QUEEN MARY (USA) — det hemsökta skeppet
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'rms-queen-mary','RMS Queen Mary','rms-queen-mary','USA','Kalifornien, Long Beach','Fartyg',
  33.7522,-118.1903,3,false,true,NULL,
  'Lyxångaren med över 150 andar — i hytt B340 dras täcken av nybäddade sängar.',
  'RMS Queen Mary, en gång världens lyxigaste oceanångare, tjänade som trupptransport under andra världskriget och ligger sedan dess permanent förtöjd i Long Beach i Kalifornien — idag ett av USA:s mest omtalat hemsökta fartyg. Skeppet sägs hysa över 150 andar, och både personal och besökare rapporterar regelbundet om vad som kan vara paranormal aktivitet.

Mest ökänd är hytt B340. Gäster och städerskor har funnit badrumskranen rinnande utan att någon bott i rummet, och täcken bortdragna strax efter att sängen bäddats. Under 1970-talet stängdes B340 av, men 2018 öppnades den åter som spökattraktion.

Den nu tömda förstaklasspoolen sägs hemsökas av minst två andar — bland dem en liten flicka vid namn Jackie, som ska ha drunknat i poolen på 1940-talet. Gäster och guider berättar att de hör hennes skratt och plask.

Det finns dock betydande skepsis kring historierna. Det finns ingen notering om att någon drunknat i vare sig första- eller andraklasspoolen, och inget register över en styckad kropp i B340 eller de tre tredjeklasshytter som rummet en gång slogs samman av. Huvuddelen av spökaktiviteten började omkring 1989 — vilket vissa kopplar till Disney, som då drev fartyget och var känt för att väva fängslande berättelser. Sant eller påhittat: Queen Mary förblir ett av Amerikas mest besökta spökskepp.

Källa: hauntedrooms.com + usghostadventures.com + ghostcitytours.com + worldofcruising.co.uk',
  NULL,NULL,NULL,true,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. 1886 CRESCENT HOTEL (USA) — "Amerikas mest hemsökta hotell"
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'crescent-hotel','1886 Crescent Hotel','crescent-hotel','USA','Arkansas, Eureka Springs','Hotell',
  36.4097,-93.7383,3,false,true,NULL,
  'Kvacksalvaren Norman Bakers falska cancerklinik — bårhus, lik-kylrum och spöklika sjuksköterskor.',
  'Crescent Hotel i Eureka Springs i Arkansas, byggt 1886, kallas ofta "Amerikas mest hemsökta hotell". Det uppfördes som en lyxanläggning för förmögna resenärer, men dess mörka rykte vilar på en senare epok.

År 1937 köptes hotellet av Norman Baker, en karismatisk men bedräglig figur utan någon medicinsk utbildning, som redan jagats ut ur sin hemstat Iowa. Han gjorde om hotellet till Baker Cancer Clinic och utgav sig för att ha botemedlet mot cancer. En av hans "behandlingar" bestod i att borra hål i patienternas skallar och spruta in en blandning av källvatten, majssilke, karbolsyra och malda vattenmelonfrön. År 1940 greps och fängslades Baker för postbedrägeri.

En arkeologisk utgrävning har senare blottlagt hundratals flaskor med Bakers "hemliga formel" och burkar med kirurgiska "preparat" tagna ur patienter. Till den makabra atmosfären hör också ett bårhus från Bakers tid, med obduktionsbord och en kylkammare för lik.

Under de senaste 25 åren har Crescent fått rykte som "Amerikas mest hemsökta hotell", uppmärksammat i sjutton nationella och internationella paranormala tv-program. Gäster berättar om spöklika sjuksköterskor som skjuter bårvagnar, uppenbarelser av forna patienter, underliga ljus som driver genom korridorerna och steg som ekar i tomma rum. Idag tar hotellet emot både vanliga gäster och spöksökare.

Källa: crescent-hotel.com + Smithsonian Magazine + usghostadventures.com + Atlas Obscura',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. VILLISCA AXE MURDER HOUSE (USA) — det olösta massmordet
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'villisca-axe-murder-house','Villisca Axe Murder House','villisca-axe-murder-house','USA','Iowa, Villisca','Hus',
  40.9300,-94.9760,5,false,true,NULL,
  'Åtta människor — sex av dem barn — yxmördades i sömnen 1912. Mordet är ännu olöst.',
  'Villisca Axe Murder House i den lilla orten Villisca i Iowa är en av delstatens mest ökända spökplatser — skådeplatsen för ett brutalt och ännu olöst massmord.

Natten mellan den 9 och 10 juni 1912, efter en kyrkogudstjänst, blev åtta människor ihjälslagna med en yxa medan de sov. Offren var föräldrarna Josiah B. Moore (43) och Sarah (39), deras fyra barn Herman (11), Mary Katherine (10), Arthur (7) och Paul (5), samt två gästande flickor, Ina May (8) och Lena Stillinger (11). Alla åtta hade svåra huvudskador; Josiah ensam hade träffats minst trettio gånger.

Utredningen pekade ut flera misstänkta. Pastorn George Kelly bekände inför rätten, men juryn trodde inte på bekännelsen, och han friades efter två rättegångar. I boken "The Man from the Train" (2017) hävdar Bill och Rachel James att mördaren var Paul Mueller, en tysktalande immigrant som var föremål för en år lång men resultatlös klappjakt. Brottet är än idag olöst.

Ett par köpte huset 1995 och återställde det till hur det såg ut 1912, utan moderna installationer. Idag erbjuds guidade turer och övernattningar i huset — vars främsta dragningskraft är att det sägs vara hemsökt av offren. Få platser i USA bär på en så tung och konkret tragedi.

Källa: Engelska Wikipedia "Villisca axe murders" + murderhouse.com + allthatsinteresting.com + traveliowa.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. LEMP MANSION (USA) — bryggardynastins självmord
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'lemp-mansion','Lemp Mansion','lemp-mansion','USA','Missouri, St. Louis','Herrgård',
  38.5970,-90.2230,3,false,true,NULL,
  'Fyra i bryggarfamiljen Lemp tog sina liv — tre av dem innanför husets väggar.',
  'Lemp Mansion på DeMenil Place i Benton Park i St. Louis, Missouri, byggdes 1890 och räknas till stadens mest hemsökta byggnader. Bakom spökhistorierna ligger en av Amerikas mest tragiska bryggardynastier.

John Adam Lemp kom till St. Louis från Eschwege i Tyskland 1838 och byggde 1840 ett blygsamt bryggeri. William J. Lemp Brewing Co. växte till en dominerande kraft på den amerikanska ölmarknaden före förbudstiden, särskilt känd för ölmärket Falstaff.

Men familjen drabbades av en rad självmord. Mellan 1904 och 1949 tog fyra medlemmar av familjen Lemp sina liv, tre av dem innanför husets väggar. Det första skedde den 13 februari 1904, då William sköt sig i huvudet med en revolver i sitt sovrum. År 1920 tog hans dotter Elsa, ansedd som St. Louis rikaste arvtagerska, sitt liv. William J. Lemp Jr. sköt sig i samma byggnad där hans far dött arton år tidigare, och brodern Charles, som bodde kvar i huset, dog likaså för egen hand.

Sedan dess sägs herrgården vara hemsökt av familjen Lemps andar. Besökare och personal berättar om steg, röster och skuggor i de gamla rummen. Idag är Lemp Mansion en restaurang med övernattningsrum — där gästerna kan dela natten med den olycksdrabbade familjens gengångare.

Källa: Engelska Wikipedia "Lemp Mansion" + ghostcitytours.com + Atlas Obscura + lempmansion.com',
  NULL,NULL,NULL,false,true,'published','web_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
