import React, { useState, useEffect } from 'react';
import { pb, formatPrice, formatDate } from '../../lib/pb';
import { Tag, Copy, Check, Sparkles } from 'lucide-react';
import { Link } from 'react-router-dom';

export default function PromotionsPage() {
  const [coupons, setCoupons] = useState([]);
  const [copiedCode, setCopiedCode] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    (async () => {
      try {
        const list = await pb.collection('coupons').getList(1, 20, {
          filter: 'is_active = true',
          sort: '-created',
        });
        setCoupons(list.items);
      } catch (err) {
        console.error(err);
      } finally {
        setLoading(false);
      }
    })();
  }, []);

  const handleCopy = (code) => {
    navigator.clipboard.writeText(code);
    setCopiedCode(code);
    setTimeout(() => setCopiedCode(null), 2500);
  };

  return (
    <div className="promotions-page">
      <div className="promo-hero">
        <div className="promo-badge"><Sparkles size={16} /> สิทธิพิเศษเฉพาะคุณ</div>
        <h1>โปรโมชั่น & โค้ดส่วนลด</h1>
        <p>เลือกรับคูปองส่วนลดพิเศษเพื่อใช้เป็นส่วนลดในการสั่งซื้อรองเท้าคู่โปรดของคุณ</p>
      </div>

      <div className="promo-container">
        {loading ? (
          <div className="loading-spinner"><div className="spinner" /></div>
        ) : coupons.length === 0 ? (
          <div className="empty-promo">
            <Tag size={48} strokeWidth={1} />
            <p>ขณะนี้ยังไม่มีโปรโมชั่นใหม่ ติดตามได้เร็วๆ นี้!</p>
          </div>
        ) : (
          <div className="coupon-grid">
            {coupons.map(c => {
              const isCopied = copiedCode === c.code;
              let discountDesc = '';
              if (c.discount_type === 'fixed_amount') {
                discountDesc = `ลดทันที ${formatPrice(c.discount_value)}`;
              } else if (c.discount_type === 'percentage') {
                discountDesc = `ลดทันที ${c.discount_value}% (สูงสุด ${formatPrice(c.max_discount || 0)})`;
              } else if (c.discount_type === 'free_shipping') {
                discountDesc = 'ส่งฟรีไม่มีขั้นต่ำ';
              }

              return (
                <div key={c.id} className="coupon-card">
                  <div className="coupon-notch top" />
                  <div className="coupon-notch bottom" />

                  <div className="coupon-main">
                    <span className="coupon-tag-badge">{c.discount_type.replace('_', ' ').toUpperCase()}</span>
                    <h3 className="coupon-discount-text">{discountDesc}</h3>
                    <p className="coupon-title">{c.name || c.description}</p>
                    {c.min_order_amount > 0 && (
                      <span className="coupon-condition">ขั้นต่ำ {formatPrice(c.min_order_amount)}</span>
                    )}
                    {c.end_date && (
                      <span className="coupon-expiry">ใช้ได้ถึง {formatDate(c.end_date)}</span>
                    )}
                  </div>

                  <div className="coupon-side">
                    <div className="coupon-code-box">{c.code}</div>
                    <button
                      type="button"
                      className={`btn-copy-code ${isCopied ? 'copied' : ''}`}
                      onClick={() => handleCopy(c.code)}
                    >
                      {isCopied ? <><Check size={14} /> คัดลอกแล้ว</> : <><Copy size={14} /> คัดลอกโค้ด</>}
                    </button>
                  </div>
                </div>
              );
            })}
          </div>
        )}

        <div className="promo-cta-box">
          <h3>พร้อมช้อปแล้วหรือยัง?</h3>
          <p>คัดลอกโค้ดแล้วไปเลือกซื้อรองเท้าผ้าใบที่คุณชื่นชอบได้ทันที</p>
          <Link to="/products" className="btn-primary">ไปที่ร้านค้า</Link>
        </div>
      </div>
    </div>
  );
}
