import React, { useState, useEffect, useRef } from 'react';
import { pb, ctownFetch, formatDate } from '../../lib/pb';
import { useAuth } from '../../contexts/AuthContext';
import { MessageSquare, Send, User, CheckCircle2 } from 'lucide-react';

export default function AdminChatPage() {
  const { user } = useAuth();
  const [conversations, setConversations] = useState([]);
  const [activeConv, setActiveConv] = useState(null);
  const [messages, setMessages] = useState([]);
  const [replyText, setReplyText] = useState('');
  const [loading, setLoading] = useState(true);
  const [sending, setSending] = useState(false);
  const messagesEndRef = useRef(null);

  useEffect(() => {
    loadConversations();

    // Subscribe to conversations or messages
    let unsub = null;
    pb.collection('messages').subscribe('*', (e) => {
      if (e.action === 'create') {
        if (activeConv && e.record.conversation === activeConv.id) {
          setMessages(prev => {
            if (prev.some(m => m.id === e.record.id)) return prev;
            return [...prev, e.record];
          });
        }
        loadConversations();
      }
    }).then(u => { unsub = u; });

    return () => {
      if (unsub) unsub();
    };
  }, [activeConv]);

  useEffect(() => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [messages]);

  async function loadConversations() {
    try {
      const res = await pb.collection('conversations').getList(1, 50, {
        expand: 'user',
        sort: '-id',
      });
      setConversations(res.items);
      if (!activeConv && res.items.length > 0) {
        selectConversation(res.items[0]);
      }
    } catch (err) {
      console.error(err);
    } finally {
      setLoading(false);
    }
  }

  async function selectConversation(conv) {
    setActiveConv(conv);
    try {
      const mRes = await pb.collection('messages').getList(1, 100, {
        filter: `conversation = "${conv.id}"`,
        sort: 'id',
      });
      setMessages(mRes.items);

      // Mark read
      await ctownFetch('/chat/mark-read', {
        method: 'POST',
        body: { conversation_id: conv.id },
      }).catch(() => {});
    } catch (err) {
      console.error(err);
    }
  }

  async function handleSendReply(e) {
    e.preventDefault();
    if (!replyText.trim() || !activeConv || sending) return;

    setSending(true);
    try {
      await ctownFetch('/chat/send', {
        method: 'POST',
        body: {
          conversation_id: activeConv.id,
          message_text: replyText.trim(),
        },
      });

      setReplyText('');
      // Reload messages for this conv
      const mRes = await pb.collection('messages').getList(1, 100, {
        filter: `conversation = "${activeConv.id}"`,
        sort: 'id',
      });
      setMessages(mRes.items);
    } catch (err) {
      alert('ส่งข้อความไม่สำเร็จ: ' + err.message);
    } finally {
      setSending(false);
    }
  }

  return (
    <div className="admin-chat-page">
      <div className="dashboard-header-row">
        <div>
          <h2>ศูนย์ตอบแชตลูกค้า (Live Customer Chat)</h2>
          <p className="subtitle">สนทนา ให้คำปรึกษาไซซ์รองเท้า และตอบคำถามลูกค้าแบบเรียลไทม์</p>
        </div>
      </div>

      <div className="admin-chat-shell">
        {/* Conversations List (Left) */}
        <div className="admin-conv-list">
          <div className="conv-list-header">
            <h4>ห้องสนทนา ({conversations.length})</h4>
          </div>
          <div className="conv-items-scroll">
            {loading ? (
              <div className="p-4 text-center text-muted">กำลังโหลด...</div>
            ) : conversations.length === 0 ? (
              <div className="p-4 text-center text-muted">ยังไม่มีข้อความสนทนา</div>
            ) : (
              conversations.map(c => {
                const isActive = activeConv?.id === c.id;
                const custName = c.expand?.user?.name || c.expand?.user?.email || 'ลูกค้า C-TOWN';
                return (
                  <div
                    key={c.id}
                    className={`conv-item-card ${isActive ? 'active' : ''}`}
                    onClick={() => selectConversation(c)}
                  >
                    <div className="conv-avatar">
                      <User size={18} />
                    </div>
                    <div className="conv-meta">
                      <div className="conv-top-line">
                        <strong>{custName}</strong>
                        <span className="conv-time">{formatDate(c.updated || c.created)}</span>
                      </div>
                      <p className="conv-preview-text">
                        {c.last_message || 'เริ่มการสนทนาใหม่...'}
                      </p>
                    </div>
                  </div>
                );
              })
            )}
          </div>
        </div>

        {/* Chat Window (Right) */}
        <div className="admin-chat-window">
          {activeConv ? (
            <>
              <div className="admin-chat-window-header">
                <div>
                  <h4>{activeConv.expand?.user?.name || activeConv.expand?.user?.email || 'ลูกค้า C-TOWN'}</h4>
                  <span className="user-email-sub">{activeConv.expand?.user?.email || ''}</span>
                </div>
                <div className="chat-badge-live">
                  <span className="live-dot" /> ออนไลน์พร้อมตอบ
                </div>
              </div>

              <div className="admin-messages-area">
                {messages.map(m => {
                  const isStaff = m.sender_role === 'ADMIN' || m.sender_id === user?.id;
                  return (
                    <div key={m.id} className={`admin-msg-row ${isStaff ? 'from-staff' : 'from-client'}`}>
                      <div className="msg-bubble-wrap">
                        <span className="sender-tag">
                          {isStaff ? 'เจ้าหน้าที่ C-TOWN' : activeConv.expand?.user?.name || 'ลูกค้า'}
                        </span>
                        <div className="msg-content">{m.message_text}</div>
                        <span className="msg-timestamp">
                          {m.created ? new Date(m.created).toLocaleTimeString('th-TH', { hour: '2-digit', minute: '2-digit' }) : ''}
                        </span>
                      </div>
                    </div>
                  );
                })}
                <div ref={messagesEndRef} />
              </div>

              <form onSubmit={handleSendReply} className="admin-reply-box">
                <input
                  type="text"
                  placeholder="พิมพ์ข้อความตอบกลับลูกค้า..."
                  value={replyText}
                  onChange={e => setReplyText(e.target.value)}
                  className="reply-input"
                  disabled={sending}
                />
                <button
                  type="submit"
                  className="btn-send-reply"
                  disabled={!replyText.trim() || sending}
                >
                  <Send size={18} /> ส่ง
                </button>
              </form>
            </>
          ) : (
            <div className="empty-chat-selection">
              <MessageSquare size={48} strokeWidth={1} />
              <p>เลือกห้องสนทนาทางด้านซ้ายเพื่อเริ่มพูดคุยกับลูกค้า</p>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
