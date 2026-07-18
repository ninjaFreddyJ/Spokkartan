-- 79_OSTERGOTLAND_SPOKPLATSER.sql
-- Importerad från scraper-visit-sidor/data/spokvandring-ostergotland/ (Grantigos eget
-- researchmaterial: 29 spök-/sägenplatser i Skänninge, Mjölby, Västra Harg, Boxholm,
-- Mantorp och Ödeshög/Omberg — underlag för kommande vandringar i stadsvandring.io).
ALTER TABLE places ADD COLUMN IF NOT EXISTS source TEXT;
ALTER TABLE places ADD COLUMN IF NOT EXISTS translations JSONB;


BEGIN;
INSERT INTO places (id, name, slug, lat, lng, country, region, type, scary, free, bookable, teaser, description, status, source, translations) VALUES
('skanninge-avrattningsplats-tivoliangen', 'Skänninges avrättningsplats (Tivoliängen)', 'skanninge-avrattningsplats-tivoliangen', 58.392, 15.0865, 'Sverige', 'Östergötland', 'Avrättningsplats', 5, true, false,
 'En av Sveriges mest undersökta avrättningsplatser — i bruk i ~600 år, elva gravar och ett galgdike.',
 'Vid Tivoliängen i södra Skänninge låg häradets avrättningsplats, i bruk från 1000-talet till mitten av 1600-talet. Östergötlands museum grävde fram elva gravar och ett cirkelformat dike (tolkat som galgkullens rest). Här begravdes de avrättade och vanärade som nekades vigd jord — i folktron just de som blev gastar och gengångare. [Belagd arkeologi; gengångarmotivet är allmän folktro.]

(Koordinat ungefärlig — ej exakt geokodad.)',
 'published', 'spokvandring-ostergotland-research',
 '{"en": {"name": "Skänninge execution site (Tivoliängen)", "teaser": "One of Sweden''s most-excavated execution sites — used for ~600 years, eleven graves and a gallows ditch.", "description": "At Tivoliängen south of Skänninge lay the district execution ground, used from the 11th century to the mid-1600s. Östergötland''s museum uncovered eleven graves and a circular ditch (read as the gallows-mound remnant). Here the executed and dishonoured, denied consecrated ground, were buried — in folk belief exactly those who became restless revenants. [Documented archaeology; the revenant motif is general folklore.]"}}'::jsonb),

('skanninge-st-olof-petrus-de-dacia', 'S:t Olofs kloster & Petrus de Dacia', 'skanninge-st-olof-petrus-de-dacia', 58.3956, 15.0868, 'Sverige', 'Östergötland', 'Kloster', 4, true, false,
 'Vid svartbrödernas försvunna kloster skrev Sveriges förste författare om djävulen som slog en mystikers huvud i väggen.',
 'S:t Olofs dominikankloster (''svartbröderna''), grundat 1237, är borta ovan mark men utgrävt 2004–05. Här verkade Petrus de Dacia, kallad Sveriges förste författare, som skildrade mystikern Kristina av Stommeln: hur ''djäfvuln'' fysiskt angrep henne, slog hennes huvud i väggen, och hur hon fick blödande stigmata. [Texten belagd; händelserna medeltida mystik/folktro.]',
 'published', 'spokvandring-ostergotland-research',
 '{"en": {"name": "St Olof''s friary & Petrus de Dacia", "teaser": "At the vanished friary of the Black Friars, Sweden''s first author wrote of the devil beating a mystic''s head against the wall.", "description": "St Olof''s Dominican friary (the ''Black Friars''), founded 1237, is gone above ground but was excavated 2004–05. Here worked Petrus de Dacia, called Sweden''s first author, who described the mystic Christina of Stommeln: how the devil physically assaulted her, beat her head against the wall, and how she bled from stigmata. [Text documented; the events are medieval mysticism/folklore.]"}}'::jsonb),

('skanninge-sta-ingrids-kloster', 'S:ta Ingrids klosterruin', 'skanninge-sta-ingrids-kloster', 58.3984912, 15.0827434, 'Sverige', 'Östergötland', 'Kloster', 3, true, false,
 'Vallfartsort kring ett helgon som aldrig kanoniserades — en syster sägs ha svävat i bön, en annan blött ur Kristi sår.',
 'Sveriges första kvinnliga dominikankonvent, grundat ~1272 av Ingrid Elofsdotter, invigt 1281. Efter Ingrids död 1282 vördades hon som helgon och platsen blev vallfartsort; om systrarna berättades mirakel — en ska ha leviterat under bön, en annan stigmatiserats. Hon blev aldrig officiellt helgonförklarad. Ruiner och en brunn finns kvar. [Historia belagd; miraklerna är helgonlegend.]',
 'published', 'spokvandring-ostergotland-research',
 '{"en": {"name": "St Ingrid''s convent ruin", "teaser": "A pilgrimage site around a saint never canonised — one sister said to have levitated in prayer, another to have bled from Christ''s wounds.", "description": "Sweden''s first female Dominican convent, founded ~1272 by Ingrid Elofsdotter, consecrated 1281. After Ingrid''s death in 1282 she was venerated as a saint and the site became a pilgrimage goal; miracles were told of the sisters — one said to levitate in prayer, another to bear stigmata. She was never officially canonised. Ruins and a well remain. [History documented; the miracles are hagiographic legend.]"}}'::jsonb),

