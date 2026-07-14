-- Spökkartan — Koppling partner ↔ platser
-- Kör i Supabase SQL Editor (kräver 17_PARTNERS_SCHEMA.sql)
--
-- Låter en partner (t.ex. spökvandring/stadsvandring) ange vilka platser på
-- Spökkartan som ingår i vandringen. Platssidan länkar då till vandringen,
-- och vandringens profil kan visa sina stopp.

CREATE TABLE IF NOT EXISTS partner_places (
  id BIGSERIAL PRIMARY KEY,
  partner_id UUID REFERENCES partners(id) ON DELETE CASCADE,
  place_id TEXT NOT NULL,              -- länk till places.id
  note TEXT,                           -- t.ex. "Stopp 3 på vandringen"
  created_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE (partner_id, place_id)
);

ALTER TABLE partner_places ENABLE ROW LEVEL SECURITY;

-- Alla får se kopplingar för live-partners (så platssidan kan länka till vandringen).
-- Partnern och admin ser även kopplingar för profiler som väntar på godkännande.
DROP POLICY IF EXISTS "Anyone can view live partner places" ON partner_places;
CREATE POLICY "Anyone can view live partner places" ON partner_places FOR SELECT
  USING (
    partner_id = auth.uid()
    OR EXISTS (SELECT 1 FROM partners WHERE id = partner_places.partner_id AND status = 'live')
    OR EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
  );

DROP POLICY IF EXISTS "Partners manage own places" ON partner_places;
CREATE POLICY "Partners manage own places" ON partner_places FOR ALL
  USING (partner_id = auth.uid())
  WITH CHECK (partner_id = auth.uid());

DROP POLICY IF EXISTS "Admin manages partner places" ON partner_places;
CREATE POLICY "Admin manages partner places" ON partner_places FOR ALL
  USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'))
  WITH CHECK (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));

CREATE INDEX IF NOT EXISTS partner_places_place_idx ON partner_places(place_id);
CREATE INDEX IF NOT EXISTS partner_places_partner_idx ON partner_places(partner_id);

-- Verifiera
SELECT 'partner_places' AS tabell, count(*) FROM partner_places;
