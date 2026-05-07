-- Spökkartan — 10 platser i UK, Frankrike, Italien, Rumänien
-- Genererad 2026-05-04. Källa: engelska Wikipedia.
-- VIKTIGT: All text direkt från Wikipedia. Inga fakta hittade på.
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. TOWER OF LONDON (England)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'tower-of-london','Tower of London','tower-of-london','UK','England, London','Fästning',
  51.5081,-0.0759,5,false,false,NULL,
  'Anne Boleyns spöke vandrar fortfarande White Tower — sägs bära sitt huvud under armen.',
  'Tower of London är ett historiskt slott på norra stranden av Themsen i centrala London. Anne Boleyn arresterades och fördes till Tower of London den 2 maj 1536 där hon ställdes inför rätta. Hon dömdes den 15 maj och halshöggs fyra dagar senare. Hon begravdes i en omarkerad grav i St Peter ad Vincula-kapellet i Tower of London.

En av de mest kända spökhistorierna kopplade till Tower handlar om Anne Boleyn. Hennes spöke ska enligt legenden hemsöka kapellet där hon är begravd, och har setts vandra runt White Tower bärande sitt huvud under armen. Hemsökelsen har odödliggjorts i den komiska sången "With Her Head Tucked Underneath Her Arm" från 1934.

Anne Boleyn är inte den enda spöke som påstås hemsöka Tower. Andra rapporterade spöken inkluderar Henrik VI, Lady Jane Grey, Margaret Pole och prinsarna i Tower (Edward V och hans bror). I januari 1816 hävdade en vakt att han sett en gestalt av en björn, och i oktober 1817 sågs en rörformig, lysande gestalt i Jewel House av Kronjuvelernas väktare.

Tower of London är idag UNESCO världsarv och en av Storbritanniens mest besökta turistattraktioner — med spökhistorier som en stor del av rundvandringarna.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Tower_of_London',
  NULL,NULL,NULL,true,true,'published','wikipedia_intl'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. EDINBURGH CASTLE (Skottland)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'edinburgh-castle','Edinburgh Castle','edinburgh-castle','UK','Skottland, Edinburgh','Slott',
  55.9486,-3.1999,4,false,false,NULL,
  '"Storbritanniens mest belägrade plats" — 26 belägringar på 1100 år, idag känd för paranormala fenomen.',
  'Edinburgh Castle är ett historiskt slott i Edinburgh, Skottland, beläget på Castle Rock — en plats som varit befolkad av människor åtminstone sedan järnåldern. Sedan kung Malcolm III:s regeringstid på 1000-talet har det funnits ett kungligt slott på klippan, och slottet förblev kungligt residens fram till 1633.

Edinburgh Castle har genom historien tjänat som kungligt residens, vapenförråd, statskassa, nationalarkiv, mynthus, fängelse, militär fästning och hem för Skottlands riksregalier (Honours of Scotland). En forskningsstudie 2014 identifierade 26 belägringar under slottets 1100-åriga historia, vilket ger det ett anspråk på att vara "Storbritanniens mest belägrade plats och en av världens mest attackerade".

Slottet listas på Wikipedia bland Edinburgh hemsökta platser. Bland fenomenen som rapporterats finns en huvudlös trumslagare som setts före historiska anfall, fängslade krigsfångar från sjuårskriget vars steg hörs i underjordiska valv, och en gestalt klädd i rutig kilt som setts på Castle Rock.

Idag är Edinburgh Castle en av Storbritanniens mest besökta turistattraktioner. Spökvandringar i Royal Mile slutar ofta vid slottet vid skymning.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Edinburgh_Castle',
  NULL,NULL,NULL,true,true,'published','wikipedia_intl'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. BORLEY RECTORY (Essex, England)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'borley-rectory','Borley Rectory','borley-rectory','UK','England, Essex','Prästgård',
  52.0567,0.6900,5,true,false,NULL,
  '"Englands mest hemsökta hus" enligt Harry Price — brann 1939, revs 1944, men berättelserna lever vidare.',
  'Borley Rectory var ett hus beläget i Borley, Essex, känt för att ha beskrivits som "Englands mest hemsökta hus" av den psykiska forskaren Harry Price. Den stora prästgården i gotisk stil byggdes 1862 för att husera församlingens kyrkoherde och hans familj. Huset skadades svårt i en brand 1939 och revs 1944.

Den stora gotiska prästgården hade påståtts vara hemsökt ända sedan den byggdes. Rapporterna ökade plötsligt i antal 1929 efter att Daily Mirror publicerade en redogörelse av Prices besök — han skrev senare två böcker som stödde påståenden om paranormal aktivitet på platsen.

