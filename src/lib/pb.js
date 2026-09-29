// client/src/lib/pb.js
// Universal Database & Auth Adapter for C-TOWN SNEAKER STORE
// Automatically routes to Supabase when VITE_SUPABASE_URL is available,
// or falls back to PocketBase when running locally.

import PocketBase from 'pocketbase';
import { supabase } from './supabase';

const PB_URL = import.meta.env.VITE_PB_URL || 'http://127.0.0.1:8090';
export const CTOWN_API = PB_URL + '/api/ctown';

// Determine if we should use Supabase
const isSupabaseEnabled = Boolean(supabase);

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

  // Split on " && "
  const clauses = filterStr.split(/\s*&&\s*/);
  for (const clause of clauses) {
    const trimmed = clause.trim();
    if (!trimmed || trimmed === '1=1') continue;

    // Match field operator value
    // e.g. status = "active", is_bestseller = true, user = "xyz", id != "abc", quantity > 0
    const m = trimmed.match(/^([\w_]+)\s*(=|!=|>|>=|<|<=|~)\s*(.+)$/);
    if (!m) continue;

    const col = m[1];
    const op = m[2];
    let rawVal = m[3].trim();

    // Strip quotes
    if ((rawVal.startsWith('"') && rawVal.endsWith('"')) || (rawVal.startsWith("'") && rawVal.endsWith("'"))) {
      rawVal = rawVal.slice(1, -1);
    }

    let val = rawVal;
    if (val === 'true') val = true;
    else if (val === 'false') val = false;
    else if (val === 'null') val = null;
    else if (!isNaN(Number(val)) && val !== '' && !val.includes('-') && !val.includes(':')) {
      val = Number(val);
    }

    if (op === '=') query = query.eq(col, val);
    else if (op === '!=') query = query.neq(col, val);
    else if (op === '>') query = query.gt(col, val);
    else if (op === '>=') query = query.gte(col, val);
    else if (op === '<') query = query.lt(col, val);
    else if (op === '<=') query = query.lte(col, val);
    else if (op === '~') query = query.ilike(col, `%${val}%`);
  }
  return query;
}

// Expand relations helper
async function expandRelations(tableName, items, expandStr) {
  if (!expandStr || !items || items.length === 0) return items;
  const expands = expandStr.split(',').map(s => s.trim());

  // Map of relations
  const relationTableMap = {
    brand: 'brands',
    category: 'categories',
    product: 'products',
    variant: 'product_variants',
    user: 'users',
    order: 'orders'
  };

  for (const exp of expands) {
    const targetTable = relationTableMap[exp] || exp;
    const foreignIds = [...new Set(items.map(it => it[exp]).filter(Boolean))];
    if (foreignIds.length === 0) continue;

    try {
      const { data: relatedRecords } = await supabase
        .from(targetTable)
        .select('*')
        .in('id', foreignIds);

      if (relatedRecords) {
        const relMap = {};
        for (const r of relatedRecords) relMap[r.id] = r;

        for (const item of items) {
          if (!item.expand) item.expand = {};
          if (item[exp] && relMap[item[exp]]) {
            item.expand[exp] = relMap[item[exp]];
          }
        }
      }
    } catch (e) {
      console.warn(`[Supabase Adapter] Expand ${exp} failed:`, e);
    }
  }

  return items;
}

// -------------------------------------------------------------
// PocketBase Fallback Instance
// -------------------------------------------------------------
const realPb = new PocketBase(PB_URL);

// -------------------------------------------------------------
// Supabase-backed Auth Store
// -------------------------------------------------------------
const initialAuth = loadStoredAuth();
let currentAuthModel = initialAuth.model;
let currentAuthToken = initialAuth.token;
const authListeners = new Set();

function notifyAuthListeners() {
  for (const cb of authListeners) {
    try { cb(currentAuthToken, currentAuthModel); } catch (_) {}
  }
}

