import React, { useState, useEffect, useRef } from 'react';
import { useSearchParams } from 'react-router-dom';
import { pb, ctownFetch, formatDate } from '../../lib/pb';
import { useAuth } from '../../contexts/AuthContext';
import {
  Send,
  MessageCircle,
  User,
  Clock,
  CheckCheck,
  Sparkles,
  Package,
  CreditCard,
  Truck,
  RotateCcw
} from 'lucide-react';

export default function ChatBox({ compact = false }) {
  const [searchParams] = useSearchParams();
  const { user, isLoggedIn } = useAuth();

  const [conversationId, setConversationId] = useState(null);
  const [messages, setMessages] = useState([]);
  const [text, setText] = useState('');
  const [sending, setSending] = useState(false);
  const [isTyping, setIsTyping] = useState(false);
  const [guestName, setGuestName] = useState(() => {
    try {
      return localStorage.getItem('ctown_guest_chat_name') || 'ลูกค้า';
    } catch (_) {
      return 'ลูกค้า';
    }
  });
  const [editingName, setEditingName] = useState(false);
  const [nameInput, setNameInput] = useState(guestName);

  const bottomRef = useRef(null);

  const quickQuestions = [
    { label: '👟 ปรึกษาไซซ์รองเท้า', text: 'สวัสดีครับ อยากปรึกษาเรื่องไซซ์รองเท้า เท้ายาวประมาณ ... ควรเลือกไซซ์ไหนดีครับ' },
    { label: '📦 สอบถามสถานะคำสั่งซื้อ', text: searchParams.get('order') ? `สวัสดีครับ ขอสอบถามสถานะคำสั่งซื้อ #${searchParams.get('order')} ครับ` : 'สวัสดีครับ ต้องการตรวจสอบสถานะคำสั่งซื้อครับ' },
    { label: '💸 แจ้งชำระเงิน / สลิป', text: 'โอนเงินเรียบร้อยแล้วครับ รบกวนตรวจสอบยอดและจัดส่งให้หน่อยครับ' },
    { label: '🚚 สอบถามรอบจัดส่ง', text: 'สั่งซื้อวันนี้ จัดส่งรอบกี่โมง และกี่วันถึงครับ' },
  ];

  useEffect(() => {
    let unsub = null;

    async function setupChat() {
      try {
        let guestId = localStorage.getItem('ctown_guest_chat_id');
        if (!guestId) {
          guestId = 'guest_' + Math.random().toString(36).slice(2, 9);
          localStorage.setItem('ctown_guest_chat_id', guestId);
        }

        const activeName = isLoggedIn ? (user?.name || 'ลูกค้า') : guestName;

        const convRes = await ctownFetch('/chat/conversation', {
          method: 'POST',
          body: {
            guest_id: guestId,
            guest_name: activeName
          }
        });

        const cid = convRes.conversation.id;
        setConversationId(cid);

        // Load existing messages
        const msgs = await pb.collection('messages').getList(1, 100, {
          filter: `conversation = "${cid}"`,
          sort: 'id',
        });
        setMessages(msgs.items || []);

        // Subscribe to real-time messages
        unsub = pb.collection('messages').subscribe('*', (e) => {
          if (e.action === 'create' && e.record?.conversation === cid) {
            setMessages(prev => {
              if (prev.some(m => m.id === e.record.id)) return prev;
              return [...prev, e.record];
            });
            setIsTyping(false);
          }
        });
      } catch (err) {
        console.error('Chat setup err:', err);
      }
    }

    setupChat();

    const orderParam = searchParams.get('order');
    if (orderParam) {
      setText(`สวัสดีครับ ขอสอบถามสถานะคำสั่งซื้อ #${orderParam} ครับ`);
    }

    return () => {
      if (unsub) {
        try { unsub(); } catch (_) {}
      }
    };
  }, [isLoggedIn, user]);

  useEffect(() => {
    bottomRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [messages, isTyping]);

  async function handleSend(e) {
    e?.preventDefault();
    if (!text.trim() || sending) return;

    const userText = text.trim();
    setText('');
    setSending(true);

    let activeCid = conversationId;
    let guestId = localStorage.getItem('ctown_guest_chat_id');
    if (!guestId) {
      guestId = 'guest_' + Math.random().toString(36).slice(2, 9);
      localStorage.setItem('ctown_guest_chat_id', guestId);
    }

    if (!activeCid) {
      activeCid = 'conv_' + guestId.replace(/[^a-zA-Z0-9]/g, '').slice(0, 10);
      setConversationId(activeCid);
    }

    const senderId = isLoggedIn ? (user?.id || 'usr_cust') : guestId;

    // 1. Optimistic UI update immediately
    const clientMsg = {
      id: 'msg_' + Date.now(),
      conversation: activeCid,
      sender_id: senderId,
      sender_type: 'CUSTOMER',
      sender_role: 'CUSTOMER',
      message_text: userText,
      created: new Date().toISOString()
    };
    setMessages(prev => [...prev, clientMsg]);

    try {
      // 2. Send to backend/store
      await ctownFetch('/chat/send', {
        method: 'POST',
        body: {
          conversation_id: activeCid,
          message_text: userText,
          sender_id: senderId,
          sender_type: 'CUSTOMER'
        }
      });

      // 3. Automated Store Assistant Response
      triggerAutoReply(activeCid, userText);
    } catch (err) {
      console.error('Send error:', err);
    } finally {
      setSending(false);
    }
  }

  function triggerAutoReply(cid, customerMessage) {
    setIsTyping(true);

    setTimeout(async () => {
      const lower = customerMessage.toLowerCase();
      let botReply = '';

      if (lower.includes('ไซซ์') || lower.includes('size') || lower.includes('เบอร์') || lower.includes('ขนาด')) {
        botReply = '👟 ข้อมูลเรื่องไซซ์รองเท้า C-TOWN:\n• สำหรับ Nike และ Adidas ส่วนใหญ่แนะนำเลือกตรงไซซ์ปกติ (True To Size) ครับ หากหน้าเท้ากว้างแนะนำเผื่อ +0.5 ไซซ์\n• สำหรับ New Balance, Converse และ Vans สวมใส่สบายตามเบอร์ปกติครับ\nลูกค้าสามารถแจ้งความยาวเท้า (cm) หรือรุ่นที่สนใจในแชทนี้ได้เลยครับ ทีมงานจะช่วยเทียบไซซ์ให้อย่างแม่นยำครับ ✨';
      } else if (lower.includes('ออเดอร์') || lower.includes('คำสั่งซื้อ') || lower.includes('order') || lower.includes('พัสดุ') || lower.includes('ส่งของ') || lower.includes('ct-ord')) {
        botReply = '📦 การตรวจสอบสถานะพัสดุ:\nทางร้านจัดส่งสินค้าทุกวันจันทร์–เสาร์ ตัดรอบเวลา 14:00 น. โดย Flash Express และ Kerry Express (ส่งฟรีเมื่อสั่งซื้อครบ ฿2,500)\nท่านสามารถตรวจสอบสถานะได้ทันทีที่เมนู "ติดตามคำสั่งซื้อ" หรือแจ้งหมายเลขคำสั่งซื้อในแชทนี้ เพื่อให้แอดมินเช็กให้ได้เลยครับ!';
      } else if (lower.includes('โอน') || lower.includes('สลิป') || lower.includes('ชำระ') || lower.includes('จ่าย') || lower.includes('เงิน')) {
        botReply = '💸 ข้อมูลการชำระเงิน:\nสามารถโอนเงินผ่านบัญชีธนาคาร:\n• ธนาคารกสิกรไทย: 123-4-56789-0 (บจก. ซี-ทาวน์ สเนีกเกอร์ สโตร์)\n• ธนาคารไทยพาณิชย์: 987-6-54321-0\nเมื่อโอนแล้วสามารถแนบสลิปในหน้าสั่งซื้อ หรือส่งรูปสลิปในแชทนี้ได้เลยครับ เจ้าหน้าที่จะตรวจสอบยอดและอนุมัติให้ภายใน 15 นาทีครับ';
      } else {
        botReply = 'ขอบคุณที่ทักแชทเข้ามายัง C-TOWN SNEAKER STORE ครับ! 😊\nทางร้านได้รับข้อความของท่านแล้ว เจ้าหน้าที่กำลังรีบเข้ามาดูแลและตอบกลับโดยเร็วที่สุดครับ (เวลาทำการ 10:00 - 21:00 น.) มีคำถามเรื่องรุ่นรองเท้าหรือไซซ์เพิ่มเติมพิมพ์ทิ้งไว้ได้เลยครับ!';
      }

      try {
        await ctownFetch('/chat/send', {
          method: 'POST',
          body: {
            conversation_id: cid,
            message_text: botReply,
            sender_id: 'bot_c_town_assistant',
            sender_type: 'ADMIN'
          }
        });
      } catch (_) {}

      setIsTyping(false);
    }, 1200);
  }

  const handleSaveName = (e) => {
    e.preventDefault();
    if (!nameInput.trim()) return;
    setGuestName(nameInput.trim());
    try {
      localStorage.setItem('ctown_guest_chat_name', nameInput.trim());
    } catch (_) {}
    setEditingName(false);
  };

  return (
    <div
      className={`ctown-chatbox ${compact ? 'compact' : ''}`}
      style={{
        background: '#fff',
        borderRadius: '16px',
        border: '1px solid #E2E8F0',
        display: 'flex',
        flexDirection: 'column',
        height: compact ? '480px' : '620px',
        boxShadow: '0 10px 30px rgba(0,0,0,0.08)',
        overflow: 'hidden'
      }}
    >
      {/* Chat Header */}
      <div
        style={{
          background: 'linear-gradient(135deg, #1E293B 0%, #0F172A 100%)',
          color: '#fff',
          padding: '16px 20px',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'space-between',
          borderBottom: '1px solid rgba(255,255,255,0.1)'
        }}
      >
        <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
          <div
            style={{
              width: '40px',
              height: '40px',
              background: '#E11D48',
              borderRadius: '50%',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              color: '#fff',
              fontWeight: 800,
              fontSize: '1.1rem'
            }}
          >
            C
          </div>
          <div>
            <h4 style={{ margin: 0, fontSize: '1rem', fontWeight: 700, display: 'flex', alignItems: 'center', gap: '8px' }}>
              ศูนย์บริการลูกค้า C-TOWN
            </h4>
            <div style={{ display: 'flex', alignItems: 'center', gap: '6px', fontSize: '0.78rem', color: '#10B981', marginTop: '2px' }}>
              <span style={{ width: '8px', height: '8px', borderRadius: '50%', background: '#10B981', display: 'inline-block' }} />
              ออนไลน์พร้อมตอบ (10:00 - 21:00 น.)
            </div>
          </div>
        </div>

        {/* Guest name badge */}
        {!isLoggedIn && (
          <div style={{ fontSize: '0.8rem', color: '#94A3B8' }}>
            {editingName ? (
              <form onSubmit={handleSaveName} style={{ display: 'flex', gap: '4px' }}>
                <input
                  type="text"
                  value={nameInput}
                  onChange={e => setNameInput(e.target.value)}
                  style={{ padding: '3px 8px', borderRadius: '4px', border: 'none', fontSize: '0.8rem', width: '90px' }}
                />
                <button type="submit" style={{ background: '#E11D48', color: '#fff', border: 'none', borderRadius: '4px', padding: '3px 6px', fontSize: '0.75rem', cursor: 'pointer' }}>บันทึก</button>
              </form>
            ) : (
              <span onClick={() => setEditingName(true)} style={{ cursor: 'pointer', textDecoration: 'underline' }} title="คลิกเพื่อเปลี่ยนชื่อ">
                {guestName} ✏️
              </span>
            )}
          </div>
        )}
      </div>

      {/* Messages Scroll Area */}
      <div
        style={{
          flex: 1,
          padding: '20px',
          overflowY: 'auto',
          background: '#F8FAFC',
          display: 'flex',
          flexDirection: 'column',
          gap: '12px'
        }}
      >
        {/* Welcome message bubble */}
        <div style={{ display: 'flex', gap: '10px', alignItems: 'flex-start' }}>
          <div style={{ width: '32px', height: '32px', borderRadius: '50%', background: '#E11D48', color: '#fff', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '0.8rem', fontWeight: 700, flexShrink: 0 }}>
            CT
          </div>
          <div style={{ maxWidth: '82%' }}>
            <span style={{ fontSize: '0.75rem', color: '#64748B', display: 'block', marginBottom: '4px' }}>เจ้าหน้าที่ C-TOWN</span>
            <div style={{ background: '#fff', padding: '12px 16px', borderRadius: '4px 16px 16px 16px', border: '1px solid #E2E8F0', color: '#1E293B', fontSize: '0.9rem', lineHeight: 1.5, boxShadow: '0 2px 6px rgba(0,0,0,0.02)' }}>
              ยินดีต้อนรับสู่ C-TOWN SNEAKER STORE ครับ! 👟✨<br />
              มีข้อสงสัยเรื่องไซซ์รองเท้า การจัดส่ง หรือต้องการตรวจสอบออเดอร์ สามารถพิมพ์สอบถามได้เลยครับ ทีมงานพร้อมดูแลครับ
            </div>
          </div>
        </div>

        {/* Message Thread */}
        {messages.map((m, idx) => {
          const isStaff = m.sender_type === 'ADMIN' || m.sender_role === 'ADMIN';
          return (
            <div
              key={m.id || idx}
              style={{
                display: 'flex',
                gap: '10px',
                alignItems: 'flex-start',
                justifyContent: isStaff ? 'flex-start' : 'flex-end'
              }}
            >
              {isStaff && (
                <div style={{ width: '32px', height: '32px', borderRadius: '50%', background: '#E11D48', color: '#fff', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '0.8rem', fontWeight: 700, flexShrink: 0 }}>
                  CT
                </div>
              )}
              <div style={{ maxWidth: '82%', textAlign: isStaff ? 'left' : 'right' }}>
                <span style={{ fontSize: '0.75rem', color: '#64748B', display: 'block', marginBottom: '4px' }}>
                  {isStaff ? 'เจ้าหน้าที่ C-TOWN' : (isLoggedIn ? (user?.name || 'ลูกค้า') : guestName)}
                </span>
                <div
                  style={{
                    background: isStaff ? '#fff' : 'linear-gradient(135deg, #E11D48 0%, #BE123C 100%)',
                    color: isStaff ? '#1E293B' : '#fff',
                    padding: '12px 16px',
                    borderRadius: isStaff ? '4px 16px 16px 16px' : '16px 4px 16px 16px',
                    border: isStaff ? '1px solid #E2E8F0' : 'none',
                    fontSize: '0.9rem',
                    lineHeight: 1.5,
                    boxShadow: '0 2px 6px rgba(0,0,0,0.03)',
                    textAlign: 'left',
                    whiteSpace: 'pre-line'
                  }}
                >
                  {m.message_text}
                </div>
                <span style={{ fontSize: '0.7rem', color: '#94A3B8', marginTop: '4px', display: 'block' }}>
                  {m.created ? new Date(m.created).toLocaleTimeString('th-TH', { hour: '2-digit', minute: '2-digit' }) : ''}
                </span>
              </div>
            </div>
          );
        })}

        {/* Typing Indicator */}
        {isTyping && (
          <div style={{ display: 'flex', gap: '10px', alignItems: 'center' }}>
            <div style={{ width: '32px', height: '32px', borderRadius: '50%', background: '#E11D48', color: '#fff', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '0.8rem', fontWeight: 700, flexShrink: 0 }}>
              CT
            </div>
            <div style={{ background: '#fff', padding: '10px 16px', borderRadius: '16px', border: '1px solid #E2E8F0', fontSize: '0.85rem', color: '#64748B', display: 'flex', alignItems: 'center', gap: '6px' }}>
              <span style={{ fontStyle: 'italic' }}>เจ้าหน้าที่ C-TOWN กำลังพิมพ์...</span>
            </div>
          </div>
        )}

        <div ref={bottomRef} />
      </div>

      {/* Quick Questions Chips */}
      <div style={{ padding: '8px 16px', background: '#F1F5F9', borderTop: '1px solid #E2E8F0', display: 'flex', gap: '8px', overflowX: 'auto', whiteSpace: 'nowrap' }}>
        {quickQuestions.map(q => (
          <button
            key={q.label}
            type="button"
            onClick={() => { setText(q.text); }}
            style={{
              background: '#fff',
              border: '1px solid #CBD5E1',
              borderRadius: '20px',
              padding: '6px 14px',
              fontSize: '0.8rem',
              color: '#334155',
              cursor: 'pointer',
              flexShrink: 0,
              fontWeight: 500
            }}
          >
            {q.label}
          </button>
        ))}
      </div>

      {/* Input Box */}
      <form onSubmit={handleSend} style={{ display: 'flex', padding: '12px 16px', background: '#fff', borderTop: '1px solid #E2E8F0', gap: '8px' }}>
        <input
          type="text"
          placeholder="พิมพ์ข้อความสอบถามร้านค้าที่นี่ (เช่น ปรึกษาไซซ์, เช็กของ)..."
          value={text}
          onChange={e => setText(e.target.value)}
          style={{
            flex: 1,
            border: '1px solid #CBD5E1',
            borderRadius: '24px',
            padding: '10px 18px',
            fontSize: '0.9rem',
            outline: 'none'
          }}
          disabled={sending}
          autoFocus={!compact}
        />
        <button
          type="submit"
          className="btn-primary"
          disabled={!text.trim() || sending}
          style={{
            borderRadius: '50%',
            width: '42px',
            height: '42px',
            padding: 0,
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            cursor: !text.trim() || sending ? 'not-allowed' : 'pointer'
          }}
        >
          <Send size={18} />
        </button>
      </form>
    </div>
  );
}
