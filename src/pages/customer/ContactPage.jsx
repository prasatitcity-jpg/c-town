import React from 'react';
import { MapPin, Phone, Mail, Clock, ShieldCheck, RefreshCw, MessageSquare } from 'lucide-react';
import { Link } from 'react-router-dom';

export default function ContactPage() {
  return (
    <div className="contact-page">
      <div className="contact-hero">
        <h1>ติดต่อ C-TOWN SNEAKER STORE</h1>
        <p>ยินดีให้บริการและตอบทุกข้อสงสัยเกี่ยวกับสินค้าและคำสั่งซื้อของคุณ</p>
      </div>

      <div className="contact-container">
        <div className="contact-grid">
          {/* Contact Details */}
          <div className="contact-info-card">
            <h3>ข้อมูลการติดต่อ</h3>

            <div className="info-block">
              <div className="icon-wrap"><MapPin size={20} /></div>
              <div>
                <strong>หน้าร้าน C-TOWN Flagship Store</strong>
                <p>88 อาคาร C-TOWN สุขุมวิท แขวงคลองเตย เขตคลองเตย กรุงเทพมหานคร 10110</p>
              </div>
            </div>

            <div className="info-block">
              <div className="icon-wrap"><Phone size={20} /></div>
              <div>
                <strong>เบอร์โทรศัพท์</strong>
                <p><a href="tel:028889999">02-888-9999</a> (ฝ่ายบริการลูกค้า)</p>
              </div>
            </div>

            <div className="info-block">
              <div className="icon-wrap"><Mail size={20} /></div>
              <div>
                <strong>อีเมล</strong>
                <p><a href="mailto:contact@c-town-sneaker.com">contact@c-town-sneaker.com</a></p>
              </div>
            </div>

            <div className="info-block">
              <div className="icon-wrap"><Clock size={20} /></div>
              <div>
                <strong>เวลาทำการ</strong>
                <p>เปิดให้บริการทุกวัน: 10:00 – 21:00 น.</p>
              </div>
            </div>

            <div className="live-chat-cta">
              <MessageSquare size={24} />
              <div>
                <strong>ต้องการสอบถามทันที?</strong>
                <p>พูดคุยกับแอดมินผ่านระบบแชตสดออนไลน์ได้เลย</p>
              </div>
              <Link to="/chat" className="btn-chat-now">เปิดแชตสด</Link>
            </div>
          </div>

          {/* Policy Information */}
          <div className="contact-policies-card">
            <h3>นโยบายการให้บริการ</h3>

            <div className="policy-item" id="return-policy">
              <div className="policy-title">
                <RefreshCw size={20} />
                <h4>นโยบายการเปลี่ยนและคืนสินค้า</h4>
              </div>
              <p>
                ลูกค้าสามารถขอเปลี่ยนไซซ์หรือคืนสินค้าได้ภายใน 7 วันทำการ นับจากวันที่ได้รับสินค้า
                โดยสินค้าจะต้องอยู่ในสภาพสมบูรณ์ ไม่ผ่านการใช้งาน ป้ายราคาและกล่องรองเท้าต้องอยู่ครบถ้วน
              </p>
            </div>

            <div className="policy-item" id="authenticity">
              <div className="policy-title">
                <ShieldCheck size={20} />
                <h4>การรับประกันสินค้าของแท้ 100%</h4>
              </div>
              <p>
                สินค้าทุกคู่ที่จัดจำหน่ายโดย C-TOWN ได้รับการตรวจสอบอย่างละเอียดจากผู้เชี่ยวชาญ
                รับประกันของแท้ 100% หากพบสินค้าไม่แท้ยินดีคืนเงินเต็มจำนวน 200% ทันที
              </p>
            </div>

            <div className="policy-item" id="privacy">
              <div className="policy-title">
                <ShieldCheck size={20} />
                <h4>นโยบายความเป็นส่วนตัว</h4>
              </div>
              <p>
                เราให้ความสำคัญสูงสุดกับความเป็นส่วนตัวและความปลอดภัยของข้อมูลของคุณ
                ข้อมูลส่วนบุคคลและข้อมูลการชำระเงินจะถูกจัดเก็บและเข้ารหัสตามมาตรฐานความปลอดภัย
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
