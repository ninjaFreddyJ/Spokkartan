-- Spökkartan — 3 fler hemsökta platser i Indien, omgång 3
-- Genererad 2026-06-09. Kompletterar 41/47.
--
-- METOD: engelska/hindi sökord (haunted, ghosts, भूत) -> sidor som samlat
-- spökhistorier (india.com, Atlas Obscura, Moon Mausoleum, shimlaonline.in m.fl.).
-- Skrivet på SVENSKA, 200-600 ord/plats, aldrig fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. GP BLOCK, MEERUT (Indien) — de fyra männen och kvinnan i rött
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'gp-block-meerut','GP Block, Meerut','gp-block-meerut','Indien','Uttar Pradesh, Meerut','Övergiven',
  28.9840,77.7060,4,true,false,NULL,
  'Fyra män dricker öl kring ett ensamt ljus — och en kvinna i rött stiger upp mot taket.',
  'GP Block i Meerut i Uttar Pradesh är en av Indiens mest ökända spökplatser — tre byggnader som legat öde sedan 1930-talet.

Legenden kretsar kring två återkommande syner. Den första är de fyra männen: GP Block sägs hemsökas av spökena efter fyra män som ofta skymtas i en tvåvåningsbyggnad, sittande kring ett bord med ett enda tänt ljus, drickande öl. Den andra är kvinnan i rött: en kvinna klädd i röd klänning har ofta setts lämna byggnaden, med syner som rör sig från första våningen, till andra, och slutar på taket.

Byggnaderna ägs av de indiska försvarsstyrkorna men lämnades att förfalla någon gång i slutet av 1950-talet, eller kanske så tidigt som på 1930-talet. Den tvåvåningsbyggnad där männen ses har varit låst i många år, och folk minns inte ens längre vem som en gång bodde där, eller när.

GP Block placeras på nionde plats på listan över Indiens tio mest hemsökta platser. Trots de många berättelserna och undersökningarna har det dock aldrig funnits några konkreta belägg för paranormal aktivitet. Men förbipasserande undviker gärna de tysta, övergivna husen efter mörkrets inbrott — särskilt om ett ensamt ljus skulle skymta i ett fönster.

Källa: india.com + Moon Mausoleum + hauntedindia.blogspot.com + bookstruck.app',
  NULL,NULL,NULL,false,true,'published','web_in_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. JAMALI KAMALI (Indien) — djinnerna i Mehrauli
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'jamali-kamali','Jamali Kamali','jamali-kamali','Indien','Delhi, Mehrauli','Moské',
  28.5180,77.1820,3,true,false,NULL,
  'Inte vanliga spöken utan djinner — osynliga händer vidrör besökare i den gamla graven.',
  'Jamali Kamali är en moské och grav i Mehrauli Archaeological Park i Delhi, intill världsarvet Qutub Minar. Moskén byggdes omkring 1528–1529 under den förste mogulkejsaren Babur och är uppkallad efter Shaikh Jamali Kamboh, ett sufihelgon från 1500-talet känt för sin mystiska poesi.

Den rimmande andra halvan av namnet, Kamali, syftar på en okänd gestalt som begravts vid Jamalis sida. Enligt folktron var Kamali inte bara Jamalis lärjunge utan också hans älskade — en populär teori som historiker avvisar, men som tycks understödjas av sättet de två är begravda på.

Mycket av ryktena om paranormal aktivitet vid Jamali Kamali handlar dock inte om vanliga spöken, utan om djinner — en ras av skepnadsskiftande andar i den islamiska kosmologin. Det har rapporterats att besökare, särskilt nattetid efter stängning, kan känna sig iakttagna eller till och med vidrörda av osynliga händer. Människor har påstått sig se underliga ljus och skuggor i graven och hört något som låter som ett morrande djur eller skrattande röster.

Moskén är byggd i röd sandsten och utsmyckad med marmor, och dess valvprydda inre är majestätiskt, nästan palatsliknande. Men när Mehrauli-parkens hundratals monument höljs i mörker sägs djinnerna vakna — och få vågar dröja kvar bland de gamla gravarna.

Källa: Atlas Obscura + Moon Mausoleum + curlytales.com + vargiskhan.com',
  NULL,NULL,NULL,false,true,'published','web_in_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. TUNNEL 33 / BAROG (Indien) — den vänlige överstens ande
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'tunnel-33-barog','Tunnel 33 (Barog)','tunnel-33-barog','Indien','Himachal Pradesh, Barog','Tunnel',
  30.9150,77.0530,3,true,false,NULL,
  'Ingenjören sköt sig efter ett ödesdigert räknefel — hans vänliga ande pratar gärna med resenärer.',
  'Tunnel nr 33, även kallad Barogtunneln, är den längsta tunneln (1 143 meter) på den berömda Kalka–Shimla-järnvägen i Himachal Pradesh — och en av Indiens mest sägenomspunna spökplatser.

År 1898 fick den engelske järnvägsingenjören överste Barog i uppdrag att bygga tunneln, med en strikt tidsfrist. För att hinna lät han gräva från bergets båda sidor samtidigt, i tron att gångarna skulle mötas på mitten. Men på grund av ett ödesdigert räknefel i linjeföringen möttes de aldrig, och tunneln blev oavslutad.

Den hederlige Barog kände sig förödmjukad — och dessutom bötfälld på en rupie av den brittiska regeringen. En dag, under en promenad i sällskap med sin lilla hund, tog han sitt liv genom att skjuta sig nära den ofärdiga tunneln. Tunneln fullbordades senare och fick bära hans namn till hans ära.

Enligt lokal sägen lämnade hans ande aldrig platsen. Resenärer påstår sig höra viskningar, se en gestalt i vitt eller känna en närvaro inne i tunneln. Men Barog beskrivs som ett vänligt spöke — folk berättar gärna om hur de mött honom, satt sig ned och till och med skrattat tillsammans med honom. Det finns, sägs det, inga klagomål på överste Barog.

Källa: india.com + homegrown.co.in + shimlaonline.in + tripoto.com',
  NULL,NULL,NULL,false,true,'published','web_in_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
