import React, { useState, useEffect } from 'react';
import { pb, ctownFetch, formatDate } from '../../lib/pb';
import { Layers, Plus, ArrowUpRight, ArrowDownLeft, RotateCcw, AlertCircle, X } from 'lucide-react';

export default function AdminStockPage() {
  const [movements, setMovements] = useState([]);
  const [variants, setVariants] = useState([]);
  const [loading, setLoading] = useState(true);
  const [showAdjustModal, setShowAdjustModal] = useState(false);

  // Form for adjust
  const [adjustForm, setAdjustForm] = useState({
    variant_id: '',
    quantity: 1,
    notes: '',
  });

  useEffect(() => {
    loadLedger();
  }, []);

  async function loadLedger() {
    setLoading(true);
    try {
      const [mRes, vRes] = await Promise.all([
        pb.collection('stock_movements').getList(1, 100, {
          sort: '-created',
        }),
        pb.collection('product_variants').getList(1, 200, {
          expand: 'product',
        }),
      ]);
      setMovements(mRes.items);
      setVariants(vRes.items);
      if (vRes.items.length > 0 && !adjustForm.variant_id) {
        setAdjustForm(f => ({ ...f, variant_id: vRes.items[0].id }));
      }
    } catch (err) {
      console.error(err);
    } finally {
      setLoading(false);
    }
  }

  async function handleAdjustSubmit(e) {
    e.preventDefault();
    try {
      await ctownFetch('/admin/stock/adjust', {
        method: 'POST',
        body: {
          variant_id: adjustForm.variant_id,
          quantity: parseInt(adjustForm.quantity),
          notes: adjustForm.notes || 'การปรับปรุงสต็อกด้วยตนเองโดยผู้ดูแลระบบ',
        },
      });

      setShowAdjustModal(false);
      setAdjustForm({
        variant_id: variants[0]?.id || '',
        quantity: 1,
        notes: '',
      });
      await loadLedger();
    } catch (err) {
      alert('ปรับสต็อกไม่สำเร็จ: ' + err.message);
    }
  }

  const getMovementBadge = (type) => {
    switch (type) {
      case 'in':
        return <span className="movement-pill in"><ArrowUpRight size={14} /> นำเข้าสต็อก (+in)</span>;
      case 'out':
        return <span className="movement-pill out"><ArrowDownLeft size={14} /> ตัดสต็อกคำสั่งซื้อ (-out)</span>;
      case 'cancelled_restore':
        return <span className="movement-pill restore"><RotateCcw size={14} /> คืนสต็อกยกเลิก (+restore)</span>;
      case 'adjustment':
        return <span className="movement-pill adjust"><Layers size={14} /> ปรับยอดสต็อก (adjust)</span>;
      default:
        return <span className="movement-pill default">{type}</span>;
    }
  };

  return (
    <div className="admin-stock-page">
      <div className="dashboard-header-row">
        <div>
          <h2>ประวัติการเคลื่อนไหวสต็อก (Stock Ledger)</h2>
          <p className="subtitle">เก็บบันทึกประวัติการเข้า-ออกและการตัดสต็อกของสินค้าทุกรายการอย่างโปร่งใส</p>
        </div>
        <button
          type="button"
          className="btn-primary"
          onClick={() => setShowAdjustModal(true)}
          id="btn-open-adjust-modal"
        >
          <Plus size={18} /> ปรับสต็อกสินค้าด้วยตนเอง
        </button>
      </div>

      <div className="dashboard-panel">
        <div className="table-responsive">
          <table className="admin-table">
            <thead>
              <tr>
                <th>วันและเวลา</th>
                <th>SKU / รายการสินค้า</th>
                <th>ประเภทรายการ</th>
                <th>จำนวนที่เปลี่ยน</th>
                <th>คงเหลือหลังทำรายการ</th>
                <th>เลขอ้างอิง / เอกสาร</th>
                <th>หมายเหตุ</th>
              </tr>
            </thead>
            <tbody>
              {loading ? (
                <tr>
                  <td colSpan="7" className="text-center py-6">กำลังโหลดข้อมูลบัญชีสต็อก...</td>
                </tr>
              ) : movements.length === 0 ? (
                <tr>
                  <td colSpan="7" className="text-center py-6 text-muted">ยังไม่มีประวัติการเคลื่อนไหวสต็อก</td>
                </tr>
              ) : (
                movements.map(m => (
                  <tr key={m.id}>
                    <td>{formatDate(m.created)}</td>
                    <td><strong>{m.variant || '-'}</strong></td>
                    <td>{getMovementBadge(m.movement_type)}</td>
                    <td>
                      <strong className={m.quantity > 0 ? 'text-success' : 'text-danger'}>
                        {m.quantity > 0 ? `+${m.quantity}` : m.quantity} คู่
                      </strong>
                    </td>
                    <td>
                      <span className="balance-pill">{m.balance_after} คู่</span>
                    </td>
                    <td>
                      <code className="text-muted">{m.reference_id || m.reference_type || '-'}</code>
                    </td>
                    <td>{m.notes || '-'}</td>
                  </tr>
                ))
              )}
            </tbody>
          </table>
        </div>
      </div>

      {/* Adjust Modal */}
      {showAdjustModal && (
        <div className="modal-backdrop">
          <div className="modal-container">
            <div className="modal-header">
              <h3>ปรับยอดสต็อกสินค้า (Manual Adjustment)</h3>
              <button type="button" className="btn-close" onClick={() => setShowAdjustModal(false)}>
                <X size={20} />
              </button>
            </div>
            <form onSubmit={handleAdjustSubmit} className="modal-form">
              <div className="form-group">
                <label>เลือกสินค้าและไซซ์ (Variant) *</label>
                <select
                  required
                  value={adjustForm.variant_id}
                  onChange={e => setAdjustForm({ ...adjustForm, variant_id: e.target.value })}
                >
                  {variants.map(v => (
                    <option key={v.id} value={v.id}>
                      {v.expand?.product?.name || 'Product'} | {v.sku} | สี: {v.color} ไซซ์: {v.size} (เหลือ {v.stock_quantity})
                    </option>
                  ))}
                </select>
              </div>

              <div className="form-group">
                <label>จำนวนที่ต้องการปรับ (+ หรือ -) *</label>
                <input
                  type="number"
                  required
                  placeholder="เช่น 5 เพื่อเพิ่ม, -2 เพื่อลด"
                  value={adjustForm.quantity}
                  onChange={e => setAdjustForm({ ...adjustForm, quantity: e.target.value })}
                />
                <small className="text-muted">ใส่ค่าบวกเพื่อเพิ่มสต็อกเข้า หรือใส่ค่าลบเพื่อตัดสต็อกออก</small>
              </div>

              <div className="form-group">
                <label>เหตุผลหรือหมายเหตุในการปรับ *</label>
                <textarea
                  required
                  rows={2}
                  placeholder="เช่น รับของเข้าโกดังเพิ่ม, สินค้าชำรุดเสียหาย, ตรวจนับสต็อกประจำงวด"
                  value={adjustForm.notes}
                  onChange={e => setAdjustForm({ ...adjustForm, notes: e.target.value })}
                />
              </div>

              <div className="modal-footer">
                <button type="submit" className="btn-primary">ยืนยันปรับสต็อก</button>
                <button type="button" className="btn-secondary" onClick={() => setShowAdjustModal(false)}>ยกเลิก</button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
