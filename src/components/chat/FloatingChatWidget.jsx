import React, { useState } from 'react';
import { Link, useLocation } from 'react-router-dom';
import { MessageCircle, X } from 'lucide-react';
import ChatBox from './ChatBox';

export default function FloatingChatWidget() {
  const [open, setOpen] = useState(false);
  const location = useLocation();

  // Don't show floating widget if already on the /chat page or inside admin
  if (location.pathname === '/chat' || location.pathname.startsWith('/admin')) {
    return null;
  }

  return (
    <div style={{ position: 'fixed', bottom: '24px', right: '24px', zIndex: 9999 }}>
      {/* Floating Popup Window if open */}
      {open && (
        <div
          style={{
            position: 'absolute',
            bottom: '68px',
            right: '0',
            width: '360px',
            maxWidth: 'calc(100vw - 32px)',
            borderRadius: '16px',
            overflow: 'hidden',
            boxShadow: '0 20px 40px rgba(0,0,0,0.2)',
            animation: 'fadeInUp 0.25s ease'
          }}
        >
          <div style={{ position: 'relative' }}>
            <button
              type="button"
              onClick={() => setOpen(false)}
              style={{
                position: 'absolute',
                top: '12px',
                right: '12px',
                background: 'rgba(255,255,255,0.2)',
                color: '#fff',
                border: 'none',
                borderRadius: '50%',
                width: '28px',
                height: '28px',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                cursor: 'pointer',
                zIndex: 10
              }}
              title="ปิดหน้าต่างแชต"
            >
              <X size={16} />
            </button>
            <ChatBox compact={true} />
          </div>
        </div>
      )}

      {/* Floating Action Button */}
      <button
        type="button"
        onClick={() => setOpen(!open)}
        id="btn-floating-chat"
        style={{
          display: 'flex',
          alignItems: 'center',
          gap: '10px',
          background: 'linear-gradient(135deg, #E11D48 0%, #BE123C 100%)',
          color: '#fff',
          padding: '12px 20px',
          borderRadius: '30px',
          border: 'none',
          boxShadow: '0 8px 25px rgba(225, 29, 72, 0.4)',
          fontWeight: 700,
          fontSize: '0.95rem',
          cursor: 'pointer',
          transition: 'all 0.2s ease',
        }}
        onMouseEnter={e => { e.currentTarget.style.transform = 'scale(1.05)'; }}
        onMouseLeave={e => { e.currentTarget.style.transform = 'scale(1)'; }}
      >
        <span style={{ position: 'relative', display: 'flex', alignItems: 'center' }}>
          <MessageCircle size={20} />
          <span
            style={{
              position: 'absolute',
              top: '-3px',
              right: '-3px',
              width: '9px',
              height: '9px',
              borderRadius: '50%',
              background: '#10B981',
              border: '2px solid #E11D48'
            }}
          />
        </span>
        <span>{open ? 'ปิดแชท' : 'แชทร้านค้า'}</span>
      </button>
    </div>
  );
}
