'use client';
import React, { useState, useRef, useEffect } from 'react';
import { Sparkles, X, Send, User, Bot } from 'lucide-react';
import Link from 'next/link';
import { Button } from '@/components/ui/Button/Button';

const ChatBot = () => {
  const [isOpen, setIsOpen] = useState(false);
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [messages, setMessages] = useState([
    {
      id: 1,
      text: "Hello! How can I help you today?",
      sender: 'bot',
      timestamp: new Date()
    }
  ]);
  const [inputMessage, setInputMessage] = useState('');
  const [isTyping, setIsTyping] = useState(false);
  const messagesEndRef = useRef(null);

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  };

  useEffect(() => {
    scrollToBottom();
  }, [messages]);

  const checkAuth = () => {
    const token = localStorage.getItem('token');
    setIsAuthenticated(!!token);
  };

  const toggleChat = () => {
    setIsOpen(!isOpen);
    if (!isOpen) checkAuth();
  };

  const handleSendMessage = async (e) => {
    e.preventDefault();
    if (!inputMessage.trim()) return;

    const newMessage = {
      id: messages.length + 1,
      text: inputMessage,
      sender: 'user',
      timestamp: new Date()
    };

    setMessages(prev => [...prev, newMessage]);
    setInputMessage('');
    setIsTyping(true);

    setTimeout(() => {
      const botResponse = {
        id: messages.length + 2,
        text: getBotResponse(inputMessage),
        sender: 'bot',
        timestamp: new Date()
      };
      setMessages(prev => [...prev, botResponse]);
      setIsTyping(false);
    }, 1500);
  };

  const getBotResponse = (userMessage) => {
    const responses = [
      "Thanks for your message! I'm here to help.",
      "That's interesting! Can you tell me more?",
      "I understand. Let me see how I can assist you.",
      "Great question! Here's what I think...",
      "I'm processing your request. Please give me a moment.",
    ];
    return responses[Math.floor(Math.random() * responses.length)];
  };

  const formatTime = (date) => {
    return date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
  };

  return (
    <div className="fixed bottom-4 right-4 z-50">
      {/* Toggle Button */}
      <Button
        onClick={toggleChat}
        className="w-14 h-14 rounded-full shadow-lg transition-all duration-300 hover:scale-110 focus:outline-none focus:ring-4 focus:ring-opacity-50"
        style={{
          backgroundColor: '#EFB036',
          boxShadow: '0 4px 20px rgba(239, 176, 54, 0.3)'
        }}
      >
        {isOpen ? (
          <X className="w-6 h-6 text-white mx-auto" />
        ) : (
          <Sparkles className="w-6 h-6 text-white mx-auto animate-pulse" />
        )}
      </Button>

      {/* Chat Window */}
      {isOpen && (
        <div className="absolute bottom-16 right-0 w-80 h-96 rounded-lg shadow-2xl flex flex-col bg-[#EFE4D2] overflow-hidden">
          {/* Header */}
          <div className="px-4 py-3 text-white flex items-center justify-between bg-[#23486A] flex-shrink-0">
            <div className="flex items-center space-x-2">
              <div className="w-8 h-8 rounded-full flex items-center justify-center bg-[#3B6790]">
                <Bot className="w-4 h-4 text-white" />
              </div>
              <div>
                <h3 className="font-semibold text-sm">Chat Assistant</h3>
                <span className="text-xs opacity-75">Online</span>
              </div>
            </div>
            <Button
              onClick={toggleChat}
              className="text-white hover:bg-white hover:bg-opacity-20 rounded p-1"
            >
              <X className="w-4 h-4" />
            </Button>
          </div>

          {/* Chat Content */}
          <div className="flex-1 flex flex-col overflow-hidden">
            {!isAuthenticated ? (
              <div className="flex-1 flex items-center justify-center p-6">
                <div className="text-center">
                  <User className="w-12 h-12 mx-auto mb-3" style={{ color: '#3B6790' }} />
                  <h3 className="font-semibold text-lg mb-2" style={{ color: '#23486A' }}>
                    Login Required
                  </h3>
                  <p className="text-sm mb-4" style={{ color: '#4C7B8B' }}>
                    You must be logged in to use the chat feature.
                  </p>
                  <Button
                    className="px-4 py-2 rounded-lg text-white font-medium transition-colors hover:opacity-90"
                    style={{ backgroundColor: '#EFB036' }}
                  >
                    <Link href="/login">Login Now</Link>
                  </Button>
                </div>
              </div>
            ) : (
              <>
                {/* Messages */}
                <div className="flex-1 overflow-y-auto px-4 py-3 space-y-4 min-h-0 custom-scrollbar">
                  {messages.map((message) => (
                    <div
                      key={message.id}
                      className={`flex ${message.sender === 'user' ? 'justify-end' : 'justify-start'}`}
                    >
                      <div className="max-w-xs">
                        <div
                          className={`px-4 py-2 rounded-xl shadow-sm text-sm ${
                            message.sender === 'user'
                              ? 'text-white bg-[#3B6790] rounded-br-none'
                              : 'text-[#23486A] bg-white rounded-bl-none border'
                          }`}
                        >
                          {message.text}
                        </div>
                        <div className="text-xs text-gray-500 mt-1 px-1 text-end">
                          {formatTime(message.timestamp)}
                        </div>
                      </div>
                    </div>
                  ))}

                  {/* Typing Indicator */}
                  {isTyping && (
                    <div className="flex justify-start">
                      <div className="bg-white px-3 py-2 rounded-lg rounded-bl-none">
                        <div className="flex space-x-1">
                          <div className="w-2 h-2 rounded-full animate-bounce" style={{ backgroundColor: '#4C7B8B', animationDelay: '0ms' }}></div>
                          <div className="w-2 h-2 rounded-full animate-bounce" style={{ backgroundColor: '#4C7B8B', animationDelay: '150ms' }}></div>
                          <div className="w-2 h-2 rounded-full animate-bounce" style={{ backgroundColor: '#4C7B8B', animationDelay: '300ms' }}></div>
                        </div>
                      </div>
                    </div>
                  )}
                  <div ref={messagesEndRef} />
                </div>

                {/* Input Area */}
                <div className="border-t p-3 bg-[#EFE4D2] flex-shrink-0" style={{ borderColor: '#4C7B8B' }}>
                  <form onSubmit={handleSendMessage} className="flex items-center space-x-2">
                    <div className="relative flex-1">
                      <span className="absolute inset-y-0 left-0 flex items-center pl-3">
                        <Sparkles className="w-4 h-4 text-gray-500" />
                      </span>
                      <input
                        type="text"
                        value={inputMessage}
                        onChange={(e) => setInputMessage(e.target.value)}
                        placeholder="Type your message..."
                        className="w-full pl-10 pr-3 py-2 border rounded-lg focus:outline-none focus:ring-2 text-sm text-[#23486A]"
                        style={{ borderColor: '#4C7B8B' }}
                      />
                    </div>
                    <Button
                      type="submit"
                      disabled={!inputMessage.trim() || isTyping}
                      className="px-3 py-2 rounded-lg text-white transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
                      style={{ backgroundColor: '#EFB036' }}
                    >
                      <Send className="w-4 h-4" />
                    </Button>
                  </form>
                </div>
              </>
            )}
          </div>
        </div>
      )}
    </div>
  );
};

export default ChatBot;