('skanninge-varfrukyrkan', 'Vårfrukyrkan (Garpekyrkan)', 'skanninge-varfrukyrkan', 58.3948493, 15.086697, 'Sverige', 'Östergötland', 'Kyrka', 3, true, false,
 'Man går på ett golv av gravhällar över de tyska köpmännen — kyrka byggd på kyrka på kyrka.',
 'Invigd 1306, byggd i tegel av Skänninges rika tyska köpmän (''garpar''), av vilka många lät sig begravas i kyrkan. Golvet är fullt av gravhällar. Utgrävningar visar äldre kyrkor under: en stenkyrka från 1100-talet och spår av en träkyrka från 1000-talet, styrkt av en runristad gravsten. [Belagd historia.]',
 'published', 'spokvandring-ostergotland-research',
 '{"en": {"name": "Church of Our Lady (the ''Garp'' church)", "teaser": "You walk a floor of grave slabs over the German merchants — a church built on church upon church.", "description": "Consecrated 1306, built in brick by Skänninge''s wealthy German merchants, many of whom had themselves buried inside. The floor is full of grave slabs. Excavations reveal older churches beneath: a 12th-century stone church and traces of an 11th-century wooden one, confirmed by a rune-carved gravestone. [Documented history.]"}}'::jsonb),

('skanninge-allhelgonakyrkan', 'Allhelgonakyrkans plats', 'skanninge-allhelgonakyrkan', 58.3963698, 15.0856145, 'Sverige', 'Östergötland', 'Kyrka', 3, true, false,
 'Den utraderade kyrkan: Gustav Vasa rev den 1552 och förde teglet till Vadstena slott. De döda ligger kvar under gräset.',
 'Skänninges äldsta kyrka, murar från tidigt 1100-tal. Gustav Vasa lät riva den 1552 och teglet fördes till Vadstena slott. Idag bara en gräsplätt markerad med ett kors, med resterna och de döda kvar under jorden. [Belagd historia; atmosfärisk, ingen egen spöksägen.]',
 'published', 'spokvandring-ostergotland-research',
 '{"en": {"name": "Site of All Saints'' church", "teaser": "The erased church: Gustav Vasa demolished it in 1552 and carted the brick to Vadstena Castle. The dead remain under the grass.", "description": "Skänninge''s oldest church, walls from the early 1100s. Gustav Vasa had it demolished in 1552 and the brick taken to Vadstena Castle. Today only a lawn marked with a cross, the remains and the dead still beneath the soil. [Documented; atmospheric, no ghost legend of its own.]"}}'::jsonb),

('mjolby-hogby-kyrkogard-hogbystenen', 'Högby gamla kyrkogård & Högbystenen', 'mjolby-hogby-kyrkogard-hogbystenen', 58.3433, 15.1478, 'Sverige', 'Östergötland', 'Sägenplats', 4, true, false,
 'En övergiven kyrkogård och Östergötlands näst främsta runsten, som räknar upp storbonden Gulles fem söner — alla döda.',
 'Vid den övergivna kyrkplatsen norr om Högby kyrka står Högbystenen (Ög 81, ~1010–1050), näst efter Rökstenen. Torkel ristade en vers om storbonden Gulle vars fem söner alla dött våldsamt: Asmund vid Fyris, Assur österut i Bysans, Halvdan på Bornholm, Kåre ''vid udden'', och Bo. [Belagd — den mörka berättelsen är runstenens egen text.]

(Koordinat ungefärlig — ej exakt geokodad.)',
 'published', 'spokvandring-ostergotland-research',
 '{"en": {"name": "Högby old churchyard & the Högby stone", "teaser": "An abandoned churchyard and Östergötland''s second-greatest runestone, naming the freeholder Gulle''s five sons — all dead.", "description": "At the abandoned church site north of Högby church stands the Högby stone (Ög 81, ~1010–1050), second only to the Rök stone. Torkel carved a verse about the freeholder Gulle whose five sons all died violently: Asmund at Fyris, Assur east in Byzantium, Halvdan on Bornholm, Kåre ''at the headland'', and Bo. [Documented — the dark tale is the stone''s own text.]"}}'::jsonb),

('mjolby-kungshoga-gravfalt', 'Kungshöga gravfält', 'mjolby-kungshoga-gravfalt', 58.3264, 15.1106, 'Sverige', 'Östergötland', 'Sägenplats', 4, true, false,
 'Ett av Sveriges större järnåldersgravfält — 125 gravar, domarringar och resta stenar, i bruk i tusen år.',
 'En 1,5 km lång grusås utanför Mjölby med 125 synliga gravar: domarringar, treuddar, högar och en skeppssättning, i bruk i ~1000 år. Enligt en omtvistad tradition stod här ett slag under Dackefejden 1543. Domarringar var i folktron tingsplatser; gravfält klassiska gengångarmiljöer. [Fornlämning belagd; slaget och spökmotivet osäkra/allmänna.]

(Koordinat ungefärlig — ej exakt geokodad.)',
 'published', 'spokvandring-ostergotland-research',
 '{"en": {"name": "Kungshöga grave field", "teaser": "One of Sweden''s larger Iron Age grave fields — 125 graves, judge-rings and standing stones, in use a thousand years.", "description": "A 1.5 km gravel ridge outside Mjölby with 125 visible graves: judge-rings, three-pointed settings, mounds and a stone ship, used for ~1000 years. A disputed tradition places a battle here during the Dacke feud of 1543. Judge-rings were assembly sites in folk belief; grave fields classic revenant ground. [Monument documented; the battle and ghost motif uncertain/general.]"}}'::jsonb),

