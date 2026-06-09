-- Spökkartan — 9 fler hemsökta/övergivna platser i Japan, omgång 4 (Japan 25 -> 34)
-- Genererad 2026-06-09. Del av målet ~40 platser/land.
--
-- METOD: engelska/japanska sökord (haunted, abandoned, 廃墟, hitobashira) -> sidor
-- som samlat spökhistorier (Atlas Obscura, haikyo.org, abandonedkansai.com,
-- kowabana.net, japan-guide.com m.fl. samt Wikipedia). Skrivet på SVENSKA,
-- 200-600 ord/plats, aldrig fler ord än källan.
--
-- Kör i Supabase SQL Editor.

BEGIN;

-- 1. TŌJINBŌ — den mördade munkens klippor
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'tojinbo-cliffs','Tōjinbō','tojinbo-cliffs','Japan','Fukui, Sakai','Naturplats',
  36.2390,136.1260,4,true,false,NULL,
  'Den mördade munkens ande rasar vid klipporna — och de självmordsdrabbades själar drar besökare i havet.',
  'Tōjinbō är en rad branta klippor vid Japanska havet i Sakai i Fukui-prefekturen, i genomsnitt 30 meter höga och drygt en kilometer långa. Klippformationen, av pelarformad pyroxenandesit, bildades för 12–13 miljoner år sedan och är en av endast tre av sitt slag i världen.

Enligt en legend kommer namnet från en utsvävande buddhistmunk vid namn Tōjinbō, som utnyttjade sin styrka till brott. Han förälskade sig i den vackra prinsessan Aya. År 1182 bjöd munkarna från Heisen-ji ut honom till klipporna. När han blivit berusad och börjat slumra knuffade en rivaliserande munk — också förälskad i Aya — ned honom i havet. Sägnen säger att Tōjinbōs hämndlystna ande därefter rasade vid samma tid varje år och vållade storm och regn, tills en kringvandrande präst förbarmade sig och höll en minnesgudstjänst, varpå ovädren upphörde.

Men än idag sägs Tōjinbōs ande hemsöka klipporna. På den närliggande ön Oshima berättas om själarna efter dem som tagit sina liv vid Tōjinbō och vars kroppar spolats upp på klipporna. Korsar man den röda bron vid midnatt kan andarna försöka dra ned en i havet, och vandrar man motsols runt ön blir man förbannad. Besökare har hört kroppslösa röster nära telefonkioskerna. Tōjinbō är ett av Japans mest ökända självmordsstup, där en pensionerad polis sedan 2000-talet patrullerat och räddat över 500 liv.

Källa: Engelska Wikipedia "Tōjinbō" + thevintagenews.com + japantoday.com + dannywithlove.com',
  NULL,NULL,NULL,true,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 2. KANMANGAFUCHI ABYSS — de oräkneliga Bake Jizō
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'kanmangafuchi-abyss','Kanmangafuchi Abyss','kanmangafuchi-abyss','Japan','Tochigi, Nikko','Naturplats',
  36.7480,139.5860,3,true,false,NULL,
  'Stenstatyerna sägs försvinna och dyka upp igen — räkna dem och du får aldrig samma antal två gånger.',
  'Kanmangafuchi är en flera hundra meter lång naturlig ravin längs floden Daiya i Nikko, i nordvästra Tochigi-prefekturen. Längs ravinen står omkring 70 stenstatyer av bodhisattvan Jizō på rad — Jizō är i Japan främst beskyddare av barn och resande.

Statyerna omges av en kuslig legend. På grund av sin spöklika natur sägs de ha förmågan att försvinna och dyka upp igen, och de kallas därför "Bake Jizō" — spök-Jizō. Försöker man räkna dem ska man aldrig komma fram till samma antal två gånger. Raden kallas både Narabi Jizō, "Jizō på rad", och Bake Jizō, "Jizō-spökena", just för att det sägs vara omöjligt att räkna dem lika två gånger.

Enligt traditionen skänktes statyerna av biskop Tenkais lärjungar, och från början ska de ha varit hundra till antalet. Vid en översvämning 1902 förstördes eller fördes några bort av vattnet, varför antalet idag är lägre.

Platsen är på en gång vacker och olycksbådande: mossbelupna stenfigurer i röda mössor och förkläden, vänligt leende men ändå anonyma, längs den brusande, mörka floden. När dimman ligger tät över Daiyas vatten och statyerna tycks röra sig i ögonvrån förstår man varför Kanmangafuchi räknas som en av Nikkos mest mystiska platser — där gränsen mellan de levandes och de dödas värld känns ovanligt tunn.

