import React from 'react';
import ChatBox from '../../components/chat/ChatBox';

export default function ChatPage() {
  return (
    <div className="chat-page-container">
      <div className="chat-page-wrapper">
        <ChatBox compact={false} />
      </div>
    </div>
  );
}
