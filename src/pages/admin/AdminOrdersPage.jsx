import React, { useState, useEffect } from 'react';
import { useSearchParams } from 'react-router-dom';
import { pb, ctownFetch, formatPrice, formatDate, ORDER_STATUS_LABELS } from '../../lib/pb';
import {
  Search,
  Filter,
  Eye,
  CheckCircle,
  XCircle,
  Truck,
  ExternalLink,
  X,
  FileText,
} from 'lucide-react';

const STATUS_FILTERS = [
  { value: 'all', label: 'ทั้งหมด' },
  { value: 'awaiting_verification', label: 'รอตรวจสลิป' },
  { value: 'paid', label: 'ชำระแล้ว' },
  { value: 'preparing', label: 'กำลังเตรียม' },
  { value: 'packed', label: 'แพ็กแล้ว' },
  { value: 'shipped', label: 'จัดส่งแล้ว' },
  { value: 'delivered', label: 'ส่งสำเร็จ' },
  { value: 'cancelled', label: 'ยกเลิก' },
];

export default function AdminOrdersPage() {
  const [searchParams, setSearchParams] = useSearchParams();
  const [orders, setOrders] = useState([]);
  const [loading, setLoading] = useState(true);
  const [selectedOrder, setSelectedOrder] = useState(null);
  const [orderItems, setOrderItems] = useState([]);
  const [paymentProof, setPaymentProof] = useState(null);
  const [modalOpen, setModalOpen] = useState(false);
  const [updating, setUpdating] = useState(false);

  // Form inside modal for tracking
  const [trackingForm, setTrackingForm] = useState({
    shipping_carrier: 'Flash Express',
    tracking_number: '',
  });

  const currentStatus = searchParams.get('status') || 'all';
  const searchQuery = searchParams.get('search') || '';

  useEffect(() => {
    loadOrders();
  }, [currentStatus, searchQuery]);

  async function loadOrders() {
    setLoading(true);
    try {
      let filter = '';
      if (currentStatus !== 'all') {
        filter = `order_status = "${currentStatus}"`;
      }
      if (searchQuery) {
        const qFilter = `(order_number ~ "${searchQuery}" || tracking_number ~ "${searchQuery}")`;
        filter = filter ? `${filter} && ${qFilter}` : qFilter;
      }

      const res = await pb.collection('orders').getList(1, 100, {
        filter,
        sort: '-id',
      });
      setOrders(res.items);
    } catch (err) {
      console.error(err);
    } finally {
      setLoading(false);
    }
  }

  async function openOrderDetail(order) {
    setSelectedOrder(order);
    setTrackingForm({
      shipping_carrier: order.shipping_carrier || 'Flash Express',
      tracking_number: order.tracking_number || '',
    });
    setModalOpen(true);

    // Fetch order items
    try {
      const items = await pb.collection('order_items').getList(1, 50, {
        filter: `order = "${order.id}"`,
        expand: 'product,variant',
      });
      setOrderItems(items.items);
    } catch (_) {}

    // Fetch payment proof slip
    try {
      const proofs = await pb.collection('payment_proofs').getList(1, 1, {
        filter: `order = "${order.id}"`,
        sort: '-id',
      });
      setPaymentProof(proofs.items.length > 0 ? proofs.items[0] : null);
    } catch (_) {
      setPaymentProof(null);
    }
  }

  async function updateOrderStatus(orderStatus, paymentStatus = null) {
    if (!selectedOrder) return;
    setUpdating(true);
    try {
      await ctownFetch('/admin/orders/update-status', {
        method: 'POST',
        body: {
          order_id: selectedOrder.id,
          order_status: orderStatus,
          ...(paymentStatus ? { payment_status: paymentStatus } : {}),
          ...(trackingForm.shipping_carrier ? { shipping_carrier: trackingForm.shipping_carrier } : {}),
          ...(trackingForm.tracking_number ? { tracking_number: trackingForm.tracking_number } : {}),
        },
      });

      // Update local state
      setSelectedOrder(prev => ({
        ...prev,
        order_status: orderStatus,
        payment_status: paymentStatus || prev.payment_status,
        shipping_carrier: trackingForm.shipping_carrier,
        tracking_number: trackingForm.tracking_number,
      }));

      await loadOrders();
    } catch (err) {
      alert('อัปเดตสถานะไม่สำเร็จ: ' + err.message);
    } finally {
      setUpdating(false);
    }
  }

  async function handleApproveSlip() {
    if (!confirm('ยืนยันว่าการตรวจสอบยอดเงินโอนถูกต้อง และอนุมัติการชำระเงิน?')) return;
    await updateOrderStatus('preparing', 'paid');
    if (paymentProof) {
      try {
        await pb.collection('payment_proofs').update(paymentProof.id, { status: 'verified' });
      } catch (_) {}
    }
  }

  async function handleRejectSlip() {
    const reason = prompt('ระบุเหตุผลในการปฏิเสธสลิป (เช่น สลิปไม่ตรงยอด หรือ ไม่พบบัญชี):');
    if (reason === null) return;
    await updateOrderStatus('pending_payment', 'pending');
    if (paymentProof) {
      try {
        await pb.collection('payment_proofs').update(paymentProof.id, {
          status: 'rejected',
          admin_notes: reason,
        });
      } catch (_) {}
    }
  }

  const handleFilterChange = (status) => {
    const next = new URLSearchParams(searchParams);
    if (status === 'all') next.delete('status');
    else next.set('status', status);
    setSearchParams(next);
  };

  const handleSearchChange = (e) => {
    const val = e.target.value;
    const next = new URLSearchParams(searchParams);
    if (val) next.set('search', val);
    else next.delete('search');
    setSearchParams(next);
  };

  return (
    <div className="admin-orders-page">
      <div className="dashboard-header-row">
        <div>
          <h2>จัดการคำสั่งซื้อและหลักฐานการโอน (Orders)</h2>
          <p className="subtitle">ตรวจสอบสถานะ จัดส่งพัสดุ และอนุมัติสลิปโอนเงิน</p>
        </div>
      </div>

      {/* Filter and Search Bar */}
      <div className="admin-filter-bar">
        <div className="filter-chips-row">
          {STATUS_FILTERS.map(f => (
            <button
              key={f.value}
              type="button"
              className={`filter-chip-btn ${currentStatus === f.value ? 'active' : ''}`}
              onClick={() => handleFilterChange(f.value)}
            >
              {f.label}
            </button>
          ))}
        </div>

        <div className="search-box-wrap">
          <Search size={16} className="search-icon" />
          <input
            type="text"
            placeholder="ค้นหาเลขที่ออเดอร์..."
            value={searchQuery}
            onChange={handleSearchChange}
            className="admin-search-input"
          />
        </div>
      </div>

      {/* Orders Table */}
      <div className="dashboard-panel">
        <div className="table-responsive">
          <table className="admin-table">
            <thead>
              <tr>
                <th>เลขออเดอร์</th>
                <th>วันที่สั่งซื้อ</th>
                <th>ผู้รับ / โทรศัพท์</th>
                <th>ยอดรวม</th>
                <th>วิธีชำระ</th>
                <th>สถานะชำระ</th>
                <th>สถานะคำสั่งซื้อ</th>
                <th>เลขพัสดุ</th>
                <th>จัดการ</th>
              </tr>
            </thead>
            <tbody>
              {loading ? (
                <tr>
                  <td colSpan="9" className="text-center py-6">กำลังโหลดข้อมูล...</td>
                </tr>
              ) : orders.length === 0 ? (
                <tr>
                  <td colSpan="9" className="text-center py-6 text-muted">ไม่พบรายการคำสั่งซื้อ</td>
                </tr>
              ) : (
                orders.map(order => {
                  const st = ORDER_STATUS_LABELS[order.order_status] || { label: order.order_status, color: '#333', bg: '#eee' };
                  return (
                    <tr key={order.id} className={order.order_status === 'awaiting_verification' ? 'row-highlight' : ''}>
                      <td><strong>#{order.order_number}</strong></td>
                      <td>{formatDate(order.created)}</td>
                      <td>
                        <div>{order.shipping_address?.recipient_name || '-'}</div>
                        <small className="text-muted">{order.shipping_address?.phone || ''}</small>
                      </td>
                      <td><strong>{formatPrice(order.grand_total)}</strong></td>
                      <td>
                        <span className="badge-payment-method">
                          {order.payment_method === 'bank_transfer' ? 'โอนเงิน' : 'PromptPay'}
                        </span>
                      </td>
                      <td>
                        <span className={`payment-pill ${order.payment_status}`}>
                          {order.payment_status === 'paid' ? 'ชำระแล้ว' : order.payment_status === 'awaiting_verification' ? 'รอตรวจ' : 'ยังไม่ชำระ'}
                        </span>
                      </td>
                      <td>
                        <span className="status-badge" style={{ color: st.color, backgroundColor: st.bg }}>
                          {st.label}
                        </span>
                      </td>
                      <td>
                        {order.tracking_number ? (
                          <span className="tracking-code">{order.tracking_number}</span>
                        ) : (
                          <span className="text-muted">-</span>
                        )}
                      </td>
                      <td>
                        <button
                          type="button"
                          className="btn-action-view"
                          onClick={() => openOrderDetail(order)}
                          title="ดูและจัดการออเดอร์"
                        >
                          <Eye size={16} /> รายละเอียด
                        </button>
                      </td>
                    </tr>
                  );
                })
              )}
            </tbody>
          </table>
        </div>
      </div>

      {/* Order Detail Modal */}
      {modalOpen && selectedOrder && (
        <div className="modal-backdrop">
          <div className="modal-container large">
            <div className="modal-header">
              <h3>คำสั่งซื้อ #{selectedOrder.order_number}</h3>
              <button type="button" className="btn-close" onClick={() => setModalOpen(false)}>
                <X size={20} />
              </button>
            </div>

            <div className="modal-body-scroll">
              <div className="order-modal-grid">
                {/* Left: Items and shipping details */}
                <div className="modal-left-col">
                  <h4>รายการสินค้าที่สั่ง</h4>
                  <div className="order-items-table-wrap">
                    {orderItems.map(item => {
                      const v = item.expand?.variant || {};
                      const p = item.expand?.product || {};
                      return (
                        <div key={item.id} className="modal-product-item">
                          <img
                            src={v.image_url || '/images/products/placeholder.jpg'}
                            alt={p.name}
                            className="item-img"
                            onError={e => { e.target.src = '/images/products/placeholder.jpg'; }}
                          />
                          <div className="item-meta">
                            <strong>{p.name}</strong>
                            <span>SKU: {v.sku} | สี: {v.color} | ไซซ์: {v.size}</span>
                            <span>จำนวน: {item.quantity} คู่ × {formatPrice(item.unit_price)}</span>
                          </div>
                          <div className="item-price">
                            {formatPrice(item.unit_price * item.quantity)}
                          </div>
                        </div>
                      );
                    })}
                  </div>

                  <div className="modal-cost-summary">
                    <div className="row"><span>ยอดสินค้า</span><span>{formatPrice(selectedOrder.subtotal)}</span></div>
                    <div className="row"><span>ส่วนลด</span><span>- {formatPrice(selectedOrder.discount_amount || 0)}</span></div>
                    <div className="row"><span>ค่าจัดส่ง</span><span>{selectedOrder.shipping_fee === 0 ? 'ฟรี' : formatPrice(selectedOrder.shipping_fee)}</span></div>
                    <div className="row total"><span>ยอดรวมทั้งสิ้น</span><strong>{formatPrice(selectedOrder.grand_total)}</strong></div>
                  </div>

                  <h4>ที่อยู่จัดส่ง</h4>
                  <div className="address-box">
                    <strong>{selectedOrder.shipping_address?.recipient_name}</strong> ({selectedOrder.shipping_address?.phone})<br />
                    {selectedOrder.shipping_address?.address_line}, {selectedOrder.shipping_address?.subdistrict},{' '}
                    {selectedOrder.shipping_address?.district}, {selectedOrder.shipping_address?.province}{' '}
                    {selectedOrder.shipping_address?.postal_code}
                    {selectedOrder.notes && (
                      <div className="order-note-block">หมายเหตุ: {selectedOrder.notes}</div>
                    )}
                  </div>
                </div>

                {/* Right: Payment slip verification and Tracking */}
                <div className="modal-right-col">
                  <h4>หลักฐานการโอนเงิน (Slip)</h4>
                  {paymentProof ? (
                    <div className="slip-view-card">
                      <div className="slip-image-wrap">
                        {paymentProof.slip_image ? (
                          <img
                            src={`${pb.baseUrl}/api/files/payment_proofs/${paymentProof.id}/${paymentProof.slip_image}`}
                            alt="Slip"
                            className="slip-full-img"
                          />
                        ) : (
                          <div className="slip-placeholder">ไม่มีไฟล์ภาพสลิป</div>
                        )}
                      </div>
                      <div className="slip-info">
                        <div>สถานะสลิป: <strong>{paymentProof.status}</strong></div>
                        <div>ยอดโอนตามสลิป: <strong>{formatPrice(paymentProof.transfer_amount)}</strong></div>
                      </div>
                      <div className="slip-action-buttons">
                        <button
                          type="button"
                          className="btn-approve"
                          onClick={handleApproveSlip}
                          disabled={updating}
                        >
                          <CheckCircle size={16} /> อนุมัติสลิป (เตรียมของ)
                        </button>
                        <button
                          type="button"
                          className="btn-reject"
                          onClick={handleRejectSlip}
                          disabled={updating}
                        >
                          <XCircle size={16} /> ปฏิเสธสลิป
                        </button>
                      </div>
                    </div>
                  ) : (
                    <div className="no-slip-alert">
                      <FileText size={32} />
                      <p>ยังไม่มีการแนบสลิปโอนเงิน</p>
                    </div>
                  )}

                  <hr className="divider" />

                  <h4>บันทึกการจัดส่งและเลขพัสดุ</h4>
                  <div className="shipping-update-form">
                    <div className="form-group">
                      <label>ขนส่ง (Carrier)</label>
                      <select
                        value={trackingForm.shipping_carrier}
                        onChange={e => setTrackingForm({ ...trackingForm, shipping_carrier: e.target.value })}
                      >
                        <option value="Flash Express">Flash Express</option>
                        <option value="Kerry Express">Kerry Express</option>
                        <option value="Thailand Post EMS">Thailand Post EMS</option>
                        <option value="J&T Express">J&T Express</option>
                      </select>
                    </div>
                    <div className="form-group">
                      <label>หมายเลขพัสดุ (Tracking No.)</label>
                      <input
                        type="text"
                        placeholder="เช่น TH1234567890"
                        value={trackingForm.tracking_number}
                        onChange={e => setTrackingForm({ ...trackingForm, tracking_number: e.target.value })}
                      />
                    </div>

                    <button
                      type="button"
                      className="btn-primary w-100"
                      onClick={() => updateOrderStatus('shipped')}
                      disabled={updating || !trackingForm.tracking_number}
                    >
                      <Truck size={16} /> บันทึกและเปลี่ยนเป็น "จัดส่งแล้ว"
                    </button>
                  </div>

                  <hr className="divider" />

                  <h4>เปลี่ยนสถานะแบบกำหนดเอง</h4>
                  <div className="status-quick-buttons">
                    <button
                      type="button"
                      className="btn-status-sm"
                      onClick={() => updateOrderStatus('packed')}
                    >
                      แพ็กสินค้าแล้ว
                    </button>
                    <button
                      type="button"
                      className="btn-status-sm"
                      onClick={() => updateOrderStatus('delivered')}
                    >
                      จัดส่งสำเร็จแล้ว
                    </button>
                    <button
                      type="button"
                      className="btn-status-sm danger"
                      onClick={() => {
                        if (confirm('ต้องการยกเลิกคำสั่งซื้อนี้และคืนสต็อกใช่หรือไม่?')) {
                          updateOrderStatus('cancelled');
                        }
                      }}
                    >
                      ยกเลิกคำสั่งซื้อ
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
