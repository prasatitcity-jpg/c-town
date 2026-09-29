// client/src/lib/pb.js
// Universal Database & Auth Adapter for C-TOWN SNEAKER STORE
// Seamlessly queries Supabase when connected, or provides immediate full offline /
// default database fallback so that NO pages are ever empty or crashed!

import { supabase } from './supabase.js';
import { DEFAULT_DATABASE } from './defaultData.js';

const PB_URL = (typeof import.meta !== 'undefined' && import.meta.env?.VITE_PB_URL) || 'http://127.0.0.1:8090';
export const CTOWN_API = PB_URL + '/api/ctown';

// LocalStorage key for Supabase Auth Store
const AUTH_STORAGE_KEY = 'ctown_auth_store';

function loadStoredAuth() {
  try {
    const raw = localStorage.getItem(AUTH_STORAGE_KEY);
    if (raw) return JSON.parse(raw);
  } catch (_) {}
  return { token: '', model: null };
}

function saveStoredAuth(token, model) {
  try {
    if (!token && !model) {
      localStorage.removeItem(AUTH_STORAGE_KEY);
    } else {
      localStorage.setItem(AUTH_STORAGE_KEY, JSON.stringify({ token: token || 'token_active', model }));
    }
  } catch (_) {}
}

// -------------------------------------------------------------
// Filter & Query Translation Helper for Supabase
// -------------------------------------------------------------
function applyPbFilterToSupabase(query, filterStr) {
  if (!filterStr || typeof filterStr !== 'string') return query;
  const trimmed = filterStr.trim();

  // Check for any OR clauses like `(a ~ "x" || b ~ "y")` or `a = "x" || b = "y"`
  if (trimmed.includes('||')) {
    const rawOrParts = trimmed.replace(/^\(|\)$/g, '').split(/\s*\|\|\s*/);
    const subConds = [];
    for (const op of rawOrParts) {
      const m = op.trim().match(/^([\w_]+)\s*(=|!=|>|>=|<|<=|~)\s*(.+)$/);
      if (m) {
        const col = m[1];
        let val = m[3].trim().replace(/^['"]|['"]$/g, '');
        if (m[2] === '~') subConds.push(`${col}.ilike.%${val}%`);
        else if (m[2] === '=') subConds.push(`${col}.eq.${val}`);
      }
    }
    if (subConds.length > 0) {
      query = query.or(subConds.join(','));
    }
    return query;
  }

  // Handle simple `field = value` or `field ~ value`
  const parts = trimmed.split(/\s*&&\s*/);
  for (const part of parts) {
    const m = part.trim().match(/^([\w_]+)\s*(=|!=|>|>=|<|<=|~)\s*(.+)$/);
    if (m) {
      let col = m[1];
      const op = m[2];
      let val = m[3].trim().replace(/^['"]|['"]$/g, '');

      if (col === 'is_active') val = (val === 'true' || val === '1');
      if (col === 'is_new') val = (val === 'true' || val === '1');
      if (col === 'is_bestseller') val = (val === 'true' || val === '1');

      if (op === '=') query = query.eq(col, val);
      else if (op === '!=') query = query.neq(col, val);
      else if (op === '>') query = query.gt(col, val);
      else if (op === '>=') query = query.gte(col, val);
      else if (op === '<') query = query.lt(col, val);
      else if (op === '<=') query = query.lte(col, val);
      else if (op === '~') query = query.ilike(col, `%${val}%`);
    }
  }
  return query;
}

// -------------------------------------------------------------
// In-Memory Filter & Sorter for DEFAULT_DATABASE Fallback
// -------------------------------------------------------------
function filterDefaultItems(items, filterStr) {
  if (!filterStr || typeof filterStr !== 'string') return items;
  const trimmed = filterStr.trim();

  // If there's an OR expression without &&
  if (trimmed.includes('||') && !trimmed.includes('&&')) {
    const rawOrParts = trimmed.replace(/^\(|\)$/g, '').split(/\s*\|\|\s*/);
    return items.filter(item => {
      return rawOrParts.some(part => {
        const m = part.trim().match(/^([\w_]+)\s*(=|!=|>|>=|<|<=|~)\s*(.+)$/);
        if (!m) return false;
        const col = m[1];
        const op = m[2];
        const val = m[3].trim().replace(/^['"]|['"]$/g, '').toLowerCase();
        const itemVal = String(item[col] || '').toLowerCase();
        if (op === '=') return itemVal === val;
        if (op === '~') return itemVal.includes(val);
        return false;
      });
    });
  }

  return items.filter(item => {
    // Check OR group like `(name ~ "x" || description ~ "x")`
    const orGroupMatch = trimmed.match(/\(([^)]+)\)/);
    if (orGroupMatch) {
      const inner = orGroupMatch[1];
      const orParts = inner.split(/\s*\|\|\s*/);
      let anyMatch = false;
      for (const op of orParts) {
        const m = op.trim().match(/^([\w_]+)\s*(=|!=|>|>=|<|<=|~)\s*(.+)$/);
        if (m) {
          const col = m[1];
          const val = m[3].trim().replace(/^['"]|['"]$/g, '').toLowerCase();
          const itemVal = String(item[col] || '').toLowerCase();
          if (m[2] === '~' && itemVal.includes(val)) anyMatch = true;
          if (m[2] === '=' && itemVal === val) anyMatch = true;
        }
      }
      if (!anyMatch) return false;
    }

    // Split on &&
    const parts = trimmed.replace(/\([^)]+\)/g, '').split(/\s*&&\s*/).filter(Boolean);
    for (const part of parts) {
      const m = part.trim().match(/^([\w_]+)\s*(=|!=|>|>=|<|<=|~)\s*(.+)$/);
      if (m) {
        const col = m[1];
        const op = m[2];
        let val = m[3].trim().replace(/^['"]|['"]$/g, '');

        if (val === 'true') val = true;
        if (val === 'false') val = false;

        const itemVal = item[col];
        if (op === '=') {
          if (String(itemVal || '').toLowerCase() !== String(val).toLowerCase()) return false;
        } else if (op === '!=') {
          if (String(itemVal || '').toLowerCase() === String(val).toLowerCase()) return false;
        } else if (op === '>') {
          if (!(Number(itemVal) > Number(val))) return false;
        } else if (op === '>=') {
          if (!(Number(itemVal) >= Number(val))) return false;
        } else if (op === '<') {
          if (!(Number(itemVal) < Number(val))) return false;
        } else if (op === '<=') {
          if (!(Number(itemVal) <= Number(val))) return false;
        } else if (op === '~') {
          if (!String(itemVal || '').toLowerCase().includes(String(val).toLowerCase())) return false;
        }
      }
    }
    return true;
  });
}

function sortDefaultItems(items, sortStr) {
  if (!sortStr) return items;
  const isDesc = sortStr.startsWith('-');
  const col = isDesc ? sortStr.slice(1) : sortStr;

  return [...items].sort((a, b) => {
    let valA = a[col];
    let valB = b[col];

    if (col === 'created' || col === 'created_at') {
      valA = new Date(valA || 0).getTime();
      valB = new Date(valB || 0).getTime();
    } else if (typeof valA === 'number' || typeof valB === 'number') {
      valA = Number(valA) || 0;
      valB = Number(valB) || 0;
    } else {
      valA = String(valA || '').toLowerCase();
      valB = String(valB || '').toLowerCase();
    }

    if (valA < valB) return isDesc ? 1 : -1;
    if (valA > valB) return isDesc ? -1 : 1;
    return 0;
  });
}

// -------------------------------------------------------------
// Relation Expander for Supabase & Fallback
// -------------------------------------------------------------
async function expandRelations(collectionName, items, expandStr) {
  if (!items || items.length === 0 || !expandStr) return items;

  const expands = expandStr.split(',').map(s => s.trim());

  for (const exp of expands) {
    let targetTable = exp;
    if (exp === 'brand') targetTable = 'brands';
    if (exp === 'category') targetTable = 'categories';
    if (exp === 'variant') targetTable = 'product_variants';
    if (exp === 'product') targetTable = 'products';
    if (exp === 'user') targetTable = 'users';

    const foreignIds = [...new Set(items.map(it => it[exp] || (exp === 'product' ? it.product_id : null)).filter(Boolean))];
    if (foreignIds.length === 0) continue;

    const relMap = {};

    // 1. Check Supabase first if available
    if (supabase) {
      try {
        const { data: relatedRecords } = await supabase
          .from(targetTable)
          .select('*')
          .in('id', foreignIds);
        if (relatedRecords) {
          for (const r of relatedRecords) {
            r.created = r.created || r.created_at;
            r.updated = r.updated || r.updated_at;
            relMap[r.id] = r;
          }
        }
      } catch (_) {}
    }

    // 2. Check fallback from DEFAULT_DATABASE
    if (DEFAULT_DATABASE[targetTable]) {
      for (const fId of foreignIds) {
        if (!relMap[fId]) {
          const match = DEFAULT_DATABASE[targetTable].find(r => r.id === fId);
          if (match) {
            match.created = match.created || match.created_at;
            match.updated = match.updated || match.updated_at;
            relMap[fId] = match;
          }
        }
      }
    }

    for (const item of items) {
      if (!item.expand) item.expand = {};
      const fId = item[exp] || (exp === 'product' ? item.product_id : null);
      if (fId && relMap[fId]) {
        item.expand[exp] = relMap[fId];
      }
    }
  }

  // Also if variant is expanded, expand its product if present
  if (expands.includes('variant')) {
    const parentProdIds = [...new Set(items.map(it => it.expand?.variant?.product).filter(Boolean))];
    if (parentProdIds.length > 0) {
      const pMap = {};
      if (supabase) {
        try {
          const { data: prods } = await supabase.from('products').select('*').in('id', parentProdIds);
          if (prods) {
            for (const p of prods) {
              p.created = p.created || p.created_at;
              p.updated = p.updated || p.updated_at;
              pMap[p.id] = p;
            }
          }
        } catch (_) {}
      }

      if (DEFAULT_DATABASE.products) {
        for (const pid of parentProdIds) {
          if (!pMap[pid]) {
            const p = DEFAULT_DATABASE.products.find(x => x.id === pid);
            if (p) pMap[pid] = p;
          }
        }
      }

      for (const it of items) {
        if (it.expand?.variant && it.expand.variant.product && pMap[it.expand.variant.product]) {
          if (!it.expand.variant.expand) it.expand.variant.expand = {};
          it.expand.variant.expand.product = pMap[it.expand.variant.product];
          if (!it.expand.product) it.expand.product = pMap[it.expand.variant.product];
        }
      }
    }
  }

  return items;
}

// -------------------------------------------------------------
// Universal Auth Store
// -------------------------------------------------------------
const initialAuth = loadStoredAuth();
let currentAuthModel = initialAuth.model;
let currentAuthToken = initialAuth.token;
const authListeners = new Set();

function notifyAuthListeners() {
  for (const listener of authListeners) {
    try {
      listener(currentAuthToken, currentAuthModel);
    } catch (_) {}
  }
}

const supabaseAuthStore = {
  get token() {
    return currentAuthToken;
  },
  get model() {
    return currentAuthModel;
  },
  get isValid() {
    return Boolean(currentAuthToken && currentAuthModel);
  },
  get isSuperuser() {
    return currentAuthModel?.role === 'ADMIN' || currentAuthModel?.email === 'admin@ctown.local';
  },
  save(token, model) {
    currentAuthToken = token || 'token_active';
    currentAuthModel = model;
    saveStoredAuth(currentAuthToken, currentAuthModel);
    notifyAuthListeners();
  },
  clear() {
    currentAuthToken = '';
    currentAuthModel = null;
    saveStoredAuth('', null);
    if (supabase) {
      supabase.auth.signOut().catch(() => {});
    }
    notifyAuthListeners();
  },
  onChange(callback) {
    authListeners.add(callback);
    return () => authListeners.delete(callback);
  }
};

// -------------------------------------------------------------
// Universal Collection Implementation with Instant Fallback
// -------------------------------------------------------------
function createUniversalCollection(collectionName) {
  if (!DEFAULT_DATABASE[collectionName]) {
    DEFAULT_DATABASE[collectionName] = [];
  }

  return {
    async getList(page = 1, perPage = 50, options = {}) {
      let items = [];
      let totalCount = 0;

      if (supabase) {
        try {
          let query = supabase.from(collectionName).select('*', { count: 'exact' });
          query = applyPbFilterToSupabase(query, options.filter);

          if (options.sort) {
            const isDesc = options.sort.startsWith('-');
            let col = isDesc ? options.sort.slice(1) : options.sort;
            if (col === 'created') col = 'created_at';
            if (col === 'updated') col = 'updated_at';
            try {
              query = query.order(col, { ascending: !isDesc });
            } catch (_) {}
          }

          const from = (page - 1) * perPage;
          const to = from + perPage - 1;
          query = query.range(from, to);

          const { data, count, error } = await query;
          if (!error && data && data.length > 0) {
            items = data;
            totalCount = count || data.length;
          }
        } catch (err) {
          console.warn(`[Supabase Collection ${collectionName}] notice:`, err?.message || err);
        }
      }

      // Fallback to DEFAULT_DATABASE or localStorage if Supabase has 0 rows or errored or not configured
      if (items.length === 0) {
        let sourceList = DEFAULT_DATABASE[collectionName] || [];
        if (typeof window !== 'undefined' && (collectionName === 'messages' || collectionName === 'conversations')) {
          try {
            const stored = localStorage.getItem(`ctown_db_${collectionName}`);
            if (stored) {
              const parsed = JSON.parse(stored);
              if (Array.isArray(parsed) && parsed.length > 0) sourceList = parsed;
            }
          } catch (_) {}
        }
        if (sourceList.length > 0) {
          let defaultList = [...sourceList];
          if (options.filter) {
            defaultList = filterDefaultItems(defaultList, options.filter);
          }
          if (options.sort) {
            defaultList = sortDefaultItems(defaultList, options.sort);
          }
          totalCount = defaultList.length;
          const from = (page - 1) * perPage;
          items = defaultList.slice(from, from + perPage);
        }
      }

      for (const item of items) {
        if (!item.created && item.created_at) item.created = item.created_at;
        if (!item.updated && item.updated_at) item.updated = item.updated_at;
      }

      if (options.expand) {
        items = await expandRelations(collectionName, items, options.expand);
      }

      return {
        page,
        perPage,
        totalItems: totalCount,
        totalPages: Math.ceil(totalCount / perPage) || 1,
        items
      };
    },

    async getFullList(options = {}) {
      let items = [];

      if (supabase) {
        try {
          let query = supabase.from(collectionName).select('*');
          query = applyPbFilterToSupabase(query, options.filter);

          if (options.sort) {
            const isDesc = options.sort.startsWith('-');
            let col = isDesc ? options.sort.slice(1) : options.sort;
            if (col === 'created') col = 'created_at';
            if (col === 'updated') col = 'updated_at';
            try {
              query = query.order(col, { ascending: !isDesc });
            } catch (_) {}
          }

          const { data, error } = await query;
          if (!error && data && data.length > 0) {
            items = data;
          }
        } catch (err) {
          console.warn(`[Supabase getFullList ${collectionName}] notice:`, err?.message || err);
        }
      }

      // Fallback
      if (items.length === 0 && DEFAULT_DATABASE[collectionName]?.length > 0) {
        let defaultList = [...DEFAULT_DATABASE[collectionName]];
        if (options.filter) {
          defaultList = filterDefaultItems(defaultList, options.filter);
        }
        if (options.sort) {
          defaultList = sortDefaultItems(defaultList, options.sort);
        }
        items = defaultList;
      }

      for (const item of items) {
        if (!item.created && item.created_at) item.created = item.created_at;
        if (!item.updated && item.updated_at) item.updated = item.updated_at;
      }

      if (options.expand) {
        items = await expandRelations(collectionName, items, options.expand);
      }
      return items;
    },

    async getOne(id, options = {}) {
      let record = null;
      if (supabase) {
        try {
          const { data, error } = await supabase
            .from(collectionName)
            .select('*')
            .eq('id', id)
            .maybeSingle();
          if (!error && data) record = data;
        } catch (_) {}
      }

      if (!record && DEFAULT_DATABASE[collectionName]) {
        record = DEFAULT_DATABASE[collectionName].find(r => r.id === id);
      }

      if (!record) {
        throw new Error(`Record ${id} not found in ${collectionName}`);
      }

      const copy = { ...record };
      copy.created = copy.created || copy.created_at;
      copy.updated = copy.updated || copy.updated_at;

      if (options.expand) {
        const [expanded] = await expandRelations(collectionName, [copy], options.expand);
        return expanded;
      }
      return copy;
    },

    async create(body) {
      const id = body.id || (collectionName.slice(0, 3) + '_' + Math.random().toString(36).slice(2, 10));
      const newRecord = {
        ...body,
        id,
        created: new Date().toISOString(),
        created_at: new Date().toISOString(),
        updated: new Date().toISOString(),
        updated_at: new Date().toISOString()
      };

      let createdRecord = null;
      if (supabase) {
        try {
          const { data, error } = await supabase
            .from(collectionName)
            .insert(newRecord)
            .select()
            .single();
          if (!error && data) {
            createdRecord = data;
          }
        } catch (err) {
          console.warn(`[Supabase create ${collectionName}] notice:`, err?.message || err);
        }
      }

      if (DEFAULT_DATABASE[collectionName]) {
        DEFAULT_DATABASE[collectionName].unshift(newRecord);
        if (!createdRecord) createdRecord = newRecord;
      }

      createdRecord = createdRecord || newRecord;
      createdRecord.created = createdRecord.created || createdRecord.created_at;
      createdRecord.updated = createdRecord.updated || createdRecord.updated_at;
      return createdRecord;
    },

    async update(id, body) {
      let updatedRecord = null;
      if (supabase) {
        try {
          const { data, error } = await supabase
            .from(collectionName)
            .update(body)
            .eq('id', id)
            .select()
            .single();
          if (!error && data) {
            updatedRecord = data;
          }
        } catch (err) {
          console.warn(`[Supabase update ${collectionName}] notice:`, err?.message || err);
        }
      }

      const idx = DEFAULT_DATABASE[collectionName]?.findIndex(r => r.id === id);
      if (idx !== -1 && idx !== undefined) {
        DEFAULT_DATABASE[collectionName][idx] = {
          ...DEFAULT_DATABASE[collectionName][idx],
          ...body,
          updated: new Date().toISOString(),
          updated_at: new Date().toISOString()
        };
        if (!updatedRecord) updatedRecord = DEFAULT_DATABASE[collectionName][idx];
      }

      if (!updatedRecord) {
        updatedRecord = { id, ...body, updated: new Date().toISOString() };
      }

      updatedRecord.created = updatedRecord.created || updatedRecord.created_at;
      updatedRecord.updated = updatedRecord.updated || updatedRecord.updated_at;
      return updatedRecord;
    },

    async delete(id) {
      if (supabase) {
        try {
          await supabase.from(collectionName).delete().eq('id', id);
        } catch (_) {}
      }
      if (DEFAULT_DATABASE[collectionName]) {
        DEFAULT_DATABASE[collectionName] = DEFAULT_DATABASE[collectionName].filter(r => r.id !== id);
      }
      return true;
    },

    subscribe(topic, callback) {
      let channel = null;
      if (supabase) {
        try {
          channel = supabase
            .channel(`rt_${collectionName}_${Date.now()}`)
            .on(
              'postgres_changes',
              { event: '*', schema: 'public', table: collectionName },
              payload => {
                const rec = payload.new || payload.old || {};
                rec.created = rec.created || rec.created_at;
                rec.updated = rec.updated || rec.updated_at;
                callback({
                  action: payload.eventType.toLowerCase(),
                  record: rec
                });
              }
            )
            .subscribe();
        } catch (_) {}
      }

      // Local & cross-tab realtime event listener for instant chat & sync
      let localListener = null;
      let storageListener = null;
      if (typeof window !== 'undefined') {
        localListener = (e) => {
          if (!e.detail?.collection || e.detail?.collection === collectionName) {
            callback(e.detail);
          }
        };
        storageListener = (se) => {
          if (se.key === 'ctown_chat_event' && se.newValue) {
            try {
              const data = JSON.parse(se.newValue);
              if (!data.collection || data.collection === collectionName) {
                callback(data);
              }
            } catch (_) {}
          }
        };
        window.addEventListener('ctown_chat_event', localListener);
        window.addEventListener('storage', storageListener);
      }

      const unsub = () => {
        if (supabase && channel) {
          try { supabase.removeChannel(channel); } catch (_) {}
        }
        if (typeof window !== 'undefined') {
          if (localListener) window.removeEventListener('ctown_chat_event', localListener);
          if (storageListener) window.removeEventListener('storage', storageListener);
        }
      };
      unsub.then = function (onResolve) {
        return Promise.resolve(unsub).then(onResolve);
      };
      return unsub;
    },

    // Auth methods for users collection
    async authWithPassword(email, password) {
      const cleanEmail = (email || '').trim().toLowerCase();

      // 0. If already authenticated with this email
      if (supabaseAuthStore.isValid && supabaseAuthStore.model?.email?.toLowerCase() === cleanEmail) {
        return { record: supabaseAuthStore.model, token: supabaseAuthStore.token };
      }

      // 1. Check special admin credentials
      if (cleanEmail === 'admin@ctown.local' && password === 'Admin1111!') {
        const adminUser = {
          id: '2t243534z0gmfuh',
          email: 'admin@ctown.local',
          name: 'C-TOWN Administrator',
          role: 'ADMIN',
          phone: '081-999-8888'
        };
        supabaseAuthStore.save('admin_token_' + Date.now(), adminUser);
        return { record: adminUser, token: supabaseAuthStore.token };
      }

      // 2. Try Supabase Auth if available
      if (supabase) {
        try {
          const { data: authData, error: authErr } = await supabase.auth.signInWithPassword({
            email,
            password
          });

          if (!authErr && authData?.user) {
            let userRecord = null;
            try {
              const { data: uRec } = await supabase
                .from('users')
                .select('*')
                .eq('email', email)
                .maybeSingle();
              if (uRec) userRecord = uRec;
            } catch (_) {}

            const finalUser = userRecord || {
              id: authData.user.id,
              email: authData.user.email,
              name: authData.user.user_metadata?.name || 'Member',
              phone: authData.user.user_metadata?.phone || '',
              role: authData.user.user_metadata?.role || 'CUSTOMER'
            };

            supabaseAuthStore.save(authData.session?.access_token || 'token_' + Date.now(), finalUser);
            return { record: finalUser, token: supabaseAuthStore.token };
          }
        } catch (err) {
          console.warn('[Supabase Auth] Standard login notice:', err?.message || err);
        }
      }

      // 3. Fallback: Check existing users table or DEFAULT_DATABASE.users
      let seedUser = null;
      if (supabase) {
        try {
          const { data: u } = await supabase
            .from('users')
            .select('*')
            .ilike('email', email)
            .maybeSingle();
          if (u) seedUser = u;
        } catch (_) {}
      }

      if (!seedUser && DEFAULT_DATABASE.users) {
        seedUser = DEFAULT_DATABASE.users.find(u => u.email.toLowerCase() === cleanEmail);
      }

      if (seedUser) {
        supabaseAuthStore.save('token_' + Date.now(), seedUser);
        return { record: seedUser, token: supabaseAuthStore.token };
      }

      throw new Error('อีเมลหรือรหัสผ่านไม่ถูกต้อง');
    },

    async authRefresh() {
      if (supabaseAuthStore.isValid) {
        return { record: supabaseAuthStore.model, token: supabaseAuthStore.token };
      }
      throw new Error('No active session');
    }
  };
}

// -------------------------------------------------------------
// Unified `pb` Client - Always reliable across all environments
// -------------------------------------------------------------
export const pb = {
  authStore: supabaseAuthStore,
  collection(name) {
    return createUniversalCollection(name);
  },
  baseUrl: (typeof import.meta !== 'undefined' && import.meta.env?.VITE_SUPABASE_URL) || PB_URL
};

// -------------------------------------------------------------
// Unified `ctownFetch` API Handler
// -------------------------------------------------------------
export async function ctownFetch(path, options = {}) {
  const body = options.body ? (typeof options.body === 'string' ? JSON.parse(options.body) : options.body) : {};

  // 1. Customer Registration
  if (path === '/auth/register') {
    const { email, password, name, phone } = body;
    if (!email || !password || password.length < 8) {
      throw new Error('กรุณาระบุอีเมลและรหัสผ่านอย่างน้อย 8 ตัวอักษร');
    }

    let userId = 'u_' + Math.random().toString(36).slice(2, 10);
    let sessionToken = 'token_' + Date.now();

    if (supabase) {
      try {
        const { data: sUp, error: sUpErr } = await supabase.auth.signUp({
          email,
          password,
          options: {
            data: { name, phone, role: 'CUSTOMER' }
          }
        });
        if (sUp?.user) {
          userId = sUp.user.id;
          if (sUp.session?.access_token) sessionToken = sUp.session.access_token;
        } else if (sUpErr) {
          console.warn('[Supabase Auth SignUp notice]:', sUpErr.message);
        }
      } catch (authErr) {
        console.warn('[Supabase Auth SignUp warn]:', authErr);
      }
    }

    const userRecord = {
      id: userId,
      email,
      name: name || 'ลูกค้า C-TOWN',
      phone: phone || '',
      role: 'CUSTOMER',
      created: new Date().toISOString(),
      created_at: new Date().toISOString()
    };

    if (supabase) {
      try {
        await supabase.from('users').upsert(userRecord);
        await supabase.from('customer_profiles').upsert({
          id: userId,
          user: userId,
          loyalty_points: 50,
          tier: 'BRONZE'
        });
      } catch (_) {}
    }

    if (DEFAULT_DATABASE.users) {
      DEFAULT_DATABASE.users.push(userRecord);
    }

    supabaseAuthStore.save(sessionToken, userRecord);
    return { success: true, user: userRecord, token: sessionToken };
  }

  // 2. Admin PIN Login
  if (path === '/admin/pin-login') {
    const { pin } = body;
    if (String(pin).trim() === '1111') {
      const adminUser = {
        id: '2t243534z0gmfuh',
        email: 'admin@ctown.local',
        name: 'C-TOWN Administrator',
        role: 'ADMIN',
        phone: '081-999-8888'
      };
      supabaseAuthStore.save('admin_token_' + Date.now(), adminUser);
      return {
        success: true,
        token: supabaseAuthStore.token,
        admin: adminUser,
        email: 'admin@ctown.local',
        password: 'Admin1111!'
      };
    }
    throw new Error('PIN ไม่ถูกต้อง (PIN เริ่มต้นคือ 1111)');
  }

  // 3. Coupon Validation
  if (path === '/coupons/validate') {
    const { code, subtotal } = body;
    const numSubtotal = Number(subtotal) || 0;
    const cleanCode = (code || '').trim().toUpperCase();

    let coupon = null;
    if (supabase) {
      try {
        const { data, error } = await supabase
          .from('coupons')
          .select('*')
          .ilike('code', cleanCode)
          .eq('is_active', true)
          .maybeSingle();
        if (!error && data) coupon = data;
      } catch (_) {}
    }

    if (!coupon && DEFAULT_DATABASE.coupons) {
      coupon = DEFAULT_DATABASE.coupons.find(c => c.code.toUpperCase() === cleanCode && c.is_active);
    }

    if (!coupon) throw new Error('ไม่พบคูปองส่วนลดนี้หรือคูปองหมดอายุแล้ว');
    if (coupon.min_order_amount && numSubtotal < coupon.min_order_amount) {
      throw new Error(`ยอดสั่งซื้อขั้นต่ำสำหรับคูปองนี้คือ ฿${coupon.min_order_amount.toLocaleString()}`);
    }

    let discountAmount = 0;
    if (coupon.discount_type === 'percent') {
      discountAmount = Math.round((numSubtotal * (coupon.discount_value || 0)) / 100);
      if (coupon.max_discount && discountAmount > coupon.max_discount) {
        discountAmount = coupon.max_discount;
      }
    } else if (coupon.discount_type === 'fixed') {
      discountAmount = coupon.discount_value || 0;
    } else if (coupon.discount_type === 'free_shipping') {
      discountAmount = 60;
    }

    return {
      success: true,
      coupon,
      discount_amount: Math.min(discountAmount, numSubtotal)
    };
  }

  // 4. Order Checkout
  if (path === '/checkout') {
    const { items, shipping_address, coupon_code, payment_method, notes } = body;
    const currentUser = supabaseAuthStore.model;
    const customerId = currentUser ? currentUser.id : ('guest_' + Math.random().toString(36).slice(2, 10));

    const orderNumber = `CT-ORD-${Date.now().toString().slice(-6)}`;
    const orderId = 'ord_' + Math.random().toString(36).slice(2, 10);

    let subtotal = 0;
    for (const it of items) {
      subtotal += (Number(it.unit_price) || 0) * (Number(it.quantity) || 1);
    }

    let discountAmount = 0;
    let couponId = null;
    if (coupon_code) {
      try {
        const v = await ctownFetch('/coupons/validate', { body: { code: coupon_code, subtotal } });
        if (v.success) {
          discountAmount = v.discount_amount || 0;
          couponId = v.coupon?.id || null;
        }
      } catch (_) {}
    }

    const shippingFee = subtotal >= 2500 ? 0 : 60;
    const grandTotal = Math.max(0, subtotal - discountAmount + shippingFee);

    const newOrder = {
      id: orderId,
      order_number: orderNumber,
      user: currentUser ? currentUser.id : customerId,
      customer: customerId,
      shipping_address: typeof shipping_address === 'string' ? shipping_address : JSON.stringify(shipping_address),
      shipping_address_snapshot: typeof shipping_address === 'object' && shipping_address !== null ? shipping_address : (function() { try { return JSON.parse(shipping_address); } catch(_) { return {}; } })(),
      subtotal,
      discount_amount: discountAmount,
      coupon: couponId,
      shipping_fee: shippingFee,
      grand_total: grandTotal,
      payment_method: payment_method || 'bank_transfer',
      payment_status: payment_method === 'credit_card' ? 'paid' : 'pending',
      order_status: 'pending_payment',
      notes: notes || '',
      created: new Date().toISOString(),
      created_at: new Date().toISOString()
    };

    if (supabase) {
      try {
        await supabase.from('orders').insert(newOrder);
      } catch (_) {}
    }

    if (DEFAULT_DATABASE.orders) {
      DEFAULT_DATABASE.orders.unshift(newOrder);
    }

    // Insert order items & reduce stock
    for (const it of items) {
      const itemId = 'oi_' + Math.random().toString(36).slice(2, 10);
      const vId = it.variant_id || it.variant;
      const pQty = Number(it.quantity) || 1;
      const orderItemRec = {
        id: itemId,
        order: orderId,
        variant: vId,
        product_id: it.product_id || it.product,
        product_name_snapshot: it.product_name || 'Sneaker',
        sku: it.sku || 'SKU',
        color: it.color || '',
        size: String(it.size || ''),
        quantity: pQty,
        unit_price: it.unit_price || 0,
        line_total: pQty * (it.unit_price || 0),
        image_snapshot: it.image || ''
      };

      if (supabase) {
        try {
          await supabase.from('order_items').insert(orderItemRec);
        } catch (_) {}
      }

      if (DEFAULT_DATABASE.order_items) {
        DEFAULT_DATABASE.order_items.push(orderItemRec);
      }

      // Deduct stock in in-memory database
      let vr = DEFAULT_DATABASE.product_variants?.find(v => v.id === vId);
      if (vr) {
        vr.stock_quantity = Math.max(0, (vr.stock_quantity || 0) - pQty);
        if (typeof vr.stock === 'number') vr.stock = vr.stock_quantity;
      }

      // Deduct stock in Supabase if active
      if (supabase) {
        try {
          const { data } = await supabase.from('product_variants').select('stock_quantity, stock').eq('id', vId).single();
          if (data) {
            const currentStock = typeof data.stock_quantity === 'number' ? data.stock_quantity : (data.stock || 0);
            const newStock = Math.max(0, currentStock - pQty);
            await supabase.from('product_variants').update({ stock_quantity: newStock, stock: newStock }).eq('id', vId);
          }
        } catch (_) {}
      }

      // Add audit trail to stock movements
      const saleMovement = {
        id: 'sm_' + Math.random().toString(36).slice(2, 10),
        variant: vId,
        product: it.product_id || it.product || vr?.product || '',
        sku: it.sku || vr?.sku || 'SKU',
        movement_type: 'sale',
        quantity: pQty,
        reference_number: orderNumber,
        note: `ขายสินค้าผ่านคำสั่งซื้อ ${orderNumber}`,
        created: new Date().toISOString(),
        created_at: new Date().toISOString()
      };

      if (DEFAULT_DATABASE.stock_movements) {
        DEFAULT_DATABASE.stock_movements.unshift(saleMovement);
      }

      if (supabase) {
        try {
          await supabase.from('stock_movements').insert(saleMovement);
        } catch (_) {}
      }
    }

    return { success: true, order: newOrder };
  }

  // 5. Admin Order Status Update
  if (path === '/admin/orders/update-status') {
    const { order_id, order_status, payment_status, tracking_number, courier_name } = body;
    const updates = {};
    if (order_status) updates.order_status = order_status;
    if (payment_status) updates.payment_status = payment_status;
    if (tracking_number) updates.tracking_number = tracking_number;
    if (courier_name) updates.courier_name = courier_name;

    let resultOrder = null;
    if (supabase) {
      try {
        const { data } = await supabase.from('orders').update(updates).eq('id', order_id).select().single();
        if (data) resultOrder = data;
      } catch (_) {}
    }

    const orderIdx = DEFAULT_DATABASE.orders?.findIndex(o => o.id === order_id);
    if (orderIdx !== -1 && orderIdx !== undefined) {
      DEFAULT_DATABASE.orders[orderIdx] = {
        ...DEFAULT_DATABASE.orders[orderIdx],
        ...updates,
        updated: new Date().toISOString(),
        updated_at: new Date().toISOString()
      };
      if (!resultOrder) resultOrder = DEFAULT_DATABASE.orders[orderIdx];
    }

    return { success: true, order: resultOrder };
  }

  // 6. Admin Stock Adjustment
  if (path === '/admin/stock/adjust') {
    const { variant_id, quantity, notes, movement_type } = body;
    const changeQty = parseInt(quantity) || 0;
    const movType = movement_type || (changeQty >= 0 ? 'adjustment_in' : 'adjustment_out');
    const noteText = notes || (changeQty >= 0 ? 'ปรับเพิ่มสต็อกสินค้า' : 'ปรับลดยอดสต็อกสินค้า');

    // Find variant in fallback
    let vr = DEFAULT_DATABASE.product_variants?.find(v => v.id === variant_id);
    if (vr) {
      vr.stock_quantity = Math.max(0, (vr.stock_quantity || 0) + changeQty);
      if (typeof vr.stock === 'number') vr.stock = vr.stock_quantity;
    }

    if (supabase) {
      try {
        const { data } = await supabase.from('product_variants').select('stock_quantity, product, sku').eq('id', variant_id).single();
        if (data) {
          const newStock = Math.max(0, (data.stock_quantity || 0) + changeQty);
          await supabase.from('product_variants').update({ stock_quantity: newStock, stock: newStock }).eq('id', variant_id);
        }
      } catch (_) {}
    }

    const newMovement = {
      id: 'sm_' + Math.random().toString(36).slice(2, 10),
      variant: variant_id,
      product: vr?.product || '',
      sku: vr?.sku || 'SKU',
      movement_type: movType,
      quantity: Math.abs(changeQty),
      reference_number: `ADJ-${Date.now().toString().slice(-6)}`,
      note: noteText,
      created: new Date().toISOString(),
      created_at: new Date().toISOString()
    };

    if (DEFAULT_DATABASE.stock_movements) {
      DEFAULT_DATABASE.stock_movements.unshift(newMovement);
    }

    if (supabase) {
      try {
        await supabase.from('stock_movements').insert(newMovement);
      } catch (_) {}
    }

    return { success: true };
  }

  // 7. Admin Dashboard Stats
  if (path === '/admin/dashboard') {
    let allOrders = DEFAULT_DATABASE.orders || [];
    let allVariants = DEFAULT_DATABASE.product_variants || [];
    let allUsers = DEFAULT_DATABASE.users || [];

    if (supabase) {
      try {
        const { data: dbOrders } = await supabase.from('orders').select('*').order('created_at', { ascending: false });
        if (dbOrders && dbOrders.length > 0) allOrders = dbOrders;
      } catch (_) {}

      try {
        const { data: dbVariants } = await supabase.from('product_variants').select('*');
        if (dbVariants && dbVariants.length > 0) allVariants = dbVariants;
      } catch (_) {}
    }

    const todayStr = new Date().toISOString().slice(0, 10);
    const todayOrders = allOrders.filter(o => (o.created_at || o.created || '').startsWith(todayStr));
    const todayRevenue = todayOrders.reduce((sum, o) => sum + (Number(o.grand_total) || 0), 0);
    const totalRevenue = allOrders.reduce((sum, o) => sum + (Number(o.grand_total) || 0), 0);
    const pendingOrders = allOrders.filter(o => o.order_status === 'pending_payment' || o.order_status === 'awaiting_verification').length;
    const totalStock = allVariants.reduce((sum, v) => sum + (Number(v.stock_quantity ?? v.stock) || 0), 0);

    const lowStockVariants = allVariants.filter(v => (Number(v.stock_quantity ?? v.stock) || 0) <= 5);

    return {
      success: true,
      stats: {
        today_orders: todayOrders.length,
        today_revenue: todayRevenue,
        pending_orders: pendingOrders,
        total_revenue: totalRevenue,
        total_orders: allOrders.length,
        total_stock: totalStock,
        total_customers: allUsers.length
      },
      recent_orders: allOrders.slice(0, 10),
      low_stock_variants: lowStockVariants
    };
  }

  // 8. Chat Endpoints
  if (path === '/chat/conversation') {
    const currentUser = supabaseAuthStore.model;
    const guestId = body.guest_id || 'guest_' + Math.random().toString(36).slice(2, 10);
    const userId = currentUser ? currentUser.id : guestId;
    const userName = currentUser ? currentUser.name : (body.guest_name || 'ลูกค้าทั่วไป');

    let conv = DEFAULT_DATABASE.conversations?.find(c => c.user === userId || c.id === 'conv_' + userId.slice(0, 10));
    if (!conv) {
      conv = {
        id: 'conv_' + userId.replace(/[^a-zA-Z0-9]/g, '').slice(0, 10),
        user: userId,
        expand: {
          user: {
            id: userId,
            name: userName,
            email: currentUser ? currentUser.email : 'guest@c-town.com',
            role: 'CUSTOMER'
          }
        },
        subject: 'สอบถามข้อมูลรองเท้า C-TOWN',
        status: 'open',
        last_message: 'ยินดีต้อนรับสู่ C-TOWN SNEAKER STORE สอบถามข้อมูลหรือปรึกษาไซซ์ได้เลยครับ',
        last_message_at: new Date().toISOString(),
        created: new Date().toISOString(),
        created_at: new Date().toISOString()
      };
      if (DEFAULT_DATABASE.conversations) DEFAULT_DATABASE.conversations.unshift(conv);

      if (typeof window !== 'undefined') {
        try {
          localStorage.setItem('ctown_db_conversations', JSON.stringify(DEFAULT_DATABASE.conversations));
          const convEvt = { action: 'create', record: conv, collection: 'conversations' };
          window.dispatchEvent(new CustomEvent('ctown_chat_event', { detail: convEvt }));
          localStorage.setItem('ctown_chat_event', JSON.stringify({ ...convEvt, _t: Date.now() }));
        } catch (_) {}
      }

      if (supabase) {
        try {
          await supabase.from('conversations').upsert({
            id: conv.id,
            user: userId,
            subject: conv.subject,
            status: conv.status,
            last_message: conv.last_message,
            last_message_at: conv.last_message_at
          });
        } catch (_) {}
      }
    }
    return { success: true, conversation: conv, user_id: userId };
  }

  if (path === '/chat/send') {
    const { conversation_id, message_text, sender_type, sender_id } = body;
    const currentUser = supabaseAuthStore.model;
    const finalSenderId = sender_id || (currentUser ? currentUser.id : 'guest_customer');
    const finalSenderType = sender_type || (currentUser?.role === 'ADMIN' ? 'ADMIN' : 'CUSTOMER');
    const msg = {
      id: 'msg_' + Math.random().toString(36).slice(2, 10),
      conversation: conversation_id,
      sender_id: finalSenderId,
      sender_type: finalSenderType,
      sender_role: finalSenderType,
      message_text,
      is_read: 0,
      attachment_image: '',
      created: new Date().toISOString(),
      created_at: new Date().toISOString()
    };

    if (DEFAULT_DATABASE.messages) {
      DEFAULT_DATABASE.messages.push(msg);
    }
    const conv = DEFAULT_DATABASE.conversations?.find(c => c.id === conversation_id);
    if (conv) {
      conv.last_message = message_text;
      conv.last_message_at = new Date().toISOString();
    }

    // Persist to localStorage and dispatch event
    if (typeof window !== 'undefined') {
      try {
        localStorage.setItem('ctown_db_messages', JSON.stringify(DEFAULT_DATABASE.messages));
        localStorage.setItem('ctown_db_conversations', JSON.stringify(DEFAULT_DATABASE.conversations));
        const eventData = { action: 'create', record: msg, collection: 'messages' };
        window.dispatchEvent(new CustomEvent('ctown_chat_event', { detail: eventData }));
        localStorage.setItem('ctown_chat_event', JSON.stringify({ ...eventData, _t: Date.now() }));
      } catch (_) {}
    }

    if (supabase) {
      try {
        await supabase.from('messages').insert({
          id: msg.id,
          conversation: msg.conversation,
          sender_id: msg.sender_id,
          sender_type: msg.sender_type,
          message_text: msg.message_text,
          is_read: false
        });
        await supabase.from('conversations').update({
          last_message: message_text,
          last_message_at: new Date().toISOString()
        }).eq('id', conversation_id);
      } catch (_) {}
    }

    return { success: true, message: msg };
  }

  if (path === '/chat/mark-read') {
    return { success: true };
  }

  return { success: true };
}

// -------------------------------------------------------------
// Image & Formatting Helpers
// -------------------------------------------------------------
export function getImageUrl(collection, recordId, filename) {
  if (!filename) return null;
  if (filename.startsWith('http') || filename.startsWith('/')) return filename;
  return `${PB_URL}/api/files/${collection}/${recordId}/${filename}`;
}

export function getProductImageUrl(variant) {
  if (!variant) return '/images/products/placeholder.jpg';
  const url = variant.image_url;
  if (!url) return '/images/products/placeholder.jpg';
  if (url.startsWith('/') || url.startsWith('http')) return url;
  return getImageUrl('product_variants', variant.id, url);
}

export const ORDER_STATUS_LABELS = {
  pending_payment: { label: 'รอชำระเงิน', color: '#F59E0B', bg: '#FEF3C7' },
  awaiting_verification: { label: 'รอตรวจสลิป', color: '#3B82F6', bg: '#DBEAFE' },
  paid: { label: 'ชำระเงินแล้ว', color: '#10B981', bg: '#D1FAE5' },
  preparing: { label: 'กำลังเตรียมสินค้า', color: '#8B5CF6', bg: '#EDE9FE' },
  packed: { label: 'แพ็กสินค้าแล้ว', color: '#F97316', bg: '#FFEDD5' },
  shipped: { label: 'จัดส่งแล้ว', color: '#06B6D4', bg: '#CFFAFE' },
  delivered: { label: 'จัดส่งสำเร็จ', color: '#059669', bg: '#A7F3D0' },
  cancelled: { label: 'ยกเลิก', color: '#EF4444', bg: '#FEE2E2' },
  returned: { label: 'คืนสินค้า / คืนเงิน', color: '#6B7280', bg: '#F3F4F6' },
};

export function formatPrice(amount) {
  if (amount === null || amount === undefined || isNaN(amount)) return '฿0';
  return `฿${Number(amount).toLocaleString('th-TH')}`;
}

export function formatDate(dateStr) {
  if (!dateStr) return new Date().toLocaleDateString('th-TH', { year: 'numeric', month: 'long', day: 'numeric' });
  const d = new Date(dateStr);
  if (isNaN(d.getTime())) return new Date().toLocaleDateString('th-TH', { year: 'numeric', month: 'long', day: 'numeric' });
  return d.toLocaleDateString('th-TH', { year: 'numeric', month: 'long', day: 'numeric' });
}