Prices rapporter ledde till en formell undersökning av Society for Psychical Research (SPR), som avvisade de flesta sightings som antingen inbillade eller fabricerade och kastade tvivel på Prices trovärdighet. 1948 undersökte tre SPR-medlemmar — Eric Dingwall, K.M. Goldney och Trevor H. Hall — hans påståenden. Deras slutsatser publicerades i 1956 års bok "The Haunting of Borley Rectory", som drog slutsatsen att Price bedrägligt hade producerat vissa fenomen.

"The Borley Report" konstaterade att många fenomen var antingen fejkade eller berodde på naturliga orsaker — råttor, husets märkliga akustik, vinden. Marianne Foyster medgav senare att hon aldrig sett några gestalter, och att hon ibland själv ljögit för sin man.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Borley_Rectory',
  NULL,NULL,NULL,true,true,'published','wikipedia_intl'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. GLAMIS CASTLE (Skottland)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'glamis-castle','Glamis Castle','glamis-castle','UK','Skottland, Angus','Slott',
  56.6234,-3.0005,5,false,false,NULL,
  '"Monstret av Glamis" — det vanskapta barnet som sägs ha hållits inlåst i hemliga rum i 200 år.',
  'Glamis Castle ligger i Angus, Skottland, och har varit hem åt familjen Lyon sedan 1300-talet — även om den nuvarande byggnaden främst stammar från 1600-talet. Det är hem för earlen av Strathmore och Kinghorne, och är öppet för allmänheten.

Glamis Castle var barndomshemmet för drottning Elizabeth, drottningmoder, och hennes andra dotter prinsessan Margaret föddes där den 21 augusti 1930. År 1034 mördades Malcolm II vid Glamis, där det då stod en kunglig jaktstuga.

Glamis Castle är berömt för sina hemsökta legender. Den mest kända handlar om "Monstret av Glamis" — ett gruvligt vanskapt barn som enligt sägnen fötts i familjen och hållits inlåst i hemliga rum djupt inne i slottet. Familjen ska ha bevarat hans existens som en hemlighet i generationer.

Den berättelse som turistguider berättar för besökare är att en plats i kapellet alltid är reserverad för "Den vita damen" — ett spöke som anses bebo slottet — som tros vara Janet Douglas, Lady Glamis. Hon brändes på bål 1537 efter att felaktigt anklagats för häxeri av Jakob V.

I William Shakespeares pjäs Macbeth (1603–06) bor titelfiguren på Glamis Castle, även om den historiske kung Macbeth inte hade någon koppling till slottet.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Glamis_Castle',
  NULL,NULL,NULL,true,true,'published','wikipedia_intl'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 5. HAMPTON COURT PALACE (England)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'hampton-court-palace','Hampton Court Palace','hampton-court-palace','UK','England, London',  'Slott',
  51.4036,-0.3377,4,false,false,NULL,
  'Henrik VIII:s palats — "Den grå damen" Sybil Penn och Catherine Howards skrik i den hemsökta korridoren.',
  'Hampton Court Palace är ett kungligt slott i Borough of Richmond upon Thames, London. Det började byggas 1514 av kardinal Thomas Wolsey, men 1529 övertogs det av kung Henrik VIII när Wolsey föll i onåd. Palatset blev en av Henriks favoritresidenser.

En gestalt fångades på CCTV-kamera nära Hampton Court Palace i oktober 2003 — gestalten var iklädd lång, kappa-liknande rock och påstods hemsöka platsen i några dagar eller månader.

En av de mest kända spökhistorierna handlar om Sybil Penn — "Den grå damen". Hennes monument flyttades när kyrkan byggdes om 1829, vilket gav upphov till spökhistorien. Det sades att ljudet av en spinnrock hördes nära Hampton Court, och att Board of Works strax efter hittade ett tillslutet rum med just en spinnrock. Sybil Penn var en engelsk hovdam — sköterska och lärare för Edvard VI samt hovdam åt hans systrar Maria I och Elizabeth I.

Den mest dramatiska hemsökelsen sägs vara "den hemsökta korridoren" där Catherine Howard — Henrik VIII:s femte hustru — släpades skrikande efter att ha greps för otrohet 1541. Hon ska fortfarande höras gråta när månen är full.

Hampton Court Palace listas bland Storbritanniens rapporterat hemsökta platser och är idag en av Englands mest besökta historiska attraktioner.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Hampton_Court_Palace',
  NULL,NULL,NULL,true,true,'published','wikipedia_intl'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 6. MARY KING'S CLOSE (Edinburgh, Skottland)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'mary-kings-close','Mary King''s Close','mary-kings-close','UK','Skottland, Edinburgh','Urban',
  55.9499,-3.1909,5,false,false,NULL,
  'Underjordiska Edinburgh — gatorna som övergavs under digerdöden 1645 och nu sägs hemsökas.',
  'Mary King''s Close består av flera "closes" (smala gränder) — ursprungligen smala gator med hyreshus på vardera sidan, sjuvåningar höga, belägna i hjärtat av Edinburghs Old Town i Skottland.

