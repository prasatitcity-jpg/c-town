import React, { useState, useEffect } from 'react';
import { useAuth } from '../../contexts/AuthContext';
import { pb } from '../../lib/pb';
import { User, MapPin, Plus, Trash2, Check, Shield } from 'lucide-react';
import { useNavigate } from 'react-router-dom';

const THAI_PROVINCES = [
  'กรุงเทพมหานคร','กระบี่','กาญจนบุรี','กาฬสินธุ์','กำแพงเพชร','ขอนแก่น','จันทบุรี','ฉะเชิงเทรา','ชลบุรี','ชัยนาท',
  'ชัยภูมิ','ชุมพร','เชียงราย','เชียงใหม่','ตรัง','ตราด','ตาก','นครนายก','นครปฐม','นครพนม','นครราชสีมา',
  'นครศรีธรรมราช','นครสวรรค์','นนทบุรี','นราธิวาส','น่าน','บึงกาฬ','บุรีรัมย์','ปทุมธานี','ประจวบคีรีขันธ์',
  'ปราจีนบุรี','ปัตตานี','พระนครศรีอยุธยา','พะเยา','พังงา','พัทลุง','พิจิตร','พิษณุโลก','เพชรบุรี','เพชรบูรณ์',
  'แพร่','ภูเก็ต','มหาสารคาม','มุกดาหาร','แม่ฮ่องสอน','ยโสธร','ยะลา','ร้อยเอ็ด','ระนอง','ระยอง','ราชบุรี',
  'ลพบุรี','ลำปาง','ลำพูน','เลย','ศรีสะเกษ','สกลนคร','สงขลา','สตูล','สมุทรปราการ','สมุทรสงคราม','สมุทรสาคร',
  'สระแก้ว','สระบุรี','สิงห์บุรี','สุโขทัย','สุพรรณบุรี','สุราษฎร์ธานี','สุรินทร์','หนองคาย','หนองบัวลำภู',
  'อ่างทอง','อำนาจเจริญ','อุดรธานี','อุตรดิตถ์','อุทัยธานี','อุบลราชธานี',
];

