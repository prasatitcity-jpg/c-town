import React, { useState } from 'react';
import { NavLink, Link, useNavigate, Outlet } from 'react-router-dom';
import { useAuth } from '../../contexts/AuthContext';
import {
  LayoutDashboard,
  Package,
  ShoppingBag,
  Layers,
  Tag,
  MessageSquare,
  ArrowLeft,
  LogOut,
  ShieldAlert,
  Lock,
} from 'lucide-react';

export default function AdminLayout() {
  const { user, isAdmin, isLoggedIn, logout, loginWithPin } = useAuth();
  const navigate = useNavigate();
  const [pin, setPin] = useState('');
  const [pinError, setPinError] = useState('');
  const [pinLoading, setPinLoading] = useState(false);

  const handleInlinePin = async (e) => {
    e.preventDefault();
    setPinError('');
    setPinLoading(true);
    try {
      await loginWithPin(pin);
    } catch (err) {
      setPinError(err.message || 'รหัส PIN ไม่ถูกต้อง (PIN เริ่มต้นคือ 1111)');
    } finally {
      setPinLoading(false);
    }
  };

  if (!isLoggedIn || !isAdmin) {
    return (
      <div className="admin-forbidden-screen" style={{ minHeight: '80vh', display: 'flex', alignItems: 'center', justifyContent: 'center', padding: '20px' }}>
        <div className="forbidden-card" style={{ maxWidth: '440px', width: '100%', background: '#fff', borderRadius: '16px', padding: '32px', boxShadow: '0 10px 25px rgba(0,0,0,0.08)', textAlign: 'center', border: '1px solid #f1f5f9' }}>
          <div style={{ width: '64px', height: '64px', background: '#FFF1F2', borderRadius: '50%', display: 'flex', alignItems: 'center', justifyContent: 'center', margin: '0 auto 16px' }}>
            <Lock size={32} color="#E11D48" />
          </div>
          <h2 style={{ fontSize: '1.4rem', fontWeight: 700, color: '#1E293B', marginBottom: '8px' }}>เข้าสู่ระบบผู้ดูแลระบบ (Admin)</h2>
          <p style={{ color: '#64748B', fontSize: '0.9rem', marginBottom: '24px' }}>หน้านี้สงวนสิทธิ์เฉพาะแอดมิน กรุณากรอกรหัส PIN เพื่อเข้าใช้งาน</p>

          <form onSubmit={handleInlinePin} style={{ marginBottom: '20px' }}>
            {pinError && (
              <div style={{ background: '#FEE2E2', color: '#B91C1C', padding: '10px 14px', borderRadius: '8px', fontSize: '0.85rem', marginBottom: '14px', textAlign: 'left' }}>
                {pinError}
              </div>
            )}
            <div style={{ marginBottom: '16px' }}>
              <input
                autoFocus
                type="password"
                maxLength={4}
                placeholder="กรอกรหัส PIN (1111)"
                value={pin}
                onChange={e => setPin(e.target.value.replace(/\D/g, ''))}
                style={{
                  width: '100%',
                  textAlign: 'center',
                  fontSize: '1.5rem',
                  letterSpacing: '8px',
                  padding: '12px',
                  borderRadius: '10px',
                  border: '2px solid #E2E8F0',
                  outline: 'none',
                }}
              />
            </div>
            <button
              type="submit"
              disabled={pin.length < 4 || pinLoading}
              style={{
                width: '100%',
                padding: '12px',
                borderRadius: '10px',
                background: '#E11D48',
                color: '#fff',
                fontWeight: 600,
                border: 'none',
                cursor: pin.length < 4 || pinLoading ? 'not-allowed' : 'pointer',
                opacity: pin.length < 4 || pinLoading ? 0.7 : 1
              }}
            >
              {pinLoading ? 'กำลังตรวจสอบ...' : 'ยืนยันรหัส PIN (เข้าหลังบ้าน)'}
            </button>
          </form>

          <div style={{ display: 'flex', gap: '12px', justifyContent: 'center' }}>
            <Link to="/login" style={{ fontSize: '0.85rem', color: '#64748B', textDecoration: 'underline' }}>ล็อกอินด้วยอีเมล</Link>
            <span style={{ color: '#CBD5E1' }}>•</span>
            <Link to="/" style={{ fontSize: '0.85rem', color: '#E11D48', textDecoration: 'none' }}>กลับสู่หน้าร้านค้า</Link>
          </div>
        </div>
      </div>
    );
  }

  const handleLogout = () => {
    logout();
    navigate('/');
  };

  const navItems = [
    { to: '/admin', end: true, label: 'แดชบอร์ดสรุปผล', icon: <LayoutDashboard size={20} /> },
    { to: '/admin/orders', label: 'จัดการคำสั่งซื้อ & สลิป', icon: <ShoppingBag size={20} /> },
    { to: '/admin/products', label: 'จัดการสินค้าและสต็อก', icon: <Package size={20} /> },
    { to: '/admin/stock', label: 'ประวัติเคลื่อนไหวสต็อก (Ledger)', icon: <Layers size={20} /> },
    { to: '/admin/coupons', label: 'คูปองและโปรโมชั่น', icon: <Tag size={20} /> },
    { to: '/admin/chat', label: 'ศูนย์ตอบแชตลูกค้า', icon: <MessageSquare size={20} /> },
  ];

  return (
    <div className="admin-shell">
      {/* Sidebar */}
      <aside className="admin-sidebar">
        <div className="admin-sidebar-header">
          <Link to="/" className="admin-logo">
            <span className="logo-c">C</span>
            <span className="logo-town">-TOWN</span>
          </Link>
          <span className="admin-portal-badge">ADMIN PORTAL</span>
        </div>

        <nav className="admin-nav-list">
          {navItems.map(item => (
            <NavLink
              key={item.to}
              to={item.to}
              end={item.end}
              className={({ isActive }) => `admin-nav-item ${isActive ? 'active' : ''}`}
            >
              {item.icon}
              <span>{item.label}</span>
            </NavLink>
          ))}
        </nav>

        <div className="admin-sidebar-footer">
          <Link to="/" className="admin-nav-item return-link">
            <ArrowLeft size={18} />
            <span>กลับหน้าร้านค้า</span>
          </Link>
          <button type="button" onClick={handleLogout} className="admin-nav-item logout-link">
            <LogOut size={18} />
            <span>ออกจากระบบ</span>
          </button>
        </div>
      </aside>

      {/* Main Area */}
      <div className="admin-main-wrap">
        <header className="admin-topbar">
          <div className="topbar-title">ระบบจัดการหลังบ้าน C-TOWN SNEAKER</div>
          <div className="admin-profile-pill">
            <div className="admin-avatar">AD</div>
            <div className="admin-meta">
              <span className="admin-name">{user?.name || 'Administrator'}</span>
              <span className="admin-role">Super Admin</span>
            </div>
          </div>
        </header>

        <main className="admin-content-area">
          <Outlet />
        </main>
      </div>
    </div>
  );
}
