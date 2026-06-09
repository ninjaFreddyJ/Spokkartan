-- Spökkartan — 8 fler hemsökta platser i Australien, omgång 2 (Australien 19 -> 27)
-- Genererad 2026-06-09. METOD: engelska sökord -> Wikipedia, ghosttoursaustralia.com.au,
-- amyscrypt.com, adelaidehauntedhorizons.com.au m.fl. Svenska, 200-600 ord/plats.
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. MONTE CRISTO HOMESTEAD — Australiens mest hemsökta hus
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'monte-cristo-homestead','Monte Cristo Homestead','monte-cristo-homestead','Australien','New South Wales, Junee','Herrgård',
  -34.8500,147.5830,4,false,true,NULL,
  'En gravid tjänsteflicka hoppade från balkongen och en pojke hölls kedjad i 30 år — minst tio spöken.',
  'Monte Cristo Homestead i Junee i New South Wales uppfördes 1885 av pionjären Christopher William Crawley som en tvåvånings herrgård i sen viktoriansk stil, tronande på en kulle över staden. Den marknadsför sig som "Australiens mest hemsökta hus".

Familjen Crawley bodde kvar till 1948, varefter huset stod tomt och förföll tills paret Reg och Olive Ryan köpte det 1963 och restaurerade det. Bakom det vackra yttre döljer sig flera tragedier. Crawley ska ha gjort två av sina tjänsteflickor med barn; en av dem tog livet av sig genom att hoppa från balkongen, gravid — och blekmärket efter att hennes blod tvättats bort från trappstegen sägs ännu synas. Den andra födde en son, Harold, som efter en svår huvudskada hölls kedjad i vagnshuset i över trettio år, skrikande och tjutande dagligen.

En stalldräng, Morris, brann till döds i sin säng sedan hans husbonde tänt eld på halmmadrassen för att få honom att vakna. Och Crawleys lilla barnbarn Ethel dog 1917 när barnsköterskan tappade henne i trappan — hon hävdade att hon knuffats av en osynlig kraft.

Paret Ryan rapporterade otaliga övernaturliga händelser: spökljus, djur som dog oförklarligt och minst tio spöken. Övernattande gäster berättar om underliga röster i fjärran och steg i korridorerna.

Källa: Engelska Wikipedia "Monte Cristo Homestead" + thelittlehouseofhorrors.com + pedestrian.tv + tracesmagazine.com.au',
  NULL,NULL,NULL,true,true,'published','web_au_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. ADELAIDE GAOL — 45 hängningar inom murarna
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'adelaide-gaol','Adelaide Gaol','adelaide-gaol','Australien','South Australia, Adelaide','Fängelse',
  -34.9100,138.5790,4,false,true,NULL,
  '45 män hängdes här och vilar ännu inom murarna — en seriemördares ande vandrar bland gravarna.',
  'Adelaide Gaol är en av Adelaides äldsta offentliga byggnader och tjänade som fängelse och avrättningsplats i nästan 150 år. Den räknas som en av de mest hemsökta platserna i South Australia.

Med 45 hängningar och begravningsmark för mördare är det föga förvånande att ett dussintal rastlösa andar sägs hemsöka fängelset. Den förste som hängdes i South Australia var Michael Magee, den 2 maj 1838, och den siste Glen Sabre Valance i november 1964. Av de 66 fångar som hängdes i delstaten avrättades 45 vid Adelaide Gaol, och deras kroppar vilar ännu inom murarna, på en av fängelsets två kyrkogårdar.

Ett av de oftast sedda spökena tros vara John Balaban, en sadistisk seriemördare som dödade minst fem personer — däribland sin egen hustru och sexårige son — och som avrättades 1953. William Baker Ashton, fängelsets förste direktör, sägs alltjämt hålla till i sitt forna kontor på övervåningen, där han dog; tunga steg av en kraftig man hörs ofta paca där inne. En tredje gestalt, Fred Carr, visar sig regelbundet nära trappan till de övre cellerna, prydligt klädd i mörkt och vänligt nyfiken på besökarna.

