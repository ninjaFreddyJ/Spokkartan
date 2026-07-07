-- 69: Fyra medlemsnivåer — free / explorer / pro / ultimate.
-- Idempotent. Kör av apply-db CI.
--
-- SÄKERHET (viktigt): migreringen får INTE påverka befintliga betalande PRO
-- eller de på testperiod. Regeln:
--   * har is_pro=true idag (betalande PRO ELLER aktiv trial) → tier='pro'  (oförändrad åtkomst)
--   * alla andra                                             → tier='free'
--   * spökjägare (role='hunter'/'pending_hunter') behåller sin ROLL oavsett tier —
--     betalar de (is_pro=true) fortsätter de som 'pro', annars 'free'.
-- Ingen befintlig användare tappar åtkomst (is_pro styr fortfarande upplåsning).

alter table public.profiles
  add column if not exists tier text default 'free'
  check (tier in ('free','explorer','pro','ultimate'));

-- Backfill: bevara alla som har åtkomst idag.
update public.profiles set tier = 'pro'
  where coalesce(is_pro, false) = true and (tier is null or tier = 'free');
update public.profiles set tier = 'free' where tier is null;

-- Håll is_pro synkad med tier så resten av appen (som gate:ar på is_pro)
-- fortsätter fungera oförändrat: is_pro = true för alla betalnivåer.
create or replace function public.sync_is_pro_from_tier()
returns trigger as $$
begin
  new.is_pro := (new.tier is not null and new.tier <> 'free');
  return new;
end;
$$ language plpgsql;

drop trigger if exists profiles_sync_is_pro on public.profiles;
create trigger profiles_sync_is_pro
  before update of tier on public.profiles
  for each row execute function public.sync_is_pro_from_tier();

-- Verifiera fördelningen
select tier, count(*) from public.profiles group by tier order by tier;
