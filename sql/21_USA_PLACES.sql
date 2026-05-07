-- Spökkartan — 10 hemsökta platser i USA
-- Genererad 2026-05-04. Källor: Wikipedia (engelska) + Wikipedia-listan över hemsökta platser i USA.
-- VIKTIGT: All text är direkt sammanställd och översatt från Wikipedia-artiklarna.
--          Inga fakta är tillagda eller hittade på.
--
-- BILDER: img sätts till NULL i denna batch — bilder kompletteras i en senare körning
-- när Wikipedia är på allowlist. För manuell komplettering, se länkarna i kommentarerna
-- (öppna Wikipedia-artikeln, högerklicka huvudbilden → "Kopiera bildadress" → klistra in).
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- ───────────────────────────────────────────────────────────
-- 1. STANLEY HOTEL (Estes Park, Colorado)
-- Källa: https://en.wikipedia.org/wiki/The_Stanley_Hotel
-- ───────────────────────────────────────────────────────────
INSERT INTO places (
  id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url,
  teaser, description, img, img_credit, img_author, featured, is_new, status, source
) VALUES (
  'stanley-hotel-estes-park',
  'The Stanley Hotel',
  'stanley-hotel-estes-park',
  'USA', 'Colorado, Estes Park', 'Hotell',
  40.3825, -105.5180,
  4, false, true,
  'https://www.booking.com/searchresults.sv.html?ss=Stanley+Hotel+Estes+Park',
  'Hotellet som inspirerade Stephen King till The Shining — F.O. och Flora Stanley sägs aldrig ha lämnat byggnaden.',
  'The Stanley Hotel är ett 140-rums hotell i Georgian Revival-stil i Estes Park, Colorado, cirka 8 km från ingången till Rocky Mountain National Park. Hotellet byggdes av Freelan Oscar Stanley, medgrundare av Stanley Motor Carriage Company, och invigdes den 4 juli 1909 — som en resort för östkustens överklass och en hälsoanläggning för tuberkulospatienter.

Stanley kom till Colorado 1903 efter att ha drabbats av tuberkulos, flyttade till Estes Park på rekommendation av läkaren Sherman Grant Bonney, och hans hälsa förbättrades dramatiskt under första säsongen. 1926 sålde Stanley hotellet till ett privat bolag, men det gick i konkurs. 1929 köpte Stanley tillbaka hotellet ur exekutiv auktion och sålde det igen 1930 till hotell- och bilmagnaten Roe Emery i Denver.

Hotellet anses idag vara ett av Amerikas mest hemsökta hotell. Personal och gäster har genom åren rapporterat om Flora Stanley som spelar piano på natten, mystiska steg i korridorerna och oförklarliga ljud från det berömda rum 217. Hotellet erbjuder dagligen historie- och spökturer.

Stanley Hotel var inspirationen till Stephen Kings roman The Shining (1977). I maj 2025 förvärvades det 100-åriga hotellet av The Stanley Partnership for Art Culture and Education för 400 miljoner dollar.

Källa: Wikipedia — https://en.wikipedia.org/wiki/The_Stanley_Hotel',
  NULL, NULL, NULL,
  true, true, 'published', 'wikipedia_us_haunted'
) ON CONFLICT (id) DO UPDATE SET
  description = EXCLUDED.description,
  teaser = EXCLUDED.teaser,
  scary = EXCLUDED.scary;