export default function AccountPage() {
  const { user, isLoggedIn } = useAuth();
  const navigate = useNavigate();
  const [addresses, setAddresses] = useState([]);
  const [showAddForm, setShowAddForm] = useState(false);
  const [loading, setLoading] = useState(false);
  const [newAddr, setNewAddr] = useState({
    recipient_name: '',
    phone: '',
    address_line: '',
    subdistrict: '',
    district: '',
    province: 'กรุงเทพมหานคร',
    postal_code: '',
    is_default: false,
  });

  useEffect(() => {
    if (!isLoggedIn) {
      navigate('/login');
      return;
    }
    loadAddresses();
  }, [isLoggedIn]);

  async function loadAddresses() {
    try {
      const list = await pb.collection('addresses').getList(1, 10, {
        filter: `user = "${user.id}"`,
        sort: '-is_default',
      });
      setAddresses(list.items);
    } catch (err) {
      console.error(err);
    }
  }

  async function handleAddAddress(e) {
    e.preventDefault();
    setLoading(true);
    try {
      // If marked default, unset other defaults
      if (newAddr.is_default && addresses.length > 0) {
        for (const a of addresses) {
          if (a.is_default) {
            await pb.collection('addresses').update(a.id, { is_default: false });
          }
        }
      }

      await pb.collection('addresses').create({
        ...newAddr,
        user: user.id,
      });

      setShowAddForm(false);
      setNewAddr({
        recipient_name: '',
        phone: '',
        address_line: '',
        subdistrict: '',
        district: '',
        province: 'กรุงเทพมหานคร',
        postal_code: '',
        is_default: false,
      });
      await loadAddresses();
    } catch (err) {
      alert('บันทึกที่อยู่ไม่สำเร็จ: ' + err.message);
    } finally {
      setLoading(false);
    }
  }

  async function handleDeleteAddress(id) {
    if (!confirm('ต้องการลบที่อยู่นี้ใช่หรือไม่?')) return;
    try {
      await pb.collection('addresses').delete(id);
      await loadAddresses();
    } catch (err) {
      alert('ลบไม่สำเร็จ: ' + err.message);
    }
  }

  async function handleSetDefault(id) {
    try {
      for (const a of addresses) {
        await pb.collection('addresses').update(a.id, { is_default: a.id === id });
      }
      await loadAddresses();
    } catch (err) {
      alert('ตั้งค่าที่อยู่เริ่มต้นไม่สำเร็จ');
    }
  }

  if (!isLoggedIn) return null;

  return (
    <div className="account-page">
      <div className="account-container">
        <h1 className="account-title">ข้อมูลบัญชีของฉัน</h1>

        <div className="account-grid">
          {/* User Profile Card */}
          <div className="account-card profile-card">
            <div className="profile-header">
              <div className="avatar-circle">
                <User size={36} />
              </div>
              <div>
                <h2>{user?.name || 'ลูกค้า C-TOWN'}</h2>
                <span className="user-email">{user?.email}</span>
                <div className="role-tag">
                  <Shield size={13} /> {user?.role || 'CUSTOMER'}
                </div>
              </div>
            </div>

            <div className="profile-details">
              <div className="detail-item">
                <span className="label">เบอร์โทรศัพท์</span>
                <span className="value">{user?.phone || 'ยังไม่ได้ระบุ'}</span>
              </div>
              <div className="detail-item">
                <span className="label">สมัครสมาชิกเมื่อ</span>
                <span className="value">
                  {user?.created ? new Date(user.created).toLocaleDateString('th-TH') : '-'}
                </span>
              </div>
            </div>
          </div>

          {/* Addresses Card */}
          <div className="account-card address-card">
            <div className="address-header">
              <div className="title-with-icon">
                <MapPin size={22} />
                <h3>สมุดที่อยู่สำหรับจัดส่ง</h3>
              </div>
              <button
                type="button"
                className="btn-secondary btn-sm"
                onClick={() => setShowAddForm(!showAddForm)}
                id="btn-toggle-address-form"
              >
                <Plus size={16} /> {showAddForm ? 'ปิดแบบฟอร์ม' : 'เพิ่มที่อยู่ใหม่'}
              </button>
            </div>

            {/* Add Address Form */}
            {showAddForm && (
              <form onSubmit={handleAddAddress} className="add-address-form">
                <h4>เพิ่มที่อยู่ใหม่</h4>
                <div className="form-row">
                  <div className="form-group">
                    <label>ชื่อผู้รับ *</label>
                    <input
                      type="text"
                      required
                      value={newAddr.recipient_name}
                      onChange={e => setNewAddr({ ...newAddr, recipient_name: e.target.value })}
                    />
                  </div>
                  <div className="form-group">
                    <label>เบอร์โทรศัพท์ *</label>
                    <input
                      type="tel"
                      required
                      value={newAddr.phone}
                      onChange={e => setNewAddr({ ...newAddr, phone: e.target.value })}
                    />
                  </div>
                </div>

                <div className="form-group">
                  <label>บ้านเลขที่ ซอย ถนน อาคาร *</label>
                  <input
                    type="text"
                    required
                    value={newAddr.address_line}
                    onChange={e => setNewAddr({ ...newAddr, address_line: e.target.value })}
                  />
                </div>

                <div className="form-row three-col">
                  <div className="form-group">
                    <label>แขวง/ตำบล *</label>
                    <input
                      type="text"
                      required
                      value={newAddr.subdistrict}
                      onChange={e => setNewAddr({ ...newAddr, subdistrict: e.target.value })}
                    />
                  </div>
                  <div className="form-group">
                    <label>เขต/อำเภอ *</label>
                    <input
                      type="text"
                      required
                      value={newAddr.district}
                      onChange={e => setNewAddr({ ...newAddr, district: e.target.value })}
                    />
                  </div>
                  <div className="form-group">
                    <label>รหัสไปรษณีย์ *</label>
                    <input
                      type="text"
                      required
                      maxLength={5}
                      value={newAddr.postal_code}
                      onChange={e => setNewAddr({ ...newAddr, postal_code: e.target.value })}
                    />
                  </div>
                </div>

                <div className="form-group">
                  <label>จังหวัด *</label>
                  <select
                    value={newAddr.province}
                    onChange={e => setNewAddr({ ...newAddr, province: e.target.value })}
                  >
                    {THAI_PROVINCES.map(p => <option key={p} value={p}>{p}</option>)}
                  </select>
                </div>

                <div className="form-checkbox">
                  <label>
                    <input
                      type="checkbox"
                      checked={newAddr.is_default}
                      onChange={e => setNewAddr({ ...newAddr, is_default: e.target.checked })}
                    />
                    ตั้งเป็นที่อยู่จัดส่งเริ่มต้น
                  </label>
                </div>

                <div className="form-actions">
                  <button type="submit" className="btn-primary" disabled={loading}>
                    {loading ? 'กำลังบันทึก...' : 'บันทึกที่อยู่'}
                  </button>
                  <button type="button" className="btn-secondary" onClick={() => setShowAddForm(false)}>
                    ยกเลิก
                  </button>
                </div>
              </form>
            )}

            {/* Addresses List */}
            <div className="saved-address-list">
              {addresses.length === 0 ? (
                <div className="empty-address">ยังไม่มีที่อยู่จัดส่งที่บันทึกไว้</div>
              ) : (
                addresses.map(a => (
                  <div key={a.id} className={`address-item-card ${a.is_default ? 'is-default' : ''}`}>
                    <div className="address-info-block">
                      <div className="name-row">
                        <strong>{a.recipient_name}</strong>
                        <span className="phone">({a.phone})</span>
                        {a.is_default && <span className="default-badge">ค่าเริ่มต้น</span>}
                      </div>
                      <p className="address-text">
                        {a.address_line}, {a.subdistrict}, {a.district}, {a.province} {a.postal_code}
                      </p>
                    </div>

                    <div className="address-item-actions">
                      {!a.is_default && (
                        <button
                          type="button"
                          className="btn-link"
                          onClick={() => handleSetDefault(a.id)}
                        >
                          ตั้งเป็นค่าเริ่มต้น
                        </button>
                      )}
                      <button
                        type="button"
                        className="btn-icon-danger"
                        title="ลบที่อยู่"
                        onClick={() => handleDeleteAddress(a.id)}
                      >
                        <Trash2 size={16} />
                      </button>
                    </div>
                  </div>
                ))
              )}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
