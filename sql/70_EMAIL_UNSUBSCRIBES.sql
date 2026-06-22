-- Spökkartan — migration: e-post-avregistreringar ("suppression list")
-- Skapar tabellen email_unsubscribes + Row Level Security + en hjälpfunktion.
--
-- SYFTE:
--   En enda lista över adresser som INTE ska få fler mail. Den som bett att
--   slippa mail läggs här, och alla framtida utskick ska kolla mot listan först.
--
-- SÅ HÄR TAR DU BORT NÅGON I FRAMTIDEN (en rad i Supabase SQL Editor):
--   insert into public.email_unsubscribes (email, reason)
--   values ('namn@example.com', 'Bad om att slippa mail')
--   on conflict (email) do nothing;
--
-- ...eller låt personen själv klicka avregistreringslänken i mailet:
--   https://DIN-DOMAN/api/unsubscribe?email=namn@example.com
--
-- SÅ HÄR KOLLAR DU FÖRE ETT UTSKICK om en adress är avregistrerad:
--   select public.is_unsubscribed('namn@example.com');   -- true = skicka INTE
--
-- Kör i Supabase SQL Editor (idempotent — säker att köra om).

create table if not exists public.email_unsubscribes (
  email      text primary key,                 -- alltid gemener (lower-case)
  reason     text,                             -- valfri notering om varför
  source     text not null default 'manual',   -- manual | self | admin | import
  created_at timestamptz not null default now()
);

create index if not exists email_unsubscribes_created_idx
  on public.email_unsubscribes(created_at desc);

alter table public.email_unsubscribes enable row level security;

-- Endast admin (ditt konto) får läsa listan.
drop policy if exists "unsub_select_admin" on public.email_unsubscribes;
create policy "unsub_select_admin"
  on public.email_unsubscribes for select
  to authenticated
  using ((auth.jwt() ->> 'email') = 'fredrik.lundberg@grantigo.com');

-- Endast admin får ta bort en rad (om någon ångrar sig och vill ha mail igen).
drop policy if exists "unsub_delete_admin" on public.email_unsubscribes;
create policy "unsub_delete_admin"
  on public.email_unsubscribes for delete
  to authenticated
  using ((auth.jwt() ->> 'email') = 'fredrik.lundberg@grantigo.com');

-- OBS: ingen INSERT-policy för anon/authenticated. Avregistrering sker via
-- serverless-endpointen /api/unsubscribe (service-role, förbi RLS) eller av
-- admin via SQL. Det hindrar att någon läser/ändrar listan från klienten.

-- Hjälpfunktion: är adressen avregistrerad? Använd FÖRE varje utskick.
-- security definer så att den kan läsa tabellen även när anropas av utskickskod.
create or replace function public.is_unsubscribed(addr text)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1 from public.email_unsubscribes
    where email = lower(trim(addr))
  );
$$;

-- ── Ta bort den som bett att slippa mail (engångs-seed) ──────────────────────
insert into public.email_unsubscribes (email, reason, source)
values ('irmahenriksson49@gmail.com', 'Bad om att inte få fler mail', 'manual')
on conflict (email) do nothing;
