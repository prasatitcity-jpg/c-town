import React, { useState, useEffect } from 'react';
import { pb, formatPrice, formatDate } from '../../lib/pb';
import { Plus, Tag, Trash2, X, Check, Calendar } from 'lucide-react';

export default function AdminCouponsPage() {
  const [coupons, setCoupons] = useState([]);
  const [loading, setLoading] = useState(true);
  const [showAddModal, setShowAddModal] = useState(false);

  const [form, setForm] = useState({
    code: '',
    name: '',
    discount_type: 'fixed_amount',
    discount_value: 100,
    min_order_amount: 1000,
    max_discount: 0,
    usage_limit: 100,
    is_active: true,
  });

  useEffect(() => {
    loadCoupons();
  }, []);

  async function loadCoupons() {
    setLoading(true);
    try {
      const res = await pb.collection('coupons').getList(1, 50, {
        sort: '-created',
      });
      setCoupons(res.items);
    } catch (err) {
      console.error(err);
    } finally {
      setLoading(false);
    }
  }

  async function handleCreateCoupon(e) {
    e.preventDefault();
    try {
      await pb.collection('coupons').create({
        ...form,
        code: form.code.toUpperCase().trim(),
        discount_value: parseFloat(form.discount_value),
        min_order_amount: parseFloat(form.min_order_amount) || 0,
        max_discount: parseFloat(form.max_discount) || 0,
        usage_limit: parseInt(form.usage_limit) || 0,
        used_count: 0,
      });

      setShowAddModal(false);
      setForm({
        code: '',
        name: '',
        discount_type: 'fixed_amount',
        discount_value: 100,
        min_order_amount: 1000,
        max_discount: 0,
        usage_limit: 100,
        is_active: true,
      });
      await loadCoupons();
    } catch (err) {
      alert('สร้างคูปองไม่สำเร็จ: ' + err.message);
    }
  }

  async function toggleActive(coupon) {
    try {
      await pb.collection('coupons').update(coupon.id, {
        is_active: !coupon.is_active,
      });
      await loadCoupons();
    } catch (err) {
      alert('แก้ไขสถานะไม่สำเร็จ');
    }
  }

  async function handleDelete(id) {
    if (!confirm('ยืนยันลบคูปองส่วนลดนี้?')) return;
    try {
      await pb.collection('coupons').delete(id);
      await loadCoupons();
    } catch (err) {
      alert('ลบไม่สำเร็จ: ' + err.message);
    }
  }

  return (
    <div className="admin-coupons-page">
      <div className="dashboard-header-row">
        <div>
          <h2>คูปองและโปรโมชั่น (Coupons & Promos)</h2>
          <p className="subtitle">สร้างและจัดการโค้ดส่วนลดสำหรับส่งเสริมการขาย</p>
        </div>
        <button
          type="button"
          className="btn-primary"
          onClick={() => setShowAddModal(true)}
          id="btn-add-coupon"
        >
          <Plus size={18} /> สร้างโค้ดคูปองใหม่
        </button>
      </div>

      <div className="dashboard-panel">
        <div className="table-responsive">
          <table className="admin-table">
            <thead>
              <tr>
                <th>โค้ดส่วนลด</th>
                <th>ชื่อ / คำอธิบาย</th>
                <th>ประเภทส่วนลด</th>
                <th>มูลค่าส่วนลด</th>
                <th>ยอดสั่งซื้อขั้นต่ำ</th>
                <th>ใช้ไปแล้ว / สิทธิ์ทั้งหมด</th>
                <th>สถานะ</th>
                <th>จัดการ</th>
              </tr>
            </thead>
            <tbody>
              {loading ? (
                <tr><td colSpan="8" className="text-center py-6">กำลังโหลดข้อมูล...</td></tr>
              ) : coupons.length === 0 ? (
                <tr><td colSpan="8" className="text-center py-6 text-muted">ยังไม่มีคูปองส่วนลด</td></tr>
              ) : (
                coupons.map(c => (
                  <tr key={c.id}>
                    <td>
                      <span className="coupon-code-pill">{c.code}</span>
                    </td>
                    <td><strong>{c.name || '-'}</strong></td>
                    <td>
                      {c.discount_type === 'fixed_amount' ? 'ลดตามจำนวนเงิน' :
                       c.discount_type === 'percentage' ? 'ลดเป็นเปอร์เซ็นต์' :
                       'ส่งฟรี'}
                    </td>
                    <td>
                      <strong>
                        {c.discount_type === 'percentage'
                          ? `${c.discount_value}%`
                          : formatPrice(c.discount_value)}
                      </strong>
                    </td>
                    <td>{c.min_order_amount > 0 ? formatPrice(c.min_order_amount) : 'ไม่มีขั้นต่ำ'}</td>
                    <td>
                      <span>{c.used_count || 0} / {c.usage_limit || 'ไม่จำกัด'}</span>
                    </td>
                    <td>
                      <button
                        type="button"
                        className={`toggle-active-btn ${c.is_active ? 'active' : 'inactive'}`}
                        onClick={() => toggleActive(c)}
                      >
                        {c.is_active ? 'เปิดใช้งาน' : 'ปิดใช้งาน'}
                      </button>
                    </td>
                    <td>
                      <button
                        type="button"
                        className="btn-icon-danger"
                        title="ลบคูปอง"
                        onClick={() => handleDelete(c.id)}
                      >
                        <Trash2 size={16} />
                      </button>
                    </td>
                  </tr>
                ))
              )}
            </tbody>
          </table>
        </div>
      </div>

      {/* Add Coupon Modal */}
      {showAddModal && (
        <div className="modal-backdrop">
          <div className="modal-container">
            <div className="modal-header">
              <h3>สร้างคูปองส่วนลดใหม่</h3>
              <button type="button" className="btn-close" onClick={() => setShowAddModal(false)}>
                <X size={20} />
              </button>
            </div>
            <form onSubmit={handleCreateCoupon} className="modal-form">
              <div className="form-group">
                <label>รหัสโค้ด (เช่น FLASH50, WELCOME) *</label>
                <input
                  type="text"
                  required
                  placeholder="WELCOME100"
                  value={form.code}
                  onChange={e => setForm({ ...form, code: e.target.value })}
                />
              </div>

              <div className="form-group">
                <label>ชื่อหรือคำอธิบายโปรโมชั่น *</label>
                <input
                  type="text"
                  required
                  placeholder="ส่วนลดต้อนรับสมาชิกใหม่"
                  value={form.name}
                  onChange={e => setForm({ ...form, name: e.target.value })}
                />
              </div>

              <div className="form-row">
                <div className="form-group">
                  <label>ประเภทส่วนลด *</label>
                  <select
                    value={form.discount_type}
                    onChange={e => setForm({ ...form, discount_type: e.target.value })}
                  >
                    <option value="fixed_amount">ลดตามจำนวนเงิน (บาท)</option>
                    <option value="percentage">ลดเป็นเปอร์เซ็นต์ (%)</option>
                    <option value="free_shipping">จัดส่งฟรี (Free Shipping)</option>
                  </select>
                </div>
                <div className="form-group">
                  <label>มูลค่าส่วนลด *</label>
                  <input
                    type="number"
                    required
                    min={0}
                    value={form.discount_value}
                    onChange={e => setForm({ ...form, discount_value: e.target.value })}
                  />
                </div>
              </div>

              <div className="form-row">
                <div className="form-group">
                  <label>ยอดสั่งซื้อขั้นต่ำ (บาท)</label>
                  <input
                    type="number"
                    min={0}
                    value={form.min_order_amount}
                    onChange={e => setForm({ ...form, min_order_amount: e.target.value })}
                  />
                </div>
                <div className="form-group">
                  <label>จำกัดจำนวนสิทธิ์ (ครั้ง)</label>
                  <input
                    type="number"
                    min={1}
                    value={form.usage_limit}
                    onChange={e => setForm({ ...form, usage_limit: e.target.value })}
                  />
                </div>
              </div>

              <div className="modal-footer">
                <button type="submit" className="btn-primary">สร้างคูปอง</button>
                <button type="button" className="btn-secondary" onClick={() => setShowAddModal(false)}>ยกเลิก</button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
