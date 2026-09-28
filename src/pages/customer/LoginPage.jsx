import React, { useState } from 'react';
import { useNavigate, useLocation, Link } from 'react-router-dom';
import { useAuth } from '../../contexts/AuthContext';
import { Lock, Mail, User, Phone, ArrowRight, ShieldCheck, KeyRound } from 'lucide-react';

export default function LoginPage() {
  const [activeTab, setActiveTab] = useState('login'); // 'login' | 'register' | 'admin_pin'
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [passwordConfirm, setPasswordConfirm] = useState('');
  const [name, setName] = useState('');
  const [phone, setPhone] = useState('');
  const [adminPin, setAdminPin] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const { login, register, loginWithPin } = useAuth();
  const navigate = useNavigate();
  const location = useLocation();
  const from = location.state?.from?.pathname || (activeTab === 'admin_pin' ? '/admin' : '/');

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
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
      } else {
        await login(email, password);
      }
      navigate(from, { replace: true });
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
               activeTab === 'admin_pin' ? 'กรอกรหัสผ่านความปลอดภัยเพื่อเข้าสู่ระบบจัดการหลังบ้าน' :
               'ยินดีต้อนรับกลับมา เลือกชมและสั่งซื้อรองเท้าคู่โปรดของคุณ'}
            </p>
          </div>

          {/* Three Tabs: Login, Register, Admin */}
          <div className="auth-tabs three-tabs">
            <button
              type="button"
              className={`auth-tab-btn ${activeTab === 'login' ? 'active' : ''}`}
              onClick={() => { setActiveTab('login'); setError(''); }}
              id="tab-login"
            >
              เข้าสู่ระบบ
            </button>
            <button
              type="button"
              className={`auth-tab-btn ${activeTab === 'register' ? 'active' : ''}`}
              onClick={() => { setActiveTab('register'); setError(''); }}
              id="tab-register"
            >
              สมัครสมาชิก
            </button>
            <button
              type="button"
              className={`auth-tab-btn tab-admin ${activeTab === 'admin_pin' ? 'active' : ''}`}
              onClick={() => { setActiveTab('admin_pin'); setError(''); }}
              id="tab-admin-pin"
            >
              <ShieldCheck size={15} /> ผู้ดูแลระบบ
            </button>
          </div>

          {error && <div className="auth-error-banner">{error}</div>}

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
                    🔒 กรุณากรอกรหัส 4 หลักเพื่อเข้าสู่ระบบจัดการหลังบ้าน (ระบบไม่แสดงรหัสผ่าน)
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
                      placeholder="••••••••"
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
                        placeholder="••••••••"
                        value={passwordConfirm}
                        onChange={e => setPasswordConfirm(e.target.value)}
                      />
                    </div>
                  </div>
                )}

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
