import React, { useState, useEffect } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { useCart } from '../../contexts/CartContext';
import { useAuth } from '../../contexts/AuthContext';
import { pb, ctownFetch, formatPrice } from '../../lib/pb';
import { CheckCircle, Upload, X, Tag } from 'lucide-react';

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

export default function CheckoutPage() {
  const { cartItems, subtotal, clearCart } = useCart();
  const { user, isLoggedIn } = useAuth();
  const navigate = useNavigate();

  const [form, setForm] = useState({
    recipient_name: user?.name || '',
    phone: user?.phone || '',
    address_line: '',
    subdistrict: '',
    district: '',
    province: 'กรุงเทพมหานคร',
    postal_code: '',
    notes: '',
  });
  const [addresses, setAddresses] = useState([]);
  const [couponCode, setCouponCode] = useState('');
  const [couponResult, setCouponResult] = useState(null);
  const [couponMsg, setCouponMsg] = useState('');
  const [paymentMethod, setPaymentMethod] = useState('bank_transfer');
  const [storeSettings, setStoreSettings] = useState(null);
  const [slipFile, setSlipFile] = useState(null);
  const [slipPreview, setSlipPreview] = useState('');
  const [loading, setLoading] = useState(false);
  const [order, setOrder] = useState(null);

  const shippingFee = (couponResult?.coupon?.discount_type === 'free_shipping') ? 0 : (subtotal >= 2500 ? 0 : 60);
  const discountAmount = couponResult?.coupon?.discount_amount || 0;
  const grandTotal = Math.max(0, subtotal - discountAmount + shippingFee);

  useEffect(() => {
    if (!isLoggedIn) { navigate('/login'); return; }
    (async () => {
      try {
        const saved = await pb.collection('addresses').getList(1, 5, { filter: `user = "${user.id}"` });
        setAddresses(saved.items);
        if (saved.items.length > 0) {
          const def = saved.items.find(a => a.is_default) || saved.items[0];
          setForm({
            recipient_name: def.recipient_name || user?.name || '',
            phone: def.phone || user?.phone || '',
            address_line: def.address_line || '',
            subdistrict: def.subdistrict || '',
            district: def.district || '',
            province: def.province || 'กรุงเทพมหานคร',
            postal_code: def.postal_code || '',
            notes: '',
          });
        }
      } catch (_) {}
      try {
        const settings = await pb.collection('store_settings').getList(1, 1);
        if (settings.items.length > 0) setStoreSettings(settings.items[0]);
      } catch (_) {}
    })();
  }, [isLoggedIn, user]);

  if (!isLoggedIn) return null;

  const handleCoupon = async () => {
    if (!couponCode.trim()) return;
    try {
      const result = await ctownFetch('/coupons/validate', {
        method: 'POST',
        body: { code: couponCode, subtotal },
      });
      setCouponResult(result);
      setCouponMsg('✅ ' + (result.coupon?.description || 'คูปองใช้งานได้'));
    } catch (err) {
      setCouponResult(null);
      setCouponMsg('❌ ' + err.message);
    }
  };

  const handleSlipUpload = (e) => {
    const file = e.target.files[0];
    if (!file) return;
    if (!['image/jpeg', 'image/jpg', 'image/png', 'image/webp'].includes(file.type)) {
      alert('รองรับเฉพาะ JPG, PNG, WEBP เท่านั้น');
      return;
    }
    if (file.size > 5 * 1024 * 1024) {
      alert('ไฟล์รูปต้องไม่เกิน 5MB');
      return;
    }
    setSlipFile(file);
    setSlipPreview(URL.createObjectURL(file));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (cartItems.length === 0) return;
    if (!form.recipient_name || !form.phone || !form.address_line || !form.province || !form.postal_code) {
      alert('กรุณากรอกข้อมูลที่อยู่จัดส่งให้ครบถ้วน');
      return;
    }

    setLoading(true);
    try {
      const orderData = {
        items: cartItems.map(ci => ({
          variant_id: ci.variant,
          quantity: ci.quantity,
        })),
        shipping_address: form,
        coupon_code: couponCode,
        payment_method: paymentMethod,
        notes: form.notes,
      };

      const result = await ctownFetch('/checkout', { method: 'POST', body: orderData });
      const createdOrder = result.order;

      // Upload slip if bank transfer
      if (paymentMethod === 'bank_transfer' && slipFile) {
        const proofFormData = new FormData();
        proofFormData.append('order', createdOrder.id);
        proofFormData.append('user', user.id);
        proofFormData.append('slip_image', slipFile);
        proofFormData.append('transfer_bank', form.transfer_bank || '');
        proofFormData.append('transfer_amount', grandTotal);
        proofFormData.append('status', 'pending');

        // Update order status to awaiting_verification
        await ctownFetch('/admin/orders/update-status', {
          method: 'POST',
          body: {
            order_id: createdOrder.id,
            order_status: 'awaiting_verification',
            payment_status: 'awaiting_verification',
          },
        }).catch(() => {});

        try {
          await pb.collection('payment_proofs').create(proofFormData);
        } catch (uploadErr) {
          console.error('Slip upload error:', uploadErr);
        }
      }

      clearCart();
      setOrder(createdOrder);
    } catch (err) {
      alert('เกิดข้อผิดพลาด: ' + err.message);
    } finally {
      setLoading(false);
    }
  };

  // Order Success Screen
  if (order) {
    return (
      <div className="order-success-page">
        <div className="success-icon"><CheckCircle size={64} /></div>
        <h1>สั่งซื้อสำเร็จ! 🎉</h1>
        <div className="order-number-display">
          <span>หมายเลขคำสั่งซื้อ:</span>
          <strong>{order.order_number}</strong>
        </div>
        <div className="order-summary-receipt">
          <div className="receipt-row"><span>ยอดสินค้า</span><span>{formatPrice(order.subtotal)}</span></div>
          <div className="receipt-row"><span>ส่วนลด</span><span>- {formatPrice(order.discount_amount || 0)}</span></div>
          <div className="receipt-row"><span>ค่าจัดส่ง</span><span>{order.shipping_fee === 0 ? 'ฟรี' : formatPrice(order.shipping_fee)}</span></div>
          <div className="receipt-row receipt-total"><span>ยอดรวมสุทธิ</span><strong>{formatPrice(order.grand_total)}</strong></div>
        </div>
        <p className="success-note">
          {paymentMethod === 'bank_transfer'
            ? 'ร้านค้าจะตรวจสอบการชำระเงินและอัปเดตสถานะภายใน 1-2 ชั่วโมงในเวลาทำการ'
            : 'ร้านค้าได้รับคำสั่งซื้อของคุณแล้ว'}
        </p>
        {storeSettings && (
          <div className="bank-info-reminder">
            <p>ช่องทางการชำระเงิน:</p>
            {(storeSettings.bank_accounts_json || []).map((b, i) => (
              <div key={i} className="bank-info-card">
                <strong>{b.bank}</strong><br />
                บัญชี: {b.account_name}<br />
                เลขที่: {b.account_number}
              </div>
            ))}
          </div>
        )}
        <div className="success-actions">
          <Link to={`/orders`} className="btn-primary" id="btn-view-orders">ดูคำสั่งซื้อของฉัน</Link>
          <Link to="/" className="btn-secondary" id="btn-back-home">กลับหน้าแรก</Link>
        </div>
      </div>
    );
  }

  const bankAccounts = storeSettings?.bank_accounts_json || [];

  return (
    <div className="checkout-page">
      <h1 className="checkout-title">ชำระเงิน</h1>

      <form className="checkout-form" onSubmit={handleSubmit}>
        <div className="checkout-layout">
          {/* Left: Shipping & Payment */}
          <div className="checkout-left">
            {/* Saved Addresses */}
            {addresses.length > 0 && (
              <div className="checkout-section">
                <h3 className="checkout-section-title">ที่อยู่ที่บันทึกไว้</h3>
                <div className="saved-addresses">
                  {addresses.map(addr => (
                    <button
                      key={addr.id}
                      type="button"
                      className="saved-address-card"
                      onClick={() => setForm({
                        recipient_name: addr.recipient_name,
                        phone: addr.phone,
                        address_line: addr.address_line,
                        subdistrict: addr.subdistrict,
                        district: addr.district,
                        province: addr.province,
                        postal_code: addr.postal_code,
                        notes: form.notes,
                      })}
                    >
                      <strong>{addr.recipient_name}</strong> ({addr.phone})<br />
                      {addr.address_line}, {addr.subdistrict}, {addr.district}, {addr.province} {addr.postal_code}
                    </button>
                  ))}
                </div>
              </div>
            )}

            {/* Shipping Form */}
            <div className="checkout-section">
              <h3 className="checkout-section-title">ข้อมูลจัดส่ง</h3>
              <div className="form-grid">
                <div className="form-group full-width">
                  <label>ชื่อผู้รับ *</label>
                  <input type="text" value={form.recipient_name} required
                    onChange={e => setForm(f => ({ ...f, recipient_name: e.target.value }))} id="checkout-recipient" />
                </div>
                <div className="form-group">
                  <label>เบอร์โทรศัพท์ *</label>
                  <input type="tel" value={form.phone} required
                    onChange={e => setForm(f => ({ ...f, phone: e.target.value }))} id="checkout-phone" />
                </div>
                <div className="form-group full-width">
                  <label>ที่อยู่ *</label>
                  <textarea value={form.address_line} required rows={2}
                    onChange={e => setForm(f => ({ ...f, address_line: e.target.value }))} id="checkout-address" />
                </div>
                <div className="form-group">
                  <label>ตำบล/แขวง *</label>
                  <input type="text" value={form.subdistrict} required
                    onChange={e => setForm(f => ({ ...f, subdistrict: e.target.value }))} id="checkout-subdistrict" />
                </div>
                <div className="form-group">
                  <label>อำเภอ/เขต *</label>
                  <input type="text" value={form.district} required
                    onChange={e => setForm(f => ({ ...f, district: e.target.value }))} id="checkout-district" />
                </div>
                <div className="form-group">
                  <label>จังหวัด *</label>
                  <select value={form.province} onChange={e => setForm(f => ({ ...f, province: e.target.value }))} id="checkout-province">
                    {THAI_PROVINCES.map(p => <option key={p} value={p}>{p}</option>)}
                  </select>
                </div>
                <div className="form-group">
                  <label>รหัสไปรษณีย์ *</label>
                  <input type="text" value={form.postal_code} required maxLength={5}
                    onChange={e => setForm(f => ({ ...f, postal_code: e.target.value }))} id="checkout-postal" />
                </div>
                <div className="form-group full-width">
                  <label>หมายเหตุถึงร้าน</label>
                  <textarea value={form.notes} rows={2}
                    onChange={e => setForm(f => ({ ...f, notes: e.target.value }))} id="checkout-notes" />
                </div>
              </div>
            </div>

            {/* Payment Method */}
            <div className="checkout-section">
              <h3 className="checkout-section-title">วิธีชำระเงิน</h3>
              <div className="payment-options">
                <label className={`payment-option${paymentMethod === 'bank_transfer' ? ' selected' : ''}`}>
                  <input type="radio" name="payment" value="bank_transfer"
                    checked={paymentMethod === 'bank_transfer'}
                    onChange={() => setPaymentMethod('bank_transfer')} id="pay-bank" />
                  🏦 โอนเงินผ่านธนาคาร
                </label>
                <label className={`payment-option${paymentMethod === 'qr_promptpay' ? ' selected' : ''}`}>
                  <input type="radio" name="payment" value="qr_promptpay"
                    checked={paymentMethod === 'qr_promptpay'}
                    onChange={() => setPaymentMethod('qr_promptpay')} id="pay-qr" />
                  📱 QR PromptPay
                </label>
              </div>

              {/* Bank Info */}
              {(paymentMethod === 'bank_transfer' || paymentMethod === 'qr_promptpay') && bankAccounts.length > 0 && (
                <div className="bank-info-section">
                  <p className="bank-info-label">โอนเงินมายังบัญชีต่อไปนี้:</p>
                  {bankAccounts.map((b, i) => (
                    <div key={i} className="bank-card">
                      <strong>{b.bank}</strong>
                      <span>ชื่อบัญชี: {b.account_name}</span>
                      <span>เลขที่บัญชี: <strong>{b.account_number}</strong></span>
                      {b.branch && <span>สาขา: {b.branch}</span>}
                      {b.promptpay_id && <span>PromptPay: {b.promptpay_id}</span>}
                    </div>
                  ))}
                </div>
              )}

              {/* Slip Upload */}
              {(paymentMethod === 'bank_transfer' || paymentMethod === 'qr_promptpay') && (
                <div className="slip-upload-section">
                  <label className="slip-upload-label">
                    <Upload size={16} /> แนบหลักฐานการโอนเงิน
                  </label>
                  <input
                    type="file"
                    accept="image/jpeg,image/jpg,image/png,image/webp"
                    onChange={handleSlipUpload}
                    className="slip-file-input"
                    id="slip-upload"
                  />
                  {slipPreview && (
                    <div className="slip-preview">
                      <img src={slipPreview} alt="slip preview" className="slip-preview-img" />
                      <button type="button" className="slip-remove-btn" onClick={() => { setSlipFile(null); setSlipPreview(''); }}>
                        <X size={14} />
                      </button>
                    </div>
                  )}
                </div>
              )}
            </div>
          </div>

          {/* Right: Order Summary */}
          <div className="checkout-right">
            <div className="checkout-summary">
              <h3 className="checkout-section-title">รายการสินค้า</h3>
              {cartItems.map(item => {
                const variant = item.expand?.variant || {};
                const product = item.expand?.product || {};
                const price = variant.sale_price || variant.selling_price || item.unit_price || 0;
                return (
                  <div key={item.id} className="checkout-item">
                    <img
                      src={variant.image_url || '/images/products/placeholder.jpg'}
                      alt={product.name}
                      className="checkout-item-img"
                      onError={e => { e.target.src = '/images/products/placeholder.jpg'; }}
                    />
                    <div className="checkout-item-info">
                      <span className="checkout-item-name">{product.name}</span>
                      <span className="checkout-item-meta">{variant.color} | ไซซ์ {variant.size}</span>
                      <span className="checkout-item-qty">× {item.quantity}</span>
                    </div>
                    <span className="checkout-item-price">{formatPrice(price * item.quantity)}</span>
                  </div>
                );
              })}

              {/* Coupon */}
              <div className="coupon-section">
                <div className="coupon-input-row">
                  <Tag size={15} />
                  <input
                    type="text"
                    placeholder="รหัสคูปอง"
                    value={couponCode}
                    onChange={e => setCouponCode(e.target.value.toUpperCase())}
                    className="coupon-input"
                    id="coupon-input"
                  />
                  <button type="button" onClick={handleCoupon} className="btn-apply-coupon" id="btn-apply-coupon">
                    ใช้
                  </button>
                </div>
                {couponMsg && (
                  <span className={`coupon-msg${couponMsg.startsWith('✅') ? ' success' : ' error'}`}>
                    {couponMsg}
                  </span>
                )}
              </div>

              {/* Totals */}
              <div className="checkout-totals">
                <div className="total-row"><span>ราคาสินค้า</span><span>{formatPrice(subtotal)}</span></div>
                {discountAmount > 0 && (
                  <div className="total-row discount-row">
                    <span>ส่วนลด ({couponCode})</span>
                    <span>- {formatPrice(discountAmount)}</span>
                  </div>
                )}
                <div className="total-row">
                  <span>ค่าจัดส่ง</span>
                  <span>{shippingFee === 0 ? <span className="free-ship">ฟรี</span> : formatPrice(shippingFee)}</span>
                </div>
                <div className="total-row grand-total">
                  <span>ยอดรวมสุทธิ</span>
                  <strong>{formatPrice(grandTotal)}</strong>
                </div>
              </div>

              <button
                type="submit"
                className="btn-place-order"
                disabled={loading || cartItems.length === 0}
                id="btn-place-order"
              >
                {loading ? 'กำลังดำเนินการ...' : '✅ ยืนยันคำสั่งซื้อ'}
              </button>
            </div>
          </div>
        </div>
      </form>
    </div>
  );
}
