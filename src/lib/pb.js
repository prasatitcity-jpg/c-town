import PocketBase from 'pocketbase';

const PB_URL = import.meta.env.VITE_PB_URL || 'http://127.0.0.1:8090';

export const pb = new PocketBase(PB_URL);

export const CTOWN_API = PB_URL + '/api/ctown';

export async function ctownFetch(path, options = {}) {
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
  if (!dateStr) return '-';
  return new Date(dateStr).toLocaleDateString('th-TH', { year: 'numeric', month: 'long', day: 'numeric' });
}
