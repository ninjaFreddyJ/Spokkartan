-- Spökkartan — migration: web-push-prenumerationer (notiser till alla)
-- Lagrar varje webbläsares push-prenumeration. Utskick sker server-side i
-- api/send-push.js med service role-nyckeln (förbi RLS).
--
-- Kör i Supabase SQL Editor EN gång.

create table if not exists public.push_subscriptions (
  id          uuid primary key default gen_random_uuid(),
  endpoint    text not null unique,
  p256dh      text not null,
  auth        text not null,
  user_id     uuid references auth.users(id) on delete set null,
  countries   text[] default '{}',          -- tomt = alla länder
  frequency   text default 'instant',
  user_agent  text,
  created_at  timestamptz not null default now()
);

create index if not exists push_subscriptions_endpoint_idx on public.push_subscriptions(endpoint);

alter table public.push_subscriptions enable row level security;

-- Vem som helst får registrera/uppdatera sin egen prenumeration (upsert på endpoint).
drop policy if exists "push_insert_anyone" on public.push_subscriptions;
create policy "push_insert_anyone"
  on public.push_subscriptions for insert
  to anon, authenticated
  with check (true);

drop policy if exists "push_update_anyone" on public.push_subscriptions;
create policy "push_update_anyone"
  on public.push_subscriptions for update
  to anon, authenticated
  using (true) with check (true);

-- Får ta bort sin prenumeration (t.ex. vid avstängning).
drop policy if exists "push_delete_anyone" on public.push_subscriptions;
create policy "push_delete_anyone"
  on public.push_subscriptions for delete
  to anon, authenticated
  using (true);

-- OBS: ingen SELECT-policy -> ingen anon/authenticated kan läsa prenumerationer.
-- Utskicksfunktionen läser med service role-nyckeln som kringgår RLS.