('mjolby-kvarnby-svartan', 'Mjölby kvarnby & Svartåns fall', 'mjolby-kvarnby-svartan', 58.323, 15.1355, 'Sverige', 'Östergötland', 'Sägenplats', 2, true, false,
 'Vid kvarnhjulen och forsarna hörde näcken hemma — spelmannen som lockade folk i djupet.',
 'Mjölby var kvarnby vid Svartåns forsar redan på 1100-talet. Vid rinnande vatten och kvarnar placerade folktron näcken (strömkarlen, kvarngubben) — en spelande gestalt som lockade särskilt barn och kvinnor i vattnet. Berättelserna användes för att skrämma barn från strömt vatten. [Kvarnhistorien belagd; näcken allmän, väldokumenterad folktro, ej namngiven lokalsägen.]

(Koordinat ungefärlig — ej exakt geokodad.)',
 'published', 'spokvandring-ostergotland-research',
 '{"en": {"name": "Mjölby mill village & the Svartån falls", "teaser": "At the mill wheels and rapids the Neck belonged — the fiddler who lured people into the deep.", "description": "Mjölby was a mill village at the rapids of the Svartån already in the 12th century. At running water and mills folk belief placed the Neck (the stream-man, the mill-gnome) — a fiddling figure luring especially children and women into the water. The tales were told to keep children from swift water. [Mill history documented; the Neck is general, well-attested folklore, not a named local legend.]"}}'::jsonb),

('mjolby-ojebro-stenvalvsbro', 'Öjebro stenvalvsbro', 'mjolby-ojebro-stenvalvsbro', 58.3789901, 15.190482, 'Sverige', 'Östergötland', 'Bro', 2, true, false,
 'En av Sveriges längsta stenvalvsbroar över mörkt vatten — krigshärjning 1567 och en ''felstavad'' kungainskrift.',
 'Åtta valv, 64 m, byggd 1797 över Svartån efter att träbron brunnit. Här härjade danske översten Daniel Rantzau under Nordiska sjuårskriget 1567; svenskarna rev bron men danskarna byggde en ny. Mittpelarna bär Gustav IV Adolfs initialer — den södra ''felstavad''. [Belagd historia; mörkt vatten ger näck-stämning, ingen egen spöksägen.]',
 'published', 'spokvandring-ostergotland-research',
 '{"en": {"name": "Öjebro stone-arch bridge", "teaser": "One of Sweden''s longest stone-arch bridges over dark water — war raids in 1567 and a ''misspelled'' royal inscription.", "description": "Eight arches, 64 m, built 1797 over the Svartån after the timber bridge burned. Here the Danish colonel Daniel Rantzau raided during the Northern Seven Years'' War of 1567; the Swedes tore down the bridge, the Danes built a new one. The central piers bear Gustav IV Adolf''s initials — the southern one ''misspelled''. [Documented; dark water lends a Neck mood, no ghost legend of its own.]"}}'::jsonb),

('vastraharg-svaneholm-garpe', 'Svaneholms borgruin & jätten Garpe', 'vastraharg-svaneholm-garpe', 58.2704146, 15.2830049, 'Sverige', 'Östergötland', 'Sägenplats', 4, true, false,
 '1300-talsborg på en holme där jätten Garpe bodde med sin dvärg och hund — hans kopparbro syns i månljus.',
 'Borg anlagd av Magnus Eriksson på 1300-talet, belägrad och intagen 1364 av tyska soldater, med murar upp till 5 m tjocka. Sägnen: jätten Garpe bodde här med dvärgbetjänt och hund, ägde en kopparbro som syns i sjön på månljusa nätter, och gav slättfolket ''guldkorn'' (säd). När de valde andra gudar flyttade han norrut — men kastade först tre stenar mot kyrkan, som än idag ligger i sjön. [Borgen belagd; Garpe är nedtecknad folklore via hembygdsföreningen.]',
 'published', 'spokvandring-ostergotland-research',
 '{"en": {"name": "Svaneholm castle ruin & the giant Garpe", "teaser": "A 14th-century castle on an islet where the giant Garpe lived with his dwarf and hound — his copper bridge glints in moonlight.", "description": "A castle raised by Magnus Eriksson in the 1300s, besieged and taken in 1364 by German soldiers, with walls up to 5 m thick. The legend: the giant Garpe lived here with a dwarf servant and a hound, owned a copper bridge visible in the lake on moonlit nights, and gave the plain-folk ''grains of gold'' (grain). When they chose other gods he moved north — but first threw three stones at the church, still lying in the lake today. [Castle documented; Garpe is recorded folklore via the local heritage society.]"}}'::jsonb),

('vastraharg-kyrka', 'Västra Hargs kyrka', 'vastraharg-kyrka', 58.2638621, 15.2502472, 'Sverige', 'Östergötland', 'Kyrka', 2, true, false,
 'Kyrkan vars arkiv brann 1797 — därför lever bygdens sägner bara muntligt. De tre jättestenarna ligger i sjön intill.',
 'Stenkyrka trol. från 1200-talet (dopfunt tidigt 1200-tal bevarad); nuvarande kyrka 1814–15. År 1797 brann prästgården och kyrkans arkiv upp helt — mycket av den äldre sockenhistorien och folkloren gick förlorad. Byn står på gammal ''harg'' (fornnordisk offerplats). Jätten Garpes tre kaststenar ligger i sjön här. [Belagd historia.]',
 'published', 'spokvandring-ostergotland-research',
 '{"en": {"name": "Västra Harg church", "teaser": "The church whose archive burned in 1797 — so the parish''s legends live only by word of mouth. The three giant''s stones lie in the lake beside it.", "description": "A stone church probably from the 1200s (early-13th-century font preserved); present church 1814–15. In 1797 the parsonage and church archive burned entirely — much of the older parish history and folklore was lost. The village stands on an old ''harg'' (Norse sacrificial site). Giant Garpe''s three thrown stones lie in the lake here. [Documented history.]"}}'::jsonb),

