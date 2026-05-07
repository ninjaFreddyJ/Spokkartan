-- Spökkartan — Australien (20 platser)
-- Genererad 2026-05-06. Källa: Användarens forskningsrapport.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. PORT ARTHUR (Tasmanien)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'port-arthur','Port Arthur','port-arthur','Australien','Tasmanien','Straffkoloni',
  -43.1492,147.8542,5,false,false,NULL,
  'Brittiska imperiets fruktade straffkoloni — över 1 000 dog under driften.',
  'Detta världsarv var en gång en av de mest fruktade straffkolonierna i det brittiska imperiet. Mellan 1833 och 1877 hölls de mest svårhanterliga fångarna här. Över 1 000 personer dog under de dryga 40 åren av drift. Platsens rykte förvärrades ytterligare av massakern 1996.

Den mest aktiva delen sägs vara "The Separate Prison", en byggnad designad för att reformera fångar genom total isolering och tystnad. Denna metod drev många till vansinne, och vittnesmål från guider och turister inkluderar ljudet av snyftningar som kommer från de små, fönsterlösa cellerna.

Ett annat vanligt fenomen är "The Blue Lady", en kvinna som tros ha dött i barnsäng på platsen och som ses vandra nära den gamla kyrkan. Port Arthur beskrivs ofta som en plats där "slöjan mellan världarna" är exceptionellt tunn.',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. ARADALE ASYLUM (Victoria)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'aradale-asylum','Aradale Asylum','aradale-asylum','Australien','Victoria, Ararat','Mentalsjukhus',
  -37.2942,142.9411,5,false,false,NULL,
  '13 000 patienter dog inom murarna under 126 år av drift.',
  'Detta massiva komplex i Ararat var hem för tusentals patienter som betraktades som obotligt sjuka under 1800- och 1900-talen. Det uppskattas att omkring 13 000 personer dog inom asylens väggar under dess 126 år i bruk.

En av de mest kända hemsökelserna rör "Nurse Kerry", en sträng sjuksköterska som sägs vaka över de döda patienterna i männens flygel. Besökare på guidade turer har rapporterat om att de blivit knuffade, känt plötsliga köldvågor och hört tunga dörrar slå igen trots att de varit låsta.

En särskild plats för paranormal aktivitet är "The Suicide Walk", en täckt bro där förtvivlade patienter sades ta sina liv.',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. FREMANTLE PRISON (Western Australia)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'fremantle-prison','Fremantle Prison','fremantle-prison','Australien','Western Australia, Fremantle','Fängelse',
  -32.0578,115.7533,4,false,false,NULL,
  '44 hängningar och otaliga prygel — fängelset byggt av fångar själva.',
  'Byggt av fångar på 1850-talet med kalksten från platsen, förblev detta fängelse i bruk fram till 1991. Det var scenen för 44 hängningar och otaliga fall av prygling. Området kring galgen sägs ha en extremt tung och deprimerande energi som tappar besökare på deras vitalitet.

De underjordiska tunnlarna, där fångar arbetade under farliga förhållanden, rapporteras vara hemsökta av skuggfigurer och ljudet av hackor mot sten. Vittnesmål från tidigare vakter inkluderar syner av fångar i historiska kläder som marscherar genom cellblocken under nattskiftet.',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. QUARANTINE STATION (NSW)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'quarantine-station-sydney','Quarantine Station','quarantine-station-sydney','Australien','New South Wales, Sydney','Karantänstation',
  -33.8131,151.2917,4,false,true,NULL,
  'Sydneys karantänstation — över 500 dog här i pest, kolera och smittkoppor.',
  'Belägen vid det natursköna North Head vid Sydneys hamninlopp, bär denna plats på minnet av dem som anlände till Australien med hopp om ett nytt liv, men istället mötte döden i karantän. Mellan 1833 och 1984 dog över 500 personer här i sjukdomar som böldpest, kolera och smittkoppor.

Sjukhusbyggnaden anses vara den mest hemsökta. Besökare har känt doften av desinfektionsmedel i tomma rum och sett uppenbarelsen av "The Matron", en sjuksköterska som sägs fortsätta sitt arbete med att se efter de sjuka genom att titta till besökare när de vilar.',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 5. THE DEVIL'S POOL (Queensland)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'devils-pool-babinda','The Devil''s Pool','devils-pool-babinda','Australien','Queensland, Babinda','Naturplats',
  -17.4211,145.8942,4,true,false,NULL,
  'Aboriginsk legend om Oolanas hämnd — 17+ unga män har drunknat sedan 1959.',
  'Denna naturliga klippbassäng nära Babinda är djupt förknippad med aboriginsk folklore. Enligt legenden dränkte sig en ung kvinna vid namn Oolana här efter att ha skilts från sin älskare. Hennes ande sägs nu hemsöka poolen och locka unga män i döden genom att dra ner dem under ytan.

