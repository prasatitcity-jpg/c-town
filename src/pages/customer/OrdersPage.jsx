import React, { useState, useEffect } from 'react';
import { pb, formatPrice, formatDate, ORDER_STATUS_LABELS } from '../../lib/pb';
import { useAuth } from '../../contexts/AuthContext';
import { useNavigate, Link } from 'react-router-dom';
import { Package, ChevronDown, ChevronUp } from 'lucide-react';

export default function OrdersPage() {
  const { user, isLoggedIn } = useAuth();
  const navigate = useNavigate();
  const [orders, setOrders] = useState([]);
  const [loading, setLoading] = useState(true);
  const [expanded, setExpanded] = useState(null);

  useEffect(() => {
    if (!isLoggedIn) { navigate('/login'); return; }
    loadOrders();
  }, [isLoggedIn]);

  async function loadOrders() {
    setLoading(true);
    try {
      const result = await pb.collection('orders').getList(1, 50, {
        filter: `user = "${user.id}"`,
        sort: '-id',
        expand: 'payment_proofs_via_order',
      });
      setOrders(result.items);
    } catch (err) {
      console.error(err);
    } finally {
      setLoading(false);
    }
  }

  async function loadItems(orderId) {
    if (expanded === orderId) { setExpanded(null); return; }
    try {
      const items = await pb.collection('order_items').getList(1, 50, {
        filter: `order = "${orderId}"`,
        expand: 'product,variant',
      });
      setOrders(prev => prev.map(o => o.id === orderId ? { ...o, items: items.items } : o));
      setExpanded(orderId);
    } catch (err) { console.error(err); }
  }

  if (!isLoggedIn) return null;

  const statusInfo = (status) => ORDER_STATUS_LABELS[status] || { label: status, color: '#666', bg: '#eee' };

  return (
    <div className="orders-page">
      <div className="orders-header">
        <h1><Package size={26} /> คำสั่งซื้อของฉัน</h1>
        <Link to="/track-order" className="btn-track-order" id="link-track-order">🔍 ติดตามพัสดุ</Link>
      </div>

      {loading ? (
        <div className="orders-loading"><div className="spinner" /></div>
      ) : orders.length === 0 ? (
        <div className="orders-empty">
          <Package size={56} strokeWidth={1} />
          <h3>ยังไม่มีคำสั่งซื้อ</h3>
          <Link to="/products" className="btn-primary" id="btn-start-shopping">เริ่มช้อปเลย</Link>
        </div>
      ) : (
        <div className="orders-list">
          {orders.map(order => {
            const st = statusInfo(order.order_status);
            const isOpen = expanded === order.id;
            return (
              <div key={order.id} className="order-card">
                <div className="order-card-header" onClick={() => loadItems(order.id)}>
                  <div className="order-info">
                    <span className="order-number">#{order.order_number}</span>
                    <span className="order-date">{formatDate(order.created)}</span>
                  </div>
                  <div className="order-status-badge" style={{ color: st.color, background: st.bg }}>
                    {st.label}
                  </div>
                  <div className="order-total">{formatPrice(order.grand_total)}</div>
                  <button className="order-expand-btn" id={`expand-${order.id}`}>
                    {isOpen ? <ChevronUp size={18} /> : <ChevronDown size={18} />}
                  </button>
                </div>

                {isOpen && (
                  <div className="order-card-body">
                    {/* Items */}
                    {order.items?.map(item => {
                      const variant = item.expand?.variant || {};
                      const product = item.expand?.product || {};
                      return (
                        <div key={item.id} className="order-item">
                          <img
                            src={variant.image_url || '/images/products/placeholder.jpg'}
                            alt={product.name}
                            className="order-item-img"
                            onError={e => { e.target.src = '/images/products/placeholder.jpg'; }}
                          />
                          <div className="order-item-details">
                            <strong>{product.name}</strong>
                            <span>{variant.color} | ไซซ์ {variant.size}</span>
                            <span>× {item.quantity}</span>
                          </div>
                          <span className="order-item-price">{formatPrice(item.unit_price * item.quantity)}</span>
                        </div>
                      );
                    })}

                    {/* Totals */}
                    <div className="order-totals-mini">
                      <div><span>ส่วนลด</span><span>- {formatPrice(order.discount_amount || 0)}</span></div>
                      <div><span>ค่าจัดส่ง</span><span>{order.shipping_fee === 0 ? 'ฟรี' : formatPrice(order.shipping_fee)}</span></div>
                      <div className="bold"><span>รวมสุทธิ</span><span>{formatPrice(order.grand_total)}</span></div>
                    </div>

                    {/* Shipping address */}
                    {order.shipping_address && (
                      <div className="order-address">
                        <strong>ที่อยู่จัดส่ง:</strong>
                        <p>{JSON.stringify(order.shipping_address)
                          .replace(/[{}"]/g, '')
                          .replace(/,/g, ', ')
                          .replace(/:/g, ': ')}</p>
                      </div>
                    )}

                    {/* Tracking */}
                    {order.tracking_number && (
                      <div className="order-tracking">
                        <strong>เลขติดตาม:</strong> {order.tracking_number} ({order.shipping_carrier || ''})
                      </div>
                    )}

                    {/* Chat link */}
                    <div className="order-actions">
                      <Link to="/chat" className="btn-chat-support" id={`order-chat-${order.id}`}>
                        💬 ติดต่อร้าน
                      </Link>
                    </div>
                  </div>
                )}
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
}