('boxholm-tegelbruk-jattegraven', 'Boxholms tegelbruk — Jättegraven', 'boxholm-tegelbruk-jattegraven', 57.9967, 15.05, 'Sverige', 'Östergötland', 'Sägenplats', 3, true, false,
 'Under en triangulär stensättning ska en jätte ligga begravd — platsen där man undvek ''lappri'' efter mörkrets inbrott.',
 'Vid Boxholms tegelbruk i Svartåns dalgång (orten uppkallad efter sätesgården Bocksholm, järnbruk från 1754) ligger en triangulär stensättning där en jätte enligt sägnen är begravd — huvud, armar och fötter markerade av stenarna. Den ensamme vandraren undvek platsen efter mörkret, där ''lappri'' (spökeri) ansågs förekomma. [Bruksort belagd; jättegraven nedtecknad folklore.]

(Koordinat ungefärlig — ej exakt geokodad.)',
 'published', 'spokvandring-ostergotland-research',
 '{"en": {"name": "Boxholm brickworks — the Giant''s Grave", "teaser": "Under a triangular stone setting a giant is said to lie buried — a place shunned after dark for its ''haunting''.", "description": "By the Boxholm brickworks in the Svartån valley (the town named after the manor Bocksholm, ironworks from 1754) lies a triangular stone setting where a giant is said to be buried — head, arms and feet marked by the stones. The lone traveller shunned the place after dark, where ''haunting'' was thought to occur. [Ironworks town documented; the giant''s grave is recorded folklore.]"}}'::jsonb),

('boxholm-malexanders-kyrka', 'Malexanders kyrka', 'boxholm-malexanders-kyrka', 58.0322943, 15.2781374, 'Sverige', 'Östergötland', 'Kyrka', 3, true, false,
 'Trollen rev kyrkbygget varje natt tills man lät tvillingkvigor välja platsen — vid Sommens strand.',
 'Kyrkplats omnämnd 1345; medeltidskyrkan (besökt av heliga Birgitta) brann 1587, nuvarande 1881. Sägnen: kyrkan skulle byggas vid Ormsjötorp, men ''onda makter''/troll rev bygget varje natt. Man släppte då ett par tvillingkvigor med en släde och byggde där de stannade. En annan sägen: Malexanderbor stal en av Asbys kyrkklockor och förde den över Sommen. [Historia belagd; troll- och klocksägnen nedtecknad folklore.]',
 'published', 'spokvandring-ostergotland-research',
 '{"en": {"name": "Malexander church", "teaser": "Trolls tore down the building each night until twin heifers chose the spot — by the shore of Lake Sommen.", "description": "A church site recorded in 1345; the medieval church (visited by St Birgitta) burned in 1587, the present one 1881. The legend: the church was to be built at Ormsjötorp, but ''evil powers''/trolls tore the work down each night. So a pair of twin heifers with a sledge were loosed, and it was built where they stopped. Another legend: Malexander folk stole one of Asby''s church bells and carried it across Sommen. [History documented; the troll and bell legends are recorded folklore.]"}}'::jsonb),

('boxholm-ekeby-kyrka-igelbacken', 'Ekeby kyrka & Igelbäcken', 'boxholm-ekeby-kyrka-igelbacken', 58.2517273, 15.0463189, 'Sverige', 'Östergötland', 'Kyrka', 3, true, false,
 'Fyra runstenar på kyrkogården — och kyrkans första storklocka sägs ligga jättestulen i bäcken intill.',
 'Ekeby kyrka har nuvarande byggnad från 1600-talet, inventarier från 1100-talet och fyra ~1000-åriga runstenar på kyrkogården. Sägnen: under en videbuske i Igelbäcken på Ekebys östra gärde ligger kyrkans första storklocka gömd — stulen av en jätte. [Kyrkan belagd; klocksägnen nedtecknad folklore.]',
 'published', 'spokvandring-ostergotland-research',
 '{"en": {"name": "Ekeby church & the Igelbäcken", "teaser": "Four runestones in the churchyard — and the church''s first great bell said to lie giant-stolen in the brook nearby.", "description": "Ekeby church''s present building is from the 1600s, with fittings from the 1100s and four ~1000-year-old runestones in the churchyard. The legend: under a willow in the Igelbäcken brook on Ekeby''s east field lies the church''s first great bell, hidden — stolen by a giant. [Church documented; the bell legend is recorded folklore.]"}}'::jsonb),

('boxholm-rinna-kyrka', 'Rinna kyrka', 'boxholm-rinna-kyrka', 58.2853858, 14.958919, 'Sverige', 'Östergötland', 'Kyrka', 3, true, false,
 'Ett kyrkråe rev osynligt ned om natten det som byggts om dagen — samma motiv som i Malexander.',
 'När Rinna kyrka skulle byggas revs enligt sägnen osynligt ned om natten det som rests under dagen; ett kyrkråe (kyrkans skyddsväsen) låg bakom. Ett återkommande bygdemotiv (jfr Malexander). [Nedtecknad folklore.]',
 'published', 'spokvandring-ostergotland-research',
 '{"en": {"name": "Rinna church", "teaser": "A church-warden spirit invisibly tore down at night what was built by day — the same motif as at Malexander.", "description": "When Rinna church was to be built, legend says what was raised by day was invisibly torn down at night; a church-warden spirit was behind it. A recurring local motif (cf. Malexander). [Recorded folklore.]"}}'::jsonb),