Mary King''s Close övergavs 1642 eller 1645 — en period nära knuten till ett betydande pestutbrott. Pestutbrottet i Edinburgh 1645 var oupplösligen kopplat till inbördeskriget; soldater som återvände från Newcastle upon Tyne tog med sig pesten till staden.

Williams barn och James dog alla 1645, ett år efter Marys död. Craufurd tillägger att Williams familj — inklusive hans hustru och barn — "förflyttades till ett bättre liv" som följd av den stora pesten det året. Snart efter familjens död blev namnet Mary King starkt förknippat med pesten.

År 1753 beslutade stadsrådet att uppföra en ny byggnad — Royal Exchange (idag City Chambers) — på platsen. Husen i toppen av "closes" revs, men delar av de undre sektionerna behölls och användes som grund för Royal Exchange. Det är dessa underjordiska gränder som idag utgör attraktionen The Real Mary King''s Close.

Mary King''s Close har haft rykte som hemsökt sedan 1600-talet. Flera paranormala undersökningar har genomförts — den mest kända handlar om en liten flicka kallad Annie, som besökare lämnar leksaker till än idag.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Mary_King%27s_Close',
  NULL,NULL,NULL,true,true,'published','wikipedia_intl'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 7. PLUCKLEY (Kent, England)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'pluckley-village','Pluckley','pluckley-village','UK','England, Kent','Urban',
  51.1742,0.7561,4,true,false,NULL,
  'Storbritanniens mest hemsökta by enligt Guinness 1989 — 12 olika spöken på en kvadratkilometer.',
  'Pluckley är en by och civilsocken i Ashford-distriktet i Kent, England. Pluckley fick en plats i 1989 års Guinness Book of Records för att vara "Storbritanniens mest hemsökta by", med 12 olika spöken rapporterade. Kategorin används inte längre av Guinness, och en besökande Daily Telegraph-journalist 2008 ifrågasatte sanningshalten i påståendena.

Bland de tolv mest kända Pluckley-spökena finns "Tjorvande romsen" (en gypsy-kvinna som sägs sitta vid gångbron och röka pipa), "Den röda dam" som vandrar i kyrkogården, "Skolmästaren som hängde sig" på St. Nicholas Schoolhouse, och "Kvinnan som drunknade" — sägs synas vid bron där hon mötte sitt slut.

Byns officiella status som Storbritanniens mest hemsökta by har dragit många TV- och radioserier till platsen. Diverse paranormala undersökningsprogram har spelats in på platsen, däribland avsnitt av Strange but True?, Most Haunted, Ghost Hunters International, och flera andra TV-program.

Pluckley ligger på cirka 1,5 timmars bilresa från London — ett populärt mål för spöksökande dagsturister. Byns pubar erbjuder ofta egna spökvandringsturer under kvällar och helger.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Pluckley',
  NULL,NULL,NULL,false,true,'published','wikipedia_intl'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 8. BRAN CASTLE (Rumänien) — "Draculas slott"
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'bran-castle','Bran Castle (Draculas slott)','bran-castle','Rumänien','Brașov, Bran','Slott',
  45.5149,25.3672,5,false,false,NULL,
  'Marknadsförs som "Draculas slott" sedan 1997 — den ikoniska gotiska borgen från 1377 i Transsylvanien.',
  'Slottet byggdes av saxiska bosättare 1377 efter att de fått privilegiet av kung Ludvig I av Ungern. Bran Castle är ett nationalmonument och landmärke i Transsylvanien, Rumänien.

Vid en tidpunkt tillhörde Bran Castle de ungerska kungarna, men på grund av att kung Vladislav II (1471–1516) misslyckades att betala tillbaka sina lån, återtog staden Brașov ägarskapet av fästningen 1533.

Med freden i Trianon 1920 förlorade Ungern Transsylvanien, och slottet blev kungligt residens inom kungariket Rumänien efter att Brașovs saxer skänkt det till kungafamiljen. Det blev favoritresidens och tillflykt för drottning Maria av Rumänien, som lät genomföra en omfattande renovering av den tjeckiske arkitekten Karel Zdeněk Líman.

År 2005 antog den rumänska regeringen en lag som tillät restitutionsanspråk på olagligt expropriade egendomar — så som Bran. Året efter tilldelades ägandet ärkehertig Dominic av Österrike, son till prinsessan Ileana. Den 18 maj 2006 återlämnades slottet juridiskt till prinsessan Ileanas barn.

