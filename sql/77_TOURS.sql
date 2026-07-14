-- Spökkartan — Grantigos egna digitala vandringar (stadsvandring.io)
-- Kör i Supabase SQL Editor (körs annars automatiskt av apply-db-workflowen).
--
-- Platser som ingår i en av Grantigos digitala spök- eller stadsvandringar
-- länkar till vandringen i stadsvandring.io-appen. Hanteras i adminpanelen
-- (fliken Vandringar). Ersätter partnertorget som källa för vandringslänkar —
-- den enda vandringspartnern är Grantigo själv.

CREATE TABLE IF NOT EXISTS tours (
  id TEXT PRIMARY KEY,                 -- slug, t.ex. 'spokvandring-skanninge'
  name TEXT NOT NULL,
  kind TEXT DEFAULT 'spok' CHECK (kind IN ('spok','stad')),  -- spökvandring / stadsvandring
  city TEXT,
  url TEXT NOT NULL,                   -- länk till vandringen i stadsvandring.io
  teaser TEXT,
  price_from INT,
  duration_min INT,
  img TEXT,
  active BOOLEAN DEFAULT true,
  sort_order INT DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE IF NOT EXISTS tour_places (
  id BIGSERIAL PRIMARY KEY,
  tour_id TEXT REFERENCES tours(id) ON DELETE CASCADE,
  place_id TEXT NOT NULL,              -- länk till places.id
  note TEXT,                           -- t.ex. "Stopp 3 på vandringen"
  created_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE (tour_id, place_id)
);

ALTER TABLE tours ENABLE ROW LEVEL SECURITY;
ALTER TABLE tour_places ENABLE ROW LEVEL SECURITY;

-- Alla får läsa aktiva vandringar; admin ser även inaktiva.
DROP POLICY IF EXISTS "Anyone can view active tours" ON tours;
CREATE POLICY "Anyone can view active tours" ON tours FOR SELECT
  USING (active = true OR (auth.jwt() ->> 'email') = 'fredrik.lundberg@grantigo.com');

DROP POLICY IF EXISTS "Admin manages tours" ON tours;
CREATE POLICY "Admin manages tours" ON tours FOR ALL
  USING ((auth.jwt() ->> 'email') = 'fredrik.lundberg@grantigo.com')
  WITH CHECK ((auth.jwt() ->> 'email') = 'fredrik.lundberg@grantigo.com');

DROP POLICY IF EXISTS "Anyone can view active tour places" ON tour_places;
CREATE POLICY "Anyone can view active tour places" ON tour_places FOR SELECT
  USING (
    EXISTS (SELECT 1 FROM tours WHERE id = tour_places.tour_id AND active = true)
    OR (auth.jwt() ->> 'email') = 'fredrik.lundberg@grantigo.com'
  );

DROP POLICY IF EXISTS "Admin manages tour places" ON tour_places;
CREATE POLICY "Admin manages tour places" ON tour_places FOR ALL
  USING ((auth.jwt() ->> 'email') = 'fredrik.lundberg@grantigo.com')
  WITH CHECK ((auth.jwt() ->> 'email') = 'fredrik.lundberg@grantigo.com');

CREATE INDEX IF NOT EXISTS tour_places_place_idx ON tour_places(place_id);
CREATE INDEX IF NOT EXISTS tour_places_tour_idx ON tour_places(tour_id);

-- Exempel (avkommentera och anpassa, eller lägg till via adminpanelens
-- Vandringar-flik):
-- INSERT INTO tours (id, name, kind, city, url, teaser, duration_min) VALUES
--   ('spokvandring-skanninge', 'Spökvandring Skänninge', 'spok', 'Skänninge',
--    'https://stadsvandring.io/', 'Följ med på en kuslig vandring genom Skänninges mörka historia.', 60)
-- ON CONFLICT (id) DO NOTHING;

-- Verifiera
SELECT 'tours' AS tabell, count(*) FROM tours
UNION ALL SELECT 'tour_places', count(*) FROM tour_places;
