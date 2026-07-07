-- 70: Stripe-koppling — spara kund/prenumeration så webhooken kan bevilja/
-- nedgradera tier automatiskt. Idempotent.

alter table public.profiles add column if not exists stripe_customer_id     text;
alter table public.profiles add column if not exists stripe_subscription_id text;

create index if not exists profiles_stripe_customer_idx on public.profiles(stripe_customer_id);

-- (tier-kolumnen + sync-trigger finns i 69. Webhooken uppdaterar 'tier' →
--  triggern sätter is_pro, så all befintlig gating fungerar.)
