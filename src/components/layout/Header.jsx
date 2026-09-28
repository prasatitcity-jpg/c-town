import React, { useState } from 'react';
import { Link, useNavigate, useLocation } from 'react-router-dom';
import {
  ShoppingBag,
  User,
  Search,
  Menu,
  X,
  ChevronDown,
  MessageCircle,
  Package,
  Lock,
  Home,
  Compass,
} from 'lucide-react';
import { useAuth } from '../../contexts/AuthContext';
import { useCart } from '../../contexts/CartContext';

export default function Header({ onSearch }) {
  const { user, isLoggedIn, isAdmin, logout, loginWithPin } = useAuth();
  const { totalItems } = useCart();
  const navigate = useNavigate();
  const location = useLocation();

  const [mobileOpen, setMobileOpen] = useState(false);
  const [searchOpen, setSearchOpen] = useState(false);
  const [searchQuery, setSearchQuery] = useState('');
  const [userMenuOpen, setUserMenuOpen] = useState(false);

  // Admin PIN modal state
  const [pinModalOpen, setPinModalOpen] = useState(false);
  const [adminPin, setAdminPin] = useState('');
  const [pinError, setPinError] = useState('');
  const [pinLoading, setPinLoading] = useState(false);

  const handleSearch = (e) => {
    e.preventDefault();
    if (searchQuery.trim()) {
      navigate(`/products?search=${encodeURIComponent(searchQuery.trim())}`);
      setSearchOpen(false);
      setSearchQuery('');
    }
  };

  const handlePinSubmit = async (e) => {
    e.preventDefault();
    setPinError('');
    setPinLoading(true);
    try {
      await loginWithPin(adminPin);
      setPinModalOpen(false);
      setAdminPin('');
      navigate('/admin');
    } catch (err) {
      setPinError(err.message || 'รหัส PIN ไม่ถูกต้อง');
    } finally {
      setPinLoading(false);
    }
  };

  const navLinks = [
    { to: '/', label: 'หน้าแรก' },
    { to: '/products', label: 'สินค้าทั้งหมด' },
    { to: '/promotions', label: 'โปรโมชั่น' },
    { to: '/track-order', label: 'ติดตามคำสั่งซื้อ' },
    { to: '/contact', label: 'ติดต่อร้าน' },
  ];

  return (
    <>
      <header className="ctown-header">
        <div className="header-top-bar">
          <div className="top-bar-container">
            <span className="top-bar-notice">🌸 ส่งฟรีเมื่อสั่งซื้อครบ ฿2,500 | เปิดทุกวัน 10:00–21:00</span>
            <div className="top-bar-right-links">
              <button
                type="button"
                className="top-bar-admin-btn"
                onClick={() => setPinModalOpen(true)}
                id="btn-topbar-admin-pin"
              >
                <Lock size={12} /> เข้าสู่ระบบผู้ดูแล
              </button>
            </div>
          </div>
        </div>

        <div className="header-main">
          {/* Logo */}
          <Link to="/" className="header-logo">
            <span className="logo-c">C</span>
            <span className="logo-town">-TOWN</span>
          </Link>

          {/* Desktop Nav */}
          <nav className="header-nav desktop-nav">
            {navLinks.map(link => (
              <Link
                key={link.to}
                to={link.to}
                className={`nav-link${location.pathname === link.to ? ' active' : ''}`}
              >
                {link.label}
              </Link>
            ))}
          </nav>

          {/* Right Corner: Search, Cart, Login / Account */}
          <div className="header-right-zone">
            {/* Search */}
            <button
              type="button"
              className="icon-btn search-toggle-btn"
              onClick={() => setSearchOpen(!searchOpen)}
              title="ค้นหาสินค้า"
              id="btn-search-toggle"
            >
              <Search size={19} />
            </button>

            {/* Cart */}
            <Link to="/cart" className="icon-btn cart-btn" title="ตะกร้าสินค้า" id="btn-cart">
              <ShoppingBag size={19} />
              {totalItems > 0 && (
                <span className="cart-badge">{totalItems > 99 ? '99+' : totalItems}</span>
              )}
            </Link>

            {/* User Auth Section at the Far Top-Right */}
            <div className="header-auth-corner">
              {isLoggedIn ? (
                <div className="user-menu-wrapper">
                  <button
                    type="button"
                    className="user-pill-btn"
                    onClick={() => setUserMenuOpen(!userMenuOpen)}
                    id="btn-user-menu"
                  >
                    <div className="avatar-mini">
                      {isAdmin ? 'AD' : (user?.name ? user.name[0].toUpperCase() : 'U')}
                    </div>
                    <div className="user-pill-text">
                      <span className="user-greeting">สวัสดี</span>
                      <span className="user-name-display">{user?.name?.split(' ')[0] || 'ลูกค้า'}</span>
                    </div>
                    <ChevronDown size={14} />
                  </button>

                  {userMenuOpen && (
                    <div className="user-dropdown" onMouseLeave={() => setUserMenuOpen(false)}>
                      <div className="user-dropdown-header">
                        <span className="user-dropdown-name">{user?.name}</span>
                        <span className="user-dropdown-email">{user?.email}</span>
                        {isAdmin && <span className="admin-badge">ADMIN</span>}
                      </div>
                      <Link to="/account" className="dropdown-item" onClick={() => setUserMenuOpen(false)} id="menu-account">
                        <User size={15} /> ข้อมูลบัญชี
                      </Link>
                      <Link to="/orders" className="dropdown-item" onClick={() => setUserMenuOpen(false)} id="menu-orders">
                        <Package size={15} /> คำสั่งซื้อของฉัน
                      </Link>
                      <Link to="/chat" className="dropdown-item" onClick={() => setUserMenuOpen(false)} id="menu-chat">
                        <MessageCircle size={15} /> ข้อความ
                      </Link>
                      {isAdmin && (
                        <Link to="/admin" className="dropdown-item admin-item" onClick={() => setUserMenuOpen(false)} id="menu-admin">
                          ⚙️ เข้าสู่ระบบ Admin Dashboard
                        </Link>
                      )}
                      <button
                        type="button"
                        className="dropdown-item logout-item"
                        onClick={() => { logout(); setUserMenuOpen(false); navigate('/'); }}
                        id="btn-logout"
                      >
                        ออกจากระบบ
                      </button>
                    </div>
                  )}
                </div>
              ) : (
                <div className="auth-buttons-group">
                  <Link to="/login" className="btn-customer-login" id="btn-header-login">
                    <User size={15} /> เข้าสู่ระบบ
                  </Link>
                  <button
                    type="button"
                    className="btn-admin-pin-shortcut"
                    onClick={() => setPinModalOpen(true)}
                    title="เข้าสู่ระบบ Admin"
                    id="btn-header-admin-pin"
                  >
                    <Lock size={14} /> Admin
                  </button>
                </div>
              )}
            </div>

            {/* Mobile menu toggle */}
            <button
              type="button"
              className="icon-btn mobile-menu-btn"
              onClick={() => setMobileOpen(!mobileOpen)}
              id="btn-mobile-menu"
            >
              {mobileOpen ? <X size={22} /> : <Menu size={22} />}
            </button>
          </div>
        </div>

        {/* Search Bar Dropdown */}
        {searchOpen && (
          <div className="search-bar-dropdown">
            <form onSubmit={handleSearch} className="search-form">
              <Search size={18} className="search-icon-input" />
              <input
                autoFocus
                type="text"
                placeholder="ค้นหาสินค้า แบรนด์ หรือรุ่น..."
                value={searchQuery}
                onChange={e => setSearchQuery(e.target.value)}
                className="search-input"
                id="search-input"
              />
              <button type="submit" className="search-submit-btn" id="btn-search-submit">ค้นหา</button>
            </form>
          </div>
        )}

        {/* Mobile Navigation Drawer */}
        {mobileOpen && (
          <div className="mobile-nav-backdrop" onClick={() => setMobileOpen(false)}>
            <nav className="mobile-nav" onClick={e => e.stopPropagation()}>
              <div className="mobile-nav-header">
                <span className="mobile-nav-title">เมนูนำทาง</span>
                <button type="button" className="btn-close-mobile" onClick={() => setMobileOpen(false)}>
                  <X size={20} />
                </button>
              </div>

              {/* User section in mobile drawer */}
              <div className="mobile-user-section">
                {isLoggedIn ? (
                  <div className="mobile-user-card">
                    <div className="avatar-mini">
                      {isAdmin ? 'AD' : (user?.name ? user.name[0].toUpperCase() : 'U')}
                    </div>
                    <div>
                      <strong>{user?.name || 'ลูกค้า C-TOWN'}</strong>
                      <span className="text-muted d-block">{user?.email}</span>
                    </div>
                  </div>
                ) : (
                  <div className="mobile-guest-actions">
                    <Link
                      to="/login"
                      className="btn-primary w-100 text-center"
                      onClick={() => setMobileOpen(false)}
                    >
                      เข้าสู่ระบบ / สมัครสมาชิก
                    </Link>
                  </div>
                )}
              </div>

              <div className="mobile-links-list">
                {navLinks.map(link => (
                  <Link
                    key={link.to}
                    to={link.to}
                    className={`mobile-nav-link ${location.pathname === link.to ? 'active' : ''}`}
                    onClick={() => setMobileOpen(false)}
                  >
                    {link.label}
                  </Link>
                ))}

                {isLoggedIn && (
                  <>
                    <Link to="/account" className="mobile-nav-link" onClick={() => setMobileOpen(false)}>
                      ข้อมูลบัญชีของฉัน
                    </Link>
                    <Link to="/orders" className="mobile-nav-link" onClick={() => setMobileOpen(false)}>
                      คำสั่งซื้อของฉัน
                    </Link>
                    <Link to="/chat" className="mobile-nav-link" onClick={() => setMobileOpen(false)}>
                      พูดคุยกับทางร้าน
                    </Link>
                    {isAdmin && (
                      <Link to="/admin" className="mobile-nav-link admin-link" onClick={() => setMobileOpen(false)}>
                        ⚙️ Admin Dashboard
                      </Link>
                    )}
                    <button
                      type="button"
                      className="mobile-nav-link logout-btn"
                      onClick={() => { logout(); setMobileOpen(false); navigate('/'); }}
                    >
                      ออกจากระบบ
                    </button>
                  </>
                )}

                <button
                  type="button"
                  className="mobile-nav-link admin-access-btn"
                  onClick={() => { setMobileOpen(false); setPinModalOpen(true); }}
                >
                  <Lock size={15} /> เข้าสู่ระบบผู้ดูแลระบบ (Admin)
                </button>
              </div>
            </nav>
          </div>
        )}

        {/* Admin PIN Login Modal - NEVER DISPLAYS THE PIN */}
        {pinModalOpen && (
          <div className="modal-backdrop" onClick={() => setPinModalOpen(false)}>
            <div className="modal-container pin-modal-card" onClick={e => e.stopPropagation()}>
              <div className="modal-header">
                <div className="pin-modal-title">
                  <Lock size={20} className="text-primary-pink" />
                  <h3>เข้าสู่ระบบ Admin</h3>
                </div>
                <button type="button" className="btn-close" onClick={() => setPinModalOpen(false)}>
                  <X size={20} />
                </button>
              </div>

              <form onSubmit={handlePinSubmit} className="pin-form-body">
                <p className="pin-instruction">
                  กรุณาระบุรหัส PIN เพื่อเข้าสู่ระบบจัดการหลังบ้าน
                </p>

                {pinError && <div className="pin-error-alert">{pinError}</div>}

                <div className="pin-input-wrap">
                  <input
                    autoFocus
                    type="password"
                    maxLength={4}
                    placeholder="••••"
                    value={adminPin}
                    onChange={e => setAdminPin(e.target.value.replace(/\D/g, ''))}
                    className="pin-masked-input"
                    id="input-admin-pin"
                  />
                </div>

                <div className="pin-actions">
                  <button
                    type="submit"
                    className="btn-primary w-100"
                    disabled={adminPin.length < 4 || pinLoading}
                    id="btn-submit-pin"
                  >
                    {pinLoading ? 'กำลังตรวจสอบ...' : 'ยืนยันรหัส PIN (เข้าหลังบ้าน)'}
                  </button>
                </div>
              </form>
            </div>
          </div>
        )}
      </header>

      {/* Modern Bottom Mobile Navigation Bar for Smartphones */}
      <nav className="mobile-bottom-bar">
        <Link to="/" className={`bottom-bar-item ${location.pathname === '/' ? 'active' : ''}`}>
          <Home size={20} />
          <span>หน้าแรก</span>
        </Link>
        <Link to="/products" className={`bottom-bar-item ${location.pathname.startsWith('/products') ? 'active' : ''}`}>
          <Compass size={20} />
          <span>สินค้า</span>
        </Link>
        <Link to="/cart" className={`bottom-bar-item cart-bottom-item ${location.pathname === '/cart' ? 'active' : ''}`}>
          <div className="bottom-cart-icon-wrap">
            <ShoppingBag size={20} />
            {totalItems > 0 && <span className="bottom-cart-badge">{totalItems}</span>}
          </div>
          <span>ตะกร้า</span>
        </Link>
        <Link to={isLoggedIn ? "/orders" : "/track-order"} className={`bottom-bar-item ${location.pathname === '/orders' || location.pathname === '/track-order' ? 'active' : ''}`}>
          <Package size={20} />
          <span>ออเดอร์</span>
        </Link>
        <Link to={isLoggedIn ? "/account" : "/login"} className={`bottom-bar-item ${location.pathname === '/account' || location.pathname === '/login' ? 'active' : ''}`}>
          <User size={20} />
          <span>{isLoggedIn ? (user?.name?.split(' ')[0] || 'บัญชี') : 'เข้าสู่ระบบ'}</span>
        </Link>
      </nav>
    </>
  );
}
