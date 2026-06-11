-- Spökkartan — 4 hemsökta platser i Indien (भूतिया जगहें / haunted places)
-- Genererad 2026-06-09. Samma generella metod, nu Indien.
--
-- METOD: sökord på engelska/hindi (haunted places, ghosts, भूत, भूतिया जगह)
-- -> sidor som samlat spökhistorier (Rajasthan Tourism, holidify.com,
-- nativeplanet.com, homegrown.co.in m.fl. samt engelska Wikipedia).
-- Skrivet på SVENSKA, 200-600 ord/plats, aldrig fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. BHANGARH FORT (Indien) — Indiens mest hemsökta plats
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'bhangarh-fort','Bhangarh Fort','bhangarh-fort','Indien','Rajasthan, Alwar','Fästning',
  27.0963,76.2872,5,false,false,NULL,
  'Indiens mest hemsökta plats — myndigheten förbjuder inträde efter solnedgången.',
  'Bhangarh Fort i Rajasthan, byggt på 1600-talet av Madho Singh, betraktas allmänt som Indiens mest hemsökta plats. Fästningen ligger omkring 50 kilometer från Sariska-reservatet, mellan Jaipur och Alwar.

Två sägner förklarar dess rykte. Den första handlar om asketen Baba Balau Nath, vars meditationsplats fanns här långt före fästningen. Han tillät bygget på ett strikt villkor: att fästningens skugga aldrig fick falla över hans plats. Allt var väl tills en ärelysten efterträdare byggde på fästningen på höjden, så att dess olycksbringande skugga slukade asketens boning — och därmed var Bhangarh dömt.

Den andra sägnen rör prinsessan Ratnavati, eftertraktad av många friare. En trollkarl, bevandrad i svartkonst, blev förälskad i henne och bytte i hemlighet ut hennes parfym mot en kärleksdryck. Men prinsessan genomskådade listen och kastade drycken på ett stenblock, som rullade mot trollkarlen och krossade honom. Innan han dog förbannade han staden: den skulle snart förstöras och ingen skulle någonsin kunna leva där.

Eftersom platsen anses hemsökt är Bhangarh stängt för besökare före soluppgång och efter solnedgång — den indiska fornminnesmyndigheten ASI har officiellt förbjudit inträde nattetid. ASI har dock aldrig officiellt förklarat platsen hemsökt; förbudet motiveras med att de instabila ruinerna är farliga i mörker och att trakten hyser leoparder och vildsvin. Men för de flesta är Bhangarh helt enkelt Indiens mest skräckinjagande plats.

Källa: Rajasthan Tourism + holidify.com + thomascook.in + urbanjaipur.com',
  NULL,NULL,NULL,true,true,'published','web_in_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. KULDHARA (Indien) — den förbannade spökbyn
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'kuldhara','Kuldhara','kuldhara','Indien','Rajasthan, Jaisalmer','Övergiven',
  26.7700,70.6470,4,false,false,NULL,
  'En hel by försvann över en natt 1825 — och förbannade marken så att ingen mer kan bo där.',
  'Kuldhara är en spökby omkring 17 kilometer väster om Jaisalmer i Rajasthan. För tre sekler sedan var den en blomstrande ort, men idag ligger den öde, höljd i mystik.

Byn grundades 1291 av Paliwal-brahminerna, ett välmående samhälle tack vare deras skicklighet att odla rika skördar i den karga öknen med hjälp av ett uppfinningsrikt system som utnyttjade underjordiska vattenådror.

Enligt sägnen försvann en natt år 1825 alla invånare i Kuldhara och 83 närliggande byar i mörkret. Anledningen var byns onde minister Salim Singh, som fäst blicken vid byhövdingens dotter och förklarat att han skulle gifta sig med henne, med eller mot hennes vilja, och hotat byborna med fruktansvärda följder om de inte lydde. Hellre än att ge efter beslöt bybornas råd att överge sina förfäders hem över en enda natt. Innan de gav sig av förbannade de Kuldhara så att ingen någonsin mer skulle kunna bosätta sig där.

Trogen förbannelsen ligger byn fortfarande öde, och det sägs att ingen lyckats tillbringa ens en natt där. Forskare pekar också på andra möjliga orsaker till den plötsliga flykten — sinande vattentillgång eller en jordbävning. Idag är Kuldhara ett skyddat fornminne under delstatens arkeologiska myndighet, en kuslig stad av tomma sandstenshus där öknens vind viskar mellan ruinerna.