Spöksteg, röster och poltergeistaktivitet — dörrar som rör sig, elektroniska störningar och plötsliga temperaturfall — rapporteras genom hela fängelset.

Källa: adelaidegaol.org.au + amyscrypt.com + adelaidehauntedhorizons.com.au + adelaidegaol.sa.gov.au',
  NULL,NULL,NULL,false,true,'published','web_au_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. BOGGO ROAD GAOL — Ernest Austin och den trebenta spökkatten
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'boggo-road-gaol','Boggo Road Gaol','boggo-road-gaol','Australien','Queensland, Brisbane','Fängelse',
  -27.4960,153.0290,4,false,true,NULL,
  'Den siste avrättade mannens skugga ses i cellblock E — och en trebent spökkatt stryker mot besökarnas ben.',
  'Boggo Road Gaol i Brisbane öppnade 1883 och var en av Queenslands viktigaste fånganstalter i över ett sekel. Den bestod av två avdelningar: Division 1, ökänd för sina avrättningar, och Division 2, som från början hyste kvinnliga fångar. Den enda del som står kvar idag är Number Two Division, ursprungligen kvinnofängelset uppfört 1902.

Vid galgen i Division 1 hängdes 42 av landets mest avskyvärda brottslingar. Ellen Thomson var den enda kvinna som avrättats i Queensland; hon mötte sitt öde i den äldsta delen av fängelset, som revs på 1970-talet.

Mest ökänd är anden efter Ernest Austin, den siste man som avrättades i Queensland sedan han våldtagit och mördat en elvaårig flicka. Hans spöke ska ha setts åtskilliga gånger i både division 1 och 2. Sedan spökturerna startade 1998 har både besökare och personal sett skuggan av en man i cellblock E — samma plats där fångar såg Austins ande redan på 1980-talet.

Spökhistorier från vakter och fångar går tillbaka till 1930-talet. Under tjugo år har besökare svurit på att de blivit vidrörda, gripna eller till och med tilltalade av andar. Den märkligaste hemsökelsen är dock en trebent spökkatt — "Tripod" — som besökare påstår har strukit sig mot deras ben eller hörts jama.

Källa: ghosttoursaustralia.com.au + boggoroadgaol.com + redcliffetourism.com + viator.com',
  NULL,NULL,NULL,false,true,'published','web_au_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. Z WARD — "Hell Ward" för de kriminellt sinnessjuka
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'z-ward-glenside','Z Ward (Glenside)','z-ward-glenside','Australien','South Australia, Adelaide','Asyl',
  -34.9420,138.6360,4,false,true,NULL,
  'Folket kallade den "Hell Ward" — i "Scratchys rum" sägs huden slå upp i klolika rivmärken.',
  'Z Ward i Glenside i Adelaide stod färdigt 1885 och stängde 1973. Den fristående byggnaden, omgiven av en imponerande "ha-ha"-mur, hyste många av delstatens mest våldsamma och "kriminellt sinnessjuka" patienter — mördare, tjuvar och de svårast störda.

Ursprungligen hette den L Ward, men kom snart att kallas Z Ward — eller snarare "Hell Ward" i folkmun, av "Hell" i stället för "L". Den byggdes mer som ett fängelse än en asyl, med maximala säkerhetsanordningar för att ingen skulle kunna rymma. Dess syfte var att stänga inne dem som ansågs alltför farliga och psykiskt sjuka för en vanlig kriminalvårdsanstalt.

Paranormal aktivitet är vanlig inne i Z Ward, som låste in South Australias kriminellt sinnessjuka i nästan nittio år. "Aktivitet" har dokumenterats i celler på båda våningarna, däribland "Scratchys rum", där huden sägs kunna slå upp i klolika rivmärken, och "spegelrummet", där en skuggestalt sägs glida in i glaset.

Idag erbjuds åtskilliga turer i Z Ward — både kulturhistoriska turer och spökturer, drivna av National Trust och Haunted Horizons. Spökturerna har blivit populära bland dem som dras till både det paranormala och byggnadens mörka historia. I de tysta, tjockmurade cellerna känns de inspärrades förtvivlan ännu påtaglig.

