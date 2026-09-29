import React, { useState, useEffect } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { useCart } from '../../contexts/CartContext';
import { useAuth } from '../../contexts/AuthContext';
import { pb, ctownFetch, formatPrice } from '../../lib/pb';
import {
  CheckCircle,
  Upload,
  X,
  Tag,
  ShoppingBag,
  CreditCard,
  Building,
  QrCode,
  ArrowLeft,
  Check,
  Copy,
  AlertCircle
} from 'lucide-react';

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
    email: user?.email || '',
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
  const [slipFile, setSlipFile] = useState(null);
  const [slipPreview, setSlipPreview] = useState('');
  const [loading, setLoading] = useState(false);
  const [order, setOrder] = useState(null);
  const [copiedBank, setCopiedBank] = useState('');

  const shippingFee = (couponResult?.coupon?.discount_type === 'free_shipping') ? 0 : (subtotal >= 2500 ? 0 : 60);
  const discountAmount = couponResult?.coupon?.discount_amount || 0;
  const grandTotal = Math.max(0, subtotal - discountAmount + shippingFee);

  useEffect(() => {
    if (isLoggedIn && user?.id) {
      (async () => {
        try {
          const saved = await pb.collection('addresses').getList(1, 5, { filter: `user = "${user.id}"` });
          setAddresses(saved.items || []);
          if (saved.items?.length > 0) {
            const def = saved.items.find(a => a.is_default) || saved.items[0];
            setForm(f => ({
              ...f,
              recipient_name: def.recipient_name || user?.name || '',
              phone: def.phone || user?.phone || '',
              email: user?.email || '',
              address_line: def.address_line || '',
              subdistrict: def.subdistrict || '',
              district: def.district || '',
              province: def.province || 'กรุงเทพมหานคร',
              postal_code: def.postal_code || '',
            }));
          } else {
            setForm(f => ({
              ...f,
              recipient_name: user?.name || '',
              phone: user?.phone || '',
              email: user?.email || '',
            }));
          }
        } catch (_) {}
      })();
    }
  }, [isLoggedIn, user]);

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
      alert('รองรับเฉพาะไฟล์รูปภาพ JPG, PNG, WEBP');
      return;
    }
    if (file.size > 5 * 1024 * 1024) {
      alert('ไฟล์รูปภาพต้องมีขนาดไม่เกิน 5MB');
      return;
    }
    setSlipFile(file);
    setSlipPreview(URL.createObjectURL(file));
  };

  const handleCopy = (text, bankKey) => {
    navigator.clipboard?.writeText(text);
    setCopiedBank(bankKey);
    setTimeout(() => setCopiedBank(''), 2500);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (cartItems.length === 0) {
      alert('ไม่มีสินค้าในตะกร้า');
      return;
    }
    if (!form.recipient_name || !form.phone || !form.address_line || !form.province || !form.postal_code) {
      alert('กรุณากรอกข้อมูลจัดส่งให้ครบถ้วน (ชื่อ, เบอร์โทร, ที่อยู่, จังหวัด, รหัสไปรษณีย์)');
      return;
    }

    setLoading(true);
    try {
      const orderData = {
        items: cartItems.map(ci => {
          const v = ci.expand?.variant;
          const p = ci.expand?.product;
          return {
            variant_id: ci.variant,
            product_id: ci.product,
            product_name: p?.name || 'สนีกเกอร์ C-TOWN',
            sku: v?.sku || 'SKU',
            color: v?.color || '',
            size: v?.size || '',
            unit_price: ci.unit_price || v?.selling_price || 0,
            quantity: ci.quantity || 1,
            image: v?.image_url || p?.main_image || ''
          };
        }),
        shipping_address: form,
        coupon_code: couponCode,
        payment_method: paymentMethod,
        notes: form.notes,
      };

      const result = await ctownFetch('/checkout', { method: 'POST', body: orderData });
      const createdOrder = result.order;

      // If slip uploaded, update status
      if (paymentMethod === 'bank_transfer' && slipFile) {
        await ctownFetch('/admin/orders/update-status', {
          method: 'POST',
          body: {
            order_id: createdOrder.id,
            order_status: 'awaiting_verification',
            payment_status: 'awaiting_verification',
          },
        }).catch(() => {});
      }

      clearCart();

      // Save recent order to localStorage for easy 1-click tracking
      try {
        const savedRecent = JSON.parse(localStorage.getItem('ctown_my_orders') || '[]');
        const newRecent = [
          {
            id: createdOrder.id,
            order_number: createdOrder.order_number,
            grand_total: createdOrder.grand_total,
            created: createdOrder.created,
            order_status: createdOrder.order_status,
            item_count: orderData.items.length
          },
          ...savedRecent.filter(o => o.order_number !== createdOrder.order_number)
        ].slice(0, 10);
        localStorage.setItem('ctown_my_orders', JSON.stringify(newRecent));
      } catch (_) {}

      setOrder(createdOrder);
    } catch (err) {
      alert('เกิดข้อผิดพลาดในการสั่งซื้อ: ' + err.message);
    } finally {
      setLoading(false);
    }
  };

  // 1. Order Success Screen
  if (order) {
    return (
      <div className="order-success-page" style={{ maxWidth: '640px', margin: '40px auto', padding: '32px', background: '#fff', borderRadius: '16px', boxShadow: '0 10px 30px rgba(0,0,0,0.06)', textAlign: 'center' }}>
        <div style={{ width: '72px', height: '72px', background: '#D1FAE5', borderRadius: '50%', display: 'flex', alignItems: 'center', justifyContent: 'center', margin: '0 auto 20px', color: '#059669' }}>
          <CheckCircle size={48} />
        </div>
        <h1 style={{ fontSize: '1.8rem', fontWeight: 800, color: '#111827', marginBottom: '8px' }}>สั่งซื้อสินค้าสำเร็จ! 🎉</h1>
        <p style={{ color: '#6B7280', marginBottom: '24px' }}>ขอบคุณสำหรับการสั่งซื้อกับ C-TOWN SNEAKER STORE</p>

        <div style={{ background: '#F9FAFB', border: '1px solid #E5E7EB', borderRadius: '12px', padding: '16px', marginBottom: '24px' }}>
          <span style={{ fontSize: '0.85rem', color: '#6B7280' }}>หมายเลขคำสั่งซื้อของคุณ:</span>
          <div style={{ fontSize: '1.4rem', fontWeight: 800, color: '#E11D48', letterSpacing: '1px', marginTop: '4px' }}>
            {order.order_number}
          </div>
          <span style={{ display: 'inline-block', marginTop: '8px', padding: '3px 10px', borderRadius: '12px', fontSize: '0.75rem', fontWeight: 600, background: order.payment_status === 'paid' ? '#D1FAE5' : '#FEF3C7', color: order.payment_status === 'paid' ? '#065F46' : '#92400E' }}>
            สถานะ: {order.payment_status === 'paid' ? 'ชำระเงินแล้ว' : (slipFile ? 'รอตรวจสอบสลิป' : 'รอแจ้งชำระเงิน')}
          </span>
        </div>

        <div style={{ textAlign: 'left', background: '#F8FAFC', padding: '16px 20px', borderRadius: '12px', marginBottom: '24px', fontSize: '0.9rem' }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '8px' }}>
            <span style={{ color: '#64748B' }}>ยอดรวมสินค้า:</span>
            <span>{formatPrice(order.subtotal)}</span>
          </div>
          {order.discount_amount > 0 && (
            <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '8px', color: '#059669' }}>
              <span>ส่วนลด:</span>
              <span>- {formatPrice(order.discount_amount)}</span>
            </div>
          )}
          <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '8px' }}>
            <span style={{ color: '#64748B' }}>ค่าจัดส่ง:</span>
            <span>{order.shipping_fee === 0 ? 'ฟรี (ส่งฟรี)' : formatPrice(order.shipping_fee)}</span>
          </div>
          <div style={{ display: 'flex', justifyContent: 'space-between', borderTop: '1px solid #E2E8F0', paddingTop: '10px', marginTop: '8px', fontWeight: 800, fontSize: '1.1rem', color: '#E11D48' }}>
            <span>ยอดชำระสุทธิ:</span>
            <span>{formatPrice(order.grand_total)}</span>
          </div>
        </div>

        {paymentMethod === 'bank_transfer' && (
          <div style={{ background: '#FFF1F2', border: '1px solid #FFE4E6', borderRadius: '12px', padding: '16px', textAlign: 'left', marginBottom: '24px' }}>
            <h4 style={{ color: '#9F1239', fontWeight: 700, marginBottom: '8px', display: 'flex', alignItems: 'center', gap: '6px' }}>
              <Building size={18} /> ข้อมูลบัญชีสำหรับโอนเงิน
            </h4>
            <div style={{ fontSize: '0.88rem', color: '#4B5563', lineHeight: '1.6' }}>
              <strong>ธนาคารกสิกรไทย (KBANK)</strong><br />
              ชื่อบัญชี: บจก. ซี-ทาวน์ สนีกเกอร์ สโตร์<br />
              เลขที่บัญชี: <strong style={{ color: '#111827' }}>123-4-56789-0</strong>
            </div>
            <p style={{ fontSize: '0.8rem', color: '#9F1239', marginTop: '8px' }}>
              *หลังโอนเงิน ทีมงานจะตรวจสอบและจัดส่งสินค้าภายใน 24 ชม.
            </p>
          </div>
        )}

        <div style={{ display: 'flex', gap: '12px', justifyContent: 'center' }}>
          <Link to="/products" className="btn-primary" style={{ padding: '12px 24px', borderRadius: '10px', textDecoration: 'none' }}>
            เลือกดูสินค้าต่อ
          </Link>
          <Link to={`/track-order?order=${order.order_number}`} className="btn-secondary" style={{ padding: '12px 24px', borderRadius: '10px', textDecoration: 'none' }}>
            ติดตามสถานะพัสดุ
          </Link>
        </div>
      </div>
    );
  }

  // 2. Empty Cart Screen
  if (cartItems.length === 0) {
    return (
      <div className="checkout-empty-page" style={{ textAlign: 'center', padding: '80px 20px', minHeight: '60vh' }}>
        <div style={{ width: '80px', height: '80px', borderRadius: '50%', background: '#FEE2E2', display: 'flex', alignItems: 'center', justifyContent: 'center', margin: '0 auto 20px' }}>
          <ShoppingBag size={40} color="#E11D48" />
        </div>
        <h2 style={{ fontSize: '1.6rem', fontWeight: 800, marginBottom: '10px', color: '#111827' }}>ไม่มีสินค้าในตะกร้า</h2>
        <p style={{ color: '#6B7280', marginBottom: '24px' }}>กรุณาเลือกซื้อรองเท้าผ้าใบก่อนดำเนินการสั่งซื้อและชำระเงิน</p>
        <Link to="/products" className="btn-primary" style={{ padding: '12px 28px', borderRadius: '10px', textDecoration: 'none', display: 'inline-block' }}>
          ไปเลือกซื้อรองเท้าเลย
        </Link>
      </div>
    );
  }

  // 3. Main Checkout Screen
  return (
    <div className="checkout-page" style={{ maxWidth: '1140px', margin: '30px auto', padding: '0 20px' }}>
      <div style={{ marginBottom: '24px' }}>
        <h1 style={{ fontSize: '1.8rem', fontWeight: 800, color: '#111827' }}>ขั้นตอนการชำระเงิน</h1>
        <p style={{ color: '#6B7280', fontSize: '0.9rem' }}>กรอกข้อมูลจัดส่งและเลือกช่องทางการชำระเงินเพื่อยืนยันคำสั่งซื้อ</p>
      </div>

      {!isLoggedIn && (
        <div style={{ background: '#EFF6FF', border: '1px solid #BFDBFE', padding: '12px 18px', borderRadius: '10px', marginBottom: '24px', display: 'flex', alignItems: 'center', justifyContent: 'space-between', flexWrap: 'wrap', gap: '10px' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '8px', color: '#1E40AF', fontSize: '0.9rem' }}>
            <AlertCircle size={18} />
            <span>สั่งซื้อในฐานะลูกค้าทั่วไป (Guest Checkout) หรือเข้าสู่ระบบเพื่อสะสมแต้ม</span>
          </div>
          <Link to="/login" style={{ color: '#2563EB', fontWeight: 600, fontSize: '0.85rem', textDecoration: 'underline' }}>
            เข้าสู่ระบบสมาชิก
          </Link>
        </div>
      )}

      <form onSubmit={handleSubmit}>
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(320px, 1fr))', gap: '30px', alignItems: 'start' }}>
          
          {/* Left Column: Delivery Details & Payment */}
          <div>
            {/* Delivery Information */}
            <div style={{ background: '#fff', borderRadius: '14px', padding: '24px', boxShadow: '0 4px 15px rgba(0,0,0,0.03)', border: '1px solid #F1F5F9', marginBottom: '24px' }}>
              <h3 style={{ fontSize: '1.15rem', fontWeight: 700, marginBottom: '16px', color: '#1E293B', display: 'flex', alignItems: 'center', gap: '8px' }}>
                📍 ข้อมูลที่อยู่จัดส่งสินค้า
              </h3>

              <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '16px', marginBottom: '16px' }}>
                <div style={{ gridColumn: 'span 2' }}>
                  <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#475569', marginBottom: '6px' }}>
                    ชื่อ-นามสกุลผู้รับ *
                  </label>
                  <input
                    type="text"
                    required
                    placeholder="เช่น สมชาย ใจดี"
                    value={form.recipient_name}
                    onChange={e => setForm({ ...form, recipient_name: e.target.value })}
                    style={{ width: '100%', padding: '10px 14px', borderRadius: '8px', border: '1px solid #CBD5E1', outline: 'none' }}
                  />
                </div>

                <div>
                  <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#475569', marginBottom: '6px' }}>
                    เบอร์โทรศัพท์ติดต่อ *
                  </label>
                  <input
                    type="tel"
                    required
                    placeholder="08x-xxx-xxxx"
                    value={form.phone}
                    onChange={e => setForm({ ...form, phone: e.target.value })}
                    style={{ width: '100%', padding: '10px 14px', borderRadius: '8px', border: '1px solid #CBD5E1', outline: 'none' }}
                  />
                </div>

                <div>
                  <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#475569', marginBottom: '6px' }}>
                    อีเมล (สำหรับส่งใบเสร็จ)
                  </label>
                  <input
                    type="email"
                    placeholder="example@gmail.com"
                    value={form.email}
                    onChange={e => setForm({ ...form, email: e.target.value })}
                    style={{ width: '100%', padding: '10px 14px', borderRadius: '8px', border: '1px solid #CBD5E1', outline: 'none' }}
                  />
                </div>

                <div style={{ gridColumn: 'span 2' }}>
                  <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#475569', marginBottom: '6px' }}>
                    ที่อยู่ (บ้านเลขที่ / หมู่บ้าน / อาคาร / ถนน) *
                  </label>
                  <input
                    type="text"
                    required
                    placeholder="เช่น 123/45 ซอยสุขุมวิท 55"
                    value={form.address_line}
                    onChange={e => setForm({ ...form, address_line: e.target.value })}
                    style={{ width: '100%', padding: '10px 14px', borderRadius: '8px', border: '1px solid #CBD5E1', outline: 'none' }}
                  />
                </div>

                <div>
                  <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#475569', marginBottom: '6px' }}>
                    แขวง / ตำบล
                  </label>
                  <input
                    type="text"
                    placeholder="คลองตันเหนือ"
                    value={form.subdistrict}
                    onChange={e => setForm({ ...form, subdistrict: e.target.value })}
                    style={{ width: '100%', padding: '10px 14px', borderRadius: '8px', border: '1px solid #CBD5E1', outline: 'none' }}
                  />
                </div>

                <div>
                  <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#475569', marginBottom: '6px' }}>
                    เขต / อำเภอ
                  </label>
                  <input
                    type="text"
                    placeholder="วัฒนา"
                    value={form.district}
                    onChange={e => setForm({ ...form, district: e.target.value })}
                    style={{ width: '100%', padding: '10px 14px', borderRadius: '8px', border: '1px solid #CBD5E1', outline: 'none' }}
                  />
                </div>

                <div>
                  <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#475569', marginBottom: '6px' }}>
                    จังหวัด *
                  </label>
                  <select
                    value={form.province}
                    onChange={e => setForm({ ...form, province: e.target.value })}
                    style={{ width: '100%', padding: '10px 14px', borderRadius: '8px', border: '1px solid #CBD5E1', outline: 'none', background: '#fff' }}
                  >
                    {THAI_PROVINCES.map(p => (
                      <option key={p} value={p}>{p}</option>
                    ))}
                  </select>
                </div>

                <div>
                  <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#475569', marginBottom: '6px' }}>
                    รหัสไปรษณีย์ *
                  </label>
                  <input
                    type="text"
                    required
                    placeholder="10110"
                    value={form.postal_code}
                    onChange={e => setForm({ ...form, postal_code: e.target.value })}
                    style={{ width: '100%', padding: '10px 14px', borderRadius: '8px', border: '1px solid #CBD5E1', outline: 'none' }}
                  />
                </div>

                <div style={{ gridColumn: 'span 2' }}>
                  <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#475569', marginBottom: '6px' }}>
                    หมายเหตุเพิ่มเติม (ถ้ามี)
                  </label>
                  <input
                    type="text"
                    placeholder="เช่น ฝากไว้กับรปภ. หรือ โทรแจ้งก่อนส่ง"
                    value={form.notes}
                    onChange={e => setForm({ ...form, notes: e.target.value })}
                    style={{ width: '100%', padding: '10px 14px', borderRadius: '8px', border: '1px solid #CBD5E1', outline: 'none' }}
                  />
                </div>
              </div>
            </div>

            {/* Payment Method */}
            <div style={{ background: '#fff', borderRadius: '14px', padding: '24px', boxShadow: '0 4px 15px rgba(0,0,0,0.03)', border: '1px solid #F1F5F9' }}>
              <h3 style={{ fontSize: '1.15rem', fontWeight: 700, marginBottom: '16px', color: '#1E293B', display: 'flex', alignItems: 'center', gap: '8px' }}>
                💳 ช่องทางการชำระเงิน
              </h3>

              <div style={{ display: 'flex', flexDirection: 'column', gap: '12px', marginBottom: '20px' }}>
                {/* Bank Transfer Option */}
                <label style={{ display: 'flex', alignItems: 'center', gap: '12px', padding: '14px', borderRadius: '10px', border: paymentMethod === 'bank_transfer' ? '2px solid #E11D48' : '1px solid #E2E8F0', background: paymentMethod === 'bank_transfer' ? '#FFF1F2' : '#fff', cursor: 'pointer' }}>
                  <input
                    type="radio"
                    name="payment"
                    value="bank_transfer"
                    checked={paymentMethod === 'bank_transfer'}
                    onChange={() => setPaymentMethod('bank_transfer')}
                  />
                  <Building size={20} color={paymentMethod === 'bank_transfer' ? '#E11D48' : '#64748B'} />
                  <div>
                    <strong style={{ display: 'block', fontSize: '0.95rem' }}>โอนเงินผ่านธนาคาร / สแกน PromptPay</strong>
                    <span style={{ fontSize: '0.8rem', color: '#64748B' }}>โอนเงินและแนบสลิปเพื่อยืนยันคำสั่งซื้อ</span>
                  </div>
                </label>

                {/* Credit Card Option */}
                <label style={{ display: 'flex', alignItems: 'center', gap: '12px', padding: '14px', borderRadius: '10px', border: paymentMethod === 'credit_card' ? '2px solid #E11D48' : '1px solid #E2E8F0', background: paymentMethod === 'credit_card' ? '#FFF1F2' : '#fff', cursor: 'pointer' }}>
                  <input
                    type="radio"
                    name="payment"
                    value="credit_card"
                    checked={paymentMethod === 'credit_card'}
                    onChange={() => setPaymentMethod('credit_card')}
                  />
                  <CreditCard size={20} color={paymentMethod === 'credit_card' ? '#E11D48' : '#64748B'} />
                  <div>
                    <strong style={{ display: 'block', fontSize: '0.95rem' }}>บัตรเครดิต / เดบิต</strong>
                    <span style={{ fontSize: '0.8rem', color: '#64748B' }}>รองรับ Visa, Mastercard, JCB ปลอดภัย 100%</span>
                  </div>
                </label>
              </div>

              {/* Bank Details when bank_transfer selected */}
              {paymentMethod === 'bank_transfer' && (
                <div style={{ background: '#F8FAFC', borderRadius: '12px', padding: '16px', border: '1px solid #E2E8F0', marginBottom: '16px' }}>
                  <span style={{ fontSize: '0.85rem', fontWeight: 700, color: '#475569', display: 'block', marginBottom: '10px' }}>
                    บัญชีธนาคารสำหรับโอนชำระเงิน:
                  </span>
                  
                  {/* KBANK */}
                  <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', background: '#fff', padding: '10px 14px', borderRadius: '8px', border: '1px solid #E2E8F0', marginBottom: '8px' }}>
                    <div>
                      <strong style={{ color: '#047857' }}>กสิกรไทย (KBANK)</strong>
                      <div style={{ fontSize: '0.85rem', color: '#1E293B' }}>123-4-56789-0 (บจก. ซี-ทาวน์)</div>
                    </div>
                    <button
                      type="button"
                      onClick={() => handleCopy('1234567890', 'kbank')}
                      style={{ padding: '6px 12px', borderRadius: '6px', border: '1px solid #CBD5E1', background: '#F8FAFC', fontSize: '0.8rem', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '4px' }}
                    >
                      {copiedBank === 'kbank' ? <Check size={14} color="#059669" /> : <Copy size={14} />}
                      {copiedBank === 'kbank' ? 'คัดลอกแล้ว' : 'คัดลอก'}
                    </button>
                  </div>

                  {/* SCB */}
                  <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', background: '#fff', padding: '10px 14px', borderRadius: '8px', border: '1px solid #E2E8F0', marginBottom: '12px' }}>
                    <div>
                      <strong style={{ color: '#4C1D95' }}>ไทยพาณิชย์ (SCB)</strong>
                      <div style={{ fontSize: '0.85rem', color: '#1E293B' }}>987-6-54321-0 (บจก. ซี-ทาวน์)</div>
                    </div>
                    <button
                      type="button"
                      onClick={() => handleCopy('9876543210', 'scb')}
                      style={{ padding: '6px 12px', borderRadius: '6px', border: '1px solid #CBD5E1', background: '#F8FAFC', fontSize: '0.8rem', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '4px' }}
                    >
                      {copiedBank === 'scb' ? <Check size={14} color="#059669" /> : <Copy size={14} />}
                      {copiedBank === 'scb' ? 'คัดลอกแล้ว' : 'คัดลอก'}
                    </button>
                  </div>

                  {/* Slip Upload Area */}
                  <div>
                    <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#475569', marginBottom: '6px' }}>
                      แนบหลักฐานการโอนเงิน (สลิป):
                    </label>
                    <input
                      type="file"
                      accept="image/*"
                      onChange={handleSlipUpload}
                      style={{ fontSize: '0.85rem' }}
                    />
                    {slipPreview && (
                      <div style={{ marginTop: '10px' }}>
                        <img
                          src={slipPreview}
                          alt="Slip Preview"
                          style={{ maxHeight: '140px', borderRadius: '8px', border: '1px solid #CBD5E1' }}
                        />
                      </div>
                    )}
                  </div>
                </div>
              )}
            </div>
          </div>

          {/* Right Column: Order Summary */}
          <div style={{ background: '#fff', borderRadius: '14px', padding: '24px', boxShadow: '0 4px 15px rgba(0,0,0,0.03)', border: '1px solid #F1F5F9', position: 'sticky', top: '20px' }}>
            <h3 style={{ fontSize: '1.15rem', fontWeight: 700, marginBottom: '16px', color: '#1E293B', display: 'flex', alignItems: 'center', gap: '8px' }}>
              🛍️ สรุปรายการสินค้า ({cartItems.length} รายการ)
            </h3>

            {/* Items list */}
            <div style={{ maxHeight: '280px', overflowY: 'auto', marginBottom: '20px', paddingRight: '4px' }}>
              {cartItems.map(item => {
                const p = item.expand?.product || {};
                const v = item.expand?.variant || {};
                const price = v.sale_price || v.selling_price || item.unit_price || 0;
                return (
                  <div key={item.id} style={{ display: 'flex', gap: '12px', alignItems: 'center', marginBottom: '14px', paddingBottom: '12px', borderBottom: '1px solid #F1F5F9' }}>
                    <img
                      src={v.image_url || p.main_image || '/images/products/placeholder.jpg'}
                      alt={p.name || 'Sneaker'}
                      style={{ width: '56px', height: '56px', borderRadius: '8px', objectFit: 'cover', background: '#F8FAFC' }}
                      onError={e => { e.target.src = '/images/products/placeholder.jpg'; }}
                    />
                    <div style={{ flex: 1, minWidth: 0 }}>
                      <div style={{ fontWeight: 600, fontSize: '0.9rem', color: '#1E293B', whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>
                        {p.name || 'รองเท้าผ้าใบ C-TOWN'}
                      </div>
                      <div style={{ fontSize: '0.78rem', color: '#64748B' }}>
                        สี: {v.color || 'มาตรฐาน'} | ไซซ์: {v.size || '-'}
                      </div>
                      <div style={{ fontSize: '0.85rem', fontWeight: 700, color: '#E11D48', marginTop: '2px' }}>
                        {formatPrice(price)} x {item.quantity}
                      </div>
                    </div>
                    <div style={{ fontWeight: 700, fontSize: '0.9rem', color: '#1E293B' }}>
                      {formatPrice(price * item.quantity)}
                    </div>
                  </div>
                );
              })}
            </div>

            {/* Coupon Code Input */}
            <div style={{ marginBottom: '20px' }}>
              <div style={{ display: 'flex', gap: '8px' }}>
                <input
                  type="text"
                  placeholder="กรอกโค้ดคูปองส่วนลด"
                  value={couponCode}
                  onChange={e => setCouponCode(e.target.value.toUpperCase())}
                  style={{ flex: 1, padding: '8px 12px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '0.85rem', textTransform: 'uppercase' }}
                />
                <button
                  type="button"
                  onClick={handleCoupon}
                  style={{ padding: '8px 16px', borderRadius: '8px', background: '#1E293B', color: '#fff', border: 'none', fontSize: '0.85rem', fontWeight: 600, cursor: 'pointer' }}
                >
                  ใช้คูปอง
                </button>
              </div>
              {couponMsg && (
                <div style={{ fontSize: '0.8rem', marginTop: '6px', color: couponMsg.startsWith('✅') ? '#059669' : '#DC2626' }}>
                  {couponMsg}
                </div>
              )}
            </div>

            {/* Financial Totals */}
            <div style={{ fontSize: '0.9rem', color: '#64748B', lineHeight: '2' }}>
              <div style={{ display: 'flex', justifyContent: 'space-between' }}>
                <span>ราคาสินค้ารวม:</span>
                <span style={{ color: '#1E293B', fontWeight: 600 }}>{formatPrice(subtotal)}</span>
              </div>
              {discountAmount > 0 && (
                <div style={{ display: 'flex', justifyContent: 'space-between', color: '#059669' }}>
                  <span>ส่วนลดคูปอง:</span>
                  <span style={{ fontWeight: 600 }}>- {formatPrice(discountAmount)}</span>
                </div>
              )}
              <div style={{ display: 'flex', justifyContent: 'space-between' }}>
                <span>ค่าจัดส่ง:</span>
                <span style={{ color: '#1E293B', fontWeight: 600 }}>
                  {shippingFee === 0 ? <span style={{ color: '#059669' }}>ฟรี (ครบ ฿2,500)</span> : formatPrice(shippingFee)}
                </span>
              </div>
              <div style={{ display: 'flex', justifyContent: 'space-between', borderTop: '1px solid #E2E8F0', paddingTop: '10px', marginTop: '10px', fontSize: '1.2rem', fontWeight: 800, color: '#E11D48' }}>
                <span>ยอดชำระสุทธิ:</span>
                <span>{formatPrice(grandTotal)}</span>
              </div>
            </div>

            {/* Submit Button */}
            <button
              type="submit"
              disabled={loading}
              style={{
                width: '100%',
                padding: '14px',
                borderRadius: '10px',
                background: '#E11D48',
                color: '#fff',
                fontSize: '1.05rem',
                fontWeight: 700,
                border: 'none',
                marginTop: '20px',
                cursor: loading ? 'not-allowed' : 'pointer',
                boxShadow: '0 4px 14px rgba(225, 29, 72, 0.35)',
                transition: 'all 0.2s',
                opacity: loading ? 0.7 : 1
              }}
            >
              {loading ? 'กำลังบันทึกคำสั่งซื้อ...' : `ยืนยันการสั่งซื้อ (${formatPrice(grandTotal)})`}
            </button>
            <p style={{ textAlign: 'center', fontSize: '0.75rem', color: '#94A3B8', marginTop: '10px' }}>
              🔒 ปลอดภัยด้วยมาตรฐานความปลอดภัยระดับสากล
            </p>
          </div>
        </div>
      </form>
    </div>
  );
}