Källa: japan-guide.com + kanpai-japan.com + Atlas Obscura + GaijinPot',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 3. KEJONUMA LEISURE LAND — spökkvinnans damm
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'kejonuma-leisure-land','Kejonuma Leisure Land','kejonuma-leisure-land','Japan','Miyagi, Ōsaki','Övergiven',
  38.5390,140.8760,4,false,false,NULL,
  'Byggd vid "spökkvinnans damm", där en mor som födde ett ormbarn dränkte sig och förbannade platsen.',
  'Kejonuma Leisure Land var en nöjespark i Ōsaki i Miyagi-prefekturen, byggd 1979 i ett försök att föra tillbaka glädjen till bygden efter andra världskrigets umbäranden. På sin höjdpunkt hade parken upp till 200 000 besökare och erbjöd pariserhjul, kopp-och-fat-karusell, miniatyrtåg, gokartbana och golfrange. Efter 21 år stängde den för gott år 2000.

Namnet Kejonuma betyder "spökkvinnans damm" och syftar på en gammal regional sägen om vattnet intill. Enligt berättelsen levde en vacker ung kvinna nära en damm känd för sin myllrande mängd ormar. En dag födde hon ett barn i form av en orm, som slingrade sig ned i dammen, där dess gråt kunde höras varje natt. Driven till vansinne av ormbarnets oupphörliga jämmer dränkte sig den unga modern i dammen — och förbannade platsen med sin död.

Idag står Kejonuma Leisure Land övergiven och svårt förfallen. Bland träden rostar resterna av pariserhjulet, karusellen, gokartbanan och golfrangen, utsatta för väder och vind i decennier. Den tysta, igenvuxna parken vid den förbannade dammen har blivit ett av norra Japans mest beryktade haikyo — övergivna platser — dit urban explorers söker sig för att uppleva stämningen av glädje som vänts i kuslig tystnad, med spökkvinnans sägen vilande över det stilla vattnet.

Källa: Atlas Obscura + haikyo.org + abandonedkansai.com + urbexsession.com',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 4. WESTERN VILLAGE — de övergivna cowboyrobotarna
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'western-village-nikko','Western Village','western-village-nikko','Japan','Tochigi, Nikko','Övergiven',
  36.7330,139.6900,3,false,false,NULL,
  'En övergiven Vilda västern-park full av rostande animatroniska cowboyer — Westworld blivet verklighet.',
  'Western Village var en temapark i Nikko, öppnad 1973 och inspirerad av amerikanska och italienska westernfilmer — samt science fiction-westernfilmen Westworld från samma år, där en skara felfungerande robotar attackerar intet ont anande turister. Efter att parken stängt 2007 har dess overklighet bara förstärkts.

Parken är fylld av förfallande animatroniska cowboyfigurer. Byggnaderna "befolkades" en gång av animatroniska gestalter — ett handelsbiträde, en bartender, en Pony Express-anställd — många byggda för att likna kända filmstjärnor, vilket ger den övergivna parken en starkt kuslig Westworld-känsla. Här finns en kopia av Mount Rushmore, en diversehandel, barberare, kyrka, sheriffstation med fängelse och en saloon full av skurkaktiga figurer. Den falska kyrkan var faktiskt äkta — importerad hela vägen från Kalifornien.

När parken till sist stängde 2007 lämnades det mesta kvar på plats, och allt fick stå och förfalla där det stod. Ovanför den öde staden vakar en fullskalig kopia av Mount Rushmore med sina fyra väldiga presidentansikten, numera urblekta och spruckna.

Idag är platsen ett mecka för haikyo-utövare, urban explorers från Japan och hela världen, som dras till den surrealistiska och olycksbådande miljön. De rostiga, leende cowboyrobotarna, frusna mitt i en gest, stirrar tomt ut över en stad som aldrig fanns på riktigt — en spökstad i dubbel bemärkelse, där Vilda västern möter Westworlds mardröm i den japanska skogens tystnad.

Källa: Atlas Obscura + abandonedkansai.com + laughingsquid.com + Lost Collective',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 5. HACHIJŌ ROYAL HOTEL — Japans största övergivna hotell
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'hachijo-royal-hotel','Hachijō Royal Hotel','hachijo-royal-hotel','Japan','Tokyo, Hachijōjima','Övergiven',
  33.1050,139.7900,3,false,false,NULL,
  'Ett barockpalats på "Japans Hawaii" där ormbunkar nu tränger upp genom mattor, sängar och soffor.',
  'Hachijō Royal Hotel på ön Hachijōjima, omkring 290 kilometer söder om Tokyo i Izu-öarna, var en gång Japans största lyxhotell — och är idag landets största övergivna hotell.