('boxholm-sommen-urkon', 'Sjön Sommen — Urkon Sommakoa', 'boxholm-sommen-urkon', 58.04, 15.27, 'Sverige', 'Östergötland', 'Sägenplats', 4, true, false,
 'Sjön skapades av urkon som sparkade upp berget; instängd i en grotta äter hon ett hårstrå per julafton — sen bryter hon ut.',
 'Den örika sprickdalssjön Sommen (sägen: 365 öar) skapades enligt folktron när urkon Sommakoa i vrede sparkade upp sprickor i berget. Trollkarlen Somme från Tullerum låste in henne i en grotta vid Norra Vi-fjorden, där hon ligger på kol och päls och äter ett hårstrå varje julafton — när pälsen tar slut bryter hon ut och förstör världen. [Nedtecknad folklore; sjön belagd geografi.]

(Koordinat ungefärlig — ej exakt geokodad.)',
 'published', 'spokvandring-ostergotland-research',
 '{"en": {"name": "Lake Sommen — the primal cow Sommakoa", "teaser": "The lake was made by the primal cow kicking open the rock; caged in a cave she eats one hair each Christmas Eve — then she breaks free.", "description": "The island-strewn rift lake Sommen (legend: 365 islands) was made, folk belief holds, when the primal cow Sommakoa angrily kicked cracks into the rock. The wizard Somme of Tullerum locked her in a cave by the Norra Vi fjord, where she lies on coal and fur eating one hair each Christmas Eve — when the fur runs out she breaks free and destroys the world. [Recorded folklore; the lake is documented geography.]"}}'::jsonb),

('boxholm-malexandermorden', 'Malexandermorden (minnesplats)', 'boxholm-malexandermorden', 58.0323, 15.2781, 'Sverige', 'Östergötland', 'Minnesplats', 3, true, false,
 '1999 sköts två poliser ihjäl med sina egna vapen i skogen vid Malexander — en respektfull minnesplats, inte spökunderhållning.',
 'Den 28 maj 1999 sköts poliserna Olle Borén och Robert Karlström ihjäl med sina egna tjänstevapen efter ett bankrån. En av de mörkaste händelserna i modern svensk kriminalhistoria; minnesmärke finns. [Belagd, nutida tragedi med efterlevande — hanteras pietetsfullt, sensationalisera inte.]',
 'published', 'spokvandring-ostergotland-research',
 '{"en": {"name": "The Malexander murders (memorial)", "teaser": "In 1999 two police officers were shot dead with their own weapons in the forest at Malexander — a respectful memorial, not ghost entertainment.", "description": "On 28 May 1999 the officers Olle Borén and Robert Karlström were shot dead with their own service weapons after a bank robbery. One of the darkest events in modern Swedish crime history; a memorial stands. [Documented, recent tragedy with survivors — handle with respect, do not sensationalise.]"}}'::jsonb),

('mantorp-kararp-galgbacken', 'Kårarp / Galgbacken (Eriksgatan)', 'mantorp-kararp-galgbacken', 58.362, 15.33, 'Sverige', 'Östergötland', 'Avrättningsplats', 4, true, false,
 'Häradets avrättningsplats vid själva medeltida Eriksgatan — med järnåldersgravfält, hålväg och tre runstenar.',
 'Vid gamla Eriksgatans sträckning på gränsen Viby/Sjögestad (norr om Mantorp) låg traktens avrättningsplats. Riksintresse KE 89: gravfält från äldre järnålder, tydlig hålväg och tre runstenar invid vägen. Galgbackar bar i folktron gastar och gengångare. [Fornmiljö belagd; gengångarmotivet allmän folktro, ingen ortsbelagd spöksägen.]

(Koordinat ungefärlig — ej exakt geokodad.)',
 'published', 'spokvandring-ostergotland-research',
 '{"en": {"name": "Kårarp / the Gallows Hill (Eriksgata)", "teaser": "The district execution ground on the medieval royal road itself — with an Iron Age grave field, a hollow way and three runestones.", "description": "Along the old Eriksgata (royal road) on the Viby/Sjögestad boundary north of Mantorp lay the local execution ground. National interest KE 89: an early Iron Age grave field, a clear hollow way and three runestones by the road. Gallows hills in folk belief bore revenants. [Monument documented; the revenant motif is general folklore, no site-specific ghost legend.]"}}'::jsonb),

('mantorp-veta-kyrka-lonnglugg', 'Veta kyrka — lönngluggen', 'mantorp-veta-kyrka-lonnglugg', 58.3554146, 15.2588763, 'Sverige', 'Östergötland', 'Kyrka', 3, true, false,
 'En hålglugg i korväggen lät brottslingar och smittsamma följa mässan utifrån — de som inte fick komma in bland de levande.',
 'Veta kyrka har delar från 1100-talet. I korets södra vägg finns en ''lönnglugg'' som troligen lät brottslingar och smittsamma sjuka, som inte fick vistas i kyrkan, ändå följa mässan utifrån. Häradsting med dödsdomar hölls i Veta 1604–1681. [Belagd historia; stark stämning, ingen egen spöksägen.]',
 'published', 'spokvandring-ostergotland-research',
 '{"en": {"name": "Veta church — the leper''s squint", "teaser": "A hole in the chancel wall let criminals and the contagious follow Mass from outside — those not allowed in among the living.", "description": "Veta church has parts from the 1100s. In the chancel''s south wall is a ''squint'' that likely let criminals and the contagious, barred from inside, still follow Mass from without. District courts passing death sentences met at Veta 1604–1681. [Documented; strong atmosphere, no ghost legend of its own.]"}}'::jsonb),