Det är ett faktum att minst 17 unga män har drunknat på platsen sedan 1959, ofta under förhållanden som verkat oförklarliga för erfarna simmare. Platsen är idag inhägnad, men legenden lever kvar som en varning om naturens farliga och ibland hämndlystna krafter.',
  NULL,NULL,NULL,true,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 6. OLD MELBOURNE GAOL
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'old-melbourne-gaol','Old Melbourne Gaol','old-melbourne-gaol','Australien','Victoria, Melbourne','Fängelse',
  -37.8078,144.9664,4,false,false,NULL,
  '133 hängningar — Ned Kellys avrättningsplats är nu Melbournes mest hemsökta byggnad.',
  'Old Melbourne Gaol var ett av Australiens mest beryktade fängelser, byggt 1845. 133 personer hängdes här, inklusive den ökända bushrangern Ned Kelly. Idag är det ett museum med en stark paranormal renommé.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 7. BEECHWORTH ASYLUM (Victoria)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'beechworth-asylum','Beechworth Asylum','beechworth-asylum','Australien','Victoria, Beechworth','Mentalsjukhus',
  -36.3644,146.6856,4,false,false,NULL,
  'Mentalsjukhus från 1867 — över 9 000 dog under verksamheten.',
  'Beechworth Asylum (även känt som Mayday Hills) öppnade 1867 och stängde 1995. Över 9 000 patienter beräknas ha dött här. Idag erbjuds spökvandringar i de övergivna byggnaderna.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 8. MAITLAND GAOL (NSW)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'maitland-gaol','Maitland Gaol','maitland-gaol','Australien','New South Wales, Maitland','Fängelse',
  -32.7417,151.5542,4,false,false,NULL,
  'Australiens äldsta opåverkade fängelseanläggning — i drift 1848-1998.',
  'Maitland Gaol var i drift 1848-1998 och är Australiens äldsta opåverkade fängelseanläggning. Idag erbjuds spökturer.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 9. WILLOW COURT (Tasmanien)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'willow-court','Willow Court','willow-court','Australien','Tasmanien, New Norfolk','Asyl',
  -42.7811,147.0625,4,false,false,NULL,
  'Australiens äldsta mentalsjukhus (1827) — komplexet är delvis övergivet.',
  'Willow Court i New Norfolk var Australiens äldsta mentalsjukhus, i drift 1827-2000. Komplexet är idag delvis övergivet och sägs vara starkt hemsökt.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 10. OLD GEELONG GAOL (Victoria)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'old-geelong-gaol','Old Geelong Gaol','old-geelong-gaol','Australien','Victoria, Geelong','Fängelse',
  -38.1472,144.3667,4,false,false,NULL,
  'Geelongs gamla fängelse — i drift 1849-1991, idag känt för spökvandringar.',
  'Old Geelong Gaol var i drift 1849-1991 och är idag ett populärt mål för spökvandringar och paranormala undersökningar.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 11. COCKATOO ISLAND (NSW)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'cockatoo-island-sydney','Cockatoo Island','cockatoo-island-sydney','Australien','New South Wales, Sydney','Fängelse/Varv',
  -33.8467,151.1711,3,false,true,NULL,
  'UNESCO-ö i Sydney Harbour — straffkoloni, sedan skeppsvarv.',
  'Cockatoo Island är ett UNESCO-världsarv i Sydney Harbour. Ön fungerade som straffkoloni från 1839 och sedan som skeppsvarv. Idag är den en kulturell plats med övernattningsmöjligheter.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 12. PRINCESS THEATRE (Victoria)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'princess-theatre-melbourne','Princess Theatre','princess-theatre-melbourne','Australien','Victoria, Melbourne','Teater',
  -37.8117,144.9725,3,false,false,NULL,
  'Melbournes klassiska teater hemsökt av "Federici" — operasångaren som dog på scenen 1888.',
  'Princess Theatre i Melbourne öppnade 1854 och är förknippad med spökhistorien om Federici, en italiensk operasångare som dog på scenen 1888 efter en föreställning av Faust.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 13. NORTH KAPUNDA HOTEL (SA)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'north-kapunda-hotel','North Kapunda Hotel','north-kapunda-hotel','Australien','South Australia, Kapunda','Hotell/Bordell',
  -34.3411,138.9172,4,false,true,NULL,
  '"Australiens mest hemsökta hotell" — tidigare bordell med 38 rapporterade andar.',
  'North Kapunda Hotel marknadsförs som "Australiens mest hemsökta hotell". Den f.d. bordellen i guldgrävarstaden Kapunda har enligt rapporter 38 olika andar och erbjuder spökvandringar.

