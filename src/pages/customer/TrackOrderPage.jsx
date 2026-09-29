import React, { useState, useEffect } from 'react';
import { useSearchParams, Link } from 'react-router-dom';
import { pb, formatPrice, formatDate, ORDER_STATUS_LABELS } from '../../lib/pb';
import { useAuth } from '../../contexts/AuthContext';
import {
  Search,
  Package,
  Clock,
  CheckCircle2,
  Truck,
  AlertCircle,
  Copy,
  Check,
  MessageCircle,
  ShoppingBag,
  ExternalLink,
  ChevronRight,
  ArrowRight
} from 'lucide-react';

export default function TrackOrderPage() {
  const [searchParams, setSearchParams] = useSearchParams();
  const { user, isLoggedIn } = useAuth();

  const [query, setQuery] = useState(searchParams.get('order') || '');
  const [order, setOrder] = useState(null);
  const [items, setItems] = useState([]);
  const [loading, setLoading] = useState(false);
  const [searched, setSearched] = useState(false);
  const [error, setError] = useState('');
  const [copiedTracking, setCopiedTracking] = useState(false);
  const [recentOrders, setRecentOrders] = useState([]);

  // Load recent orders from localStorage & user account on mount
  useEffect(() => {
    loadRecentOrders();
    const orderParam = searchParams.get('order');
    if (orderParam) {
      executeSearch(orderParam);
    }
  }, []);

  async function loadRecentOrders() {
    const list = [];
    try {
      const local = JSON.parse(localStorage.getItem('ctown_my_orders') || '[]');
      list.push(...local);
    } catch (_) {}

    // If logged in, fetch from API
    if (isLoggedIn && user?.id) {
      try {
        const res = await pb.collection('orders').getList(1, 10, {
          filter: `customer = "${user.id}"`,
          sort: '-created',
        });
        for (const o of res.items) {
          if (!list.some(x => x.order_number === o.order_number)) {
            list.push({
              id: o.id,
              order_number: o.order_number,
              grand_total: o.grand_total,
              created: o.created || o.created_at,
              order_status: o.order_status,
              item_count: 1
            });
          }
        }
      } catch (_) {}
    }

    setRecentOrders(list.slice(0, 8));
  }

  const handleSearchSubmit = (e) => {
    e.preventDefault();
    if (!query.trim()) return;
    executeSearch(query.trim());
  };

  async function executeSearch(rawQuery) {
    const cleanQ = rawQuery.trim().replace(/^#/, '');
    if (!cleanQ) return;

    setLoading(true);
    setError('');
    setSearched(true);
    setOrder(null);
    setItems([]);

    try {
      // 1. Search by order_number or tracking_number or id
      let list = await pb.collection('orders').getList(1, 1, {
        filter: `order_number = "${cleanQ}" || tracking_number = "${cleanQ}" || id = "${cleanQ}"`,
      });

      // 2. If not found, try searching by phone or case-insensitive query
      if (list.items.length === 0) {
        const allOrders = await pb.collection('orders').getList(1, 100, { sort: '-id' });
        const matched = allOrders.items.find(o => {
          const numMatch = String(o.order_number || '').toLowerCase().includes(cleanQ.toLowerCase());
          const trMatch = String(o.tracking_number || '').toLowerCase().includes(cleanQ.toLowerCase());
          const idMatch = String(o.id || '').toLowerCase() === cleanQ.toLowerCase();
          
          let phoneMatch = false;
          try {
            const addr = typeof o.shipping_address === 'string' ? JSON.parse(o.shipping_address) : (o.shipping_address || o.shipping_address_snapshot || {});
            phoneMatch = String(addr.phone || '').replace(/\D/g, '').includes(cleanQ.replace(/\D/g, ''));
          } catch (_) {}

          return numMatch || trMatch || idMatch || (cleanQ.length >= 9 && phoneMatch);
        });

        if (matched) {
          list = { items: [matched] };
        }
      }

      if (list.items.length === 0) {
        setError(`ไม่พบข้อมูลคำสั่งซื้อ "${cleanQ}" กรุณาตรวจสอบหมายเลขคำสั่งซื้อหรือเลขพัสดุอีกครั้ง`);
        return;
      }

      const foundOrder = list.items[0];
      setOrder(foundOrder);
      setSearchParams({ order: foundOrder.order_number });

      // Save to recent
      try {
        const saved = JSON.parse(localStorage.getItem('ctown_my_orders') || '[]');
        const updated = [
          {
            id: foundOrder.id,
            order_number: foundOrder.order_number,
            grand_total: foundOrder.grand_total,
            created: foundOrder.created,
            order_status: foundOrder.order_status,
          },
          ...saved.filter(x => x.order_number !== foundOrder.order_number)
        ].slice(0, 10);
        localStorage.setItem('ctown_my_orders', JSON.stringify(updated));
        setRecentOrders(updated);
      } catch (_) {}

      // Fetch items
      try {
        const orderItems = await pb.collection('order_items').getList(1, 50, {
          filter: `order = "${foundOrder.id}"`,
          expand: 'product,variant',
        });
        setItems(orderItems.items);
      } catch (_) {
        setItems([]);
      }
    } catch (err) {
      console.error(err);
      setError('เกิดข้อผิดพลาดในการค้นหาคำสั่งซื้อ');
    } finally {
      setLoading(false);
    }
  }

  const statusSteps = [
    { key: 'pending_payment', label: 'รอชำระเงิน' },
    { key: 'awaiting_verification', label: 'รอตรวจสลิป' },
    { key: 'paid', label: 'ชำระสำเร็จ' },
    { key: 'preparing', label: 'กำลังเตรียมสินค้า' },
    { key: 'shipped', label: 'จัดส่งแล้ว' },
    { key: 'delivered', label: 'จัดส่งสำเร็จ' },
  ];

  const getStepIndex = (status) => {
    const idx = statusSteps.findIndex(s => s.key === status);
    if (idx !== -1) return idx;
    if (status === 'packed') return 3;
    return 1;
  };

  const currentStep = order ? getStepIndex(order.order_status) : -1;
  const isCancelled = order?.order_status === 'cancelled';

  // Parse shipping address safely
  const shippingAddr = order ? (function() {
    if (typeof order.shipping_address === 'object' && order.shipping_address !== null) {
      return order.shipping_address;
    }
    if (order.shipping_address_snapshot && typeof order.shipping_address_snapshot === 'object') {
      return order.shipping_address_snapshot;
    }
    try {
      return JSON.parse(order.shipping_address || '{}');
    } catch (_) {
      return {};
    }
  })() : {};

  const handleCopyTracking = () => {
    if (order?.tracking_number) {
      navigator.clipboard.writeText(order.tracking_number);
      setCopiedTracking(true);
      setTimeout(() => setCopiedTracking(false), 2000);
    }
  };

  return (
    <div className="track-order-page" style={{ maxWidth: '900px', margin: '0 auto', padding: '30px 16px' }}>
      {/* Hero Search Box */}
      <div className="track-hero" style={{ background: 'linear-gradient(135deg, #1E293B 0%, #0F172A 100%)', borderRadius: '20px', padding: '40px 24px', color: '#fff', textAlign: 'center', marginBottom: '32px', boxShadow: '0 10px 25px rgba(0,0,0,0.1)' }}>
        <h1 style={{ fontSize: '1.8rem', fontWeight: 800, marginBottom: '8px' }}>🔍 ติดตามสถานะคำสั่งซื้อ</h1>
        <p style={{ color: '#94A3B8', fontSize: '0.95rem', marginBottom: '24px' }}>
          ตรวจสอบความคืบหน้าการจัดส่งสินค้าของคุณได้ตลอด 24 ชั่วโมง
        </p>

        <form onSubmit={handleSearchSubmit} style={{ maxWidth: '580px', margin: '0 auto', display: 'flex', gap: '8px', background: '#fff', padding: '6px', borderRadius: '12px', boxShadow: '0 4px 15px rgba(0,0,0,0.1)' }}>
          <input
            type="text"
            placeholder="กรอกหมายเลขคำสั่งซื้อ (เช่น CT-ORD-028639) หรือเบอร์โทร"
            value={query}
            onChange={e => setQuery(e.target.value)}
            style={{ flex: 1, border: 'none', outline: 'none', padding: '12px 16px', fontSize: '1rem', color: '#1E293B' }}
            id="track-query-input"
          />
          <button
            type="submit"
            className="btn-primary"
            disabled={loading}
            style={{ padding: '12px 24px', borderRadius: '8px', fontWeight: 600, display: 'inline-flex', alignItems: 'center', gap: '8px' }}
            id="btn-track-submit"
          >
            <Search size={18} /> {loading ? 'กำลังค้นหา...' : 'ตรวจสอบ'}
          </button>
        </form>
      </div>

      {/* Recent Orders Section (1-click tracking) */}
      {!order && recentOrders.length > 0 && (
        <div style={{ background: '#fff', borderRadius: '16px', padding: '24px', marginBottom: '32px', border: '1px solid #E2E8F0', boxShadow: '0 4px 12px rgba(0,0,0,0.03)' }}>
          <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '16px' }}>
            <h3 style={{ fontSize: '1.1rem', fontWeight: 700, color: '#1E293B', display: 'flex', alignItems: 'center', gap: '8px' }}>
              <Package size={20} color="#E11D48" /> คำสั่งซื้อล่าสุดของคุณ
            </h3>
            <span style={{ fontSize: '0.8rem', color: '#64748B' }}>คลิกเพื่อดูรายละเอียด</span>
          </div>

          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(260px, 1fr))', gap: '12px' }}>
            {recentOrders.map(ro => {
              const st = ORDER_STATUS_LABELS[ro.order_status] || { label: ro.order_status || 'รอดำเนินการ', color: '#1E293B', bg: '#F1F5F9' };
              return (
                <div
                  key={ro.order_number}
                  onClick={() => { setQuery(ro.order_number); executeSearch(ro.order_number); }}
                  style={{
                    background: '#F8FAFC',
                    border: '1px solid #E2E8F0',
                    borderRadius: '12px',
                    padding: '16px',
                    cursor: 'pointer',
                    transition: 'all 0.2s ease',
                  }}
                  onMouseEnter={e => { e.currentTarget.style.borderColor = '#E11D48'; e.currentTarget.style.transform = 'translateY(-2px)'; }}
                  onMouseLeave={e => { e.currentTarget.style.borderColor = '#E2E8F0'; e.currentTarget.style.transform = 'none'; }}
                >
                  <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '8px' }}>
                    <strong style={{ color: '#E11D48', fontSize: '0.95rem' }}>#{ro.order_number}</strong>
                    <span style={{ fontSize: '0.75rem', padding: '3px 8px', borderRadius: '20px', fontWeight: 600, color: st.color, backgroundColor: st.bg }}>
                      {st.label}
                    </span>
                  </div>
                  <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', fontSize: '0.85rem' }}>
                    <span style={{ color: '#64748B' }}>{formatDate(ro.created)}</span>
                    <strong style={{ color: '#1E293B' }}>{formatPrice(ro.grand_total)}</strong>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      )}

      {/* Error Card */}
      {error && (
        <div style={{ background: '#FFF1F2', border: '1px solid #FFE4E6', borderRadius: '16px', padding: '24px', textAlign: 'center', color: '#BE123C', marginBottom: '24px' }}>
          <AlertCircle size={36} style={{ margin: '0 auto 12px' }} />
          <h3 style={{ fontSize: '1.1rem', fontWeight: 700, marginBottom: '6px' }}>{error}</h3>
          <p style={{ fontSize: '0.85rem', color: '#9F1239', marginBottom: '16px' }}>
            หากท่านมีข้อสงสัยหรือจำเลขออเดอร์ไม่ได้ สามารถติดต่อสอบถามเจ้าหน้าที่ได้ทันที
          </p>
          <Link
            to="/chat"
            className="btn-primary"
            style={{ display: 'inline-flex', alignItems: 'center', gap: '8px', padding: '10px 20px', borderRadius: '8px', textDecoration: 'none' }}
          >
            <MessageCircle size={16} /> แชทกับร้านค้า
          </Link>
        </div>
      )}

      {/* Search Result */}
      {order && (
        <div style={{ background: '#fff', borderRadius: '20px', border: '1px solid #E2E8F0', padding: '28px', boxShadow: '0 10px 25px rgba(0,0,0,0.04)' }}>
          {/* Header Bar */}
          <div style={{ display: 'flex', flexWrap: 'wrap', justifyContent: 'space-between', alignItems: 'center', gap: '16px', paddingBottom: '20px', borderBottom: '1px solid #F1F5F9', marginBottom: '24px' }}>
            <div>
              <span style={{ fontSize: '0.85rem', color: '#64748B' }}>หมายเลขคำสั่งซื้อ:</span>
              <h2 style={{ fontSize: '1.6rem', fontWeight: 800, color: '#1E293B', margin: '2px 0 6px' }}>
                #{order.order_number}
              </h2>
              <span style={{ fontSize: '0.85rem', color: '#94A3B8' }}>สั่งซื้อเมื่อ: {formatDate(order.created || order.created_at)}</span>
            </div>
            <div>
              <span
                style={{
                  display: 'inline-block',
                  fontSize: '0.9rem',
                  fontWeight: 700,
                  padding: '8px 16px',
                  borderRadius: '30px',
                  color: ORDER_STATUS_LABELS[order.order_status]?.color || '#1E293B',
                  backgroundColor: ORDER_STATUS_LABELS[order.order_status]?.bg || '#F1F5F9'
                }}
              >
                ● {ORDER_STATUS_LABELS[order.order_status]?.label || order.order_status}
              </span>
            </div>
          </div>

          {/* Timeline */}
          {!isCancelled ? (
            <div style={{ marginBottom: '32px' }}>
              <div style={{ display: 'flex', justifyContent: 'space-between', position: 'relative', margin: '20px 0' }}>
                <div style={{ position: 'absolute', top: '18px', left: '5%', right: '5%', height: '3px', background: '#E2E8F0', zIndex: 0 }} />
                <div
                  style={{
                    position: 'absolute',
                    top: '18px',
                    left: '5%',
                    width: `${Math.min(100, Math.max(0, (currentStep / (statusSteps.length - 1)) * 90))}%`,
                    height: '3px',
                    background: '#E11D48',
                    transition: 'width 0.5s ease',
                    zIndex: 0
                  }}
                />
                {statusSteps.map((step, idx) => {
                  const isDone = currentStep >= idx;
                  const isCur = currentStep === idx;
                  return (
                    <div key={step.key} style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', position: 'relative', zIndex: 1, width: '70px', textAlign: 'center' }}>
                      <div
                        style={{
                          width: '36px',
                          height: '36px',
                          borderRadius: '50%',
                          background: isDone ? '#E11D48' : '#fff',
                          border: isDone ? 'none' : '2px solid #CBD5E1',
                          color: isDone ? '#fff' : '#94A3B8',
                          display: 'flex',
                          alignItems: 'center',
                          justifyContent: 'center',
                          fontWeight: 700,
                          fontSize: '0.85rem',
                          marginBottom: '8px',
                          boxShadow: isCur ? '0 0 0 4px #FFE4E6' : 'none'
                        }}
                      >
                        {isDone ? <Check size={18} strokeWidth={3} /> : idx + 1}
                      </div>
                      <span style={{ fontSize: '0.75rem', fontWeight: isCur ? 700 : 500, color: isCur ? '#E11D48' : isDone ? '#1E293B' : '#94A3B8' }}>
                        {step.label}
                      </span>
                    </div>
                  );
                })}
              </div>
            </div>
          ) : (
            <div style={{ background: '#FEE2E2', color: '#991B1B', padding: '14px', borderRadius: '10px', textAlign: 'center', marginBottom: '24px' }}>
              ⚠️ คำสั่งซื้อนี้ถูกยกเลิกแล้ว
            </div>
          )}

          {/* Delivery & Recipient Information */}
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(260px, 1fr))', gap: '20px', background: '#F8FAFC', padding: '20px', borderRadius: '14px', marginBottom: '28px', border: '1px solid #EDF2F7' }}>
            <div>
              <h4 style={{ fontSize: '0.95rem', fontWeight: 700, color: '#1E293B', display: 'flex', alignItems: 'center', gap: '6px', marginBottom: '12px' }}>
                <Truck size={18} color="#E11D48" /> ข้อมูลการจัดส่งพัสดุ
              </h4>
              <p style={{ margin: '0 0 6px', fontSize: '0.88rem', color: '#475569' }}>
                <strong>ผู้ให้บริการขนส่ง:</strong> {order.shipping_carrier || 'Flash Express / Kerry Express'}
              </p>
              <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginTop: '6px' }}>
                <span style={{ fontSize: '0.88rem', color: '#475569' }}><strong>เลขพัสดุ:</strong></span>
                {order.tracking_number ? (
                  <div style={{ display: 'inline-flex', alignItems: 'center', gap: '6px', background: '#E2E8F0', padding: '3px 10px', borderRadius: '6px' }}>
                    <span style={{ fontFamily: 'monospace', fontWeight: 700, color: '#0F172A' }}>{order.tracking_number}</span>
                    <button
                      type="button"
                      onClick={handleCopyTracking}
                      style={{ border: 'none', background: 'transparent', cursor: 'pointer', padding: '2px', color: '#475569' }}
                      title="คัดลอกเลขพัสดุ"
                    >
                      {copiedTracking ? <Check size={14} color="#059669" /> : <Copy size={14} />}
                    </button>
                  </div>
                ) : (
                  <span style={{ fontSize: '0.85rem', color: '#E11D48', background: '#FFF1F2', padding: '2px 8px', borderRadius: '4px' }}>
                    กำลังแพ็กสินค้าและเตรียมนำส่ง
                  </span>
                )}
              </div>
            </div>

            <div>
              <h4 style={{ fontSize: '0.95rem', fontWeight: 700, color: '#1E293B', display: 'flex', alignItems: 'center', gap: '6px', marginBottom: '12px' }}>
                <Package size={18} color="#E11D48" /> ที่อยู่ผู้รับสินค้า
              </h4>
              {shippingAddr.recipient_name ? (
                <div style={{ fontSize: '0.88rem', color: '#475569', lineHeight: 1.6 }}>
                  <strong>{shippingAddr.recipient_name}</strong> (โทร: {shippingAddr.phone})<br />
                  {shippingAddr.address_line} {shippingAddr.subdistrict ? `ต./แขวง ${shippingAddr.subdistrict}` : ''} {shippingAddr.district ? `อ./เขต ${shippingAddr.district}` : ''}<br />
                  {shippingAddr.province} {shippingAddr.postal_code}
                  {shippingAddr.notes && <div style={{ color: '#E11D48', fontSize: '0.8rem', marginTop: '4px' }}>หมายเหตุ: {shippingAddr.notes}</div>}
                </div>
              ) : (
                <span style={{ color: '#94A3B8', fontSize: '0.88rem' }}>ที่อยู่จัดส่งตามที่แจ้งไว้กับระบบ</span>
              )}
            </div>
          </div>

          {/* Ordered Sneaker Items */}
          <div style={{ marginBottom: '28px' }}>
            <h4 style={{ fontSize: '1rem', fontWeight: 700, color: '#1E293B', marginBottom: '14px', display: 'flex', alignItems: 'center', gap: '8px' }}>
              <ShoppingBag size={18} color="#E11D48" /> รายการสินค้าในออเดอร์ ({items.length || 1} ชิ้น)
            </h4>

            <div style={{ border: '1px solid #E2E8F0', borderRadius: '12px', overflow: 'hidden' }}>
              {items.length === 0 ? (
                <div style={{ padding: '20px', textAlign: 'center', color: '#64748B', fontSize: '0.9rem' }}>
                  กำลังโหลดข้อมูลสินค้าในออเดอร์...
                </div>
              ) : (
                items.map((it, idx) => {
                  const pName = it.product_name_snapshot || it.expand?.product?.name || 'สนีกเกอร์ C-TOWN';
                  const color = it.color || it.expand?.variant?.color || 'Original';
                  const size = it.size || it.expand?.variant?.size || '-';
                  const img = it.image_snapshot || it.expand?.variant?.image_url || it.expand?.product?.main_image || '/images/products/placeholder.jpg';
                  const lineTotal = it.line_total || (it.unit_price * it.quantity);

                  return (
                    <div
                      key={it.id || idx}
                      style={{
                        display: 'flex',
                        alignItems: 'center',
                        gap: '16px',
                        padding: '14px 18px',
                        borderBottom: idx < items.length - 1 ? '1px solid #F1F5F9' : 'none',
                        background: '#fff'
                      }}
                    >
                      <img
                        src={img}
                        alt={pName}
                        style={{ width: '60px', height: '60px', objectFit: 'cover', borderRadius: '8px', border: '1px solid #E2E8F0' }}
                        onError={e => { e.target.src = '/images/products/placeholder.jpg'; }}
                      />
                      <div style={{ flex: 1 }}>
                        <h5 style={{ margin: '0 0 4px', fontSize: '0.95rem', fontWeight: 700, color: '#1E293B' }}>{pName}</h5>
                        <div style={{ fontSize: '0.82rem', color: '#64748B' }}>
                          สี: <span style={{ color: '#1E293B', fontWeight: 600 }}>{color}</span> • ไซซ์: <span style={{ color: '#1E293B', fontWeight: 600 }}>{size} EU</span>
                        </div>
                      </div>
                      <div style={{ textAlign: 'right' }}>
                        <div style={{ fontSize: '0.85rem', color: '#64748B' }}>
                          {formatPrice(it.unit_price)} × {it.quantity}
                        </div>
                        <div style={{ fontSize: '1rem', fontWeight: 700, color: '#E11D48' }}>
                          {formatPrice(lineTotal)}
                        </div>
                      </div>
                    </div>
                  );
                })
              )}
            </div>

            {/* Total Row */}
            <div style={{ display: 'flex', justifyContent: 'flex-end', alignItems: 'center', gap: '16px', marginTop: '16px', padding: '16px 20px', background: '#FFF1F2', borderRadius: '12px' }}>
              <span style={{ fontSize: '0.95rem', color: '#475569' }}>ยอดชำระสุทธิ:</span>
              <strong style={{ fontSize: '1.4rem', color: '#E11D48' }}>{formatPrice(order.grand_total)}</strong>
            </div>
          </div>

          {/* Quick Actions */}
          <div style={{ display: 'flex', flexWrap: 'wrap', gap: '12px', justifyContent: 'center' }}>
            <Link
              to={`/chat?order=${order.order_number}`}
              className="btn-primary"
              style={{ display: 'inline-flex', alignItems: 'center', gap: '8px', padding: '12px 24px', borderRadius: '10px', textDecoration: 'none' }}
            >
              <MessageCircle size={18} /> สอบถามร้านค้าเกี่ยวกับออเดอร์นี้
            </Link>
            <Link
              to="/products"
              className="btn-secondary"
              style={{ display: 'inline-flex', alignItems: 'center', gap: '8px', padding: '12px 24px', borderRadius: '10px', textDecoration: 'none' }}
            >
              <ShoppingBag size={18} /> เลือกดูสินค้าอื่นๆ
            </Link>
            <button
              type="button"
              onClick={() => { setOrder(null); setQuery(''); setSearchParams({}); }}
              className="btn-secondary"
              style={{ padding: '12px 20px', borderRadius: '10px' }}
            >
              ค้นหาออเดอร์อื่น
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
