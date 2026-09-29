import React, { useState, useEffect } from 'react';
import { useNavigate, useLocation, Link } from 'react-router-dom';
import { useAuth } from '../../contexts/AuthContext';
import {
  Lock,
  Mail,
  User,
  Phone,
  ArrowRight,
  ShieldCheck,
  KeyRound,
  CheckCircle2,
  Trash2,
  UserCheck
} from 'lucide-react';

export default function LoginPage() {
  const [activeTab, setActiveTab] = useState('login'); // 'login' | 'register' | 'admin_pin'
  const [email, setEmail] = useState(() => {
    try {
      return localStorage.getItem('ctown_saved_email') || '';
    } catch (_) {
      return '';
    }
  });
  const [password, setPassword] = useState('');
  const [passwordConfirm, setPasswordConfirm] = useState('');
  const [name, setName] = useState('');
  const [phone, setPhone] = useState('');
  const [adminPin, setAdminPin] = useState('');
  const [rememberMe, setRememberMe] = useState(true);
  const [savedAccounts, setSavedAccounts] = useState([]);
  const [error, setError] = useState('');
  const [successMsg, setSuccessMsg] = useState('');
  const [loading, setLoading] = useState(false);

  const { login, register, loginWithPin } = useAuth();
  const navigate = useNavigate();
  const location = useLocation();
  const from = location.state?.from?.pathname || (activeTab === 'admin_pin' ? '/admin' : '/');

  useEffect(() => {
    loadSavedAccounts();
  }, []);

  function loadSavedAccounts() {
    try {
      const stored = JSON.parse(localStorage.getItem('ctown_registered_users') || '[]');
      setSavedAccounts(stored);
    } catch (_) {}
  }

  const handleSelectSavedAccount = (acc) => {
    setEmail(acc.email);
    setError('');
  };

  const handleRemoveSavedAccount = (e, accEmail) => {
    e.stopPropagation();
    try {
      const updated = savedAccounts.filter(a => a.email !== accEmail);
      localStorage.setItem('ctown_registered_users', JSON.stringify(updated));
      setSavedAccounts(updated);
      if (email === accEmail) setEmail('');
    } catch (_) {}
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setSuccessMsg('');
    setLoading(true);

    try {
      if (activeTab === 'admin_pin') {
        await loginWithPin(adminPin);
        navigate('/admin', { replace: true });
        return;
      }

      if (activeTab === 'register') {
        if (password !== passwordConfirm) {
          throw new Error('รหัสผ่านและการยืนยันรหัสผ่านไม่ตรงกัน');
        }
        if (password.length < 8) {
          throw new Error('รหัสผ่านต้องมีความยาวอย่างน้อย 8 ตัวอักษร');
        }
        await register({ email, password, passwordConfirm, name, phone });
        if (rememberMe) {
          try { localStorage.setItem('ctown_saved_email', email); } catch (_) {}
        }
        loadSavedAccounts();
        setSuccessMsg('สมัครสมาชิกสำเร็จ! เข้าสู่ระบบเรียบร้อยแล้ว');
      } else {
        await login(email, password);
        if (rememberMe) {
          try { localStorage.setItem('ctown_saved_email', email); } catch (_) {}
        }
        loadSavedAccounts();
        setSuccessMsg('เข้าสู่ระบบสำเร็จ! ยินดีต้อนรับกลับมา');
      }

      setTimeout(() => {
        navigate(from, { replace: true });
      }, 500);
    } catch (err) {
      console.error(err);
      setError(err.message || 'การดำเนินการไม่สำเร็จ กรุณาตรวจสอบข้อมูล');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="auth-page">
      <div className="auth-container">
        <div className="auth-card">
          <div className="auth-header">
            <Link to="/" className="auth-logo">
              <span className="logo-c">C</span>
              <span className="logo-town">-TOWN</span>
            </Link>
            <h2>
              {activeTab === 'register' ? 'สมัครสมาชิกใหม่' :
               activeTab === 'admin_pin' ? 'เข้าสู่ระบบผู้ดูแลระบบ (Admin)' :
               'เข้าสู่ระบบสมาชิก'}
            </h2>
            <p className="auth-subtext">
              {activeTab === 'register' ? 'ร่วมเป็นครอบครัว C-TOWN เพื่อรับสิทธิพิเศษและโปรโมชั่น' :
               activeTab === 'admin_pin' ? 'กรอกรหัส PIN ความปลอดภัยเพื่อเข้าสู่ระบบจัดการหลังบ้าน' :
               'ยินดีต้อนรับกลับมา เลือกชมและสั่งซื้อรองเท้าคู่โปรดของคุณ'}
            </p>
          </div>

          {/* Three Tabs: Login, Register, Admin */}
          <div className="auth-tabs three-tabs">
            <button
              type="button"
              className={`auth-tab-btn ${activeTab === 'login' ? 'active' : ''}`}
              onClick={() => { setActiveTab('login'); setError(''); setSuccessMsg(''); }}
              id="tab-login"
            >
              เข้าสู่ระบบ
            </button>
            <button
              type="button"
              className={`auth-tab-btn ${activeTab === 'register' ? 'active' : ''}`}
              onClick={() => { setActiveTab('register'); setError(''); setSuccessMsg(''); }}
              id="tab-register"
            >
              สมัครสมาชิก
            </button>
            <button
              type="button"
              className={`auth-tab-btn tab-admin ${activeTab === 'admin_pin' ? 'active' : ''}`}
              onClick={() => { setActiveTab('admin_pin'); setError(''); setSuccessMsg(''); }}
              id="tab-admin-pin"
            >
              <ShieldCheck size={15} /> ผู้ดูแลระบบ
            </button>
          </div>

          {error && <div className="auth-error-banner">{error}</div>}
          {successMsg && (
            <div style={{ background: '#ECFDF5', color: '#065F46', border: '1px solid #A7F3D0', padding: '12px 16px', borderRadius: '10px', fontSize: '0.9rem', marginBottom: '16px', display: 'flex', alignItems: 'center', gap: '8px' }}>
              <CheckCircle2 size={18} color="#059669" /> {successMsg}
            </div>
          )}

          {/* Saved Accounts Quick Select (Remembered registered users) */}
          {activeTab === 'login' && savedAccounts.length > 0 && (
            <div style={{ background: '#F8FAFC', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '14px', marginBottom: '20px' }}>
              <div style={{ fontSize: '0.8rem', fontWeight: 700, color: '#64748B', display: 'flex', alignItems: 'center', gap: '6px', marginBottom: '10px', textTransform: 'uppercase' }}>
                <UserCheck size={16} color="#E11D48" /> บัญชีที่เคยสมัครในอุปกรณ์นี้ (คลิกเพื่อเลือก)
              </div>
              <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
                {savedAccounts.map(acc => {
                  const isSelected = email.toLowerCase() === acc.email.toLowerCase();
                  return (
                    <div
                      key={acc.email}
                      onClick={() => handleSelectSavedAccount(acc)}
                      style={{
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'space-between',
                        padding: '8px 12px',
                        background: isSelected ? '#FFF1F2' : '#fff',
                        border: isSelected ? '1.5px solid #E11D48' : '1px solid #CBD5E1',
                        borderRadius: '8px',
                        cursor: 'pointer',
                        transition: 'all 0.15s ease'
                      }}
                    >
                      <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
                        <div style={{ width: '28px', height: '28px', borderRadius: '50%', background: isSelected ? '#E11D48' : '#94A3B8', color: '#fff', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '0.75rem', fontWeight: 700 }}>
                          {acc.name ? acc.name[0].toUpperCase() : 'U'}
                        </div>
                        <div>
                          <strong style={{ fontSize: '0.85rem', color: '#1E293B', display: 'block' }}>{acc.name}</strong>
                          <span style={{ fontSize: '0.75rem', color: '#64748B' }}>{acc.email}</span>
                        </div>
                      </div>
                      <button
                        type="button"
                        onClick={(e) => handleRemoveSavedAccount(e, acc.email)}
                        style={{ border: 'none', background: 'transparent', color: '#94A3B8', cursor: 'pointer', padding: '4px' }}
                        title="ลบออกจากรายการจดจำ"
                      >
                        <Trash2 size={14} />
                      </button>
                    </div>
                  );
                })}
              </div>
            </div>
          )}

          <form onSubmit={handleSubmit} className="auth-form">
            {/* Admin PIN Login Form */}
            {activeTab === 'admin_pin' ? (
              <div className="admin-pin-view">
                <div className="form-group text-center">
                  <label htmlFor="admin-pin-input">รหัสความปลอดภัยผู้ดูแลระบบ</label>
                  <div className="pin-input-big-wrap">
                    <input
                      id="admin-pin-input"
                      type="password"
                      maxLength={4}
                      autoFocus
                      required
                      placeholder="••••"
                      value={adminPin}
                      onChange={e => setAdminPin(e.target.value.replace(/\D/g, ''))}
                      className="pin-masked-input-large"
                    />
                  </div>
                  <div className="pin-hint-text">
                    🔒 กรุณากรอกรหัส PIN 4 หลัก (ค่าเริ่มต้นคือ 1111)
                  </div>
                </div>

                <button
                  type="submit"
                  className="btn-primary auth-submit-btn"
                  disabled={loading || adminPin.length < 4}
                  id="btn-admin-pin-submit"
                >
                  {loading ? 'กำลังเข้าสู่ระบบ...' : <>เข้าสู่ระบบจัดการหลังบ้าน <ArrowRight size={18} /></>}
                </button>
              </div>
            ) : (
              <>
                {activeTab === 'register' && (
                  <>
                    <div className="form-group">
                      <label htmlFor="reg-name">ชื่อ - นามสกุล *</label>
                      <div className="input-with-icon">
                        <User size={18} className="input-icon" />
                        <input
                          id="reg-name"
                          type="text"
                          required
                          placeholder="สมชาย ใจดี"
                          value={name}
                          onChange={e => setName(e.target.value)}
                        />
                      </div>
                    </div>

                    <div className="form-group">
                      <label htmlFor="reg-phone">เบอร์โทรศัพท์ *</label>
                      <div className="input-with-icon">
                        <Phone size={18} className="input-icon" />
                        <input
                          id="reg-phone"
                          type="tel"
                          required
                          placeholder="0812345678"
                          value={phone}
                          onChange={e => setPhone(e.target.value)}
                        />
                      </div>
                    </div>
                  </>
                )}

                <div className="form-group">
                  <label htmlFor="auth-email">อีเมล *</label>
                  <div className="input-with-icon">
                    <Mail size={18} className="input-icon" />
                    <input
                      id="auth-email"
                      type="email"
                      required
                      placeholder="name@example.com"
                      value={email}
                      onChange={e => setEmail(e.target.value)}
                    />
                  </div>
                </div>

                <div className="form-group">
                  <label htmlFor="auth-password">รหัสผ่าน *</label>
                  <div className="input-with-icon">
                    <Lock size={18} className="input-icon" />
                    <input
                      id="auth-password"
                      type="password"
                      required
                      placeholder="อย่างน้อย 8 ตัวอักษร"
                      value={password}
                      onChange={e => setPassword(e.target.value)}
                    />
                  </div>
                </div>

                {activeTab === 'register' && (
                  <div className="form-group">
                    <label htmlFor="auth-password-confirm">ยืนยันรหัสผ่าน *</label>
                    <div className="input-with-icon">
                      <Lock size={18} className="input-icon" />
                      <input
                        id="auth-password-confirm"
                        type="password"
                        required
                        placeholder="กรอกรหัสผ่านอีกครั้ง"
                        value={passwordConfirm}
                        onChange={e => setPasswordConfirm(e.target.value)}
                      />
                    </div>
                  </div>
                )}

                {/* Remember Me Checkbox */}
                <div style={{ display: 'flex', alignItems: 'center', gap: '8px', margin: '4px 0 16px', fontSize: '0.85rem', color: '#475569' }}>
                  <input
                    type="checkbox"
                    id="chk-remember-me"
                    checked={rememberMe}
                    onChange={e => setRememberMe(e.target.checked)}
                    style={{ width: '16px', height: '16px', accentColor: '#E11D48', cursor: 'pointer' }}
                  />
                  <label htmlFor="chk-remember-me" style={{ cursor: 'pointer', margin: 0, fontWeight: 500 }}>
                    จดจำบัญชีและอีเมลสำหรับการเข้าใช้งานครั้งถัดไป
                  </label>
                </div>

                <button
                  type="submit"
                  className="btn-primary auth-submit-btn"
                  disabled={loading}
                  id="btn-auth-submit"
                >
                  {loading ? (
                    'กำลังดำเนินการ...'
                  ) : activeTab === 'register' ? (
                    <>สร้างบัญชีสมาชิก <ArrowRight size={18} /></>
                  ) : (
                    <>เข้าสู่ระบบ <ArrowRight size={18} /></>
                  )}
                </button>
              </>
            )}
          </form>

          <div className="auth-footer-note">
            <ShieldCheck size={16} /> ข้อมูลของคุณได้รับการปกป้องตามมาตรฐานความปลอดภัย
          </div>
        </div>
      </div>
    </div>
  );
}
