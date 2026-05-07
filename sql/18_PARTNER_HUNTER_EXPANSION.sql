-- Spökkartan — Utökat schema för Partners + Spökjägare
-- Kör efter 17_PARTNERS_SCHEMA.sql är körd
-- Lägger till: partner_packages, partner_questions, hunter_visits + utökade profiles-fält

-- 1. Utöka partners med fler beskrivningsfält + dinner-typ
ALTER TABLE partners DROP CONSTRAINT IF EXISTS partners_type_check;
ALTER TABLE partners ADD CONSTRAINT partners_type_check
  CHECK (type IN ('hunter','medium','tarot','tour','event','hotel','dinner','author','other'));

-- Tar bort "free"-tier — lägsta paid-nivå är nu Bas 29 kr/mån.
-- Befintliga rader med tier='free' migreras till 'basic' (de blir då "väntar betalning").
UPDATE partners SET tier = 'basic' WHERE tier = 'free';
ALTER TABLE partners DROP CONSTRAINT IF EXISTS partners_tier_check;
ALTER TABLE partners ADD CONSTRAINT partners_tier_check
  CHECK (tier IN ('basic','pro','featured'));
ALTER TABLE partners ALTER COLUMN tier SET DEFAULT 'basic';

ALTER TABLE partners ADD COLUMN IF NOT EXISTS what_customer_gets TEXT;
ALTER TABLE partners ADD COLUMN IF NOT EXISTS gallery TEXT[] DEFAULT '{}';
ALTER TABLE partners ADD COLUMN IF NOT EXISTS opening_hours TEXT;
ALTER TABLE partners ADD COLUMN IF NOT EXISTS languages TEXT[] DEFAULT '{}';

