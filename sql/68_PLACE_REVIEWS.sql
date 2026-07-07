-- 68: Platsrecensioner — användare betygsätter platser de besökt via knappval.
-- Strukturerat (ingen fritext krävs): helhetsupplevelse, spöklighetsnivå (1–5),
-- vad de upplevde (taggar) + valfri kort kommentar. Idempotent.
--
-- Ger också aggregat (antal, snitt-spöklighet, vanligaste upplevelsen) som matar
-- platssidan + crawler-prerendern (AggregateRating → bra för SEO/AEO).

create table if not exists public.place_reviews (
  id          bigserial primary key,
  place_id    text not null,                 -- places.id är en slug (text)
  user_id     uuid references public.profiles(id) on delete cascade,
  experience  text check (experience in ('amazing','good','ok','dull')),
  spook_level int  check (spook_level between 1 and 5),
  tags        text[] default '{}',           -- t.ex. {cold,sounds,shadows}
  note        text,
  created_at  timestamptz default now(),
  updated_at  timestamptz default now(),
  unique (place_id, user_id)                 -- en recension per plats och användare
);

create index if not exists place_reviews_place_idx on public.place_reviews(place_id);
create index if not exists place_reviews_user_idx  on public.place_reviews(user_id);

alter table public.place_reviews enable row level security;

drop policy if exists "Anyone can read place reviews" on public.place_reviews;
create policy "Anyone can read place reviews" on public.place_reviews for select using (true);

drop policy if exists "Users insert own place review" on public.place_reviews;
create policy "Users insert own place review" on public.place_reviews for insert with check (auth.uid() = user_id);

drop policy if exists "Users update own place review" on public.place_reviews;
create policy "Users update own place review" on public.place_reviews for update using (auth.uid() = user_id);

drop policy if exists "Users delete own place review" on public.place_reviews;
create policy "Users delete own place review" on public.place_reviews for delete using (auth.uid() = user_id);

-- Aggregat per plats (security_invoker → base-tabellens RLS gäller, anon får läsa).
create or replace view public.place_review_stats
  with (security_invoker = on) as
select
  place_id,
  count(*)                                        as review_count,
  round(avg(spook_level)::numeric, 1)             as avg_spook,
  mode() within group (order by experience)       as top_experience
from public.place_reviews
group by place_id;

-- Verifiera
select 'place_reviews' as tabell, count(*) from public.place_reviews;