('mantorp-bjalbo-ingrid-ylva', 'Bjälbo kyrka & Ingrid Ylva', 'mantorp-bjalbo-ingrid-ylva', 58.3721546, 15.005237, 'Sverige', 'Östergötland', 'Kyrka', 4, true, false,
 'Birger Jarls ''trollkunniga'' mor sägs ha murats in stående i en pelare — så länge hon höll huvudet högt skulle ätten skyddas.',
 'Bjälbo var Folkungaättens huvudgård och anges som Birger Jarls födelseort; det mäktiga tornet (~1220) knyts till hans mor Ingrid Ylva. Sägnen beskriver henne som ''trollkunnig'' vit häxa och berättar att hennes döda kropp murades in stående i en pelare — så länge hon höll huvudet högt skulle ingen olycka drabba Folkungaätten. [Tornet/historien belagd; inmurnings- och häxsägnen är folklore.]',
 'published', 'spokvandring-ostergotland-research',
 '{"en": {"name": "Bjälbo church & Ingrid Ylva", "teaser": "Birger Jarl''s ''sorcery-wise'' mother is said to have been walled in standing in a pillar — while she held her head high the dynasty would be spared.", "description": "Bjälbo was the Folkung dynasty''s main seat and is named as Birger Jarl''s birthplace; the mighty tower (~1220) is tied to his mother Ingrid Ylva. Legend calls her a ''sorcery-wise'' white witch and says her dead body was walled in standing in a pillar — while she held her head high no misfortune would strike the Folkungs. [Tower/history documented; the walling-in and witch legend are folklore.]"}}'::jsonb),

('mantorp-sya-kyrka', 'Sya kyrka & gravfälten', 'mantorp-sya-kyrka', 58.3361583, 15.2270917, 'Sverige', 'Östergötland', 'Kyrka', 2, true, false,
 'Runstenar och fyra järnåldersgravfält kring en kyrka vid Svartån — 1500 år av begravningar i obruten följd.',
 'Medeltida socken (nämnd 1382), nuvarande kyrka från 1770-talet på 1200-talsgrund. En del av en runsten står på kyrkogården, en annan vid gamla landsvägen; i socknen fyra järnåldersgravfält och ~2 km stensträngar. [Belagd fornmiljö; ingen egen spöksägen — atmosfärstopp.]',
 'published', 'spokvandring-ostergotland-research',
 '{"en": {"name": "Sya church & the grave fields", "teaser": "Runestones and four Iron Age grave fields around a church by the Svartån — 1500 years of burials in unbroken succession.", "description": "A medieval parish (named 1382), the present church from the 1770s on a 13th-century base. Part of a runestone stands in the churchyard, another by the old road; the parish holds four Iron Age grave fields and ~2 km of stone rows. [Documented monuments; no ghost legend of its own — an atmosphere stop.]"}}'::jsonb),

-- OBS: 'alvastra-klosterruin' finns redan live (09_IMPORT) — återanvänt id/slug berikar den.
('alvastra-klosterruin', 'Alvastra klosterruin', 'alvastra-klosterruin', 58.296599, 14.6584864, 'Sverige', 'Östergötland', 'Kloster', 4, true, false,
 'Cistercienserkloster från 1143 där munkarnas skatt sägs gömd i berget — och där nattvandrare i skymningen tror sig se kåpklädda gestalter.',
 'Grundat 1143 av munkar från Clairvaux på kung Sverkers initiativ; ett av Nordens första cistercienserkloster, rivet efter reformationen (sten till Vadstena slott). Sägnen: munkarna gömde sin skatt i Omberg via ''Murgrönagången'' mot Rödgavel. Modern spökturism rapporterar orgelmusik, kalla stråk och ''latinröster'' vid midnatt. [Klostret belagt; skattsägnen folklore; midnattsspökena sentida rykten.]',
 'published', 'spokvandring-ostergotland-research',
 '{"en": {"name": "Alvastra abbey ruin", "teaser": "A Cistercian abbey from 1143 where the monks'' treasure is said hidden in the mountain — and where dusk walkers think they glimpse cowled figures.", "description": "Founded 1143 by monks from Clairvaux at King Sverker''s initiative; one of the Nordic region''s first Cistercian abbeys, demolished after the Reformation (stone to Vadstena Castle). The legend: the monks hid their treasure in Mount Omberg via the ''Ivy Passage'' toward Rödgavel. Modern ghost tourism reports organ music, cold spots and ''Latin voices'' at midnight. [Abbey documented; treasure a legend; the midnight ghosts recent rumour.]"}}'::jsonb),