-- 2. Partner-paket (priser + vad ingår)
CREATE TABLE IF NOT EXISTS partner_packages (
  id BIGSERIAL PRIMARY KEY,
  partner_id UUID REFERENCES partners(id) ON DELETE CASCADE,
  name TEXT NOT NULL,                  -- "Grundpaket", "Premium", "Helkväll" osv
  description TEXT,
  price INT NOT NULL,                  -- pris i SEK (ören om man vill)
  price_unit TEXT DEFAULT 'fast',      -- 'fast' / 'per_person' / 'per_timme' / 'per_natt'
  duration_min INT,
  max_participants INT,
  includes TEXT[] DEFAULT '{}',        -- punktlista — vad ingår
  highlight BOOLEAN DEFAULT false,     -- "Mest populär"
  booking_link TEXT,
  image TEXT,
  active BOOLEAN DEFAULT true,
  sort_order INT DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE partner_packages ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Anyone can view active packages" ON partner_packages;
CREATE POLICY "Anyone can view active packages" ON partner_packages FOR SELECT USING (active = true);

DROP POLICY IF EXISTS "Partners manage own packages" ON partner_packages;
CREATE POLICY "Partners manage own packages" ON partner_packages FOR ALL USING (partner_id = auth.uid());

CREATE INDEX IF NOT EXISTS partner_packages_partner_idx ON partner_packages(partner_id);

-- 3. Frågor till partners (formulär som landar i adminpanelen)
CREATE TABLE IF NOT EXISTS partner_questions (
  id BIGSERIAL PRIMARY KEY,
  partner_id UUID REFERENCES partners(id) ON DELETE CASCADE,
  asker_name TEXT NOT NULL,
  asker_email TEXT NOT NULL,
  asker_phone TEXT,
  subject TEXT,
  message TEXT NOT NULL,
  package_id BIGINT REFERENCES partner_packages(id) ON DELETE SET NULL,
  status TEXT DEFAULT 'new' CHECK (status IN ('new','seen','replied','spam','closed')),
  admin_notes TEXT,
  user_id UUID REFERENCES profiles(id) ON DELETE SET NULL,  -- om inloggad
  created_at TIMESTAMPTZ DEFAULT now(),
  replied_at TIMESTAMPTZ
);

ALTER TABLE partner_questions ENABLE ROW LEVEL SECURITY;

-- Vem som helst får skicka in (även anonym)
DROP POLICY IF EXISTS "Anyone can submit question" ON partner_questions;
CREATE POLICY "Anyone can submit question" ON partner_questions FOR INSERT WITH CHECK (true);

-- Bara admin (och den partner det gäller) får läsa
DROP POLICY IF EXISTS "Admin & partner can read questions" ON partner_questions;
CREATE POLICY "Admin & partner can read questions" ON partner_questions FOR SELECT
  USING (
    partner_id = auth.uid()
    OR EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
  );

DROP POLICY IF EXISTS "Admin & partner can update questions" ON partner_questions;
CREATE POLICY "Admin & partner can update questions" ON partner_questions FOR UPDATE
  USING (
    partner_id = auth.uid()
    OR EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
  );

CREATE INDEX IF NOT EXISTS partner_questions_partner_idx ON partner_questions(partner_id);
CREATE INDEX IF NOT EXISTS partner_questions_status_idx ON partner_questions(status);

-- 4. Spökjägar-profiler — utöka profiles-tabellen
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS hunter_tagline TEXT;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS hunter_speciality TEXT;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS hunter_active_since INT;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS hunter_gallery TEXT[] DEFAULT '{}';
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS hunter_best_place TEXT;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS hunter_best_place_reason TEXT;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS hunter_upcoming TEXT;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS hunter_youtube TEXT;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS hunter_podcast TEXT;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS hunter_tiktok TEXT;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS hunter_website TEXT;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS hunter_tier TEXT DEFAULT 'free'
  CHECK (hunter_tier IN ('free','premium','spotlight','article'));
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS hunter_tier_expires_at TIMESTAMPTZ;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS hunter_featured_until TIMESTAMPTZ;

-- 5. Besökta platser för spökjägare
CREATE TABLE IF NOT EXISTS hunter_visits (
  id BIGSERIAL PRIMARY KEY,
  hunter_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  place_id TEXT,                      -- länk till places.id om finns i databasen
  place_name TEXT NOT NULL,
  place_country TEXT,
  visit_date DATE,
  spook_factor INT CHECK (spook_factor BETWEEN 1 AND 5),
  notes TEXT,                          -- kort kommentar
  is_best BOOLEAN DEFAULT false,       -- markerad som "bästa platsen"
  best_reason TEXT,                    -- varför detta är bästa platsen
  photo TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE hunter_visits ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Anyone can view hunter visits" ON hunter_visits;
CREATE POLICY "Anyone can view hunter visits" ON hunter_visits FOR SELECT USING (true);

DROP POLICY IF EXISTS "Hunters manage own visits" ON hunter_visits;
CREATE POLICY "Hunters manage own visits" ON hunter_visits FOR ALL USING (hunter_id = auth.uid());

CREATE INDEX IF NOT EXISTS hunter_visits_hunter_idx ON hunter_visits(hunter_id);
CREATE INDEX IF NOT EXISTS hunter_visits_best_idx ON hunter_visits(hunter_id, is_best);

-- 6. Spökjägar-betalningar / artikel-beställningar
CREATE TABLE IF NOT EXISTS hunter_orders (
  id BIGSERIAL PRIMARY KEY,
  hunter_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  product TEXT NOT NULL CHECK (product IN ('premium_79','spotlight_129','article_1299')),
  amount INT NOT NULL,                 -- SEK
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending','paid','active','expired','cancelled','refunded')),
  stripe_session_id TEXT,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  paid_at TIMESTAMPTZ,
  expires_at TIMESTAMPTZ
);

ALTER TABLE hunter_orders ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Hunters see own orders" ON hunter_orders;
CREATE POLICY "Hunters see own orders" ON hunter_orders FOR SELECT
  USING (
    hunter_id = auth.uid()
    OR EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
  );

DROP POLICY IF EXISTS "Hunters create own orders" ON hunter_orders;
CREATE POLICY "Hunters create own orders" ON hunter_orders FOR INSERT WITH CHECK (hunter_id = auth.uid());

CREATE INDEX IF NOT EXISTS hunter_orders_hunter_idx ON hunter_orders(hunter_id);
CREATE INDEX IF NOT EXISTS hunter_orders_status_idx ON hunter_orders(status);

-- Verifiera
SELECT 'partner_packages' AS tabell, count(*) FROM partner_packages
UNION ALL SELECT 'partner_questions', count(*) FROM partner_questions
UNION ALL SELECT 'hunter_visits', count(*) FROM hunter_visits
UNION ALL SELECT 'hunter_orders', count(*) FROM hunter_orders;