-- ───────────────────────────────────────────────────────────
-- 2. MYRTLES PLANTATION (St. Francisville, Louisiana)
-- Källa: https://en.wikipedia.org/wiki/Myrtles_Plantation
-- ───────────────────────────────────────────────────────────
INSERT INTO places (
  id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url,
  teaser, description, img, img_credit, img_author, featured, is_new, status, source
) VALUES (
  'myrtles-plantation-louisiana',
  'Myrtles Plantation',
  'myrtles-plantation-louisiana',
  'USA', 'Louisiana, St. Francisville', 'Herrgård',
  30.7846, -91.3766,
  5, false, true,
  'https://www.booking.com/searchresults.sv.html?ss=Myrtles+Plantation',
  'Marknadsförs som "USA:s mest hemsökta plantage" med tolv ryktade spöken sedan 1796.',
  'Myrtles Plantation är ett historiskt hem och tidigare cajun/creole-plantage i St. Francisville, Louisiana, byggt 1796. Namnet ändrades till "The Myrtles" efter de krusbärsmyrtlar som växte i området under tidigt 1800-tal, då plantagen genomgick en ombyggnation. Myrtles överlevde det amerikanska inbördeskriget — om än rånad på sina fina möbler och dyra accessoarer. Idag är den listad i National Register of Historic Places och fortsätter vara en populär turistattraktion på grund av sin koppling till paranormal aktivitet.

Myrtles har länge marknadsförts som en spökturism-destination med många legender och spökhistorier. En av de första nedteckningarna av platsens hemsökta natur kom 1948 i Clarence John Laughlins bok Ghosts Along the Mississippi.

Plantagen har förekommit i flera populärkulturella program om paranormal aktivitet. 2002 gjorde Unsolved Mysteries ett inslag om de påstådda hemsökelserna. Myrtles förekom även i ett avsnitt av Ghost Hunters 2005 samt i Ghost Adventures och Most Terrifying Places in America.

Det är värt att notera att historisk dokumentation inte stödjer alla legender — Sara, James och Cornelia Woodruff dödades inte genom förgiftning, utan dukade under för gula febern.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Myrtles_Plantation',
  NULL, NULL, NULL,
  true, true, 'published', 'wikipedia_us_haunted'
) ON CONFLICT (id) DO UPDATE SET
  description = EXCLUDED.description,
  teaser = EXCLUDED.teaser,
  scary = EXCLUDED.scary;


-- ───────────────────────────────────────────────────────────
-- 3. WINCHESTER MYSTERY HOUSE (San Jose, California)
-- Källa: https://en.wikipedia.org/wiki/Winchester_Mystery_House
-- ───────────────────────────────────────────────────────────
INSERT INTO places (
  id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url,
  teaser, description, img, img_credit, img_author, featured, is_new, status, source
) VALUES (
  'winchester-mystery-house',
  'Winchester Mystery House',
  'winchester-mystery-house',
  'USA', 'California, San Jose', 'Spökhus',
  37.3184, -121.9509,
  4, false, false, NULL,
  'Sarah Winchesters labyrintiska herrgård — sju våningar revs och byggdes upp 16 gånger.',
  'Winchester Mystery House är en herrgård i San Jose, Kalifornien, som en gång var den privata bostaden för Sarah Winchester, änka efter vapenmagnaten William Wirt Winchester. Huset blev en turistattraktion bara nio månader efter Winchesters död 1922.

Huset köptes för 12 570 dollar från John Hamm av Winchester 1886 och låg på en 45 hektar stor ranch i Santa Clara-dalen. Hon kallade åtta-rumsgården och egendomen för Llanada Villa.

Med planer på att bygga ut anställde Winchester minst två arkitekter, men avskedade dem och bestämde sig för att planera själv. Hon designade rummen ett efter ett, övervakade projektet och tog råd från snickarna hon anställt. Hon var känd för att riva ner och avbryta byggen om utvecklingen inte motsvarade hennes förväntningar — vilket resulterade i en labyrintisk design. I San Jose News från 1897 rapporterades att ett sjuvåningstorn revs och byggdes upp 16 gånger.

Huset anses ofta hemsökt — populärryktet hävdar att Winchester byggde det för att fånga andar och spöken som hon trodde följde henne. Det finns dock inga bevis för dessa rykten. Trots påståenden om att huset är USA:s mest hemsökta hus, menar utredaren Joe Nickell att inga bevis för spökerier finns.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Winchester_Mystery_House',
  NULL, NULL, NULL,
  true, true, 'published', 'wikipedia_us_haunted'
) ON CONFLICT (id) DO UPDATE SET
  description = EXCLUDED.description,
  teaser = EXCLUDED.teaser,
  scary = EXCLUDED.scary;


