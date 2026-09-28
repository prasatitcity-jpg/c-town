import React from 'react';
import { Link } from 'react-router-dom';
import { MessageCircle, MapPin, Phone, Mail, Clock } from 'lucide-react';

export default function Footer() {
  return (
    <footer className="ctown-footer">
      <div className="footer-container">
        <div className="footer-grid">
          {/* Brand */}
          <div className="footer-brand">
            <div className="footer-logo">
              <span className="logo-c">C</span><span className="logo-town">-TOWN</span>
            </div>
            <p className="footer-tagline">Step Into Your Style</p>
            <p className="footer-desc">
              ร้านรองเท้าผ้าใบสตรีทแวร์ระดับพรีเมียม คัดสรรสินค้าแท้จากแบรนด์ชั้นนำทั่วโลก
            </p>
            <div className="footer-socials">
              <a href="https://facebook.com/ctownsneakers" target="_blank" rel="noreferrer" className="social-icon" id="footer-facebook" title="Facebook">
                <svg width="18" height="18" fill="currentColor" viewBox="0 0 24 24"><path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/></svg>
              </a>
              <a href="https://instagram.com/ctown.sneakers" target="_blank" rel="noreferrer" className="social-icon" id="footer-instagram" title="Instagram">
                <svg width="18" height="18" fill="currentColor" viewBox="0 0 24 24"><path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z"/></svg>
              </a>
              <a href="https://lin.ee/ctown_sneakers" target="_blank" rel="noreferrer" className="social-icon" id="footer-line">
                <MessageCircle size={18} />
              </a>
            </div>
          </div>

          {/* Quick Links */}
          <div className="footer-col">
            <h4 className="footer-col-title">หมวดหมู่สินค้า</h4>
            <ul className="footer-links">
              <li><Link to="/products?category=men">รองเท้าผ้าใบผู้ชาย</Link></li>
              <li><Link to="/products?category=women">รองเท้าผ้าใบผู้หญิง</Link></li>
              <li><Link to="/products?category=unisex">Unisex</Link></li>
              <li><Link to="/products?category=streetwear">Streetwear</Link></li>
              <li><Link to="/products?new=1">สินค้าใหม่</Link></li>
              <li><Link to="/products?bestseller=1">สินค้าขายดี</Link></li>
              <li><Link to="/promotions">โปรโมชั่น</Link></li>
            </ul>
          </div>

          {/* Customer Service */}
          <div className="footer-col">
            <h4 className="footer-col-title">บริการลูกค้า</h4>
            <ul className="footer-links">
              <li><Link to="/track-order">ติดตามคำสั่งซื้อ</Link></li>
              <li><Link to="/orders">ประวัติการสั่งซื้อ</Link></li>
              <li><Link to="/chat">ติดต่อร้านค้า</Link></li>
              <li><Link to="/account">ข้อมูลบัญชีของฉัน</Link></li>
              <li><Link to="/contact#return-policy">นโยบายการคืนสินค้า</Link></li>
              <li><Link to="/contact#privacy">นโยบายความเป็นส่วนตัว</Link></li>
              <li><Link to="/contact#terms">เงื่อนไขการใช้บริการ</Link></li>
            </ul>
          </div>

          {/* Contact Info */}
          <div className="footer-col">
            <h4 className="footer-col-title">ติดต่อเรา</h4>
            <ul className="footer-contact-list">
              <li>
                <MapPin size={15} />
                <span>88 C-TOWN Complex, สุขุมวิท<br />คลองเตย, กรุงเทพฯ 10110</span>
              </li>
              <li>
                <Phone size={15} />
                <a href="tel:028889999">02-888-9999</a>
              </li>
              <li>
                <Mail size={15} />
                <a href="mailto:contact@c-town-sneaker.com">contact@c-town-sneaker.com</a>
              </li>
              <li>
                <Clock size={15} />
                <span>ทุกวัน 10:00–21:00 น.</span>
              </li>
            </ul>
          </div>
        </div>

        <div className="footer-bottom">
          <p>© {new Date().getFullYear()} C-TOWN SNEAKER STORE. All rights reserved.</p>
          <p>สินค้าแท้ 100% | บริการจัดส่งทั่วประเทศ</p>
        </div>
      </div>
    </footer>
  );
}
