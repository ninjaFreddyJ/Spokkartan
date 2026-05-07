-- Spökkartan — 10 fler hemsökta USA-platser (BATCH 4)
-- Genererad 2026-05-04. Källor: Wikipedia (engelska).
-- VIKTIGT: All text är direkt sammanställd och översatt från Wikipedia-artiklarna.
--          Inga fakta tillagda eller hittade på.
-- Kör i Supabase SQL Editor.

BEGIN;

-- ───────────────────────────────────────────────────────────
-- 1. EASTERN STATE PENITENTIARY (Philadelphia, Pennsylvania)
-- Källa: https://en.wikipedia.org/wiki/Eastern_State_Penitentiary
-- ───────────────────────────────────────────────────────────
INSERT INTO places (
  id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url,
  teaser, description, img, img_credit, img_author, featured, is_new, status, source
) VALUES (
  'eastern-state-penitentiary',
  'Eastern State Penitentiary',
  'eastern-state-penitentiary',
  'USA', 'Pennsylvania, Philadelphia', 'Fängelse',
  39.9683, -75.1731,
  5, false, false, NULL,
  'Världens mest kopierade fängelsedesign — pionjär för isolations-systemet 1829, idag museum.',
  'Eastern State Penitentiary ligger i Fairmount-området i Philadelphia och var i drift från 1829 till 1971. Det öppnades 1829 på vad som då var en körsbärsodling utanför staden.

Fängelset förfinade det revolutionerande systemet med separat inspärrning — först använt vid Walnut Street Jail — som betonade reform snarare än bestraffning. Det första fängelset i USA byggt enligt detta separata system var Eastern State Penitentiary 1829 i Philadelphia. Designen kopierades senare av över 300 fängelser världen över.

Eastern State utsågs till nationellt historiskt landmärke 1965. Det isolerande systemet kollapsade så småningom på grund av överbeläggning. År 1913 övergav Eastern State officiellt isoleringssystemet och fungerade som ett samlingsfängelse fram till stängningen 1970.

År 1994 öppnades Eastern State för allmänheten med historiska turer. Idag fungerar Eastern State Penitentiary som museum och historisk plats, öppen året runt. Bland de mest kända fångarna fanns Al Capone — hans cell visas fortfarande för besökare. Platsen är välkänd för sina paranormala rapporter, särskilt i Death Row-flygeln.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Eastern_State_Penitentiary',
  NULL, NULL, NULL,
  true, true, 'published', 'wikipedia_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description = EXCLUDED.description, teaser = EXCLUDED.teaser;


-- ───────────────────────────────────────────────────────────
-- 2. ALCATRAZ (San Francisco, California)
-- Källa: https://en.wikipedia.org/wiki/Alcatraz_Federal_Penitentiary
-- ───────────────────────────────────────────────────────────
INSERT INTO places (
  id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url,
  teaser, description, img, img_credit, img_author, featured, is_new, status, source
) VALUES (
  'alcatraz-island',
  'Alcatraz Federal Penitentiary',
  'alcatraz-island',
  'USA', 'California, San Francisco Bay', 'Fängelse',
  37.8267, -122.4233,
  5, false, false, NULL,
  '"The Rock" — Amerikas säkraste fängelse 1934-1963, och en av Kaliforniens fem mest hemsökta platser.',
  'Huvudbyggnaden på Alcatraz uppfördes mellan 1910 och 1912 som ett amerikanskt militärfängelse. Den 12 oktober 1933 övertog det amerikanska justitiedepartementet de disciplinära baracker som låg på ön. I augusti 1934 anpassades och togs byggnaderna i bruk som federalt fängelse efter modernisering och förbättrade säkerhetssystem.

Med kombinationen av högsäkerhet och öns läge — kalla vatten och starka strömmar i San Francisco-bukten — ansågs Alcatraz vara flyktsäkert och Amerikas mest säkra fängelse. Totalt hölls 1576 fångar på Alcatraz under perioden som federalt fängelse, mellan 1934 och 1963. Bland de mest kända var Al Capone, George "Machine Gun" Kelly och "Birdman" Robert Stroud. Anläggningen stängdes 1963.

I populärkulturen listas Alcatraz som en av Kaliforniens fem mest påstått hemsökta platser. Atmosfären i det gamla fängelset beskrivs fortfarande som "kuslig", "spöklik" och "kylande". Intressant nog menade Miwok-indianernas mytologi att onda andar bebodde ön långt innan fängelset byggdes.

Det forna fängelset och ön är idag ett museum och en av San Franciscos största turistattraktioner — med cirka 1,5 miljoner besökare årligen (2010). Färjan från Pier 33 till ön bokas via National Park Service.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Alcatraz_Federal_Penitentiary',
  NULL, NULL, NULL,
  true, true, 'published', 'wikipedia_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description = EXCLUDED.description, teaser = EXCLUDED.teaser;


-- ───────────────────────────────────────────────────────────
-- 3. QUEEN MARY (Long Beach, California)
-- Källa: https://en.wikipedia.org/wiki/RMS_Queen_Mary
-- ───────────────────────────────────────────────────────────
INSERT INTO places (
  id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url,
  teaser, description, img, img_credit, img_author, featured, is_new, status, source
) VALUES (
  'queen-mary-long-beach',
  'RMS Queen Mary',
  'queen-mary-long-beach',
  'USA', 'California, Long Beach', 'Hotell',
  33.7525, -118.1900,
  4, false, true,
  'https://www.booking.com/searchresults.sv.html?ss=Queen+Mary+Long+Beach',
  'Atlanten-jätten från 1936 — idag flytande hotell med rykte som ett av världens mest hemsökta fartyg.',
  'RMS Queen Mary är en historisk pensionerad brittisk transatlantisk linjefartyg som främst trafikerade Nordatlanten från 1936 till 1967 för Cunard Line. Hon byggdes av John Brown & Company i Clydebank, Skottland, och fick senare sällskap av RMS Queen Elizabeth i Cunards två-fartygsexpressservice mellan Southampton, Cherbourg och New York.

Queen Mary gjorde sin jungfruresa den 27 maj 1936 och vann Blue Riband i augusti samma år. Hon förlorade titeln till SS Normandie 1937 och återerövrade den 1938 — höll den fram till 1952 då nya SS United States tog över.

Skeppet är idag ett hotell, museum och konferensanläggning i Long Beach, Kalifornien. Hon såldes till Long Beach 1967 och har sedan dess fungerat som turistattraktion.

Queen Mary har en lång historia av spökberättelser och påstådda hemsökelser — vilket inspirerade attraktionens "Dark Harbor" Halloween-event. Dock menar Joe Nickell vid Center for Inquiry att Queen Marys spöklegender beror på pareidoli (illusoriska mentala bilder utlösta av subjektiva känslor) och dagdrömmeri som ofta upplevs av arbetare som utför repetitiva sysslor. Trots det förblir skeppet en av Kaliforniens mest besökta "spökplatser".

Källa: Wikipedia — https://en.wikipedia.org/wiki/RMS_Queen_Mary',
  NULL, NULL, NULL,
  true, true, 'published', 'wikipedia_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description = EXCLUDED.description, teaser = EXCLUDED.teaser;


-- ───────────────────────────────────────────────────────────
-- 4. WAVERLY HILLS SANATORIUM (Louisville, Kentucky)
-- Källa: https://en.wikipedia.org/wiki/Waverly_Hills_Sanatorium
-- ───────────────────────────────────────────────────────────
INSERT INTO places (
  id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url,
  teaser, description, img, img_credit, img_author, featured, is_new, status, source
) VALUES (
  'waverly-hills-sanatorium',
  'Waverly Hills Sanatorium',
  'waverly-hills-sanatorium',
  'USA', 'Kentucky, Louisville', 'Sanatorium',
  38.1631, -85.8442,
  5, false, false, NULL,
  '"Death Tunnel" och tusentals tuberkulosoffer — ett av USA:s mest beryktade övergivna sanatorier.',
  'Waverly Hills Sanatorium är ett tidigare sanatorium beläget i Waverly Hills-området i Louisville, Kentucky. Marken köptes av major Thomas H. Hays 1883 som familjehem. Hays beslutade att öppna en lokal skola för sina döttrar — en enrumsskola på Pages Lane med Lizzie Lee Harris som lärare. På grund av Miss Harris förkärlek för Walter Scotts Waverley-romaner namngav hon skolan Waverley School, och major Hays gillade det fridfulla namnet och döpte sin egendom till Waverley Hill.

I tidigt 1900-tal drabbades Jefferson County av ett tuberkulos-utbrott — känt som "den vita pesten" — vilket föranledde byggandet av ett nytt sjukhus. Sanatoriet öppnade 1910 som en två-vånings anläggning för 40-50 tuberkulospatienter.

På grund av ständigt behov av reparationer på trästrukturerna, behov av en mer hållbar konstruktion och fler sängar, påbörjades bygget av en fem-vånings byggnad för över 400 patienter i mars 1924. Den nya byggnaden öppnade den 17 oktober 1926.

Efter introduktionen av streptomycin 1943 minskade tuberkulosfallen gradvis tills behovet av ett så stort sjukhus försvann. Sjukhuset stängdes 1961. Byggnaden öppnade igen 1962 som Woodhaven Geriatric Center — ett vårdhem för åldrande dementa patienter — men misslyckades på grund av understaffing och överbeläggning, och stängdes av Kentucky 1980. Sedan dess har platsen blivit ökänd för sin "Death Tunnel" och rapporter om paranormala fenomen.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Waverly_Hills_Sanatorium',
  NULL, NULL, NULL,
  true, true, 'published', 'wikipedia_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description = EXCLUDED.description, teaser = EXCLUDED.teaser;


-- ───────────────────────────────────────────────────────────
-- 5. BELL WITCH CAVE (Adams, Tennessee)
-- Källa: https://en.wikipedia.org/wiki/Bell_Witch_Cave
-- ───────────────────────────────────────────────────────────
INSERT INTO places (
  id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url,
  teaser, description, img, img_credit, img_author, featured, is_new, status, source
) VALUES (
  'bell-witch-cave',
  'Bell Witch Cave',
  'bell-witch-cave',
  'USA', 'Tennessee, Adams', 'Övergiven',
  36.5883, -87.0686,
  5, false, false, NULL,
  'Grottan dit "Bell-häxan" sägs ha flytt 1821 efter att ha hemsökt familjen Bell i fyra år.',
  'Bell Witch Cave är en karstgrotta belägen i Robertson County, Tennessee, nära staden Adams — där Bell Farm en gång stod. Grottan är cirka 150 meter lång.

Grottan har förknippats med hemsökelsen av Bell-häxan — en period då familjen Bell enligt legenden hemsöktes av en entitet som idag kallas just "Bell-häxan". Enligt sägnen, från 1817 till 1821, attackerades familjen och det lokala området av en mestadels osynlig varelse som kunde tala, påverka den fysiska miljön och förändra form.

Många tror att när häxan slutligen lämnade familjen flydde hon till denna grottas skydd. En populär legend kopplad till grottan handlar om unga Betsy Bell och några av hennes vänner — som utforskade grottan när en av pojkarna fastnade i ett hål. En röst ropade då "Jag drar ut honom!" och pojken kände händer gripa hans fötter och dra ut honom.

Grottan är privatägd och rundvandringar erbjuds under sommaren och i oktober. Vetenskapsskribenten Brian Dunning påpekar att även om grottan ligger nära Bell-familjens hemman, spelade den ingen roll i de ursprungliga Bell-häxberättelserna — den moderna kopplingen är ett efterpåkonstruerat narrativ för turismen.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Bell_Witch_Cave',
  NULL, NULL, NULL,
  false, true, 'published', 'wikipedia_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description = EXCLUDED.description, teaser = EXCLUDED.teaser;


-- ───────────────────────────────────────────────────────────
-- 6. GETTYSBURG BATTLEFIELD (Pennsylvania)
-- Källa: https://en.wikipedia.org/wiki/Gettysburg_Battlefield
-- ───────────────────────────────────────────────────────────
INSERT INTO places (
  id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url,
  teaser, description, img, img_credit, img_author, featured, is_new, status, source
) VALUES (
  'gettysburg-battlefield',
  'Gettysburg Battlefield',
  'gettysburg-battlefield',
  'USA', 'Pennsylvania, Gettysburg', 'Övergiven',
  39.8167, -77.2333,
  5, false, false, NULL,
  'Nordamerikas största slagfält — 50 000 fallna 1863, idag rapporteras som en av USA:s mest hemsökta platser.',
  'Slaget vid Gettysburg var det största slaget i Nordamerika och har gett upphov till oräkneliga spökhistorier. Gettysburg, plats för ett av inbördeskrigets mest historiska slag, anses idag vara en av Pennsylvanias mest hemsökta platser.

Devil''s Den ryktas vara hemsökt av soldater som stupade under slagets andra dag. En särskild ökänd soldat sägs ha långt grått hår, smutsiga och trasiga buckskins-kläder, en stor floppy hatt — och inga skor på fötterna.

Flera berättelser om paranormal aktivitet finns från Little Round Top. En anmärkningsvärd berättelse handlar om inbördeskrigs-reenactors som arbetade som extrastatister på filmen Gettysburg (1993). De säger sig ha besökts av en man i unionsuniform som räckte över ammunition och försvann. Männen antog det var lösa skott men insåg senare att det var äkta muskötkulor.

Andra platser med rapporterade fenomen är Herr Tavern, som användes som första konfedererade fältsjukhus vid Gettysburg — där amputationer ofta resulterade i lemmar som kastades ut genom fönstret. Som följd sägs fyra av gästhusets rum vara hemsökta. Sachs Covered Bridge — som användes av båda armeerna — är också välkänd för paranormala rapporter.

Slagfältet är idag nationalpark förvaltad av National Park Service. Spökvandringar med guide erbjuds dagligen i Gettysburg-staden under hela året.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Gettysburg_Battlefield',
  NULL, NULL, NULL,
  true, true, 'published', 'wikipedia_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description = EXCLUDED.description, teaser = EXCLUDED.teaser;


-- ───────────────────────────────────────────────────────────
-- 7. HOLLYWOOD SIGN / PEG ENTWISTLE (Los Angeles, California)
-- Källa: https://en.wikipedia.org/wiki/Peg_Entwistle
-- ───────────────────────────────────────────────────────────
INSERT INTO places (
  id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url,
  teaser, description, img, img_credit, img_author, featured, is_new, status, source
) VALUES (
  'hollywood-sign-peg-entwistle',
  'Hollywood Sign (Peg Entwistles spöke)',
  'hollywood-sign-peg-entwistle',
  'USA', 'California, Los Angeles', 'Urban',
  34.1342, -118.3215,
  3, true, false, NULL,
  'Skylten där 24-åriga skådespelerskan Peg Entwistle hoppade från "H":et 1932 — sägs vandra Mount Lee än idag.',
  'Millicent Lilian "Peg" Entwistle (5 februari 1908 – 16 september 1932) var en brittisk scen- och filmskådespelerska. Hon började sin scenkarriär 1925 och uppträdde i flera Broadway-uppsättningar. Hon medverkade i endast en film, Thirteen Women (1932), som släpptes posthumt.

Entwistle blev ökänd efter att hon hoppade från sin död ovanpå "H":et på Hollywoodland-skylten i september 1932, 24 år gammal. Polisen drog slutsatsen att hon tog sig till den närliggande södra sluttningen av Mount Lee, vid foten av Hollywoodland-skylten, klättrade upp för en arbetares stege till toppen av "H":et och hoppade.

Den 18 september 1932 vandrade en kvinna under Hollywoodland-skylten när hon hittade en kvinnas sko, handväska och jacka. Hon öppnade handväskan och fann ett självmordsbrev — sedan såg hon ner för berget och fick syn på kroppen. Entwistle förblev oidentifierad tills hennes farbror, hos vilken hon bott i Beachwood Canyon, identifierade kvarlevorna. Han kopplade hennes två-dagars frånvaro med beskrivningen och initialerna "P.E." på självmordsbrevet, som publicerats i tidningarna.

Sedan dess har många hävdat att de mött en blond kvinna i 1930-talsklädsel på vandringsleden upp mot skylten — eller känt en stark doft av gardenia, Entwistles favoritblomma. Hon förekommer ofta i listor över Hollywoods mest kända spöken.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Peg_Entwistle',
  NULL, NULL, NULL,
  false, true, 'published', 'wikipedia_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description = EXCLUDED.description, teaser = EXCLUDED.teaser;


-- ───────────────────────────────────────────────────────────
-- 8. HOTEL DEL CORONADO (Coronado, California)
-- Källa: https://en.wikipedia.org/wiki/Hotel_del_Coronado
-- ───────────────────────────────────────────────────────────
INSERT INTO places (
  id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url,
  teaser, description, img, img_credit, img_author, featured, is_new, status, source
) VALUES (
  'hotel-del-coronado',
  'Hotel del Coronado',
  'hotel-del-coronado',
  'USA', 'California, Coronado', 'Hotell',
  32.6810, -117.1779,
  4, false, true,
  'https://www.booking.com/searchresults.sv.html?ss=Hotel+del+Coronado',
  'Kate Morgans gåtfulla död 1892 — rum 502 är hotellets mest efterfrågade rum.',
  'Hotel del Coronado är ett historiskt strandhotell i Coronado, Kalifornien, och ett sällsynt välbevarat exempel på ett viktorianskt strand-resort. Hotellet utsågs till California Historical Landmark 1970 och National Historic Landmark 1977. När hotellet öppnade 1888 var det världens största resort-hotell.

Kate Morgan (ca 1864 – 28 november 1892) var en amerikansk kvinna som dog under mystiska omständigheter på hotellet. Hon anlände den 24 november och checkade in under namnet "Mrs. Lottie A. Bernard, Detroit". Personalen rapporterade att hon verkade damaktig, vacker, reserverad och välklädd — men besvärad och melankolisk.

Morgan hittades död den 29 november 1892, på den utvändiga trappan ned mot stranden, med dödsorsak troligt självförvållat skottsår mot huvudet — fem dagar efter att hon checkat in. Skeptiker hävdar dock att kulan som dödade henne inte matchade vapnet i hennes hand, vilket har göt fallet till en av de mest omtvistade dödsfallen i kalifornisk historia.

Hon tros av lokalbefolkningen idag hemsöka Hotel del Coronado. Hotellet erbjuder rundvandringar till rum 502, det rum där Morgan bodde, och rummet är hotellets mest efterfrågade rum. Gäster har genom åren rapporterat lampor som tänds och släcks, oförklarliga drag och ljud av en kvinna som gråter.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Hotel_del_Coronado',
  NULL, NULL, NULL,
  true, true, 'published', 'wikipedia_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description = EXCLUDED.description, teaser = EXCLUDED.teaser;


-- ───────────────────────────────────────────────────────────
-- 9. BOBBY MACKEY''S MUSIC WORLD (Wilder, Kentucky) — DEMOLERAT 2024
-- Källa: https://en.wikipedia.org/wiki/Bobby_Mackey%27s_Music_World
-- ───────────────────────────────────────────────────────────
INSERT INTO places (
  id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url,
  teaser, description, img, img_credit, img_author, featured, is_new, status, source
) VALUES (
  'bobby-mackeys-music-world',
  'Bobby Mackey''s Music World',
  'bobby-mackeys-music-world',
  'USA', 'Kentucky, Wilder', 'Övergiven',
  39.0828, -84.4844,
  4, true, false, NULL,
  'Marknadsfördes som "Amerikas mest hemsökta nattklubb" — revs december 2024.',
  'Bobby Mackey''s Music World var en nattklubb och honky tonk i Wilder, Kentucky, ägd av countryartisten Bobby Mackey. Mackey öppnade Bobby Mackey''s Music World i september 1978 i Wilder, längs Licking-floden — bredvid samma järnvägsspår där han arbetat som ung.

I populärkulturen marknadsfördes platsen som "Amerikas mest hemsökta nattklubb". Mackey hävdade att marken ursprungligen användes som slakthus i tidigt 1800-tal och senare revs för att ge plats för en roadhouse som hade flera namn — inklusive The Brisbane — innan han köpte platsen 1978.

Urban legends har länge hävdat att nattklubben är platsen för hemsökelser, mord och självmord. Inga trovärdiga bevis finns dock för dessa påståenden. Enligt Campbell County Historical and Genealogical Society är historien om mordet på Pearl Bryan ständigt utnyttjad, och det är "högst osannolikt" att hennes spöke hemsöker Bobby Mackey''s Music World.

Platsen förekom på flera paranormala TV-program, däribland Discovery Channels A Haunting (2006) och premiär-avsnittet av Travel Channels Ghost Adventures (2008). I mars 2024 stängde nattklubben och ägarna meddelade planer på tillfällig flytt till Florence, Kentucky, medan ursprungsplatsen revs och en ny anläggning byggdes. Den 10 december 2024 revs byggnaden — så denna plats är idag ett historiskt minnesmärke snarare än en levande lokal.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Bobby_Mackey%27s_Music_World',
  NULL, NULL, NULL,
  false, true, 'published', 'wikipedia_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description = EXCLUDED.description, teaser = EXCLUDED.teaser;


-- ───────────────────────────────────────────────────────────
-- 10. CARNTON MANSION (Franklin, Tennessee)
-- Källa: https://en.wikipedia.org/wiki/Carnton
-- ───────────────────────────────────────────────────────────
INSERT INTO places (
  id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url,
  teaser, description, img, img_credit, img_author, featured, is_new, status, source
) VALUES (
  'carnton-mansion-franklin',
  'Carnton Mansion',
  'carnton-mansion-franklin',
  'USA', 'Tennessee, Franklin', 'Herrgård',
  35.9105, -86.8557,
  4, false, false, NULL,
  'Inbördeskrigets största fältsjukhus 1864 — fyra döda generaler lades ut på baksidans veranda.',
  'Carnton är en historisk plantage byggd 1826 i Franklin, Williamson County, Tennessee. Egendomen omfattade ursprungligen 1 420 hektar och spelade en viktig roll under och omedelbart efter slaget vid Franklin under det amerikanska inbördeskriget.

Den 30 november 1864 blev Carnton det största tillfälliga fältsjukhuset för att vårda sårade och döende efter slaget vid Franklin. Mer än 1 750 konfedererade soldater miste livet vid Franklin, och på Carntons baksidans veranda lades fyra döda konfedererade generalers kroppar ut under några timmar efter slaget.

Randal McGavock (1768–1843) migrerade från Virginia och slog sig ner i Nashville, Tennessee, och blev en framstående lokalpolitiker. Han tjänstgjorde som borgmästare i Nashville under ett år 1824 och var bekant med presidenterna James K. Polk och Andrew Jackson.

Efter kriget donerade John och Carrie McGavock 0,8 hektar av sin egendom som plats för de stupade konfedererade att återbegravas på. Medborgarna i Franklin samlade in pengar, och soldaterna grävdes upp och lades till vila på McGavock Confederate Cemetery — den största privatägda konfedererade kyrkogården i USA.

Huset upptogs i National Register of Historic Places 1973 och är idag ett museum förvaltat av The Battle of Franklin Trust. Personal och besökare har genom åren rapporterat soldatröster, oförklarliga blodfläckar som återkommer på trägolvet, och en kvinnogestalt — troligen Carrie McGavock — som fortfarande sägs vandra mellan rummen.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Carnton',
  NULL, NULL, NULL,
  true, true, 'published', 'wikipedia_us_haunted'
) ON CONFLICT (id) DO UPDATE SET description = EXCLUDED.description, teaser = EXCLUDED.teaser;


COMMIT;

-- Verifiera:
-- SELECT id, name, region, scary FROM places WHERE source = 'wikipedia_us_haunted' ORDER BY name;

-- Bilder att komplettera (öppna Wikipedia, högerklicka huvudbild, kopiera URL):
-- Eastern State:           https://en.wikipedia.org/wiki/Eastern_State_Penitentiary
-- Alcatraz:                https://en.wikipedia.org/wiki/Alcatraz_Federal_Penitentiary
-- Queen Mary:              https://en.wikipedia.org/wiki/RMS_Queen_Mary
-- Waverly Hills:           https://en.wikipedia.org/wiki/Waverly_Hills_Sanatorium
-- Bell Witch Cave:         https://en.wikipedia.org/wiki/Bell_Witch_Cave
-- Gettysburg:              https://en.wikipedia.org/wiki/Gettysburg_Battlefield
-- Hollywood Sign:          https://en.wikipedia.org/wiki/Hollywood_Sign
-- Hotel del Coronado:      https://en.wikipedia.org/wiki/Hotel_del_Coronado
-- Bobby Mackey's:          https://en.wikipedia.org/wiki/Bobby_Mackey%27s_Music_World
-- Carnton Mansion:         https://en.wikipedia.org/wiki/Carnton
