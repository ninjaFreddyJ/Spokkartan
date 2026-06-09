-- Spökkartan — Tyskland omgång 8: Hexentanzplatz Thale (Tyskland 39 -> 40)
-- Genererad 2026-06-09.
-- METOD: tyska sökord (Sage, Hexen, Walpurgisnacht) -> harzlife.de, anderswohin.de,
-- oberharz.de m.fl. Skrivet på SVENSKA, 200-600 ord, aldrig fler ord än källan.
-- Kör i Supabase SQL Editor.

BEGIN;

-- HEXENTANZPLATZ THALE — häxornas Valborgsmässa i Harz
INSERT INTO places (id, name, slug, country, region, type, lat, lng, scary, free, bookable, booking_url, teaser, description, img, img_credit, img_author, featured, is_new, status, source) VALUES (
  'hexentanzplatz-thale','Hexentanzplatz Thale','hexentanzplatz-thale','Tyskland','Sachsen-Anhalt, Thale','Naturplats',
  51.7330,11.0330,3,true,false,NULL,
  'Här samlas Harzens häxor Valborgsmässoafton innan de flyger till Brocken för att fria till djävulen.',
  'Hexentanzplatz — "häxdansplatsen" — ligger söder om Thale, omkring 250 meter ovanför Bodetal, mitt emot den något lägre Roßtrappe-klippan. Platsen var sannolikt en gammal sachsisk-germansk kultplats.

Enligt traditionen samlades de gammalsachsiska germanstammarna här, särskilt natten mellan 30 april och 1 maj — den Walpurgisnatt som Goethe gjorde berömd i Faust — för att hylla de så kallade Hagedisen, skogs- och bergsgudinnor. Sedan frankerriket erövrat det sachsiska området förbjöd den kristna kyrkan kulten, och platsen fick namnet Hexentanzplatz, "häxornas dansplats".

Enligt myten om denna klippa samlas Harzens häxor här Valborgsmässoafton för att fira en kuslig ritual. Härifrån beger de sig tillsammans till Brocken, där de dansar kring den flammande häxbrasan och friar till djävulen. Varje år den 30 april firas Walpurgisnatt på Hexentanzplatz.

På andra sidan Bode reser sig Roßtrappe-klippan, som i graniten har en stor hovliknande fördjupning. Enligt sägnen duellerade djävulen med Gud i Thale, och vid det så kallade Roßtrappe finns spåren efter ett väldigt hopp ännu kvar i berget — somliga tillskriver dem i stället jätten Bodo.

Idag finns här en liten nöjespark, ett bergsteater och en stencirkel av klippblock som restes på 1990-talet, befolkad av en djävul, en häxa och en demon — en passande inramning för en av Tysklands mest sägenomspunna och hedniska platser.

Källa: harzlife.de + anderswohin.de + oberharz.de + harz-travel.de',
  NULL,NULL,NULL,false,true,'published','web_de_spukorte'
) ON CONFLICT (id) DO UPDATE SET description=EXCLUDED.description, teaser=EXCLUDED.teaser;

COMMIT;
