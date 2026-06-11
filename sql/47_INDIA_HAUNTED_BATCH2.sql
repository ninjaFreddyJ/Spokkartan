-- Spökkartan — 4 fler hemsökta platser i Indien, omgång 2
-- Genererad 2026-06-09. Fortsättning på 41_INDIA_HAUNTED.
--
-- METOD: engelska/hindi sökord (haunted, ghosts, भूत) -> sidor som samlat
-- spökhistorier (holidify.com, atlasobscura.com, amyscrypt.com, india.com m.fl.
-- samt engelska Wikipedia). Skrivet på SVENSKA, 200-600 ord/plats, aldrig fler
-- ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. DUMAS BEACH (Indien) — den svarta sandens strand
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'dumas-beach','Dumas Beach','dumas-beach','Indien','Gujarat, Surat','Naturplats',
  21.0750,72.7140,4,true,false,NULL,
  'Svart sand av aska från en gammal likbränningsplats — och resenärer som aldrig återvänt.',
  'Dumas Beach ligger drygt två mil sydväst om staden Surat i Gujarat och utmärker sig genom sin svarta sand — något ovanligt i Indien, där de flesta stränder har gyllene sand.

Man tror att Dumas en gång var en hinduisk likbränningsplats, och att andarna efter de som kremerades här hemsöker stranden. Deras brända aska sägs ha blandats med sanden och gjort den distinkt svart — och hemsökt. Spökena ska bestå av dem som inte fann frälsning, eller som dog genom självmord eller olyckor. Stranden användes också som kremeringsplats för den parsiska gemenskapen, och de bortgångnas andar sägs ännu kännas där.

Besökare har hört viskningar, skratt, gråt och andra oförklarliga ljud, särskilt nattetid, och somliga turister påstår sig ha sett spöken röra sig över sanden. Det finns också berättelser om försvinnanden — resenärer som gett sig ut på stranden om natten och aldrig återvänt.

Dagtid är Dumas en till synes vanlig, om än mörk, strand vid Arabiska havet. Men dess rykte som en av Indiens mest hemsökta platser vilar tungt, och de lokala råder bestämt mot att vandra ensam längs den svarta sanden efter mörkrets inbrott — då vågorna sägs bära med sig röster från dem som en gång brändes här.

Källa: tripoto.com + mediaindia.eu + grasshopperyatra.com + medium.com (Chronicles of Curiosity)',
  NULL,NULL,NULL,true,true,'published','web_in_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. THREE KINGS CHAPEL (Indien) — de tre förgiftade kungarna
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'three-kings-chapel','Three Kings Chapel','three-kings-chapel','Indien','Goa, Cansaulim','Kyrka',
  15.3210,73.8950,3,true,false,NULL,
  'En kung förgiftade sina två rivaler vid en måltid — alla tre vilar nu under kapellets golv.',
  'Three Kings Chapel ("de tre kungarnas kapell") ligger på Cuelim-kullen i Cansaulim i Goa, en romersk-katolsk kyrka byggd 1599 av fader Gonzalo Carvalho.

Enligt folktron styrdes kullen en gång av tre portugisiska kungar som ständigt låg i fejd. I ett försök att lägga all makt under sig bjöd den äldste, vid namn Holger, in de andra två till kapellet på en måltid — och förgiftade dem. Men gripen av skuld, eller av fruktan för undersåtarnas vrede, tog den tredje kungen sedan sitt eget liv genom att svälja det återstående giftet.

Det sägs att man begravde de tre kungarnas kroppar på kyrkans mark. Sedan dess har människor som besökt kapellet sena timmar känt en närvaro på platsen. Lokala berättelser gör gällande att de tre kungarnas andar dröjer kvar, och besökare och bybor har rapporterat oförklarliga syner och ljud efter mörkrets inbrott — vilket gjort kapellet till en av Goas mest hemsökta platser.

