-- 67: Nurturing-system — kontakter, snurr-tillstånd, event-logg, leads, referral/trial.
-- Idempotent (körs av apply-db CI vid varje main-push). Kör i Supabase SQL Editor annars.
--
-- Detta ger:
--   * profiles: referral_code, referred_by, trial_source/started, lang
--   * leads: e-postfångst UTAN konto (lead magnets: PDF-guide, exit-intent …)
--   * nurture_state: en rad per kontakt i snurran (steg, nästa utskick, holdout …)
--   * email_events: logg för mätning + daglig cap (open/click/sent/bounce)
--   * trigger: varje ny profil skrivs automatiskt in i snurran
--   * dubbelriktad 7-dagars PRO-trial vid referral (capad — aldrig en gratis månad)

create extension if not exists pgcrypto;

-- ── profiles: referral + trial + språk ─────────────────────────────
alter table public.profiles add column if not exists referral_code    text;
alter table public.profiles add column if not exists referred_by      uuid references public.profiles(id) on delete set null;
alter table public.profiles add column if not exists trial_source     text;
alter table public.profiles add column if not exists trial_started_at timestamptz;
alter table public.profiles add column if not exists lang             text default 'sv';

update public.profiles set referral_code = left(md5(id::text), 8) where referral_code is null;
create unique index if not exists profiles_referral_code_key on public.profiles(referral_code);

-- ── leads: e-post utan konto (top-of-funnel lead magnets) ──────────
create table if not exists public.leads (
  id                bigserial primary key,
  email             text not null,
  lang              text default 'sv',
  source            text,                    -- 'pdf_guide' | 'exit_intent' | …
  country           text,
  converted_user_id uuid references public.profiles(id) on delete set null,
  created_at        timestamptz default now()
);
create unique index if not exists leads_email_key on public.leads(lower(email));
alter table public.leads enable row level security;
drop policy if exists "public can insert leads" on public.leads;
create policy "public can insert leads" on public.leads for insert with check (true);
-- (ingen SELECT-policy → bara service role kan läsa)

-- ── nurture_state: en rad per kontakt i snurran ────────────────────
create table if not exists public.nurture_state (
  id             bigserial primary key,
  user_id        uuid    references public.profiles(id) on delete cascade,
  lead_id        bigint  references public.leads(id)    on delete cascade,
  email          text not null,
  lang           text default 'sv',
  segment        text default 'user',        -- user | pending_hunter | partner | pro
  step           int  default 0,             -- nästa steg som ska skickas
  reengage_count int  default 0,
  status         text default 'active',      -- active | unsubscribed | bounced | done
  unsubscribed   boolean default false,
  unsub_token    text default left(md5(gen_random_uuid()::text), 20),
  holdout        boolean default false,      -- ~10% kontrollgrupp (mäter inkrementell lyft)
  no_open_streak int  default 0,
  last_open_at   timestamptz,
  last_send_at   timestamptz,
  next_send_at   timestamptz default now(),
  created_at     timestamptz default now(),
  updated_at     timestamptz default now()
);
create unique index if not exists nurture_user_key on public.nurture_state(user_id);
create unique index if not exists nurture_lead_key on public.nurture_state(lead_id);
create index if not exists nurture_due_idx on public.nurture_state(next_send_at)
  where status = 'active' and unsubscribed = false and holdout = false;
create unique index if not exists nurture_unsub_token_key on public.nurture_state(unsub_token);
alter table public.nurture_state enable row level security;
-- (inga policies → endast service role rör tabellen)

-- ── email_events: mätning + daglig cap ─────────────────────────────
create table if not exists public.email_events (
  id         bigserial primary key,
  nurture_id bigint references public.nurture_state(id) on delete set null,
  email      text,
  step       int,
  template   text,
  type       text not null,                  -- sent | open | click | bounce | complaint | error
  meta       jsonb,
  created_at timestamptz default now()
);
create index if not exists email_events_type_time_idx on public.email_events(type, created_at);
alter table public.email_events enable row level security;

