-- Spökkartan — 3 fler hemsökta platser i Japan
-- Genererad 2026-06-09. Kompletterar 26_ASIA_JAPAN (Aokigahara, Himeji,
-- Inunaki, Kiyotaki, Oiran Buchi, Mount Osore m.fl. — utelämnas här).
--
-- METOD: engelska/japanska sökord (haunted, ghosts, 心霊スポット) -> sidor som
-- samlat spökhistorier (atlasobscura.com, japantoday.com, timeout.com m.fl.
-- samt engelska Wikipedia). Skrivet på SVENSKA, 200-600 ord/plats, aldrig
-- fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. HASHIMA ISLAND / GUNKANJIMA (Japan) — spökön
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'hashima-gunkanjima','Hashima (Gunkanjima)','hashima-gunkanjima','Japan','Nagasaki','Övergiven',
  32.6277,129.7386,4,false,true,NULL,
  '"Slagskeppsön" — en övergiven gruvö med mörk tvångsarbetshistoria och viskningar ur tomma korridorer.',
  'Hashima, allmänt kallad Gunkanjima ("slagskeppsön"), är en övergiven ö omkring 15 kilometer från Nagasakis centrum. Smeknamnet kom av att ön på avstånd liknar det japanska slagskeppet Tosa.

Den bara 6,3 hektar stora ön var känd för sina undervattenskolgruvor, anlagda 1887. Mitsubishi köpte ön 1890 och började bryta kol ur havsbottnen, medan sjömurar och utfyllnader byggde ut ön. År 1959 nådde befolkningen sin topp på 5 259 invånare — vilket gjorde Hashima till en av de mest tätbefolkade platserna på jorden.

Men ön bär också på en mörk historia. Före och under andra världskriget var den en plats för tvångsarbete: med regeringens stöd förde Mitsubishi hit tusentals arbetare från Korea och Kina, ofta mot deras vilja, för att slita i de farliga och utmattande gruvorna. Dödssiffrorna uppskattas till mellan 137 och 1 300.

Mitsubishi stängde gruvan i januari 1974, och den 20 april tömdes ön på sina invånare. Efter 35 år öppnades den åter för besök 2009, och 2015 togs den upp på Unescos världsarvslista. De spöklika ruinerna och den tragiska historien har gett upphov till rykten om paranormal aktivitet — besökare berättar om en kvävande atmosfär, viskningar ur tomma korridorer och mörka gestalter skymtade genom krossade fönster.

Källa: Engelska Wikipedia "Hashima Island" + Atlas Obscura + asiangeo.com + GaijinPot Travel',
  NULL,NULL,NULL,true,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. SUZUGAMORI EXECUTION GROUNDS (Japan) — Edos avrättningsplats
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'suzugamori','Suzugamori avrättningsplats','suzugamori','Japan','Tokyo, Shinagawa','Avrättningsplats',
  35.5897,139.7372,5,true,false,NULL,
  'Upp till 200 000 avrättades här — och vid brunnen där huvudena tvättades tar spöksynerna aldrig slut.',
  'Suzugamori avrättningsplats i Shinagawa i Tokyo var i drift från 1651 till 1871 och var en av Edos två officiella avrättningsplatser. Den låg medvetet placerad längs Tōkaidō-vägen söder om Edo, där resenärer och inkommande rōnin skulle se den — som både straff och avskräckande exempel.

Under sina 220 år sägs mellan 100 000 och 200 000 människor ha avrättats här. Halshuggning med svärd var den officiella metoden i Japan fram till 1873, men flera andra användes också. Somliga offer utsattes för mizuharitsuke, en grym "vattenkorsfästning", där de dömda bands vid pålar och långsamt dränktes av den stigande tidvattenfloden. Korsfästning och bränning på bål förekom också och drog till sig stora skaror åskådare.

Den första dokumenterade avrättningen var rōninen Marubashi Chūya, en av männen bakom Keian-upproret 1651. Den unga grönsakshandlardottern Yaoya Oshichi brändes levande här 1683, bara sexton år gammal, sedan hon tänt eld på sitt hem.

Berättelser om spöken och vilsna andar lever vidare och drar än idag till sig amatörspökjägare och nyfikna. Det sägs att de avrättades andar visar sig sent på natten, och många trafikolyckor vid närliggande korsningar har tillskrivits människor som sett dem. Kvar finns brunnen Kubiarai-no Ido, där de avhuggna huvudena tvättades — och rapporterna om spöksyner tar aldrig slut.

Källa: Engelska Wikipedia "Suzugamori execution grounds" + japantoday.com + about-tokyo.com + minnano-rakuraku.com',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. KOZUKAPPARA EXECUTION GROUNDS (Japan) — den orenade marken
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'kozukappara','Kozukappara avrättningsplats','kozukappara','Japan','Tokyo, Arakawa','Avrättningsplats',
  35.7330,139.7990,5,true,false,NULL,
  'Tågen saktar in för att inte störa andarna — på marken där 200 000 dog under Edotiden.',
  'Kozukappara (även stavat Kotsukappara) i Minami-Senju i Arakawa i Tokyo var en av Edotidens tre stora avrättningsplatser, anlagd 1651 under shogunatets dagar. Den ligger bara några minuters promenad från Minami-Senju station.

Mellan 1651 och 1873 ska svindlande 200 000 människor ha dödats här på de mest fasansfulla vis man kan tänka sig: halshuggning, korsfästning, bränning på bål och till och med kokning levande. Vanligen korsfästes, brändes eller halshöggs fångarna, varpå deras huvuden sattes upp på spjut i tre dagar som varning.

Platsen ligger intill Enmeiji-templet, och en stor del av den gamla avrättningsplatsen täcks idag av järnvägsspår. En tre meter hög stenjizo restes här till offrens minne, men efter jordbävningen den 11 mars 2011 bedömdes statyn vara rasfärdig och monterades ned; sockeln, huvudet och en arm finns ännu kvar.

Som avrättningsplats ansågs Kozukappara andligt orenad, och de enda som bodde där var de utstötta eta. Än idag berättar äkta Edo-bor att Jōban- och Hibiyalinjerna ofta får driftstopp när de passerar platsen, eller att tågen saktar in för att inte störa de andar som hemsöker området. Få platser i Tokyo bär på en så tung historia av lidande och död.

Källa: Engelska Wikipedia "Kozukappara execution grounds" + Time Out Tokyo + Atlas Obscura + city.arakawa.tokyo.jp',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
