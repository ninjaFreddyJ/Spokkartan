// supabase.js — Spökkartan datakälla + auth
import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = import.meta.env.VITE_SUPABASE_URL;
const SUPABASE_ANON_KEY = import.meta.env.VITE_SUPABASE_ANON_KEY;

if (!SUPABASE_URL || !SUPABASE_ANON_KEY) {
  console.warn('[Spokkartan] Saknar VITE_SUPABASE_URL eller VITE_SUPABASE_ANON_KEY');
}

export const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY, {
  auth: {
    persistSession: true,
    autoRefreshToken: true,
    detectSessionInUrl: true,
  }
});

// ── PLACES ─────────────────────────────────────────────────

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
    images: Array.isArray(row.images) ? row.images : [],
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

// ── AUTH ────────────────────────────────────────────────────

export async function signInWithGoogle() {
  const { data, error } = await supabase.auth.signInWithOAuth({
    provider: 'google',
    options: {
      redirectTo: window.location.origin,
      queryParams: { access_type: 'offline', prompt: 'consent' },
    }
  });
  if (error) {
    console.error('[Spokkartan] Google login fel:', error.message);
    throw error;
  }
  return data;
}

export async function signInWithEmail(email, password) {
  const { data, error } = await supabase.auth.signInWithPassword({ email, password });
  if (error) throw error;
  return data;
}

export async function signUpWithEmail(email, password, fullName) {
  const { data, error } = await supabase.auth.signUp({
    email, password,
    options: { data: { full_name: fullName, name: fullName } }
  });
  if (error) throw error;
  return data;
}

export async function signOut() {
  await supabase.auth.signOut();
}

export async function getProfile(userId) {
  const { data, error } = await supabase.from('profiles').select('*').eq('id', userId).maybeSingle();
  if (error) {
    console.error('[Spokkartan] getProfile fel:', error.message);
    return null;
  }
  return data;
}

export async function updateProfile(userId, updates) {
  const { data, error } = await supabase.from('profiles').update(updates).eq('id', userId).select().maybeSingle();
  if (error) throw error;
  return data;
}

export function onAuthChange(callback) {
  const { data } = supabase.auth.onAuthStateChange((event, session) => {
    callback(event, session);
  });
  return () => data.subscription.unsubscribe();
}

export async function getSession() {
  const { data: { session } } = await supabase.auth.getSession();
  return session;
}


// ── PARTNERS ────────────────────────────────────────────────

export async function fetchPartners({ type, tier } = {}) {
  let q = supabase.from('partners').select('*').eq('status','live');
  if (type) q = q.eq('type', type);
  if (tier) q = q.eq('tier', tier);
  // Featured first, then newest
  q = q.order('tier', { ascending: false }).order('created_at', { ascending: false });
  const { data, error } = await q;
  if (error) { console.error('[Spokkartan] fetchPartners:', error.message); return []; }
  return data || [];
}

export async function fetchPartner(id) {
  const { data, error } = await supabase.from('partners').select('*').eq('id', id).maybeSingle();
  if (error) { console.error(error); return null; }
  return data;
}

export async function createPartner(payload) {
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) throw new Error('Logga in först');
  const row = { ...payload, id: user.id, status: 'pending' };
  const { data, error } = await supabase.from('partners').upsert(row).select().maybeSingle();
  if (error) throw error;
  return data;
}

export async function updatePartner(id, updates) {
  const { data, error } = await supabase.from('partners').update(updates).eq('id', id).select().maybeSingle();
  if (error) throw error;
  return data;
}

export async function fetchPartnerServices(partnerId) {
  const { data, error } = await supabase.from('partner_services').select('*').eq('partner_id', partnerId).eq('active', true);
  if (error) { console.error(error); return []; }
  return data || [];
}

export default supabase;