('odeshog-sverkersgarden', 'Sverkersgården & kungamordet 1156', 'odeshog-sverkersgarden', 58.2958, 14.661, 'Sverige', 'Östergötland', 'Sägenplats', 4, true, false,
 'Här mördades kung Sverker den äldre av sin egen stalldräng på väg till julottan i mörkret — en minnessten står kvar.',
 'Sverkersgården intill Alvastra var ett kungligt maktcentrum för Sverkerätten. Juldagen 1156 mördades kung Sverker d.ä. på väg till julottan — enligt traditionen av sin egen stalldräng. En Sverkersten står vid kulturstigen; kungen begravdes sannolikt i Alvastra klosterkyrka. [Mordet belagd mörk historia; ingen verifierad spöksägen — bygg på den historiska tyngden.]

(Koordinat ungefärlig — ej exakt geokodad.)',
 'published', 'spokvandring-ostergotland-research',
 '{"en": {"name": "Sverkersgården & the 1156 regicide", "teaser": "Here King Sverker the Elder was murdered by his own stable-hand on the way to Christmas matins in the dark — a memorial stone remains.", "description": "Sverkersgården beside Alvastra was a royal power centre of the Sverker dynasty. On Christmas Day 1156 King Sverker the Elder was murdered on his way to Christmas matins — by tradition, by his own stable-hand. A Sverker stone stands by the heritage trail; the king was likely buried in Alvastra abbey church. [The murder is documented dark history; no verified ghost legend — build on the historical weight.]"}}'::jsonb),

('odeshog-omberg-drottning-omma', 'Omberg & drottning Omma', 'odeshog-omberg-drottning-omma', 58.323, 14.635, 'Sverige', 'Östergötland', 'Sägenplats', 4, true, false,
 'Bergets dimdrottning gråter i Rödgavels grotta så att dimma lägger sig över Vättern — jättar bor i berget och kastar sten mot kyrkorna.',
 'Omberg, urbergsmassivet mellan Vättern och Tåkern, är en av Östergötlands mest sägenomspunna platser. Drottning Omma, bergets förkristna beskyddarinna, visade sig som uggla; jätten Ringabergsbusen red över Vätterns is och drunknade vid Rödgavel, och Ommas gråt blev berget dimma (''berget ommar''). Rödgaveljättarna gömmer kyrksilver och kastar sten mot kyrkklockorna. [Nedtecknad folklore; berget belagd geografi.]

(Koordinat ungefärlig — ej exakt geokodad.)',
 'published', 'spokvandring-ostergotland-research',
 '{"en": {"name": "Mount Omberg & Queen Omma", "teaser": "The mountain''s mist-queen weeps in the Rödgavel cave so fog settles over Vättern — giants dwell in the rock and hurl stones at the churches.", "description": "Omberg, the bedrock massif between Vättern and Tåkern, is one of Östergötland''s most legend-wreathed places. Queen Omma, the mountain''s pre-Christian guardian, appeared as an owl; the giant Ringabergsbusen rode across Vättern''s ice and drowned at Rödgavel, and Omma''s weeping became the mountain''s fog. The Rödgavel giants hide church silver and hurl stones at the church bells. [Recorded folklore; the mountain is documented geography.]"}}'::jsonb),

('odeshog-heda-kyrka', 'Heda kyrka', 'odeshog-heda-kyrka', 58.286396, 14.7035483, 'Sverige', 'Östergötland', 'Kyrka', 3, true, false,
 'En jätte byggde kyrkan mot bondens blod — räddad först när jättens namn (''Påvel''/''Finn'') ropades. Madonnan har sett ''åttahundra julnätter''.',
 'En av Östergötlands bäst bevarade medeltidskyrkor (1100–1200-tal), knuten till Sverkerätten. Sägnen: en jätte från Rödgavel byggde kyrkan mot bondens/prästens blod, som räddades genom att lista ut jättens namn (Påvel/Finn) — en snedställd pelare blev kvar. Jättar tog Hedas kyrksilver men söp ihjäl varandra på kyrkvinet. Heda-madonnan inspirerade Heidenstams dikt om skulpturen som sett ''åttahundra julnätter''. [Kyrkan belagd; jättesägnerna folklore.]',
 'published', 'spokvandring-ostergotland-research',
 '{"en": {"name": "Heda church", "teaser": "A giant built the church for the farmer''s blood — saved only when the giant''s name (''Påvel''/''Finn'') was cried. The Madonna has seen ''eight hundred Christmas nights''.", "description": "One of Östergötland''s best-preserved medieval churches (12th–13th c.), tied to the Sverker dynasty. The legend: a giant from Rödgavel built the church for the farmer''s/priest''s blood, who was saved by guessing the giant''s name (Påvel/Finn) — a leaning pillar remained. Giants took Heda''s church silver but drank themselves to death on the communion wine. The Heda Madonna inspired Heidenstam''s poem of the statue that has seen ''eight hundred Christmas nights''. [Church documented; the giant legends folklore.]"}}'::jsonb),

('odeshog-rokstenen', 'Rökstenen & Röks kyrka', 'odeshog-rokstenen', 58.2949969, 14.7750461, 'Sverige', 'Östergötland', 'Sägenplats', 3, true, false,
 'Världens längsta runinskrift — själva stenen är 800-talssägen, rest av en far över sin döde son Vämod.',
 'Rökstenen (första hälften av 800-talet, ~760 tecken) restes av Varin över sonen Vämod. Inskriften, delvis i lönnrunor, anspelar på hjältesånger och myter (bl.a. Teoderik till häst); forskare läser runorna men tvistar om tolkningen (en nytolkning 2020 ser en väderkris). Stenen är alltså en primärkälla för nordisk sägentradition. [Belagd; ingen egen spöksägen.]',
 'published', 'spokvandring-ostergotland-research',
 '{"en": {"name": "The Rök stone & Rök church", "teaser": "The world''s longest runic inscription — the stone itself is 9th-century legend, raised by a father over his dead son Vämod.", "description": "The Rök stone (first half of the 9th century, ~760 characters) was raised by Varin over his son Vämod. The inscription, partly in cipher runes, alludes to heroic lays and myths (including Theodoric on horseback); scholars read the runes but dispute the meaning (a 2020 reading sees a climate crisis). The stone is thus a primary source for Norse legend. [Documented; no ghost legend of its own.]"}}'::jsonb),