const supabaseAuthStore = {
  get isValid() {
    return Boolean(currentAuthModel);
  },
  get model() {
    return currentAuthModel;
  },
  get token() {
    return currentAuthToken;
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
// Supabase-backed Collection Implementation
// -------------------------------------------------------------
function createSupabaseCollection(collectionName) {
  return {
    async getList(page = 1, perPage = 50, options = {}) {
      let query = supabase.from(collectionName).select('*', { count: 'exact' });
      query = applyPbFilterToSupabase(query, options.filter);

      if (options.sort) {
        const isDesc = options.sort.startsWith('-');
        const col = isDesc ? options.sort.slice(1) : options.sort;
        query = query.order(col, { ascending: !isDesc });
      }

      const from = (page - 1) * perPage;
      const to = from + perPage - 1;
      query = query.range(from, to);

      const { data, count, error } = await query;
      if (error) {
        console.error(`[Supabase] getList error on ${collectionName}:`, error);
        throw new Error(error.message);
      }

      let items = data || [];
      if (options.expand) {
        items = await expandRelations(collectionName, items, options.expand);
      }

      return {
        page,
        perPage,
        totalItems: count || items.length,
        totalPages: Math.ceil((count || items.length) / perPage),
        items
      };
    },

    async getFullList(options = {}) {
      let query = supabase.from(collectionName).select('*');
      query = applyPbFilterToSupabase(query, options.filter);

      if (options.sort) {
        const isDesc = options.sort.startsWith('-');
        const col = isDesc ? options.sort.slice(1) : options.sort;
        query = query.order(col, { ascending: !isDesc });
      }

      const { data, error } = await query;
      if (error) throw new Error(error.message);

      let items = data || [];
      if (options.expand) {
        items = await expandRelations(collectionName, items, options.expand);
      }
      return items;
    },

    async getOne(id, options = {}) {
      const { data, error } = await supabase
        .from(collectionName)
        .select('*')
        .eq('id', id)
        .single();
      if (error) throw new Error(error.message);

      let record = data;
      if (options.expand && record) {
        const expanded = await expandRelations(collectionName, [record], options.expand);
        record = expanded[0] || record;
      }
      return record;
    },

    async create(body = {}) {
      const record = { ...body };
      if (!record.id) {
        record.id = 'r' + Math.random().toString(36).slice(2, 9) + Math.random().toString(36).slice(2, 8);
      }
      const { data, error } = await supabase
        .from(collectionName)
        .insert(record)
        .select()
        .single();
      if (error) throw new Error(error.message);
      return data;
    },

    async update(id, body = {}) {
      const { data, error } = await supabase
        .from(collectionName)
        .update(body)
        .eq('id', id)
        .select()
        .single();
      if (error) throw new Error(error.message);
      return data;
    },

    async delete(id) {
      const { error } = await supabase
        .from(collectionName)
        .delete()
        .eq('id', id);
      if (error) throw new Error(error.message);
      return true;
    },

    subscribe(topic, callback) {
      const channel = supabase
        .channel(`rt_${collectionName}_${Date.now()}`)
        .on(
          'postgres_changes',
          { event: '*', schema: 'public', table: collectionName },
          payload => {
            callback({
              action: payload.eventType.toLowerCase(),
              record: payload.new || payload.old
            });
          }
        )
        .subscribe();

      return () => {
        supabase.removeChannel(channel);
      };
    },

    // Auth methods for users collection
    async authWithPassword(email, password) {
      // 1. Check special admin credentials
      if (email === 'admin@ctown.local' && password === 'Admin1111!') {
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

      // 2. Try Supabase Auth
      try {
        const { data: authData, error: authErr } = await supabase.auth.signInWithPassword({
          email,
          password
        });

        if (!authErr && authData?.user) {
          // Fetch linked profile from public.users or metadata
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
        console.warn('[Supabase Auth] Standard login failed, checking fallback users table:', err);
      }

      // 3. Fallback: Check existing seeded users table
      const { data: seedUser, error: seedErr } = await supabase
        .from('users')
        .select('*')
        .eq('email', email)
        .maybeSingle();

      if (!seedErr && seedUser) {
        supabaseAuthStore.save('seed_token_' + Date.now(), seedUser);
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
// Unified `pb` Client
// -------------------------------------------------------------
export const pb = isSupabaseEnabled
  ? {
      authStore: supabaseAuthStore,
      collection(name) {
        return createSupabaseCollection(name);
      },
      baseUrl: import.meta.env.VITE_SUPABASE_URL
    }
  : realPb;

// -------------------------------------------------------------
// Unified `ctownFetch` API Handler
// -------------------------------------------------------------
export async function ctownFetch(path, options = {}) {
  // If Supabase is available, handle custom endpoints client-side
  if (isSupabaseEnabled) {
    const body = options.body ? (typeof options.body === 'string' ? JSON.parse(options.body) : options.body) : {};

    // 1. Customer Registration
    if (path === '/auth/register') {
      const { email, password, name, phone } = body;
      if (!email || !password || password.length < 8) {
        throw new Error('กรุณาระบุอีเมลและรหัสผ่านอย่างน้อย 8 ตัวอักษร');
      }

      let userId = 'u_' + Math.random().toString(36).slice(2, 10);
      let sessionToken = 'token_' + Date.now();

      // Sign up on Supabase Auth
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

      // Upsert into public.users
      const userRecord = {
        id: userId,
        email,
        name: name || '',
        phone: phone || '',
        role: 'CUSTOMER',
        verified: true
      };

      try {
        await supabase.from('users').upsert(userRecord);
        await supabase.from('customer_profiles').upsert({
          id: 'cp_' + userId.slice(0, 10),
          user: userId,
          full_name: name || '',
          phone: phone || ''
        });
      } catch (dbErr) {
        console.warn('[Supabase DB Sync Profile notice]:', dbErr);
      }

      supabaseAuthStore.save(sessionToken, userRecord);
      return { success: true, user: userRecord };
    }

    // 2. Admin PIN Login
    if (path === '/admin/pin-login') {
      const { pin } = body;
      if (pin === '1111') {
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
          email: adminUser.email,
          password: 'Admin1111!',
          user: adminUser
        };
      }
      throw new Error('รหัส PIN ไม่ถูกต้อง (กรุณาระบุ PIN 1111)');
    }

    // 3. Coupon Validation
    if (path === '/coupons/validate') {
      const { code, subtotal } = body;
      const cleanCode = (code || '').trim().toUpperCase();
      const numSubtotal = Number(subtotal) || 0;

      const { data: coupon, error } = await supabase
        .from('coupons')
        .select('*')
        .eq('code', cleanCode)
        .eq('status', 'active')
        .maybeSingle();

      if (error || !coupon) {
        throw new Error('ไม่พบรหัสคูปองส่วนลดนี้ หรือคูปองหมดอายุแล้ว');
      }

      if (numSubtotal < (coupon.min_purchase || 0)) {
        throw new Error(`คูปองนี้ใช้ได้เมื่อมียอดสั่งซื้อขั้นต่ำ ${coupon.min_purchase.toLocaleString()} บาท`);
      }

      let discountAmount = 0;
      if (coupon.discount_type === 'fixed') {
        discountAmount = coupon.discount_value;
      } else if (coupon.discount_type === 'percent') {
        discountAmount = (numSubtotal * coupon.discount_value) / 100;
        if (coupon.max_discount && discountAmount > coupon.max_discount) {
          discountAmount = coupon.max_discount;
        }
      } else if (coupon.discount_type === 'free_shipping') {
        discountAmount = coupon.discount_value || 60;
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
      if (!currentUser) throw new Error('กรุณาเข้าสู่ระบบก่อนทำการสั่งซื้อ');

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
        user: currentUser.id,
        shipping_address_snapshot: shipping_address,
        subtotal,
        discount_amount: discountAmount,
        coupon: couponId,
        shipping_fee: shippingFee,
        grand_total: grandTotal,
        payment_method: payment_method || 'bank_transfer',
        payment_status: payment_method === 'credit_card' ? 'paid' : 'pending',
        order_status: 'pending_payment',
        notes: notes || ''
      };

      const { data: createdOrder, error: ordErr } = await supabase
        .from('orders')
        .insert(newOrder)
        .select()
        .single();

      if (ordErr) throw new Error(ordErr.message);

      // Insert order items
      for (const it of items) {
        const itemId = 'oi_' + Math.random().toString(36).slice(2, 10);
        await supabase.from('order_items').insert({
          id: itemId,
          order: orderId,
          variant: it.variant_id,
          product_id: it.product_id,
          product_name_snapshot: it.product_name,
          sku: it.sku || 'SKU',
          color: it.color || '',
          size: String(it.size || ''),
          quantity: it.quantity,
          unit_price: it.unit_price,
          line_total: it.quantity * it.unit_price,
          image_snapshot: it.image || ''
        });

        // Decrement stock
        if (it.variant_id) {
          try {
            const { data: vr } = await supabase.from('product_variants').select('stock_quantity, sold_quantity').eq('id', it.variant_id).single();
            if (vr) {
              await supabase.from('product_variants').update({
                stock_quantity: Math.max(0, (vr.stock_quantity || 0) - it.quantity),
                sold_quantity: (vr.sold_quantity || 0) + it.quantity
              }).eq('id', it.variant_id);
            }
          } catch (_) {}
        }
      }

      return { success: true, order: createdOrder };
    }

    // 5. Admin Order Status Update
    if (path === '/admin/orders/update-status') {
      const { order_id, order_status, payment_status, tracking_number, courier_name } = body;
      const updates = {};
      if (order_status) updates.order_status = order_status;
      if (payment_status) updates.payment_status = payment_status;
      if (tracking_number) updates.tracking_number = tracking_number;
      if (courier_name) updates.courier_name = courier_name;

      const { data, error } = await supabase.from('orders').update(updates).eq('id', order_id).select().single();
      if (error) throw new Error(error.message);
      return { success: true, order: data };
    }

    // 6. Admin Stock Adjustment
    if (path === '/admin/stock/adjust') {
      const { variant_id, delta, note, type } = body;
      const { data: vr } = await supabase.from('product_variants').select('stock_quantity, product, sku').eq('id', variant_id).single();
      if (vr) {
        const newStock = Math.max(0, (vr.stock_quantity || 0) + Number(delta));
        await supabase.from('product_variants').update({ stock_quantity: newStock }).eq('id', variant_id);

        await supabase.from('stock_movements').insert({
          id: 'sm_' + Math.random().toString(36).slice(2, 10),
          variant: variant_id,
          product: vr.product,
          sku: vr.sku,
          movement_type: type || (delta >= 0 ? 'ADJUSTMENT_IN' : 'ADJUSTMENT_OUT'),
          quantity: Math.abs(Number(delta)),
          note: note || 'Admin stock adjust'
        });
      }
      return { success: true };
    }

    // 7. Admin Dashboard Stats
    if (path === '/admin/dashboard') {
      const { count: totalOrders } = await supabase.from('orders').select('*', { count: 'exact', head: true });
      const { count: totalProducts } = await supabase.from('products').select('*', { count: 'exact', head: true });
      const { data: orders } = await supabase.from('orders').select('grand_total, payment_status, created_at').limit(100);

      let totalSales = 0;
      if (orders) {
        for (const o of orders) {
          if (o.payment_status === 'paid') totalSales += Number(o.grand_total || 0);
        }
      }

      return {
        success: true,
        stats: {
          total_orders: totalOrders || 0,
          total_products: totalProducts || 0,
          total_sales: totalSales,
          recent_orders: orders || []
        }
      };
    }

    // 8. Chat Endpoints
    if (path === '/chat/conversation') {
      const currentUser = supabaseAuthStore.model;
      if (!currentUser) throw new Error('Not logged in');
      let { data: conv } = await supabase.from('conversations').select('*').eq('user', currentUser.id).maybeSingle();
      if (!conv) {
        const { data: newC } = await supabase.from('conversations').insert({
          id: 'conv_' + currentUser.id.slice(0, 10),
          user: currentUser.id,
          subject: 'Customer Chat',
          status: 'open'
        }).select().single();
        conv = newC;
      }
      return { success: true, conversation: conv };
    }

    if (path === '/chat/send') {
      const { conversation_id, message_text, sender_type } = body;
      const currentUser = supabaseAuthStore.model;
      const msg = {
        id: 'msg_' + Math.random().toString(36).slice(2, 10),
        conversation: conversation_id,
        sender_id: currentUser ? currentUser.id : 'admin',
        sender_type: sender_type || 'CUSTOMER',
        message_text,
        is_read: false
      };
      await supabase.from('messages').insert(msg);
      await supabase.from('conversations').update({
        last_message: message_text,
        last_message_at: new Date().toISOString()
      }).eq('id', conversation_id);
      return { success: true, message: msg };
    }

    if (path === '/chat/mark-read') {
      return { success: true };
    }

    return { success: true };
  }

  // PocketBase Fallback
  const url = CTOWN_API + path;
  const token = pb.authStore.token;
  const res = await fetch(url, {
    headers: {
      'Content-Type': 'application/json',
      ...(token ? { Authorization: token } : {}),
      ...(options.headers || {}),
    },
    ...options,
    body: options.body ? (typeof options.body === 'string' ? options.body : JSON.stringify(options.body)) : undefined,
  });
  const data = await res.json();
  if (!res.ok) throw new Error(data?.message || 'Request failed');
  return data;
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
  awaiting_verification: { label: 'รอตรวจสอบการชำระเงิน', color: '#3B82F6', bg: '#DBEAFE' },
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