-- ───────────────────────────────────────────────────────────
-- 4. LIZZIE BORDEN HOUSE (Fall River, Massachusetts)
-- Källa: https://en.wikipedia.org/wiki/Lizzie_Borden_House
-- ───────────────────────────────────────────────────────────
INSERT INTO places (
  id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url,
  teaser, description, img, img_credit, img_author, featured, is_new, status, source
) VALUES (
  'lizzie-borden-house',
  'Lizzie Borden House',
  'lizzie-borden-house',
  'USA', 'Massachusetts, Fall River', 'Spökhus',
  41.7064, -71.1551,
  5, false, true,
  'https://www.booking.com/searchresults.sv.html?ss=Lizzie+Borden+House+Fall+River',
  'Platsen för 1892 års dubbelmord med yxa — idag B&B där gäster kan sova i mordrummen.',
  'Lizzie Borden House är platsen för det olösta dubbelmordet 1892 av Lizzies far Andrew och styvmor Abby Borden. Huset ligger på 230 Second Street i Fall River, Massachusetts.

Mellan 1872 och 1892 var huset Andrew Bordens egendom. Han var bankordförande och medlem av Fall Rivers övre samhällsklass. Efter att ha köpt huset byggde Andrew om det från två lägenheter till ett enskilt hem för familjen — men han vägrade installera den senaste tekniken som inomhusrörmokeri och elektricitet, vilket gjorde huset ovanligt enkelt för någon med hans status.

Lizzie Andrew Borden ställdes inför rätta och frikändes för yxmord på sin far och styvmor den 4 augusti 1892. Ingen annan åtalades för morden. Trots att hon ostraciserades av andra invånare bodde Borden resten av sitt liv i Fall River. Fallet är ett av de mest kända olösta morden i USA:s historia och har gett upphov till ramsor, böcker, filmer och teaterstycken.

Huset såldes till salu i maj 2021 och köptes av Lance Zaal för 2 miljoner dollar. Zaal förklarade att han skulle behålla fastigheten som bed-and-breakfast och hoppades utvidga verksamheten med fler Lizzie Borden-relaterade aktiviteter. Gäster kan idag sova i de rum där morden begicks.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Lizzie_Borden_House',
  NULL, NULL, NULL,
  true, true, 'published', 'wikipedia_us_haunted'
) ON CONFLICT (id) DO UPDATE SET
  description = EXCLUDED.description,
  teaser = EXCLUDED.teaser,
  scary = EXCLUDED.scary;