När det öppnade 1963 förkroppsligade det allt efterkrigstidens Japan strävade efter. Ön hade av en ivrig regering döpts om till "Japans Hawaii", ett tropiskt smultronställe för Tokyobor utan kostnaden och krånglet med verkliga utlandsresor. Hotellet, inspirerat av fransk barock, öppnade som ett av landets största palats med gipskopior av grekiska statyer och pampiga fontäner.

Men på 1970-talet hävdes restriktionerna på utlandsresor; det riktiga Hawaii och Okinawa blev tillgängliga, med verkliga sandstränder som Hachijōjimas klippiga kust inte kunde mäta sig med. Hotellet försökte gång på gång återuppfinna sig — som Pricia Resort 1996, Hachijo Oriental Resort 2004 — men stängde slutgiltigt 2006.

Idag har ett träskartat område fyllt av bråte ersatt den en gång marmorklädda receptionen. En pampig trappa leder upp till en labyrint av mörka, kusliga korridorer, och i många havsvända rum frodas miniatyrdjungler i det fuktiga tropiska klimatet — ormbunkar tränger upp genom mattor, sängar och soffgrupper i ett surrealistiskt skådespel. Lokalbor säger att hotellet inte kan rivas på grund av dess många skulder, så det får stå kvar och långsamt slukas av naturen.

Källa: offbeatjapan.com + shanethoms.com + uniqhotels.com + simify.com',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 6. MAYA KANKO HOTEL — Japans mest ikoniska haikyo
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'maya-kanko-hotel','Maya Kanko Hotel','maya-kanko-hotel','Japan','Hyōgo, Kobe','Övergiven',
  34.7270,135.1960,4,false,false,NULL,
  'Ett art déco-spökhotell högt på berget Maya, oåtkomligt med väg, som långsamt växer in i berget.',
  'Maya Kanko Hotel är en övergiven art déco-byggnad inbäddad i sluttningen av berget Maya i Kobe — kanske det mest berömda haikyo, övergivna stället, i hela Japan. Här har spelats in film, musikvideor och kortfilmer, och platsen är ett populärt motiv för modefotografering.

Byggnaden uppfördes ursprungligen 1929 av Maya Cablecar Company och kallades Club Maya, tänkt att dra nytta av turistströmmen från företagets bergbana som öppnat 1925. Bergbanans trafik lades ned 1944 under andra världskriget, och hotellet användes då för luftvärnskanoner som en del av Kobes försvar.

Banan återupptogs 1955, och hotellet byggdes om och återöppnade under nytt namn 1961. Men under tyfonsäsongen 1967 skadades det åter svårt. I sitt sista skede restaurerades byggnaden och öppnade 1974 som ett studentcenter, som stängde 1993. Efter den stora Hanshin-jordbävningen 1995 bedömdes området som osäkert och spärrades av.

Sedan dess står Maya Kanko Hotel övergivet och växer långsamt tillbaka in i berget det byggdes på. Det sitter mitt på linbanans sträckning och kan inte nås med väg — bara med linbana eller en brant, farlig vandringsled med rep fästa i träd och klippor. Dess vittrande art déco-fasad, höljd i grönska och tystnad högt över Kobe, har gjort det till en ikon bland Japans urban explorers.

Källa: theghostinmymachine.com + Atlas Obscura + abandonedkansai.com + offbeatjapan.com',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 7. JOMON-TUNNELN — människopelarna i väggarna
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'jomon-tunnel','Jomon-tunneln','jomon-tunnel','Japan','Hokkaido','Tunnel',
  43.7800,143.0500,4,true,false,NULL,
  'En jordbävning blottade upprättstående skelett inmurade i väggarna — människooffer för att bära tunneln.',
  'Jomon-tunneln byggdes på Sekihoku-linjen i Hokkaido 1914 och är ökänd för rykten om människooffer. Bygget inleddes 1912 och tunneln, 507 meter lång, drogs genom Jomonåsen.

Den mörka legenden bekräftades på ett kusligt sätt 1968, då Tokachi-jordbävningen med magnituden 7,9 skadade tunnelns väggar. När reparationerna inleddes 1970 fann arbetarna ett antal mänskliga skelett — stående upprätt, inmurade i väggarna. Över hundra arbetare från det ursprungliga tunnelbygget påträffades nära ingången och i skogen intill.

Fyndet gav näring åt tron att tunneln byggts med "hitobashira" — människopelare, en gammal sed där levande människor murades in i byggnadsverk för att blidka andarna och ge konstruktionen styrka. Många, däribland tågförare, kom att frukta att tunneln var hemsökt av offrens andar.

