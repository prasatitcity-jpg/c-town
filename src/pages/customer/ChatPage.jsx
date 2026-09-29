import React from 'react';
import ChatBox from '../../components/chat/ChatBox';
import { MessageCircle, ShieldCheck, Clock, Truck } from 'lucide-react';

export default function ChatPage() {
  return (
    <div className="chat-page-container" style={{ maxWidth: '800px', margin: '30px auto', padding: '0 16px' }}>
      <div style={{ textAlign: 'center', marginBottom: '24px' }}>
        <h1 style={{ fontSize: '1.8rem', fontWeight: 800, color: '#1E293B', marginBottom: '8px', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '10px' }}>
          <MessageCircle size={28} color="#E11D48" /> แชทกับร้านค้า C-TOWN
        </h1>
        <p style={{ color: '#64748B', fontSize: '0.95rem' }}>
          ปรึกษาไซซ์รองเท้า เช็กสต็อกสินค้า ติดตามพัสดุ หรือสอบถามข้อมูลเพิ่มเติมได้ทันที
        </p>

        {/* Feature badges */}
        <div style={{ display: 'flex', justifyContent: 'center', gap: '20px', flexWrap: 'wrap', marginTop: '16px' }}>
          <span style={{ fontSize: '0.8rem', color: '#475569', display: 'inline-flex', alignItems: 'center', gap: '6px' }}>
            <Clock size={15} color="#E11D48" /> ตอบกลับรวดเร็ว 10:00–21:00
          </span>
          <span style={{ fontSize: '0.8rem', color: '#475569', display: 'inline-flex', alignItems: 'center', gap: '6px' }}>
            <ShieldCheck size={15} color="#059669" /> สินค้าแท้ 100% มีประกัน
          </span>
          <span style={{ fontSize: '0.8rem', color: '#475569', display: 'inline-flex', alignItems: 'center', gap: '6px' }}>
            <Truck size={15} color="#2563EB" /> ส่งด่วนทั่วประเทศ
          </span>
        </div>
      </div>

      <ChatBox compact={false} />
    </div>
  );
}
