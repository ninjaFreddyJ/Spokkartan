-- Spökkartan Partners-modul: schema + RLS + tier-system
-- Kör en gång i Supabase SQL Editor (denna version har ingen extern funktion-dependens)

-- 0. Skapa profiles om saknas
CREATE TABLE IF NOT EXISTS profiles (
  id UUID PRIMARY KEY,
  email TEXT,
  full_name TEXT,
  avatar_url TEXT,
  is_pro BOOLEAN DEFAULT false,
  pro_expires_at TIMESTAMPTZ,
  role TEXT DEFAULT 'user',
  bio TEXT,
  is_hunter BOOLEAN DEFAULT false,
  yt TEXT,
  ig TEXT,
  fb TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 1. Partners (utan trigger — updated_at sätts via SET klausul i UPDATE)
CREATE TABLE IF NOT EXISTS partners (
  id UUID PRIMARY KEY REFERENCES profiles(id) ON DELETE CASCADE,
  type TEXT NOT NULL CHECK (type IN ('hunter','medium','tarot','tour','event','hotel','author','other')),
  name TEXT NOT NULL,
  tagline TEXT,
  bio TEXT,
  avatar TEXT,
  hero_image TEXT,
  verified BOOLEAN DEFAULT false,
  tier TEXT DEFAULT 'free' CHECK (tier IN ('free','basic','pro','featured')),
  tier_expires_at TIMESTAMPTZ,
  specialities TEXT[] DEFAULT '{}',
  regions_covered TEXT[] DEFAULT '{}',
  contact_email TEXT,
  contact_phone TEXT,
  website TEXT,
  instagram TEXT,
  facebook TEXT,
  youtube TEXT,
  tiktok TEXT,
  booking_url TEXT,
  price_from INT,
  rating NUMERIC(3,2),
  review_count INT DEFAULT 0,
  view_count INT DEFAULT 0,
  click_count INT DEFAULT 0,
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending','live','paused','rejected')),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX IF NOT EXISTS partners_type_idx ON partners(type);
CREATE INDEX IF NOT EXISTS partners_tier_idx ON partners(tier);
CREATE INDEX IF NOT EXISTS partners_status_idx ON partners(status);
CREATE INDEX IF NOT EXISTS partners_regions_idx ON partners USING gin(regions_covered);

ALTER TABLE partners ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Anyone can view live partners" ON partners;
CREATE POLICY "Anyone can view live partners" ON partners FOR SELECT
  USING (status = 'live' OR auth.uid() = id);

DROP POLICY IF EXISTS "Partners can update own profile" ON partners;
CREATE POLICY "Partners can update own profile" ON partners FOR UPDATE
  USING (auth.uid() = id);

DROP POLICY IF EXISTS "Authenticated can create own partner" ON partners;
CREATE POLICY "Authenticated can create own partner" ON partners FOR INSERT
  WITH CHECK (auth.uid() = id);

-- 2. Services
CREATE TABLE IF NOT EXISTS partner_services (
  id BIGSERIAL PRIMARY KEY,
  partner_id UUID REFERENCES partners(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  description TEXT,
  price_from INT,
  duration_min INT,
  max_participants INT,
  booking_link TEXT,
  image TEXT,
  active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE partner_services ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Anyone can view active services" ON partner_services;
CREATE POLICY "Anyone can view active services" ON partner_services FOR SELECT USING (active = true);
DROP POLICY IF EXISTS "Partners manage own services" ON partner_services;
CREATE POLICY "Partners manage own services" ON partner_services FOR ALL USING (partner_id = auth.uid());

CREATE INDEX IF NOT EXISTS services_partner_idx ON partner_services(partner_id);

-- 3. Reviews
CREATE TABLE IF NOT EXISTS partner_reviews (
  id BIGSERIAL PRIMARY KEY,
  partner_id UUID REFERENCES partners(id) ON DELETE CASCADE,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
  comment TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE (partner_id, user_id)
);

ALTER TABLE partner_reviews ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Anyone can view reviews" ON partner_reviews;
CREATE POLICY "Anyone can view reviews" ON partner_reviews FOR SELECT USING (true);
DROP POLICY IF EXISTS "Authenticated can create review" ON partner_reviews;
CREATE POLICY "Authenticated can create review" ON partner_reviews FOR INSERT WITH CHECK (user_id = auth.uid());
DROP POLICY IF EXISTS "Users edit own reviews" ON partner_reviews;
CREATE POLICY "Users edit own reviews" ON partner_reviews FOR UPDATE USING (user_id = auth.uid());

CREATE INDEX IF NOT EXISTS reviews_partner_idx ON partner_reviews(partner_id);

-- Verifiera
SELECT 'partners' AS tabell, count(*) FROM partners
UNION ALL SELECT 'partner_services', count(*) FROM partner_services
UNION ALL SELECT 'partner_reviews', count(*) FROM partner_reviews;
