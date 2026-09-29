import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = import.meta.env.VITE_SUPABASE_URL || '';
const SUPABASE_ANON_KEY = import.meta.env.VITE_SUPABASE_ANON_KEY || '';

// Only enable if valid non-dummy credentials are provided
export const isRealSupabase = Boolean(
  SUPABASE_URL &&
  SUPABASE_ANON_KEY &&
  !SUPABASE_URL.includes('your-project') &&
  !SUPABASE_URL.includes('azrudtycfdaaokhuwjaq') &&
  SUPABASE_URL.startsWith('http')
);

export const supabase = isRealSupabase
  ? createClient(SUPABASE_URL, SUPABASE_ANON_KEY)
  : null;

export default supabase;
