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
  HelpCircle,
  Package,
  CreditCard,
  Truck
} from 'lucide-react';

export default function ChatBox({ compact = false }) {
  const [searchParams] = useSearchParams();
  const { user, isLoggedIn } = useAuth();

  const [conversationId, setConversationId] = useState(null);
  const [messages, setMessages] = useState([]);
  const [text, setText] = useState('');
  const [sending, setSending] = useState(false);
  const [loading, setLoading] = useState(true);
  const [guestName, setGuestName] = useState(() => localStorage.getItem('ctown_guest_chat_name') || 'ลูกค้า');
  const [editingName, setEditingName] = useState(false);
  const [nameInput, setNameInput] = useState(guestName);
  
  const bottomRef = useRef(null);

  // Quick inquiry chips
  const quickQuestions = [
    { label: '👟 ปรึกษาไซซ์รองเท้า', text: 'สวัสดีครับ อยากปรึกษาเรื่องไซซ์รองเท้า เท้ายาวประมาณ ... ควรเลือกไซซ์ไหนดีครับ' },
    { label: '📦 สอบถามสถานะคำสั่งซื้อ', text: searchParams.get('order') ? `สวัสดีครับ ขอสอบถามสถานะคำสั่งซื้อ #${searchParams.get('order')} ครับ` : 'สวัสดีครับ ต้องการตรวจสอบสถานะคำสั่งซื้อครับ' },
    { label: '💸 แจ้งชำระเงิน / สลิป', text: 'โอนเงินเรียบร้อยแล้วครับ รบกวนตรวจสอบยอดและจัดส่งให้หน่อยครับ' },
    { label: '🚚 สอบถามรอบจัดส่ง', text: 'สั่งซื้อวันนี้ จัดส่งรอบกี่โมง และกี่วันถึงครับ' },
  ];

  useEffect(() => {
    initChat();

    // If order param passed, set initial text
    const orderParam = searchParams.get('order');
    if (orderParam) {
      setText(`สวัสดีครับ ขอสอบถามสถานะคำสั่งซื้อ #${orderParam} ครับ`);
    }
  }, [isLoggedIn, user]);

  useEffect(() => {
    bottomRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [messages]);

  async function initChat() {
    setLoading(true);
    try {
      // 1. Determine guest ID or user ID
      let guestId = localStorage.getItem('ctown_guest_chat_id');
      if (!guestId) {
        guestId = 'guest_' + Math.random().toString(36).slice(2, 9);
        localStorage.setItem('ctown_guest_chat_id', guestId);
      }

      const activeName = isLoggedIn ? user?.name : guestName;

      // 2. Fetch or create conversation
      const convRes = await ctownFetch('/chat/conversation', {
        method: 'POST',
        body: {
          guest_id: guestId,
          guest_name: activeName
        }
      });

      const cid = convRes.conversation.id;
      setConversationId(cid);
      await loadMessages(cid);

      // Subscribe to messages realtime
      let unsub = null;
      try {
        pb.collection('messages').subscribe('*', (e) => {
          if (e.action === 'create' && e.record.conversation === cid) {
            setMessages(prev => {
              if (prev.some(m => m.id === e.record.id)) return prev;
              return [...prev, e.record];
            });
            bottomRef.current?.scrollIntoView({ behavior: 'smooth' });
          }
        }).then(u => { unsub = u; });
      } catch (_) {}

      return () => { if (unsub) unsub(); };
    } catch (err) {
      console.error('Chat init error:', err);
    } finally {
      setLoading(false);
    }
  }

  async function loadMessages(cid) {
    try {
      const msgs = await pb.collection('messages').getList(1, 100, {
        filter: `conversation = "${cid}"`,
        sort: 'id',
      });
      setMessages(msgs.items);
    } catch (_) {}
  }

  async function handleSend(e) {
    e?.preventDefault();
    if (!text.trim() || !conversationId || sending) return;

    const msgToSend = text.trim();
    setText('');
    setSending(true);

    try {
      let guestId = localStorage.getItem('ctown_guest_chat_id');
      const senderId = isLoggedIn ? user?.id : (guestId || 'guest_user');

      await ctownFetch('/chat/send', {
        method: 'POST',
        body: {
          conversation_id: conversationId,
          message_text: msgToSend,
          sender_id: senderId,
          sender_type: 'CUSTOMER'
        }
      });

      await loadMessages(conversationId);
    } catch (err) {
      console.error('Send error:', err);
    } finally {
      setSending(false);
    }
  }

  const handleSaveName = (e) => {
    e.preventDefault();
    if (!nameInput.trim()) return;
    setGuestName(nameInput.trim());
    localStorage.setItem('ctown_guest_chat_name', nameInput.trim());
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
          <div style={{ maxWidth: '80%' }}>
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
              <div style={{ maxWidth: '80%', textAlign: isStaff ? 'left' : 'right' }}>
                <span style={{ fontSize: '0.75rem', color: '#64748B', display: 'block', marginBottom: '4px' }}>
                  {isStaff ? 'เจ้าหน้าที่ C-TOWN' : (isLoggedIn ? user?.name : guestName)}
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
                    textAlign: 'left'
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
              padding: '5px 12px',
              fontSize: '0.78rem',
              color: '#334155',
              cursor: 'pointer',
              flexShrink: 0
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
          placeholder="พิมพ์ข้อความสอบถามร้านค้าที่นี่..."
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