-- ───────────────────────────────────────────────────────────
-- 5. WHALEY HOUSE (San Diego, California)
-- Källa: https://en.wikipedia.org/wiki/Whaley_House_(San_Diego,_California)
-- ───────────────────────────────────────────────────────────
INSERT INTO places (
  id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url,
  teaser, description, img, img_credit, img_author, featured, is_new, status, source
) VALUES (
  'whaley-house-san-diego',
  'Whaley House',
  'whaley-house-san-diego',
  'USA', 'California, San Diego', 'Museum',
  32.7536, -117.1969,
  4, false, false, NULL,
  '"USA:s mest övernaturliga hem" enligt Travel Channel — byggt 1857 på platsen där Yankee Jim hängdes.',
  'Whaley House är en bostad i grekisk-revivalstil och ett museum i Old Town, San Diego, Kalifornien. Det är södra Kaliforniens äldsta tegelbyggnad, byggd 1857. Den underhålls idag av Historic Tours of America, Inc (HTA).

Whaley House var hem åt Thomas Whaley och hans familj. Vid olika tillfällen har det också rymt Whaleys allmänna handelsbod, San Diegos andra länsdomstol och stadens första kommersiella teater.

Thomas Whaley, av skotsk-irländsk härkomst, föddes den 5 oktober 1823 i New York. Han dog i sitt New Town-residens den 14 december 1890, 67 år gammal. Hans hustru Anna dog i Old Town-residenset den 24 februari 1913, 80 år gammal. En tragisk händelse i familjens historia involverade dottern Violet, som tog sitt liv genom att skjuta sig själv i bröstet med Thomas .32-kaliber-revolver den 19 augusti 1885 — bara 22 år gammal.

Efter denna historia av framgång och dödsfall är Whaley House välkänt som ett hemsökt hus. Strax efter att familjen flyttat in berättade de för San Diego Union att de hört tunga steg i huset, vilket de trodde tillhörde James "Yankee Jim" Robinson — som tidigare hängts på platsen för att ha stulit en båt.

Whaley House har förekommit i många historiska dokumentärer samt en mängd paranormala TV-program, däribland Syfy Channels Fact or Faked: Paranormal Files och Travel Channels America''s Most Haunted, där det utnämnts till "USA:s mest övernaturliga hem".

Källa: Wikipedia — https://en.wikipedia.org/wiki/Whaley_House_(San_Diego,_California)',
  NULL, NULL, NULL,
  true, true, 'published', 'wikipedia_us_haunted'
) ON CONFLICT (id) DO UPDATE SET
  description = EXCLUDED.description,
  teaser = EXCLUDED.teaser,
  scary = EXCLUDED.scary;


-- ───────────────────────────────────────────────────────────
-- 6. CRESCENT HOTEL (Eureka Springs, Arkansas)
-- Källa: https://en.wikipedia.org/wiki/Crescent_Hotel_(Eureka_Springs,_Arkansas)
-- ───────────────────────────────────────────────────────────
INSERT INTO places (
  id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url,
  teaser, description, img, img_credit, img_author, featured, is_new, status, source
) VALUES (
  'crescent-hotel-eureka-springs',
  'Crescent Hotel',
  'crescent-hotel-eureka-springs',
  'USA', 'Arkansas, Eureka Springs', 'Hotell',
  36.4071, -93.7345,
  4, false, true,
  'https://www.booking.com/searchresults.sv.html?ss=Crescent+Hotel+Eureka+Springs',
  'Marknadsförs som "Amerikas mest hemsökta hotell" — en gång falsk cancerklinik under bedragaren Norman Baker.',
  'Crescent Hotel byggdes 1886. Mellan 1908 och 1924 fungerade det främst som Crescent College and Conservatory for Young Women — en flickskola — och drevs som hotell endast under sommarmånaderna.

År 1937 fick det en ny ägare, bedragaren Norman G. Baker, som omvandlade platsen till ett sjukhus och hälsoresort. Han kallade det "ett slott i luften" i radioutsändningar. Baker — miljonär, uppfinnare och radiopersonlighet — utgav sig för att vara läkare trots att han saknade medicinsk utbildning. Han hävdade att han upptäckt en rad "botemedel" mot olika sjukdomar, däribland cancer, och attackerade ofta den organiserade läkarvården som han anklagade för att vara korrupt och vinstdriven. 1940 lämnades federala anklagelser mot Baker för postbedrägeri, och han satt fyra år i fängelse.

År 1997 köpte Marty och Elise Roenigk Crescent Hotel för 1,3 miljoner dollar. De ledde en sex år lång restaurering och renovering av hotellrummen, lade till historisk inredning och återställde byggnadens spa i källaren. Byggnaden listades i National Register of Historic Places 2016.

Crescent Hotel marknadsför sig idag som Amerikas mest hemsökta hotell. År 2005 förekom det i TV-programmet Ghost Hunters, där teamet hävdade att de såg vad de beskrev som "en helkroppsförscheinung" på sin värmekamera.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Crescent_Hotel_(Eureka_Springs,_Arkansas)',
  NULL, NULL, NULL,
  true, true, 'published', 'wikipedia_us_haunted'
) ON CONFLICT (id) DO UPDATE SET
  description = EXCLUDED.description,
  teaser = EXCLUDED.teaser,
  scary = EXCLUDED.scary;


