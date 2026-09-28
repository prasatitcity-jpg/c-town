import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { ctownFetch, formatPrice, formatDate, ORDER_STATUS_LABELS } from '../../lib/pb';
import {
  TrendingUp,
  ShoppingBag,
  Clock,
  AlertTriangle,
  ArrowRight,
  Eye,
  CheckCircle,
} from 'lucide-react';

export default function AdminDashboardPage() {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  useEffect(() => {
    loadDashboard();
  }, []);

  async function loadDashboard() {
    setLoading(true);
    try {
      const res = await ctownFetch('/admin/dashboard');
      setData(res);
    } catch (err) {
      console.error(err);
      setError(err.message || 'โหลดข้อมูลแดชบอร์ดไม่สำเร็จ');
    } finally {
      setLoading(false);
    }
  }

  if (loading) return <div className="admin-loading-screen"><div className="spinner" /></div>;
  if (error) {
    return (
      <div className="admin-dashboard-page">
        <div className="admin-error-box p-4 bg-white rounded shadow-sm border text-center my-4">
          <AlertTriangle size={36} className="text-danger mb-2 mx-auto" />
          <h3 className="mb-2">เกิดข้อผิดพลาดในการโหลดแดชบอร์ด</h3>
          <p className="text-muted mb-3">{error}</p>
          <div className="d-flex gap-2 justify-content-center">
            <button type="button" onClick={loadDashboard} className="btn-primary btn-sm">
              ลองใหม่อีกครั้ง
            </button>
            <Link to="/login" className="btn-secondary btn-sm">
              ไปหน้าเข้าสู่ระบบผู้ดูแล
            </Link>
          </div>
        </div>
      </div>
    );
  }

  const stats = data?.stats || {};
  const recentOrders = data?.recent_orders || [];
  const lowStock = data?.low_stock_variants || [];

  return (
    <div className="admin-dashboard-page">
      <div className="dashboard-header-row">
        <div>
          <h2>ภาพรวมร้านค้า (Overview)</h2>
          <p className="subtitle">สรุปผลยอดขาย คำสั่งซื้อ และสถานะสต็อกปัจจุบัน</p>
        </div>
        <button onClick={loadDashboard} className="btn-secondary btn-sm">
          รีเฟรชข้อมูล
        </button>
      </div>

      {/* KPI Cards */}
      <div className="kpi-grid">
        <div className="kpi-card highlight-card">
          <div className="kpi-icon-wrap rose">
            <TrendingUp size={24} />
          </div>
          <div className="kpi-data">
            <span className="kpi-label">ยอดขายรวมทั้งหมด</span>
            <h3 className="kpi-value">{formatPrice(stats.total_revenue || 0)}</h3>
            <span className="kpi-note">จากคำสั่งซื้อที่ชำระเงินแล้ว</span>
          </div>
        </div>

        <div className="kpi-card">
          <div className="kpi-icon-wrap blue">
            <ShoppingBag size={24} />
          </div>
          <div className="kpi-data">
            <span className="kpi-label">คำสั่งซื้อทั้งหมด</span>
            <h3 className="kpi-value">{stats.total_orders || 0} รายการ</h3>
            <span className="kpi-note">ออเดอร์ในระบบทั้งหมด</span>
          </div>
        </div>

        <div className="kpi-card">
          <div className="kpi-icon-wrap orange">
            <Clock size={24} />
          </div>
          <div className="kpi-data">
            <span className="kpi-label">รอตรวจสอบสลิป</span>
            <h3 className="kpi-value text-orange">{stats.pending_verification_count || 0} รายการ</h3>
            <Link to="/admin/orders?status=awaiting_verification" className="kpi-action-link">
              ไปตรวจสอบสลิป <ArrowRight size={14} />
            </Link>
          </div>
        </div>

        <div className="kpi-card">
          <div className="kpi-icon-wrap red">
            <AlertTriangle size={24} />
          </div>
          <div className="kpi-data">
            <span className="kpi-label">สินค้าใกล้หมด (Low Stock)</span>
            <h3 className="kpi-value text-red">{stats.low_stock_count || 0} รายการ</h3>
            <Link to="/admin/products" className="kpi-action-link">
              จัดการสต็อก <ArrowRight size={14} />
            </Link>
          </div>
        </div>
      </div>

      {/* Two Column Section */}
      <div className="dashboard-split-grid">
        {/* Recent Orders */}
        <div className="dashboard-panel">
          <div className="panel-header">
            <h3>คำสั่งซื้อล่าสุด</h3>
            <Link to="/admin/orders" className="panel-more-link">
              ดูทั้งหมด <ArrowRight size={14} />
            </Link>
          </div>

          <div className="table-responsive">
            <table className="admin-table">
              <thead>
                <tr>
                  <th>หมายเลขออเดอร์</th>
                  <th>ลูกค้า</th>
                  <th>ยอดรวม</th>
                  <th>สถานะ</th>
                  <th>วันที่</th>
                  <th>จัดการ</th>
                </tr>
              </thead>
              <tbody>
                {recentOrders.length === 0 ? (
                  <tr>
                    <td colSpan="6" className="text-center py-4 text-muted">ยังไม่มีคำสั่งซื้อ</td>
                  </tr>
                ) : (
                  recentOrders.map(o => {
                    const st = ORDER_STATUS_LABELS[o.order_status] || { label: o.order_status, color: '#333', bg: '#eee' };
                    return (
                      <tr key={o.id}>
                        <td><strong>#{o.order_number}</strong></td>
                        <td>{o.shipping_address?.recipient_name || o.shipping_address_snapshot?.recipient_name || '-'}</td>
                        <td><strong>{formatPrice(o.grand_total)}</strong></td>
                        <td>
                          <span className="status-badge" style={{ color: st.color, backgroundColor: st.bg }}>
                            {st.label}
                          </span>
                        </td>
                        <td>{formatDate(o.created)}</td>
                        <td>
                          <Link to={`/admin/orders?search=${o.order_number}`} className="btn-icon" title="ดูรายละเอียด">
                            <Eye size={16} />
                          </Link>
                        </td>
                      </tr>
                    );
                  })
                )}
              </tbody>
            </table>
          </div>
        </div>

        {/* Low Stock Alert */}
        <div className="dashboard-panel">
          <div className="panel-header">
            <h3>แจ้งเตือนสต็อกเหลือน้อย (น้อยกว่า 5 คู่)</h3>
            <Link to="/admin/stock" className="panel-more-link">
              ประวัติสต็อก <ArrowRight size={14} />
            </Link>
          </div>

          <div className="low-stock-list">
            {lowStock.length === 0 ? (
              <div className="empty-low-stock">
                <CheckCircle size={32} className="text-success" />
                <p>ระดับสต็อกสินค้าทุกรายการอยู่ในเกณฑ์ปกติ</p>
              </div>
            ) : (
              lowStock.map(v => (
                <div key={v.id} className="low-stock-item">
                  <div className="stock-info">
                    <strong>SKU: {v.sku}</strong>
                    <span>สี {v.color} • ไซซ์ {v.size}</span>
                  </div>
                  <div className="stock-badge-pill danger">
                    เหลือ {v.stock_quantity} คู่
                  </div>
                </div>
              ))
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
