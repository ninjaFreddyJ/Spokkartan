-- Spökkartan — migration: användarförslag på nya platser ("Föreslå plats")
-- Skapar tabellen place_suggestions + Row Level Security.
--
-- FLÖDE:
--   1. Vem som helst (utloggad eller inloggad) kan SKICKA IN ett förslag (INSERT).
--   2. Endast admin (din inloggning) kan LÄSA/ÄNDRA förslag (inkorgen).
--   3. När ett förslag godkänns kompletterar vi koordinater/info/bild och lägger
--      in platsen i places-tabellen (som vanligt via SQL eller admin).
--
-- Kör i Supabase SQL Editor EN gång.

create table if not exists public.place_suggestions (
  id            uuid primary key default gen_random_uuid(),
  name          text not null,
  country       text,
  region        text,
  type          text,
  lat           double precision,
  lng           double precision,
  description   text,
  why           text,                       -- "varför är platsen hemsökt/intressant?"
  submitter_name  text,
  submitter_email text,
  user_id       uuid references auth.users(id) on delete set null,
  status        text not null default 'new', -- new | reviewing | approved | rejected | published
  admin_notes   text,
  created_at    timestamptz not null default now(),
  updated_at    timestamptz not null default now()
);

create index if not exists place_suggestions_status_idx on public.place_suggestions(status);
create index if not exists place_suggestions_created_idx on public.place_suggestions(created_at desc);

alter table public.place_suggestions enable row level security;

-- Vem som helst får skicka in ett förslag.
drop policy if exists "suggestions_insert_anyone" on public.place_suggestions;
create policy "suggestions_insert_anyone"
  on public.place_suggestions for insert
  to anon, authenticated
  with check (true);

-- Endast admin (ditt konto) får läsa inkorgen.
drop policy if exists "suggestions_select_admin" on public.place_suggestions;
create policy "suggestions_select_admin"
  on public.place_suggestions for select
  to authenticated
  using ((auth.jwt() ->> 'email') = 'fredrik.lundberg@grantigo.com');

-- Endast admin får ändra status / lägga noteringar.
drop policy if exists "suggestions_update_admin" on public.place_suggestions;
create policy "suggestions_update_admin"
  on public.place_suggestions for update
  to authenticated
  using ((auth.jwt() ->> 'email') = 'fredrik.lundberg@grantigo.com')
  with check ((auth.jwt() ->> 'email') = 'fredrik.lundberg@grantigo.com');

-- Endast admin får radera.
drop policy if exists "suggestions_delete_admin" on public.place_suggestions;
create policy "suggestions_delete_admin"
  on public.place_suggestions for delete
  to authenticated
  using ((auth.jwt() ->> 'email') = 'fredrik.lundberg@grantigo.com');

-- Håll updated_at aktuell.
create or replace function public.touch_place_suggestions()
returns trigger language plpgsql as $$
begin new.updated_at = now(); return new; end; $$;

drop trigger if exists trg_touch_place_suggestions on public.place_suggestions;
create trigger trg_touch_place_suggestions
  before update on public.place_suggestions
  for each row execute function public.touch_place_suggestions();