-- ───────────────────────────────────────────────────────────
-- 7. TRANS-ALLEGHENY LUNATIC ASYLUM (Weston, West Virginia)
-- Källa: https://en.wikipedia.org/wiki/Trans-Allegheny_Lunatic_Asylum
-- ───────────────────────────────────────────────────────────
INSERT INTO places (
  id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url,
  teaser, description, img, img_credit, img_author, featured, is_new, status, source
) VALUES (
  'trans-allegheny-lunatic-asylum',
  'Trans-Allegheny Lunatic Asylum',
  'trans-allegheny-lunatic-asylum',
  'USA', 'West Virginia, Weston', 'Sanatorium',
  39.0419, -80.4647,
  5, false, false, NULL,
  'Mentalsjukhus i drift 1864–1994 — idag museum med rundvandringar, "Paranormal Lockdown"-platsen.',
  'Trans-Allegheny Lunatic Asylum var ett mentalsjukhus i Weston, West Virginia, tidigare känt under namn som West Virginia Hospital for the Insane och Weston State Hospital. Sjukhuset tog emot patienter från oktober 1864 till maj 1994.

Bygget av Trans-Allegheny Lunatic Asylum auktoriserades av Virginias generalförsamling. En tillsatt direktion fick i uppdrag att köpa en förgodkänd mark nära West Fork-floden — vid den tiden ansågs området fortfarande tillhöra Virginia. Konstruktionen påbörjades sent 1858 och utfördes inledningsvis av fångarbetare. Mest byggmaterial kom från närliggande områden, där den blå sandstenen från ett stenbrott i Mount Clare, West Virginia, är särskilt anmärkningsvärd. Skickliga stenhuggare från Tyskland och Irland anställdes för arbetet.

De första patienterna togs in i oktober 1864, men byggandet fortsatte in på 1881. Det 60 meter höga centrala klocktornet stod färdigt 1871, och separata rum för svarta patienter färdigställdes 1873.

Sjukhuset auktionerades ut av West Virginias hälso- och socialdepartement den 29 augusti 2007. Joe Jordan, en asbestsanerings-entreprenör från Morgantown, var högsta budgivare och betalade 1,5 miljoner dollar för den 22 500 kvadratmeter stora byggnaden. Huvudbyggnaden — Kirkbride — innehåller idag ett museum med målningar, dikter och teckningar gjorda av patienter, ett rum med olika behandlingsmetoder och tvångsmedel, samt artefakter som tvångströjor och hydroterapi-badkar.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Trans-Allegheny_Lunatic_Asylum',
  NULL, NULL, NULL,
  true, true, 'published', 'wikipedia_us_haunted'
) ON CONFLICT (id) DO UPDATE SET
  description = EXCLUDED.description,
  teaser = EXCLUDED.teaser,
  scary = EXCLUDED.scary;


