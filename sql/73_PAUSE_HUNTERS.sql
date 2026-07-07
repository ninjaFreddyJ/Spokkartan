-- 73: Pausa spökjägar-funktionen — konvertera befintliga spökjägare till
-- vanliga användarkonton. All data behålls; reversibelt via was_hunter.
-- Idempotent + stabilt vid CI-omkörningar.

alter table public.profiles add column if not exists was_hunter boolean default false;

-- 1. Markera nuvarande spökjägare EN gång (så vi vet vilka de var → utskick + återställning).
update public.profiles set was_hunter = true
 where was_hunter = false
   and (role in ('hunter','pending_hunter','ghosthunter') or is_hunter = true);

-- 2. Konvertera dem till vanliga användare (behåll bio, bilder, besökta platser).
update public.profiles set role = 'user', is_hunter = false
 where was_hunter = true
   and (role in ('hunter','pending_hunter','ghosthunter') or is_hunter = true);

-- ÅTERSTÄLL (när hunter-funktionen är redo igen):
--   update public.profiles set role='hunter', is_hunter=true where was_hunter=true;

select count(*) as former_hunters from public.profiles where was_hunter = true;