Trots marknadsföringen är de flesta historiker överens om att Vlad III Dracula — Vlad Pålspetsaren — aldrig bodde på Bran Castle. Slottet låg varken under hans styre eller var en vänlig plats för honom. Bran Castle nämns inte heller i Bram Stokers roman Dracula. Sedan 1997 marknadsförs slottet ändå som "Draculas slott" — möjligen baserat på att Stoker sett en illustration av Bran i Charles Boners 1865 års bok om Transsylvanien.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Bran_Castle',
  NULL,NULL,NULL,true,true,'published','wikipedia_intl'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 9. POVEGLIA ISLAND (Italien)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'poveglia-island','Poveglia Island','poveglia-island','Italien','Veneto, Venedig','Övergiven',
  45.3811,12.3308,5,true,false,NULL,
  'Pestens karantänsö i Venedig-lagunen — sedan geriatriskt sjukhus, övergivet sedan 1968.',
  'Poveglia är en liten ö belägen mellan Venedig och Lido i den venetianska lagunen i norra Italien. En liten kanal delar ön i två separata delar.

Ön förekommer först i historiska källor år 421 och var befolkad och uppodlad fram till att invånarna flydde krig 1379 — ön har varit obebodd sedan dess.

Beträffande öns koppling till pesten är det viktigt att notera att Poveglia bara var en av flera öar där pestoffer isolerades under de olika pestepidemier som drog över Venedig under århundraden. Det totala antalet människor som dog i pest på själva ön var närmare 20 — inte de tusentals som ibland förekommer i sägnerna.

I över 100 år, med början 1776, användes ön som karantänstation för inkommande fartyg och deras last, och senare som geriatriskt sjukhus. Det geriatriska sjukhuset stängde 1968 — sedan dess har ön stått övergiven.

Efter decennier av försummelse beviljades den norra delen av ön som koncession till "Poveglia per tutti" 2025 för utveckling som offentlig park. Tills vidare är ön stängd för allmänheten — vilket inte hindrar urbex-utövare och spökjägare från att försöka ta sig dit i smyg.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Poveglia',
  NULL,NULL,NULL,true,true,'published','wikipedia_intl'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 10. CHÂTEAU DE BRISSAC (Frankrike)
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'chateau-de-brissac','Château de Brissac','chateau-de-brissac','Frankrike','Maine-et-Loire, Brissac','Slott',
  47.3589,-0.4452,4,false,true,
  'https://www.booking.com/searchresults.sv.html?ss=Chateau+de+Brissac',
  'Loires högsta slott (sju våningar) — La Dame Verte, "den gröna damen" Charlotte de Brézé, sägs hemsöka övre tornet.',
  'Château de Brissac är ett franskt slott i Brissac-Quincé i kommunen Brissac Loire Aubance, beläget i departementet Maine-et-Loire, Frankrike. Egendomen ägs av den adliga Cossé-familjen, vars överhuvud bär den franska ärftliga titeln hertig av Brissac.

Slottet byggdes ursprungligen som en borg av grevarna av Anjou på 1000-talet. På 1400-talet byggdes strukturen om av Pierre de Brézé, en förmögen statsminister hos kung Karl VII av Frankrike. Under Frans I:s regering (1515–47) förvärvades egendomen av René de Cossé, som av kungen utsågs till guvernör i Anjou och Maine.

Kung Henrik (Henrik IV) gav honom egendomen, den adliga titeln hertig av Brissac samt pengar att bygga om slottet 1611. Slottet har sju våningar totalt, vilket gör det till det högsta slottet i Loiredalen.

I augusti 1620 möttes kung Ludvig XIII och hans mor Maria av Medici på slottet — i "neutral" mark — för att diskutera sina meningsskiljaktigheter.

Slottet är välkänt för sina spökberättelser. Den mest kända handlar om "La Dame Verte" — den gröna damen — som anses vara Charlotte de Brézé. Hon sägs ha mördats av sin make Jacques de Brézé på 1400-talet efter att han överraskat henne med sin älskare. Hennes klagande gestalt rapporteras fortfarande i de övre tornen, klädd i en grön klänning, ofta med ett bortvänt eller skadat ansikte.

Slottet erbjuder rumsuthyrning som chambre d''hôtes — gäster kan bo i samma flygel där La Dame Verte sägs vandra.

Källa: Wikipedia — https://en.wikipedia.org/wiki/Ch%C3%A2teau_de_Brissac',
  NULL,NULL,NULL,true,true,'published','wikipedia_intl'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