En mindre övernaturlig förklaring är att de brutala arbetsförhållandena och den usla kosten ledde till att många arbetare — framför allt brottslingar och skuldsatta som tvingats dit mot sin vilja — drabbades av beri-beri, en dödlig nervsjukdom. Utan tillgång till medicin tros offren ha begravts levande nära bygget.

Tågförare har genom åren berättat om spöklika ljud under tunneln, som tros vara skriken från dem som murades in i väggarna för att bära upp dess grund. Än idag passerar tågen Jomon-tunneln med en kuslig historia vilande i mörkret omkring sig.

Källa: kowabana.net + pinktentacle.com + guides-japan.com + Uncanny Japan',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 8. NIIGATA RUSSIAN VILLAGE — den övergivna katedralen
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'niigata-russian-village','Niigata Russian Village','niigata-russian-village','Japan','Niigata, Agano','Övergiven',
  37.8330,139.2200,3,false,false,NULL,
  'En övergiven rysk temapark med lökkupoler och ett krossat mammutskelett bland ruinerna.',
  'Niigata Russian Village var en rysktematisk by och nöjespark i Niigata-prefekturen, öppnad 1993 för att främja relationerna mellan Japan och Ryssland.

Parken inrymde en stor katedral, ett hotell, flera teatrar, restauranger och till och med en golfbana. Bland det mest besynnerliga som lämnades kvar fanns en (falsk) ullig mammut — både uppstoppad och som skelett.

Historien blev kort och olycksam. Efter att ha öppnat 1993 stängde parken efter sex år, när banken som finansierade den kollapsade. Den återöppnade efter renovering 2002, men var då igång i bara sex månader innan bristen på besökare tvingade den att stänga på nytt. I april 2004 stängdes portarna för gott.

Sedan dess har platsen lockat både vandaler och äventyrare. En brand skadade det övergivna hotellet svårt, och vandaler slog sönder möbler och förstörde mammutskelettet. Den ödsliga katedralen, med sina lökkupoler resta mot den japanska himlen, blev en surrealistisk syn — ett stycke Ryssland som långsamt förföll på Niigatas landsbygd. Inne i de tomma teatrarna och restaurangerna stod dukade bord och scendekor kvar och samlade damm, medan snön vintertid yrde in genom krossade fönster och lade sig över de övergivna salarna.

Bland urban explorers blev Russian Village ett av Japans mest fotograferade övergivna nöjesparker, ett sällsynt exempel på rysk arkitektur i Japan som naturen sakta tog tillbaka, innan anläggningen till större delen revs omkring 2016.

Källa: haikyo.org + tokyotimes.org + Atlas Obscura + abandonedkansai.com',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

-- 9. SUGISAWA-BYN — byn som ströks från kartan
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'sugisawa-village','Sugisawa-byn','sugisawa-village','Japan','Aomori','Övergiven',
  40.8200,140.7000,4,true,false,NULL,
  'En by där en yxmördare slaktade alla — sedan utplånad ur kartorna. "Ingen garanteras komma tillbaka levande."',
  'Sugisawa-byn (杉沢村) är namnet på en by som sägs ha funnits i Aomori-prefekturen, och är en av Japans mest kända skräcklegender.

Enligt sägnen var byn bebodd ända fram till tidig Shōwa-tid (1926–1989). En dag blev en ung man plötsligt vansinnig och började slakta byborna med en yxa. Hela byn utplånades, och bara den unge mannen lämnades kvar — som till sist också tog sitt eget liv. Händelserna var så grymma att lokala myndigheter beslöt att lämna byn öde, förneka att något någonsin hänt, och stryka varje spår av byn från kartorna.

Enligt legenden finns där en gammal torii-port med en skallformad sten under, som sägs vara ingången till Sugisawa. På vägen dit står en skylt: "Ingen som går in härifrån garanteras komma tillbaka levande."

Berättelsen bygger troligen på ett verkligt brott 1938, samma tid som legenden utspelar sig: i den lilla byn Kamo nära Tsuyama i Okayama dödade Mutsuo Toi, 21 år, trettio människor innan han tog sitt liv. Ryktena om Sugisawa spreds länge lokalt, men exploderade på internet i slutet av 1990-talet. Trots otaliga sökningar har ingen någonsin funnit legendens "verkliga" Sugisawa — och troligen kommer ingen någonsin att göra det.

Källa: kowabana.net + japan-makes-me-scared.com + theghostinmymachine.com + scaryforkids.com',
  NULL,NULL,NULL,false,true,'published','web_jp_haunted'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
