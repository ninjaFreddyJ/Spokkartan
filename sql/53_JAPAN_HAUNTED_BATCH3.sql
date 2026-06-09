-- Spökkartan — 2 fler hemsökta/övergivna platser i Japan, omgång 3
-- Genererad 2026-06-09. Kompletterar 26/42.
--
-- METOD: engelska/japanska sökord (haunted, abandoned, 廃墟) -> sidor som samlat
-- spökhistorier (timetravelturtle.com, abandonedkansai.com, SoraNews24 m.fl.
-- samt engelska Wikipedia). Skrivet på SVENSKA, 200-600 ord/plats, aldrig fler
-- ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. NARA DREAMLAND (Japan) — det övergivna "japanska Disneyland"
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'nara-dreamland','Nara Dreamland','nara-dreamland','Japan','Nara','Övergiven',
  34.7080,135.8330,3,false,false,NULL,
  'Det övergivna "japanska Disneyland" — ett tyst Törnrosaslott och en rostig bergochdalbana.',
  'Nara Dreamland var en nöjespark nära Nara i Japan, starkt inspirerad av Disneyland i Kalifornien. Den öppnade 1961, sedan affärsmannen Kunizo Matsuo besökt Disneyland 1955 och blivit så imponerad att han ville skapa något liknande i Japan. Parken byggdes för att se nästan identisk ut: med en egen Main Street, ett Törnrosaslott och "Ancestorland", parkens version av Frontierland med japansk historia.

På sin höjdpunkt hade Nara Dreamland över 1,6 miljoner besökare om året. Men när Tokyo Disneyland öppnade 1983, och senare Universal Studios Japan, sjönk besökssiffrorna kraftigt, och 2006 stängde parken för gott.

Efter stängningen, men före rivningen, blev Nara Dreamland ett av Japans mest berömda mål för "haikyo" — urban exploration. Övergivna åkattraktioner, ett tyst Törnrosaslott och en rostig bergochdalbana gjorde platsen kuslig och drömlik på en gång. Somliga besökare lämnade graffiti på monorälen och attraktionerna, andra placerade parkens figurstatyer i olycksbådande poser på trasiga åkattraktioner.

Parken stod övergiven tills den revs mellan oktober 2016 och december 2017, då 30 åkattraktioner och 75 byggnader avlägsnades. Idag är det spöklika "japanska Disneyland" borta — men bilderna av den tysta, övergivna sagovärlden lever vidare som en av världens mest ikoniska lost places.

Källa: Engelska Wikipedia "Nara Dreamland" + timetravelturtle.com + abandonedspaces.com + Dezeen',
  NULL,NULL,NULL,true,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. NAKAGUSUKU HOTEL RUINS (Japan) — det förbannade hotellet
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'nakagusuku-hotel','Nakagusuku Hotel ruins','nakagusuku-hotel','Japan','Okinawa, Kitanakagusuku','Övergiven',
  26.2840,127.8050,4,false,false,NULL,
  'Munkarna varnade för de heliga gravarna — bygget förbannades och investeraren blev vansinnig.',
  'Nakagusuku Hotel — även kallat Royal Hotel eller Kogen Hotel — var ett övergivet, aldrig färdigställt hotell i Kitanakagusuku på Okinawa, beläget knappt 50 meter från murarna till Nakagusuku-borgen.

Hotellet uppfördes av en förmögen affärsman från Naha för att dra nytta av världsutställningen Okinawa Ocean Exposition 1975. Kullen söder om borgen valdes för utsikten över både Stilla havet och Östkinesiska sjön. Men munkar från ett närliggande buddhistiskt tempel varnade för att platsen rymde gravar och heliga platser, och att bygget skulle reta de andar som bodde där. Varningarna ignorerades.

Efter en rad byggolyckor vägrade arbetarna att färdigställa komplexet — de kände att platsen var förbannad. Mitt i 1975 avstannade bygget helt. Enligt legenden försökte den desperate investeraren bevisa att platsen inte var hemsökt genom att sova där varje natt tills projektet var klart. Han tillbringade tre nätter på platsen och blev vansinnig. Därefter ska hans företag ha gått i konkurs, och enligt berättelsen tog han sitt liv på ett mentalsjukhus.

En mer prosaisk förklaring är att bygget övergavs när borgruinen och området blev världsarv. Hotellruinen stod kvar som en av Okinawas mest beryktade spökplatser, ett populärt mål för djärva urban explorers, tills den revs helt år 2020.

Källa: Engelska Wikipedia "Nakagusuku Hotel ruins" + abandonedkansai.com + SoraNews24 + InsideJapan Tours',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
