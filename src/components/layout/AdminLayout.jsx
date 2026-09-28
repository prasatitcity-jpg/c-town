import React from 'react';
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
} from 'lucide-react';

export default function AdminLayout() {
  const { user, isAdmin, isLoggedIn, logout } = useAuth();
  const navigate = useNavigate();

  if (!isLoggedIn || !isAdmin) {
    return (
      <div className="admin-forbidden-screen">
        <div className="forbidden-card">
          <ShieldAlert size={56} className="forbidden-icon" />
          <h2>การเข้าถึงถูกจำกัด (Admin Only)</h2>
          <p>หน้านี้สงวนสิทธิ์เฉพาะผู้ดูแลระบบ C-TOWN เท่านั้น</p>
          <div className="forbidden-actions">
            <Link to="/login" className="btn-primary">เข้าสู่ระบบด้วยบัญชีแอดมิน</Link>
            <Link to="/" className="btn-secondary">กลับสู่หน้าร้านค้า</Link>
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
    { to: '/admin/products', label: 'สินค้าและสต็อก', icon: <Package size={20} /> },
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