-- ───────────────────────────────────────────────────────────
-- 8. LALAURIE MANSION (New Orleans, Louisiana)
-- Källa: https://en.wikipedia.org/wiki/Delphine_LaLaurie
-- ───────────────────────────────────────────────────────────
INSERT INTO places (
  id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url,
  teaser, description, img, img_credit, img_author, featured, is_new, status, source
) VALUES (
  'lalaurie-mansion-new-orleans',
  'LaLaurie Mansion',
  'lalaurie-mansion-new-orleans',
  'USA', 'Louisiana, New Orleans', 'Herrgård',
  29.9596, -90.0640,
  5, false, false, NULL,
  'Branden 1834 avslöjade slavinnehav i tortyr på vinden — ägaren Delphine LaLaurie flydde till Frankrike.',
  'Den 10 april 1834 upptäckte räddningsmanskap som svarade på en brand i herrgården på Royal Street bundna slavar på vinden — med tecken på grov, långvarig misshandel. Herrgården plundrades därefter av en upprörd folkmassa av medborgare i New Orleans. Ägaren, Delphine LaLaurie, flydde till Frankrike med sin familj och ställdes aldrig inför rätta.

År 1831 köpte Delphine LaLaurie egendomen vid 1140 Royal Street och förvaltade den i eget namn med liten inblandning från sin man. 1832 lät hon bygga en två-vånings herrgård där, komplett med tillhörande slavkvarter.

Den herrgård som traditionellt anses vara LaLauries är ett landmärke i French Quarter — delvis för sin historia och delvis för sin arkitektoniska betydelse. Det är dock värt att notera att hennes ursprungliga hus brändes av folkmassan, och att den nuvarande "LaLaurie Mansion" på 1140 Royal Street faktiskt återuppfördes efter hennes flykt från New Orleans.

Skådespelaren Nicolas Cage ägde herrgården en kort tid innan den såldes på exekutiv auktion 2009. LaLaurie Mansion har förekommit i populärkulturen — inte minst i American Horror Story: Coven (2013) — och är idag ett av French Quarters mest besökta stopp på spökvandringar.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Delphine_LaLaurie',
  NULL, NULL, NULL,
  true, true, 'published', 'wikipedia_us_haunted'
) ON CONFLICT (id) DO UPDATE SET
  description = EXCLUDED.description,
  teaser = EXCLUDED.teaser,
  scary = EXCLUDED.scary;


-- ───────────────────────────────────────────────────────────
-- 9. AMITYVILLE HORROR HOUSE (Amityville, New York)
-- Källa: https://en.wikipedia.org/wiki/The_Amityville_Horror
-- ───────────────────────────────────────────────────────────
INSERT INTO places (
  id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url,
  teaser, description, img, img_credit, img_author, featured, is_new, status, source
) VALUES (
  'amityville-horror-house',
  'Amityville Horror House (112 Ocean Avenue)',
  'amityville-horror-house',
  'USA', 'New York, Amityville', 'Spökhus',
  40.6679, -73.4163,
  5, false, false, NULL,
  '1974 mördade Ronald DeFeo Jr. sex familjemedlemmar — året därpå flydde familjen Lutz efter 28 dagar.',
  'Huset på 112 Ocean Avenue är ett stort hus i nederländsk kolonialrevival-stil i ett villakvarter i Amityville, på södra kusten av Long Island, New York. Den 13 november 1974 sköt 23-årige Ronald DeFeo Jr. ihjäl sex medlemmar av sin familj i hemmet.

I december 1975 flyttade George och Kathy Lutz tillsammans med Kathys tre barn in i huset, men lämnade det efter tjugoåtta dagar och hävdade att de terroriserats av paranormala fenomen. Jay Ansons roman sägs vara baserad på dessa händelser men har varit föremål för stor kontrovers. Mordfallet ägde verkligen rum, men det finns inga bevis för att huset är eller var hemsökt.

Amityville är miljön för Jay Ansons bok The Amityville Horror, som publicerades 1977 och har anpassats till en serie filmer som började 1979. Boken och filmerna gjorde adressen till en av världens mest kända "spökhusadresser".

Huset på 112 Ocean Avenue finns kvar idag, men det har renoverats och adressen ändrats för att avskräcka nyfikna från att besöka det. De karaktäristiska kvartsrundade fönstren har tagits bort, och huset ser idag betydligt annorlunda ut än sin filmversion.

Källa: Wikipedia — https://en.wikipedia.org/wiki/The_Amityville_Horror',
  NULL, NULL, NULL,
  true, true, 'published', 'wikipedia_us_haunted'
) ON CONFLICT (id) DO UPDATE SET
  description = EXCLUDED.description,
  teaser = EXCLUDED.teaser,
  scary = EXCLUDED.scary;


