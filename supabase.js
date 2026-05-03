// supabase.js — Spökkartan datakälla
import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = import.meta.env.VITE_SUPABASE_URL;
const SUPABASE_ANON_KEY = import.meta.env.VITE_SUPABASE_ANON_KEY;

if (!SUPABASE_URL || !SUPABASE_ANON_KEY) {
  console.warn('[Spokkartan] Saknar VITE_SUPABASE_URL eller VITE_SUPABASE_ANON_KEY');
}

export const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

function normalizePlace(row) {
  return {
    id: row.id,
    name: row.name,
    country: row.country,
    region: row.region || '',
    type: row.type || '',
    lat: row.lat ? Number(row.lat) : null,
    lng: row.lng ? Number(row.lng) : null,
    scary: row.scary ? Number(row.scary) : 3,
    free: row.free === true,
    featured: row.featured === true,
    is_new: row.is_new === true,
    bookable: row.bookable === true,
    booking_url: row.booking_url || '',
    img: row.img || '',
    img_credit: row.img_credit || '',
    img_author: row.img_author || '',
    teaser: row.teaser || '',
    description: row.description || '',
    status: row.status || 'published',
  };
}

export async function fetchPlaces({ includeDrafts = false } = {}) {
  let query = supabase.from('places').select('*');
  if (!includeDrafts) query = query.eq('status', 'published');
  const { data, error } = await query;
  if (error) {
    console.error('[Spokkartan] fetchPlaces fel:', error.message);
    return [];
  }
  return (data || []).map(normalizePlace);
}

export function subscribeToPlaces(callback) {
  const channel = supabase
    .channel('places-changes')
    .on('postgres_changes', { event: '*', schema: 'public', table: 'places' }, (p) => callback(p))
    .subscribe();
  return () => supabase.removeChannel(channel);
}

export default supabase;