('odeshog-hastholmen-per-brahe', 'Hästholmen & S/S Per Brahe', 'odeshog-hastholmen-per-brahe', 58.2785395, 14.638577, 'Sverige', 'Östergötland', 'Sägenplats', 3, true, false,
 'Medeltida hamn där ångaren Per Brahe förliste 1918 — 24 döda, däribland konstnären John Bauer med familj.',
 'Hästholmen är en medeltida hamn- och handelsplats vid Vätterns östra strand med hällristningar. Natten 19–20 nov 1918 förliste S/S Per Brahe i storm strax utanför; alla 24 ombord omkom, däribland konstnären John Bauer, hustrun Ester och sonen Bengt-Olov. Fartyget bärgades 1922. [Belagd tragedi; ingen egen spöksägen — bär tragedins tyngd, hitta inte på gengångare.]',
 'published', 'spokvandring-ostergotland-research',
 '{"en": {"name": "Hästholmen & S/S Per Brahe", "teaser": "A medieval harbour where the steamer Per Brahe sank in 1918 — 24 dead, among them the artist John Bauer and his family.", "description": "Hästholmen is a medieval harbour and trading place on Vättern''s eastern shore with rock carvings. On the night of 19–20 Nov 1918 the S/S Per Brahe foundered in a storm just offshore; all 24 aboard died, among them the artist John Bauer, his wife Ester and son Bengt-Olov. The ship was salvaged in 1922. [Documented tragedy; no ghost legend of its own — carry the weight, do not invent a revenant.]"}}'::jsonb),

('odeshog-vattern-hanskratt', 'Vättern — sjörået & hånskrattet', 'odeshog-vattern-hanskratt', 58.29, 14.63, 'Sverige', 'Östergötland', 'Sägenplats', 4, true, false,
 'En stum gubbe spåddes drunkna av siaren på Fjuk; när han hittades död i vaken hörde vittnena ''ett skallande hånskratt från sjön''.',
 'Södra Vättern bär rik sjöväsen-folklore, upptecknad av Elis Åström. Fiskaren Per Jonssa från S. Freberga, spådd av fyrvaktaren-siaren på Fjuk att drunkna, skröt i åratal om att klara sig; en morgon hittades han död i en vak, och vittnena hörde ''ett skallande hånskratt från sjön'' — Vättern hånskrattade åt hans skryt. Sjörået sågs vid Fjuk (fiolspelaren; fiskaren Anders Värme 1912). Ön Jungfrun var tabu: ''här firade häxorna bröllop''. [Nedtecknad lokalfolklore via Ödeshögs hembygdsbok.]

(Koordinat ungefärlig — ej exakt geokodad.)',
 'published', 'spokvandring-ostergotland-research',
 '{"en": {"name": "Lake Vättern — the lake-wight & the scornful laugh", "teaser": "A mute old man was foretold to drown by the seer at Fjuk; when he was found dead in the ice-hole, witnesses heard ''a ringing scornful laugh from the lake''.", "description": "Southern Vättern bears rich water-wight folklore, recorded by Elis Åström. The fisherman Per Jonssa of S. Freberga, foretold by the lighthouse-keeper-seer at Fjuk to drown, boasted for years he would escape it; one morning he was found dead in an ice-hole, and witnesses heard ''a ringing scornful laugh from the lake'' — Vättern mocking his boast. The lake-wight was seen at Fjuk (the fiddler; the fisherman Anders Värme, 1912). The island Jungfrun was taboo: ''here the witches held their wedding''. [Recorded local folklore via the Ödeshög heritage book.]"}}'::jsonb),

('odeshog-stora-aby-kyrka', 'Stora Åby kyrka', 'odeshog-stora-aby-kyrka', 58.2398104, 14.7103162, 'Sverige', 'Östergötland', 'Kyrka', 2, true, false,
 'En jätte på Omberg tålde inte klockklangen och kastade stenar mot kyrkan — de ligger kvar i ringmuren.',
 'Stora Åby var tingsplats 1684–1727. Sägnen: en jätte på Omberg tålde inte kyrkklangen och kastade väldiga stenar mot kyrkan; de nådde inte fram utan ligger kvar i ringmuren ''där de fortfarande ses''. Ett klassiskt jättekast-motiv, samma som vid Heda och Rogslösa. [Kyrkan/tingsplatsen belagd; jättekastet folklore.]',
 'published', 'spokvandring-ostergotland-research',
 '{"en": {"name": "Stora Åby church", "teaser": "A giant on Omberg could not bear the bell''s ringing and hurled stones at the church — they lie still in the churchyard wall.", "description": "Stora Åby was a court site 1684–1727. The legend: a giant on Omberg could not bear the church bell and hurled great stones at the church; they fell short and lie still in the churchyard wall ''where they are seen to this day''. A classic giant''s-throw motif, as at Heda and Rogslösa. [Church/court site documented; the giant''s throw folklore.]"}}'::jsonb)

ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, lat = EXCLUDED.lat, lng = EXCLUDED.lng, region = EXCLUDED.region,
  type = EXCLUDED.type, scary = EXCLUDED.scary, teaser = EXCLUDED.teaser,
  description = EXCLUDED.description, status = EXCLUDED.status, source = EXCLUDED.source,
  translations = EXCLUDED.translations;
COMMIT;