(Kort grundtext — kan berikas med lokala källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 14. ADELAIDE ARCADE (SA)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'adelaide-arcade','Adelaide Arcade','adelaide-arcade','Australien','South Australia, Adelaide','Köpcentrum',
  -34.9228,138.6042,3,true,false,NULL,
  'Köpcentrum från 1885 i Adelaide — hemsökt av Francis Cluney, vakten som dog i hissen 1887.',
  'Adelaide Arcade öppnade 1885 och är förknippad med spökhistorien om Francis Cluney, en nattvakt som dog när han fastnade i hissmaskineriet 1887.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 15. GLEDSWOOD HOMESTEAD (NSW)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'gledswood-homestead','Gledswood Homestead','gledswood-homestead','Australien','New South Wales','Historisk gård',
  -34.0211,150.7142,3,false,true,NULL,
  'Historisk gård från 1810 nära Sydney — populär plats för spökvandringar.',
  'Gledswood Homestead är en av Sydneys äldsta bevarade kolonialgårdar (byggd 1810) och är idag en populär plats för spökvandringar.

(Kort grundtext — kan berikas med lokala källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 16. WOODFORD ACADEMY (NSW)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'woodford-academy','Woodford Academy','woodford-academy','Australien','New South Wales, Blue Mountains','Skola',
  -33.7231,150.4811,3,true,false,NULL,
  'Blue Mountains äldsta byggnad (1834) — historisk skola med rapporter om paranormal aktivitet.',
  'Woodford Academy är Blue Mountains äldsta bevarade byggnad (1834). Den fungerade länge som skola och drivs idag av National Trust.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 17. FREMANTLE ARTS CENTRE (WA)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'fremantle-arts-centre','Fremantle Arts Centre','fremantle-arts-centre','Australien','Western Australia, Fremantle','Tidigare asyl',
  -32.0528,115.7583,3,true,false,NULL,
  'Tidigare asyl från 1860-talet — idag konstnärligt centrum med renommé för paranormal aktivitet.',
  'Fremantle Arts Centre är inrymt i en tidigare asyl från 1860-talet. Byggnaden är förknippad med rapporter om paranormal aktivitet från sin tid som mentalsjukhus.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 18. GLADESVILLE HOSPITAL (NSW)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'gladesville-hospital','Gladesville Hospital','gladesville-hospital','Australien','New South Wales, Sydney','Mentalsjukhus',
  -33.8367,151.1342,3,true,false,NULL,
  'Australiens första permanenta mentalsjukhus (1838) — många byggnader står kvar.',
  'Gladesville Hospital var Australiens första permanenta mentalsjukhus, öppnat 1838. Många av byggnaderna står kvar och området är förknippat med rapporter om paranormal aktivitet.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 19. OLD GAOL ALBANY (WA)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'old-gaol-albany','Old Gaol Albany','old-gaol-albany','Australien','Western Australia, Albany','Fängelse',
  -35.0272,117.8811,3,false,false,NULL,
  'Fängelse i Albany från 1850-talet — idag museum.',
  'Old Gaol Albany byggdes på 1850-talet och är idag ett museum. Byggnaden har en koppling till lokala paranormala anekdoter.

(Kort grundtext — kan berikas med Wikipedia-källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 20. MACASSAR WATERPARK (WA)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'macassar-waterpark','Macassar Waterpark (övergiven)','macassar-waterpark','Sydafrika','Western Cape','Övergivet nöjesfält',
  -34.0711,18.7611,3,true,false,NULL,
  'Övergivet vattenpark — Sydafrikas urban-utforskar-favorit.',
  'Macassar Waterpark är ett övergivet vattenland i Western Cape, Sydafrika. Området är ett populärt mål för urbana utforskare.

OBS: Geografiskt koppling enligt användarens lista — denna plats hör tekniskt sett hemma i Sydafrika men ingick i Australien-listan.

(Kort grundtext — kan berikas med lokala källor.)',
  NULL,NULL,NULL,false,true,'published','user_report'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
