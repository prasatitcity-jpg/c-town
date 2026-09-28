import React, { useState, useEffect, useRef } from 'react';
import { pb, ctownFetch, formatPrice } from '../../lib/pb';
import { useAuth } from '../../contexts/AuthContext';
import { useNavigate } from 'react-router-dom';
import { Send, Image, MessageCircle } from 'lucide-react';

export default function ChatBox({ compact = false }) {
  const { user, isLoggedIn } = useAuth();
  const navigate = useNavigate();
  const [conversationId, setConversationId] = useState(null);
  const [messages, setMessages] = useState([]);
  const [text, setText] = useState('');
  const [sending, setSending] = useState(false);
  const [loading, setLoading] = useState(true);
  const bottomRef = useRef(null);
  let unsubscribe = null;

  useEffect(() => {
    if (!isLoggedIn) { setLoading(false); return; }
    initConversation();
    return () => { if (unsubscribe) unsubscribe(); };
  }, [isLoggedIn]);

  useEffect(() => {
    bottomRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [messages]);

  async function initConversation() {
    setLoading(true);
    try {
      const convRes = await ctownFetch('/chat/conversation', { method: 'POST' });
      const cid = convRes.conversation.id;
      setConversationId(cid);
      await loadMessages(cid);

      // Mark read
      await ctownFetch('/chat/mark-read', { method: 'POST', body: { conversation_id: cid } });

      // Subscribe to realtime updates
      try {
        unsubscribe = await pb.collection('messages').subscribe('*', (e) => {
          if (e.action === 'create' && e.record.conversation === cid) {
            setMessages(prev => {
              if (prev.some(m => m.id === e.record.id)) return prev;
              return [...prev, e.record];
            });
            bottomRef.current?.scrollIntoView({ behavior: 'smooth' });
          }
        });
      } catch (_) {}
    } catch (err) {
      console.error(err);
    } finally {
      setLoading(false);
    }
  }

  async function loadMessages(cid) {
    const msgs = await pb.collection('messages').getList(1, 100, {
      filter: `conversation = "${cid}"`,
      sort: 'id',
    });
    setMessages(msgs.items);
  }

  async function sendMessage(e) {
    e.preventDefault();
    if (!text.trim() || !conversationId || sending) return;
    setSending(true);
    try {
      await ctownFetch('/chat/send', {
        method: 'POST',
        body: { conversation_id: conversationId, message_text: text.trim() },
      });
      setText('');
      await loadMessages(conversationId);
    } catch (err) {
      console.error(err);
    } finally {
      setSending(false);
    }
  }

  if (!isLoggedIn) {
    return (
      <div className="chat-login-prompt">
        <MessageCircle size={40} strokeWidth={1.5} />
        <h3>ต้องการสอบถามสินค้า?</h3>
        <p>กรุณาเข้าสู่ระบบเพื่อส่งข้อความถึงร้านค้า</p>
        <button className="btn-primary" onClick={() => navigate('/login')}>เข้าสู่ระบบ</button>
      </div>
    );
  }

  if (loading) return <div className="chat-loading"><div className="spinner" /></div>;

  return (
    <div className={`chatbox${compact ? ' compact' : ''}`}>
      <div className="chatbox-header">
        <MessageCircle size={18} />
        <div>
          <span className="chat-title">สนทนากับ C-TOWN</span>
          <span className="chat-subtitle">ตอบกลับภายใน 30 นาที (10:00–21:00)</span>
        </div>
        <span className="online-dot" />
      </div>

      <div className="chatbox-messages" id="chat-messages">
        {messages.length === 0 && (
          <div className="chat-empty">
            <MessageCircle size={32} strokeWidth={1.2} />
            <p>เริ่มต้นการสนทนา<br />สอบถามสินค้า สี ไซซ์ สต็อก หรือสถานะออเดอร์ได้เลย!</p>
          </div>
        )}
        {messages.map(msg => {
          const isMe = msg.sender_id === user?.id;
          return (
            <div key={msg.id} className={`chat-message${isMe ? ' from-me' : ' from-admin'}`}>
              {!isMe && <span className="msg-sender-label">C-TOWN ⭐</span>}
              <div className="msg-bubble">{msg.message_text}</div>
              <span className="msg-time">
                {msg.created ? new Date(msg.created).toLocaleTimeString('th-TH', { hour: '2-digit', minute: '2-digit' }) : ''}
              </span>
            </div>
          );
        })}
        <div ref={bottomRef} />
      </div>

      <form className="chatbox-input" onSubmit={sendMessage}>
        <input
          type="text"
          value={text}
          onChange={e => setText(e.target.value)}
          placeholder="พิมพ์ข้อความ..."
          className="chat-input"
          id="chat-text-input"
          disabled={sending}
        />
        <button
          type="submit"
          className="chat-send-btn"
          disabled={!text.trim() || sending}
          id="btn-chat-send"
        >
          <Send size={16} />
        </button>
      </form>
    </div>
  );
}
