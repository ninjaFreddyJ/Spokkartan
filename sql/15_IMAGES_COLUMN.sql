-- Lägg till images-kolumn i places (array av bild-objekt)
ALTER TABLE places ADD COLUMN IF NOT EXISTS images JSONB DEFAULT '[]'::jsonb;

-- Index för att snabbt kolla vilka som har bilder
CREATE INDEX IF NOT EXISTS places_has_images_idx ON places ((jsonb_array_length(images))) WHERE jsonb_array_length(images) > 0;

-- Verifiera
SELECT count(*) AS total, count(*) FILTER (WHERE jsonb_array_length(images) > 0) AS with_images FROM places;