-- ───────────────────────────────────────────────────────────
-- 10. THE WITCH HOUSE (Salem, Massachusetts)
-- Källa: https://en.wikipedia.org/wiki/The_Witch_House
-- ───────────────────────────────────────────────────────────
INSERT INTO places (
  id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url,
  teaser, description, img, img_credit, img_author, featured, is_new, status, source
) VALUES (
  'witch-house-salem',
  'The Witch House (Jonathan Corwin House)',
  'witch-house-salem',
  'USA', 'Massachusetts, Salem', 'Museum',
  42.5219, -70.8961,
  4, false, false, NULL,
  'Domaren Jonathan Corwins hus 1675 — den enda byggnaden kvar i Salem med direkt koppling till häxprocesserna.',
  'Jonathan Corwin House — lokalt känd som The Witch House — är ett historiskt husmuseum i Salem, Massachusetts. Det var hem åt domaren Jonathan Corwin (1640–1718) och är en av få byggnader som fortfarande står i Salem med direkt koppling till häxprocesserna 1692.

När rapporter om häxeri började cirkulera i Essex County kallades Corwin in som en av de magistrater som skulle göra preliminära undersökningar. Han och John Hathorne — en annan lokal magistrat — höll förhör i början av mars 1692, då vittnesmål inhämtades från Tituba, Sarah Good och Sarah Osborne, de tre första kvinnorna som anklagades för att vara häxor.

Under häxprocesserna 1692 kallades Corwin in för att utreda anklagelser om diaboliskt aktivitet när en flod av häxanklagelser uppstod i Salem Village (idag Danvers) och grannsamhällena. Han ersatte domaren Nathaniel Saltonstall, som avgick efter avrättningen av Bridget Bishop. Corwin satt i Court of Oyer and Terminer, som till slut skickade 19 personer till galgen. De anklagade fördes till Corwins hem för "förhandsförhör".

Det är säkert känt att Jonathan Corwin köpte/färdigställde huset någon gång under 1675, vilket gör att detta datum idag används som ungefärligt byggår. Bostaden drivs nu som museum av Salems stad och är öppen säsongsvis.

Källa: Wikipedia — https://en.wikipedia.org/wiki/The_Witch_House',
  NULL, NULL, NULL,
  true, true, 'published', 'wikipedia_us_haunted'
) ON CONFLICT (id) DO UPDATE SET
  description = EXCLUDED.description,
  teaser = EXCLUDED.teaser,
  scary = EXCLUDED.scary;


COMMIT;

-- ─────────────────────────────────────────────────────────────
-- VERIFIERA RESULTAT
-- ─────────────────────────────────────────────────────────────
-- SELECT id, name, region, scary, length(description) AS desc_len
-- FROM places
-- WHERE source = 'wikipedia_us_haunted'
-- ORDER BY name;

-- ─────────────────────────────────────────────────────────────
-- BILDER ATT KOMPLETTERA MANUELLT (eller automatiskt nästa session)
-- Klicka på Wikipedia-länken nedan, högerklicka huvudbilden och kopiera URL:
-- ─────────────────────────────────────────────────────────────
-- Stanley Hotel:           https://en.wikipedia.org/wiki/The_Stanley_Hotel
-- Myrtles Plantation:      https://en.wikipedia.org/wiki/Myrtles_Plantation
-- Winchester Mystery:      https://en.wikipedia.org/wiki/Winchester_Mystery_House
-- Lizzie Borden House:     https://en.wikipedia.org/wiki/Lizzie_Borden_House
-- Whaley House:            https://en.wikipedia.org/wiki/Whaley_House_(San_Diego,_California)
-- Crescent Hotel:          https://en.wikipedia.org/wiki/Crescent_Hotel_(Eureka_Springs,_Arkansas)
-- Trans-Allegheny:         https://en.wikipedia.org/wiki/Trans-Allegheny_Lunatic_Asylum
-- LaLaurie Mansion:        https://en.wikipedia.org/wiki/Delphine_LaLaurie
-- Amityville:              https://en.wikipedia.org/wiki/The_Amityville_Horror
-- Witch House Salem:       https://en.wikipedia.org/wiki/The_Witch_House
