-- 74: Inlösbara koder. Använms för "gamla gänget"-erbjudandet: en månad gratis
-- vid återregistrering, låst till de f.d. betalande kundernas e-post.
-- Idempotent.

create table if not exists public.redeem_codes (
  code       text primary key,
  grant_days int  not null,
  restricted boolean default false,   -- true = bara e-post i redeem_code_emails
  active     boolean default true,
  created_at timestamptz default now()
);

create table if not exists public.redeem_code_emails (
  code  text not null references public.redeem_codes(code) on delete cascade,
  email text not null
);
create unique index if not exists redeem_code_email_uq on public.redeem_code_emails(code, lower(email));

create table if not exists public.redeem_redemptions (
  id           bigserial primary key,
  code         text not null,
  user_id      uuid not null references public.profiles(id) on delete cascade,
  granted_days int,
  redeemed_at  timestamptz default now(),
  unique (code, user_id)
);

alter table public.redeem_codes        enable row level security;
alter table public.redeem_code_emails  enable row level security;
alter table public.redeem_redemptions  enable row level security;
-- (inga policies → bara service role + SECURITY DEFINER-funktionen rör tabellerna)

-- Inlösning: körs som RPC från appen. SECURITY DEFINER → förbi RLS, men bara
-- för den inloggade användaren (auth.uid()) och bara om koden gäller.
create or replace function public.redeem_code(p_code text)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  uid    uuid := auth.uid();
  uemail text;
  c      record;
begin
  if uid is null then
    return jsonb_build_object('ok', false, 'error', 'Logga in först');
  end if;
  select lower(email) into uemail from public.profiles where id = uid;

  select * into c from public.redeem_codes where lower(code) = lower(p_code) and active;
  if not found then
    return jsonb_build_object('ok', false, 'error', 'Ogiltig eller inaktiv kod');
  end if;

  if c.restricted and not exists (
       select 1 from public.redeem_code_emails e
        where e.code = c.code and lower(e.email) = uemail
     ) then
    return jsonb_build_object('ok', false, 'error', 'Koden gäller inte det här kontot');
  end if;

  if exists (select 1 from public.redeem_redemptions r where r.code = c.code and r.user_id = uid) then
    return jsonb_build_object('ok', false, 'error', 'Koden är redan inlöst');
  end if;

  update public.profiles
     set tier          = 'pro',
         pro_expires_at = greatest(coalesce(pro_expires_at, now()), now()) + (c.grant_days || ' days')::interval,
         trial_source   = coalesce(trial_source, 'code'),
         updated_at     = now()
   where id = uid;

  insert into public.redeem_redemptions (code, user_id, granted_days) values (c.code, uid, c.grant_days);
  return jsonb_build_object('ok', true, 'days', c.grant_days);
end;
$$;

grant execute on function public.redeem_code(text) to anon, authenticated;

-- ── SpokkartanOldCrew: 30 dagar gratis, låst till de f.d. betalande kunderna ──
insert into public.redeem_codes (code, grant_days, restricted, active)
values ('SpokkartanOldCrew', 30, true, true)
on conflict (code) do update set grant_days = excluded.grant_days, restricted = excluded.restricted, active = excluded.active;

insert into public.redeem_code_emails (code, email) values
  ('SpokkartanOldCrew','sandra.b88@outlook.com'),
  ('SpokkartanOldCrew','vide.bromss@icloud.com'),
  ('SpokkartanOldCrew','lucaskraftig@gmail.com'),
  ('SpokkartanOldCrew','nicklassjoberg@yahoo.se'),
  ('SpokkartanOldCrew','sarah98jansson@hotmail.com'),
  ('SpokkartanOldCrew','dannibergman@hotmail.com'),
  ('SpokkartanOldCrew','krusmyntha@gmail.com'),
  ('SpokkartanOldCrew','edvin.s.t@hotmail.com'),
  ('SpokkartanOldCrew','scottzeb2014@gmail.com'),
  ('SpokkartanOldCrew','anna@eez.se'),
  ('SpokkartanOldCrew','kacka6711@gmail.com')
on conflict (code, lower(email)) do nothing;