Intressant nog är det nästan säkert att legenden från början diktades upp enbart för att hålla förälskade par borta från denna pittoreska och avskilda plats med sin milsvida utsikt. Sann eller ej lever sägnen vidare, och kullen lockar både trogna pilgrimer och nyfikna spöksökare.

Källa: Engelska Wikipedia "Three Kings Chapel" + holidify.com + thatgoangirl.com + soultravelling.in',
  NULL,NULL,NULL,false,true,'published','web_in_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. AGRASEN KI BAOLI (Indien) — den svarta brunnen
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'agrasen-ki-baoli','Agrasen ki Baoli','agrasen-ki-baoli','Indien','Delhi','Brunn',
  28.6260,77.2245,4,true,false,NULL,
  'Det svarta vattnet i trappbrunnen lockade människor att dränka sig — själarna sägs fångade än.',
  'Agrasen ki Baoli är en 60 meter lång och 15 meter bred historisk trappbrunn i New Delhi, belägen vid Hailey Road nära Connaught Place. Den har 108 trappsteg och tre nivåer, var och en med nischade valvbågar på ömse sidor om brunnen.

Den mest spridda sägnen är den om det svarta vattnet. Berättelserna säger att brunnen en gång rymde ett svart vatten som lockade människor till sig. När de närmade sig vattnet drogs de mot det och tvingades begå självmord. Vattnet har nu torkat ut, men själarna efter dem som det krävde sägs ännu dröja kvar i brunnen, fångade i all evighet.

Somliga besökare påstår sig känna att de blir följda, trots att ingen finns i närheten — en känsla de inte kan skaka av sig, var de än står i brunnen. Andra berättar om spöklika viskningar och röster, och åter andra om skugglika gestalter som lurar i de mörka hörnen av baolin.

Arkeologiska undersökningar visar att trappbrunnen till stor del byggdes om på 1300-talet av Agarwal-gemenskapen under Delhisultanatet. Idag är den en stilla, svalkande oas mitt i storstadens larm — men dess rykte som en av Delhis mest hemsökta platser lever vidare i de djupa, ekande trappstegen.

Källa: Engelska Wikipedia "Agrasen Ki Baoli" + Atlas Obscura + thirdeyetraveller.com + amyscrypt.com',
  NULL,NULL,NULL,false,true,'published','web_in_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. BRIJ RAJ BHAVAN (Indien) — major Burtons ande
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'brij-raj-bhavan','Brij Raj Bhavan','brij-raj-bhavan','Indien','Rajasthan, Kota','Slott',
  25.1820,75.8330,3,false,true,NULL,
  'Den brittiske majoren dödades 1857 — hans ande ger ännu örfilar åt vakter som somnar i tjänst.',
  'Brij Raj Bhavan är ett palats, numera hotell, i Kota i Rajasthan. Det byggdes på 1830-talet under det brittiska väldet och blev senare maharaja Umed Singh II:s sommarpalats.

Under det indiska upproret — sepoyupproret 1857 — var den brittiske majoren Charles Burton stationerad i Kota. När sepoyer plundrade palatset barrikaderade han sig i ett av de övre rummen tillsammans med sina två söner. Efter fem timmars belägring gav de upp — och soldaterna dödade dem alla.

Sedan dess sägs majorens ande hemsöka sitt gamla palats. Enligt sägnen är det ett ofarligt spöke, trots det våldsamma slutet, men mycket strikt med disciplinen i byggnaden: det sägs att han ger örfilar åt vakter som somnar i tjänst. Major Burtons ande ska vandra genom palatset klädd i sin röda rock och med ett svärd vid sidan. Vissa gäster berättar att de sett honom i korridorerna, andra att de hört hans steg mitt i natten.

Idag är Brij Raj Bhavan ett arvshotell där gäster kan bo i den gamla brittiska officerens palats — och kanske, om de råkar slumra till på sin vakt, få en sträng men osynlig örfil från den brittiske major som vägrar lämna sin post.

Källa: india.com + Moon Mausoleum + amyscrypt.com + frightfind.com',
  NULL,NULL,NULL,false,true,'published','web_in_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