Källa: adelaidehauntedhorizons.com.au + amyscrypt.com + Atlas Obscura + broadsheet.com.au',
  NULL,NULL,NULL,false,true,'published','web_au_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 5. LARUNDEL ASYLUM — speldosans toner i natten
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'larundel-asylum','Larundel Asylum','larundel-asylum','Australien','Victoria, Melbourne','Asyl',
  -37.7000,145.0670,4,false,false,NULL,
  'En flickas speldosa hörs spela sent på natten i det övergivna mentalsjukhusets korridorer.',
  'Larundel Mental Asylum i Bundoora i Melbourne började byggas 1938, men arbetet avbröts av andra världskriget. De halvfärdiga byggnaderna användes under kriget som militärsjukhus för flygvapnet och som utbildningsdepå. Femton år efter byggstarten började asylen ta emot patienter, och den stängde officiellt 2001.

Larundel är känt som det första center som behandlade den ökände australiske seriemördaren Peter Dupas, och som platsen där litium först användes för att behandla bipolär sjukdom. Efter stängningen stod den övergiven och förfallande, och sägs vara hemsökt av forna patienters andar, vilkas rastlösa själar ännu vandrar i de mörka korridorerna och viskar om det lidande de utstod.

Den mest kända legenden är speldosans. En ung flicka, som bodde många år på asylens tredje våning, ska ha haft en enda ägodel som låg henne varmt om hjärtat — en speldosa, som hon ofta spelade. Sägnen säger att man efter hennes död ofta hört de svaga tonerna av speldosan sent på natten. Somliga menar dock att musiken i själva verket kommer från en lokal glassbil, som kan höras även sent på kvällen.

Idag står Larundel som ett vidsträckt område av inhägnade ruiner, där många av de gamla sjukhusbyggnaderna restaurerats och byggts om till moderna lägenheter — men minnet av asylens mörka år dröjer kvar.

Källa: exutopia.com + amyscrypt.com + Atlas Obscura + vice.com',
  NULL,NULL,NULL,false,true,'published','web_au_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 6. HYDE PARK BARRACKS — straffångarnas spökjournal
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'hyde-park-barracks','Hyde Park Barracks','hyde-park-barracks','Australien','New South Wales, Sydney','Byggnad',
  -33.8690,151.2120,3,false,true,NULL,
  'Sydneys mest hemsökta byggnad för en regelrätt spökjournal — en kvinna i vitt vakar under fikonträdet.',
  'Hyde Park Barracks i centrala Sydney sägs vara stadens mest hemsökta byggnad. Den uppfördes 1817–1819 — ritad av straffångearkitekten Francis Greenway och byggd av fångarbete — och rymde i medeltal 600 straffångar, som om dagarna sattes i arbete och om nätterna sov i hängmattor i tolv rum. Senare tjänade byggnaden som sjukhus, kvinnofängelse och domstol, och är idag ett världsarvslistat museum.

Besökare beskriver dånande steg ovanför sig och plötsliga kalla fläckar i de gamla sovsalarna. Flera bestämda uppenbarelser har dokumenterats: en grovkäftad forna fängelseföreståndare vars svordomar tycks eka genom salarna; en "kvinna i vitt" som setts under fikonträdet på framsidan; och en man i blekt fångdräkt som driver fram i en korridor. Andra berättelser nämner en fånge som haltar i gången och två svarta gestalter som hukar vid dörren i hängmatterummet om natten.

Till skillnad från de flesta "hemsökta" platser för Hyde Park Barracks en regelrätt spökjournal, med nedteckningar av upplevelser gjorda strax efter att de inträffat. Vakter och andra som tillbringat natten i byggnaden — däribland skolbarn som sover över för att få "fångupplevelsen" — har vittnat om olika fenomen. Personalen har då och då hört oförklarliga jämmer eller sett ljus flacka av sig själva i museiflygeln.

