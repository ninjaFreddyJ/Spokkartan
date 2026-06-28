-- 66: Utöka handle_new_user-triggern så att e-postregistreringar fångas korrekt.
-- Tidigare sparades bara id/email/full_name/avatar. Nu följer även namn, bio,
-- sociala länkar och "vill bli spökjägare"-flaggan med från signup-metadata.
-- Idempotent — säker att köra om. Kör i Supabase SQL Editor (eller via apply-db CI).

-- Säkerställ kolumner (no-op om de redan finns)
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS bio  TEXT;
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS yt   TEXT;
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS ig   TEXT;
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS fb   TEXT;
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS is_hunter BOOLEAN DEFAULT false;
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS role TEXT DEFAULT 'user';

CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
DECLARE
  md           JSONB := COALESCE(NEW.raw_user_meta_data, '{}'::jsonb);
  wants_hunter BOOLEAN := COALESCE((md->>'is_hunter')::boolean, false);
BEGIN
  INSERT INTO public.profiles (id, email, full_name, avatar_url, bio, yt, ig, role)
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(md->>'full_name', md->>'name', split_part(NEW.email, '@', 1)),
    md->>'avatar_url',
    NULLIF(md->>'bio', ''),
    NULLIF(md->>'yt', ''),
    NULLIF(md->>'ig', ''),
    -- "pending_hunter" = vill bli spökjägare, väntar på admin-verifiering.
    -- is_hunter lämnas false tills admin godkänner (annars syns overifierade
    -- jägare publikt i fetchHunters).
    CASE WHEN wants_hunter THEN 'pending_hunter' ELSE 'user' END
  )
  ON CONFLICT (id) DO NOTHING;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- Verifiera
SELECT id, email, full_name, role, is_hunter FROM public.profiles
ORDER BY created_at DESC LIMIT 10;