Källa: Rajasthan Tourism + Engelska Wikipedia "Kuldhara" + heritagetourandtravels.com + jaisalmercab.com',
  NULL,NULL,NULL,false,true,'published','web_in_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. SHANIWAR WADA (Indien) — "Farbror, rädda mig"
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'shaniwar-wada','Shaniwar Wada','shaniwar-wada','Indien','Maharashtra, Pune','Ruin',
  18.5195,73.8553,4,false,false,NULL,
  'På fullmånenätter hörs den mördade prinsens rop genom ruinerna: "Kaka mala vachva".',
  'Shaniwar Wada i Pune i Maharashtra byggdes 1732 som säte för Peshwa-härskarna i Marathakonfederationen, skapad av den ikoniske ledaren Baji Rao I. Bakom de mäktiga murarna utspelade sig en av Indiens mest beryktade förräderier.

Den unge Peshwan Narayanrao hade hamnat i konflikt med sin farbror Raghunathrao och satt honom i husarrest. För att bli fri konspirerade farbrodern med ett band legoknektar, Gardis, och sände ett meddelande: "Narayanrao la dhara" ("Grip Narayanrao"). Men farbroderns hustru Anandibai ändrade ett enda ord, så att budskapet blev "Narayanrao la mara" ("Döda Narayanrao"). Den 30 augusti 1773 mutades vakterna, och när Narayanrao försökte fly höggs han brutalt ihjäl, hans kropp styckad, medan han skrek efter sin farbror om hjälp.

Sedan dess sägs Narayanraos ande hemsöka platsen. På fullmånenätter ska man kunna höra en ung pojkes röst ropa "Kaka mala vachva" ("Farbror, rädda mig") genom de tomma salarna och raserade korridorerna. Besökare berättar om oförklarliga steg, en isande närvaro och plötsliga temperaturfall efter mörkrets inbrott.

Den 27 februari 1828 utbröt en väldig eld som rasade i sju dagar och lade palatset i ruiner — bara de tunga granitmurarna, de mäktiga teakportarna och de djupa grundvalarna stod kvar. Idag är Shaniwar Wada en av Indiens mest omtalade spökplatser.

Källa: Engelska Wikipedia "Shaniwar Wada" + homegrown.co.in + thrillingtravel.in + savaari.com',
  NULL,NULL,NULL,false,true,'published','web_in_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. DOW HILL, KURSEONG (Indien) — den huvudlöse pojken
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'dow-hill-kurseong','Dow Hill, Kurseong','dow-hill-kurseong','Indien','Västbengalen, Kurseong','Naturplats',
  26.8780,88.2780,4,true,false,NULL,
  'En huvudlös pojke i skoluniform vandrar längs "Death Road" i de dimhöljda skogarna.',
  'Dow Hill ligger i de dimhöljda bergen vid Kurseong i Västbengalen, bara tre mil från Darjeeling, och räknas till Indiens mest hemsökta platser.

Den mest kända sägnen handlar om en huvudlös pojke. Människor påstår sig ha sett en ung pojke i skoluniform gå i och kring Dow Hill-skolan och den intilliggande skogen — bärande sitt eget huvud i händerna eller under armen. Många berättar om en huvudlös gestalt som vandrar längs vägsträckan mellan Dow Hill Road och skogskontoret, allmänt kallad "Death Road", dödens väg.

Victoria Boys High School och den närliggande internatskolan är brännpunkter för det paranormala. Elever rapporterar ofta om steg i tomma korridorer, känslan av att vara iakttagen och flyktiga skuggor som far genom klassrummen. Lokalbefolkningen säger att man ständigt känner sig bevakad så snart man går djupare in i skogen, och somliga berättar om ett "fasansfullt rött öga" som stirrar rakt in i ens egna innan det försvinner i en blixt.

Berättelserna bygger till stor del på lokala sägner och muntlig tradition, och det finns inga vetenskapliga belägg för spöken vare sig i Kurseong eller någon annanstans. Men i den eviga dimman, bland de täta barrträden och de gamla skolbyggnaderna, behöver man inte tro på spöken för att känna kalla kårar längs ryggraden.

Källa: nativeplanet.com + zeezest.com + tripoto.com + northeasternchronicle.in',
  NULL,NULL,NULL,false,true,'published','web_in_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
