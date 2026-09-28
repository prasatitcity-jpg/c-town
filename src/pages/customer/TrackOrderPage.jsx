import React, { useState } from 'react';
import { pb, formatPrice, formatDate, ORDER_STATUS_LABELS } from '../../lib/pb';
import { Search, Package, Clock, CheckCircle2, Truck, AlertCircle } from 'lucide-react';

export default function TrackOrderPage() {
  const [query, setQuery] = useState('');
  const [order, setOrder] = useState(null);
  const [items, setItems] = useState([]);
  const [loading, setLoading] = useState(false);
  const [searched, setSearched] = useState(false);
  const [error, setError] = useState('');

  const handleSearch = async (e) => {
    e.preventDefault();
    if (!query.trim()) return;

    setLoading(true);
    setError('');
    setSearched(true);
    setOrder(null);
    setItems([]);

    try {
      // Find by order_number or tracking_number
      const cleanQ = query.trim().replace(/^#/, '');
      const list = await pb.collection('orders').getList(1, 1, {
        filter: `order_number = "${cleanQ}" || tracking_number = "${cleanQ}"`,
      });

      if (list.items.length === 0) {
        setError('ไม่พบข้อมูลคำสั่งซื้อ กรุณาตรวจสอบหมายเลขคำสั่งซื้อหรือเลขพัสดุ');
        return;
      }

      const foundOrder = list.items[0];
      setOrder(foundOrder);

      // Fetch items
      const orderItems = await pb.collection('order_items').getList(1, 50, {
        filter: `order = "${foundOrder.id}"`,
        expand: 'product,variant',
      });
      setItems(orderItems.items);
    } catch (err) {
      console.error(err);
      setError('เกิดข้อผิดพลาดในการค้นหา');
    } finally {
      setLoading(false);
    }
  };

  const statusSteps = [
    { key: 'pending_payment', label: 'รอชำระเงิน' },
    { key: 'awaiting_verification', label: 'รอตรวจสอบสลิป' },
    { key: 'paid', label: 'ชำระเงินสำเร็จ' },
    { key: 'preparing', label: 'กำลังเตรียมสินค้า' },
    { key: 'shipped', label: 'จัดส่งแล้ว' },
    { key: 'delivered', label: 'จัดส่งสำเร็จ' },
  ];

  const getStepIndex = (status) => {
    const idx = statusSteps.findIndex(s => s.key === status);
    if (idx !== -1) return idx;
    if (status === 'packed') return 3; // between preparing and shipped
    return -1;
  };

  const currentStep = order ? getStepIndex(order.order_status) : -1;
  const isCancelled = order?.order_status === 'cancelled';

  return (
    <div className="track-order-page">
      <div className="track-hero">
        <h1>🔍 ติดตามสถานะคำสั่งซื้อ</h1>
        <p>ตรวจสอบความคืบหน้าการจัดส่งสินค้าของคุณได้ตลอด 24 ชั่วโมง</p>

        <form onSubmit={handleSearch} className="track-search-form">
          <input
            type="text"
            placeholder="กรอกหมายเลขคำสั่งซื้อ (เช่น CT-20260928-...) หรือเลขพัสดุ"
            value={query}
            onChange={e => setQuery(e.target.value)}
            className="track-input"
            id="track-query-input"
          />
          <button type="submit" className="btn-primary track-btn" disabled={loading} id="btn-track-submit">
            <Search size={18} /> {loading ? 'กำลังค้นหา...' : 'ตรวจสอบ'}
          </button>
        </form>
      </div>

      <div className="track-content">
        {error && (
          <div className="track-error-card">
            <AlertCircle size={28} />
            <p>{error}</p>
          </div>
        )}

        {order && (
          <div className="track-result-card">
            <div className="track-header-bar">
              <div>
                <span className="track-order-label">หมายเลขคำสั่งซื้อ</span>
                <h2 className="track-order-no">#{order.order_number}</h2>
                <span className="track-date">สั่งซื้อเมื่อ {formatDate(order.created)}</span>
              </div>
              <div className="track-status-pill" style={{
                color: ORDER_STATUS_LABELS[order.order_status]?.color || '#333',
                background: ORDER_STATUS_LABELS[order.order_status]?.bg || '#f3f4f6'
              }}>
                {ORDER_STATUS_LABELS[order.order_status]?.label || order.order_status}
              </div>
            </div>

            {/* Tracking timeline */}
            {!isCancelled ? (
              <div className="track-timeline">
                {statusSteps.map((step, idx) => {
                  const isDone = currentStep >= idx;
                  const isCurrent = currentStep === idx;
                  return (
                    <div key={step.key} className={`timeline-node ${isDone ? 'done' : ''} ${isCurrent ? 'current' : ''}`}>
                      <div className="node-icon">
                        {isDone ? <CheckCircle2 size={18} /> : <span>{idx + 1}</span>}
                      </div>
                      <div className="node-label">{step.label}</div>
                      {idx < statusSteps.length - 1 && <div className="node-connector" />}
                    </div>
                  );
                })}
              </div>
            ) : (
              <div className="track-cancelled-notice">
                ⚠️ คำสั่งซื้อนี้ถูกยกเลิกแล้ว
              </div>
            )}

            {/* Delivery Info */}
            <div className="track-delivery-details">
              <div className="delivery-col">
                <h4><Truck size={16} /> ข้อมูลการจัดส่ง</h4>
                <p><strong>ผู้ให้บริการ:</strong> {order.shipping_carrier || 'Flash Express / Kerry'}</p>
                <p>
                  <strong>เลขพัสดุ (Tracking No.):</strong>{' '}
                  {order.tracking_number ? (
                    <span className="tracking-highlight">{order.tracking_number}</span>
                  ) : (
                    <span className="text-muted">กำลังเตรียมจัดส่ง</span>
                  )}
                </p>
              </div>
              <div className="delivery-col">
                <h4><Package size={16} /> ที่อยู่ปลายทาง</h4>
                {order.shipping_address ? (
                  <p>
                    {order.shipping_address.recipient_name} ({order.shipping_address.phone})<br />
                    {order.shipping_address.address_line}, {order.shipping_address.subdistrict},{' '}
                    {order.shipping_address.district}, {order.shipping_address.province} {order.shipping_address.postal_code}
                  </p>
                ) : (
                  <p>-</p>
                )}
              </div>
            </div>

            {/* Items summary */}
            <div className="track-items-summary">
              <h4>รายการสินค้า ({items.length} รายการ)</h4>
              <div className="track-items-list">
                {items.map(it => {
                  const variant = it.expand?.variant || {};
                  const product = it.expand?.product || {};
                  return (
                    <div key={it.id} className="track-item-row">
                      <img
                        src={variant.image_url || '/images/products/placeholder.jpg'}
                        alt={product.name}
                        className="track-item-thumb"
                        onError={e => { e.target.src = '/images/products/placeholder.jpg'; }}
                      />
                      <div className="track-item-meta">
                        <span className="name">{product.name}</span>
                        <span className="specs">{variant.color} • ไซซ์ {variant.size} • จำนวน: {it.quantity}</span>
                      </div>
                      <span className="price">{formatPrice(it.unit_price * it.quantity)}</span>
                    </div>
                  );
                })}
              </div>
              <div className="track-total-row">
                <span>ยอดชำระสุทธิ</span>
                <strong>{formatPrice(order.grand_total)}</strong>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
