-- 80_SEED_VANDRING_VADSTENA.sql
-- Seedar Grantigos egen digitala Spökvandring i Vadstena (stadsvandring.io)
-- och kopplar dess stopp (importerade i 78) — platssidorna länkar då till
-- vandringen i appen. Kräver 77_TOURS.sql + 78_VADSTENA_SPOKVANDRING_PLATSER.sql.
-- Källa: scraper-visit-sidor/data/vadstena-spokvandring/ (rutt.json + manus.md).

INSERT INTO tours (id, name, kind, city, url, teaser, duration_min, sort_order, active) VALUES
('spokvandring-vadstena', 'Spökvandring i Vadstena', 'spok', 'Vadstena', 'https://stadsvandring.io/',
 'Sägenbaserad kvällsvandring genom Vadstenas medeltida kärna — slottet och hertig Magnus, Den svarta nunnan, Sveriges första dårhus och galgbacken. Cirka 2 km med berättarstopp, avslut vid Vättern i mörker.',
 105, 0, true)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, city = EXCLUDED.city, url = EXCLUDED.url,
  teaser = EXCLUDED.teaser, duration_min = EXCLUDED.duration_min, active = EXCLUDED.active;

INSERT INTO tour_places (tour_id, place_id, note) VALUES
('spokvandring-vadstena', 'vadstena-slott',          'Stopp 1 på vandringen'),
('spokvandring-vadstena', 'vadstena-spokvandring-02-radhustorget',   'Stopp 2 på vandringen'),
('spokvandring-vadstena', 'vadstena-spokvandring-03-klosterkyrkan',  'Stopp 3 på vandringen'),
('spokvandring-vadstena', 'vadstena-spokvandring-04-svarta-nunnan',  'Stopp 4 på vandringen'),
('spokvandring-vadstena', 'vadstena-spokvandring-05-stora-darhuset', 'Stopp 5 på vandringen'),
('spokvandring-vadstena', 'vadstena-spokvandring-06-marten-skinnare','Stopp 6 på vandringen'),
('spokvandring-vadstena', 'vadstena-spokvandring-07-hamnen',         'Stopp 7 — final vid Vättern'),
('spokvandring-vadstena', 'vadstena-spokvandring-08-klosterhotell',  'Bonusstopp — passeras mellan stopp 4 och 5'),
('spokvandring-vadstena', 'vadstena-spokvandring-09-galgbacken',     'Bonusstopp')
ON CONFLICT (tour_id, place_id) DO UPDATE SET note = EXCLUDED.note;

-- Klosterhotellet är de facto bokningsbart (officiell bokning) — ger det
-- trevliga tipset "Visste du att du kan boka ett rum här?" på platssidan.
UPDATE places
SET bookable = true, booking_url = 'https://boka.klosterhotel.se/'
WHERE id = 'vadstena-spokvandring-08-klosterhotell'
  AND (booking_url IS NULL OR booking_url = '');

-- Verifiera
SELECT t.name, count(tp.place_id) AS stopp
FROM tours t LEFT JOIN tour_places tp ON tp.tour_id = t.id
WHERE t.id = 'spokvandring-vadstena' GROUP BY t.name;
