-- Spökkartan — Ta bort länkar till externa guideplattformar
-- Kör i Supabase SQL Editor.
--
-- Bokningslänkar på platser ska peka på riktiga boenden (hotell, värdshus,
-- Booking.com m.fl.) — inte på externa guideplattformar som GetYourGuide,
-- TripAdvisor eller Viator. Vandringar tipsas i stället via Spökkartans
-- egna partners (se 75_PARTNER_PLACES.sql).

UPDATE places
SET bookable = false,
    booking_url = ''
WHERE booking_url ILIKE '%getyourguide.%'
   OR booking_url ILIKE '%tripadvisor.%'
   OR booking_url ILIKE '%viator.%';

-- Verifiera: ska returnera 0 rader
SELECT id, name, booking_url FROM places
WHERE booking_url ILIKE '%getyourguide.%'
   OR booking_url ILIKE '%tripadvisor.%'
   OR booking_url ILIKE '%viator.%';