-- ── ny användare: profil + referral-koppling + trial ───────────────
-- Auktoritativ version (ersätter den i 66). Fångar namn/bio/hunter-flagga
-- OCH referral (?ref=kod i signup-metadata) + delar ut dubbelriktad trial.
create or replace function public.handle_new_user()
returns trigger as $$
declare
  md           jsonb   := coalesce(new.raw_user_meta_data, '{}'::jsonb);
  wants_hunter boolean := coalesce((md->>'is_hunter')::boolean, false);
  ref_code     text    := nullif(md->>'ref', '');
  ref_id       uuid;
  -- Taket gör att trial-runway aldrig ens närmar sig en gratis månad.
  cap          timestamptz := now() + interval '21 days';
begin
  if ref_code is not null then
    select id into ref_id from public.profiles where referral_code = ref_code limit 1;
  end if;

  insert into public.profiles (id, email, full_name, avatar_url, bio, yt, ig, lang, role, referral_code, referred_by)
  values (
    new.id, new.email,
    coalesce(md->>'full_name', md->>'name', split_part(new.email, '@', 1)),
    md->>'avatar_url',
    nullif(md->>'bio', ''), nullif(md->>'yt', ''), nullif(md->>'ig', ''),
    coalesce(nullif(md->>'lang', ''), 'sv'),
    case when wants_hunter then 'pending_hunter' else 'user' end,
    left(md5(new.id::text), 8),
    ref_id
  )
  on conflict (id) do nothing;

  -- Dubbelriktad 7-dagars PRO-trial när någon kommer via en väns länk.
  if ref_id is not null and ref_id <> new.id then
    -- referee (nya användaren)
    update public.profiles
       set is_pro = true, trial_source = 'referral',
           trial_started_at = coalesce(trial_started_at, now()),
           pro_expires_at   = least(cap, greatest(coalesce(pro_expires_at, now()), now()) + interval '7 days')
     where id = new.id;
    -- referraren (belöning för att ha delat)
    update public.profiles
       set is_pro = true, trial_source = coalesce(trial_source, 'referral'),
           trial_started_at = coalesce(trial_started_at, now()),
           pro_expires_at   = least(cap, greatest(coalesce(pro_expires_at, now()), now()) + interval '7 days')
     where id = ref_id;
  end if;

  return new;
end;
$$ language plpgsql security definer;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- ── skriv in varje ny profil i snurran ─────────────────────────────
create or replace function public.enroll_in_nurture()
returns trigger as $$
declare
  seg text := case
                when new.role = 'pending_hunter' then 'pending_hunter'
                when coalesce(new.is_pro, false)  then 'pro'
                else 'user'
              end;
begin
  insert into public.nurture_state (user_id, email, lang, segment, holdout, next_send_at)
  values (new.id, new.email, coalesce(nullif(new.lang, ''), 'sv'), seg, (random() < 0.10), now())
  on conflict (user_id) do nothing;
  return new;
end;
$$ language plpgsql security definer;

drop trigger if exists on_profile_enroll on public.profiles;
create trigger on_profile_enroll
  after insert on public.profiles
  for each row execute function public.enroll_in_nurture();

-- ── backfill: skriv in redan befintliga användare (t.ex. Google) ───
insert into public.nurture_state (user_id, email, lang, segment, next_send_at, holdout)
select p.id, p.email, coalesce(nullif(p.lang, ''), 'sv'),
       case when p.role = 'pending_hunter' then 'pending_hunter'
            when coalesce(p.is_pro, false)  then 'pro' else 'user' end,
       now(), (random() < 0.10)
from public.profiles p
left join public.nurture_state n on n.user_id = p.id
where n.id is null;

-- Verifiera
select 'nurture_state' as tabell, count(*) from public.nurture_state
union all select 'leads', count(*) from public.leads
union all select 'email_events', count(*) from public.email_events;