Källa: csicop.org + australiatravelhub.com + neighbourhoodmedia.com.au + sydney100.com',
  NULL,NULL,NULL,false,true,'published','web_au_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 7. FISHERS GHOST — spöket som pekade ut sin egen mördare
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'fishers-ghost','Fishers Ghost','fishers-ghost','Australien','New South Wales, Campbelltown','Naturplats',
  -34.0650,150.8140,3,true,false,NULL,
  'Ett spöke satt på broräcket och pekade mot bäcken — där låg den mördade Fishers begravda kropp.',
  'Fishers Ghost är en av Australiens äldsta och mest berömda spökhistorier, från det tidiga 1800-talet, knuten till Campbelltown i New South Wales.

Den 17 juni 1826 försvann plötsligt Frederick Fisher, en straffånge som deporterats från London för förfalskning och som förvärvat en gård i Campbelltown. Hans granne George Worrall påstod att Fisher återvänt till England och lämnat fullmakt över sin egendom. Men en sen kväll i oktober 1826 rusade en välbärgad och aktad lantbrukare, John Farley, in på ortens värdshus i chocktillstånd och påstod att han sett Frederick Fishers spöke. Spöket satt på räcket till en bro, pekade mot en hage nere vid bäcken — och bleknade sedan bort.

Omständigheterna kring Fishers försvinnande väckte till slut tillräcklig misstanke för att polisen skulle genomsöka just den hage spöket pekat mot. Där fann man den mördade Fishers kvarlevor, begravda vid bäckkanten. George Worrall greps, erkände och hängdes.

Det är en av Australiens tidigaste nedtecknade spökhistorier — och en av få där ett spökvittnesmål föregick en fällande mordom. Sedan 1956 hålls varje november den tio dagar långa Festival of Fishers Ghost i Campbelltown, som bygger vidare på legenden om mannen vars ande pekade ut sin egen mördare.

Källa: Engelska Wikipedia "Fishers ghost" + visitcampbelltown.com.au + historysvault.com + dictionaryofsydney.org',
  NULL,NULL,NULL,false,true,'published','web_au_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 8. MIN MIN-LJUSET — outbackens spökljus
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'min-min-light','Min Min-ljuset','min-min-light','Australien','Queensland, Boulia','Naturplats',
  -22.9100,139.9000,2,true,false,NULL,
  'Spökljus som följer resenärer genom outbacken — de dödas andar vid det ökända Old Min Min Inn.',
  'Min Min-ljuset är ett ljusfenomen som ofta rapporterats i Australiens outback. Iakttagelser sträcker sig från Brewarrina i västra New South Wales i söder till Boulia i norra Queensland. Ljusen var lokalt kända som "ghost lights" — spökljus.

Berättelser om ljusen finns i flera aboriginska kulturer och föregår den europeiska koloniseringen; de har sedan blivit en del av vidare australisk folktro. Namnets ursprung är osäkert — det kan komma från ett aboriginskt språk i Cloncurry-trakten, eller från Min Min Hotel, en liten bosättning där en boskapsskötare såg ljuset 1918.

Enligt sägnen var ljusen de dödas andar, som hemsökte den övergivna platsen efter Old Min Min Inn — ett ökänt värdshus längs den gamla diligensvägen, med rykte om utspädd sprit, lättillgängliga droger och en strid ström av slagsmål och mord.

Det är osäkert om Min Min-ljusen är ett verkligt fenomen, och i så fall vad de beror på. Flera hypoteser har lagts fram: forskaren Jack Pettigrew menar att de kan vara svärmar av insekter som blivit självlysande, en art av uggla med egen bioluminiscens — eller en hägring av typen Fata Morgana, då ett varmt luftlager fångar kall, tät luft under sig och böjer ljuset. Men för outbackens resenärer förblir spökljusen en olöst gåta.

Källa: Engelska Wikipedia "Min Min light" + historicmysteries.com + adventuretours.com.au + australianhistory.net',
  NULL,NULL,NULL,false,true,'published','web_au_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
