"use client";

import React, { useState, useEffect } from 'react';
import { useSearchParams } from 'next/navigation';
import { Send, Search, Phone, Calendar, User } from 'lucide-react';
import { Button } from '@/components/ui/Button/Button';
import { BackButton } from '@/components/ui/Button/BackButton';

// Skeleton Loading Components
const ContactSkeleton = () => (
  <div className="p-3 rounded-lg mb-2 bg-[#23486A]/50 animate-pulse">
    <div className="flex items-start space-x-3">
      <div className="relative">
        <div className="w-12 h-12 rounded-full bg-[#4C7B8B]"></div>
      </div>
      <div className="flex-1 min-w-0 space-y-2">
        <div className="h-4 bg-[#4C7B8B] rounded w-3/4"></div>
        <div className="h-3 bg-[#4C7B8B] rounded w-1/2"></div>
        <div className="h-3 bg-[#4C7B8B] rounded w-full"></div>
      </div>
    </div>
  </div>
);

const MessageSkeleton = ({ isUser = false }) => (
  <div className={`flex ${isUser ? 'justify-end' : 'justify-start'}`}>
    <div className={`max-w-[70%] rounded-lg px-4 py-2 ${isUser ? 'bg-[#EFB036]/50' : 'bg-[#23486A]/50'}`}>
      <div className="h-4 bg-[#4C7B8B] rounded w-48 mb-2"></div>
      <div className="h-3 bg-[#4C7B8B] rounded w-16"></div>
    </div>
  </div>
);

export default function MessagesPage() {
  const searchParams = useSearchParams();
  const initialTechnician = searchParams?.get('technician') || null;
  
  const [selectedContact, setSelectedContact] = useState<string | null>(initialTechnician);
  const [messageInput, setMessageInput] = useState('');
  const [searchQuery, setSearchQuery] = useState('');
  const [isLoading, setIsLoading] = useState(true);
  const [showMobileContacts, setShowMobileContacts] = useState(false);

  // Simulate loading delay
  useEffect(() => {
    const timer = setTimeout(() => {
      setIsLoading(false);
    }, 1000);
    return () => clearTimeout(timer);
  }, []);

  // Close mobile contacts when a contact is selected
  useEffect(() => {
    if (selectedContact && window.innerWidth < 768) {
      setShowMobileContacts(false);
    }
  }, [selectedContact]);

  const contacts = [
    {
      id: 1,
      name: 'Teresa Williams',
      role: 'Plumbing Expert',
      avatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=120&h=120&fit=crop',
      lastMessage: "I'll be there on time tomorrow for the sink repair.",
      timestamp: '2:30 PM',
      online: true,
    },
    {
      id: 2,
      name: 'Dan Peters',
      role: 'HVAC Technician',
      avatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=120&h=120&fit=crop',
      lastMessage: 'The parts for your AC unit have arrived. We can schedule installation.',
      timestamp: 'Yesterday',
      online: false,
    },
    {
      id: 3,
      name: 'Rio Ronnie',
      role: 'Electrical Expert',
      avatar: 'https://images.unsplash.com/photo-1599566150163-29194dcaad36?w=120&h=120&fit=crop',
      lastMessage: "I've completed the electrical inspection. Everything looks good!",
      timestamp: 'Apr 12',
      online: true,
    },
    {
      id: 4,
      name: 'Sophia Chen',
      role: 'Carpentry Expert',
      avatar: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=120&h=120&fit=crop',
      lastMessage: 'The cabinet installation is scheduled for next week.',
      timestamp: 'Apr 8',
      online: false,
    },
  ];
  
  const messages = {
    'Teresa Williams': [
      { sender: 'Teresa Williams', text: "Hello! I'm Teresa, your assigned plumber for the sink repair.", time: '10:15 AM' },
      { sender: 'You', text: 'Hi Teresa, thanks for getting in touch.', time: '10:18 AM' },
      { sender: 'Teresa Williams', text: "I'll be arriving tomorrow between 3:30 PM and 5:30 PM. Does that work for you?", time: '10:20 AM' },
      { sender: 'You', text: 'Yes, that time works great for me.', time: '10:22 AM' },
      { sender: 'You', text: 'Should I prepare anything before you arrive?', time: '10:23 AM' },
      { sender: 'Teresa Williams', text: 'Just clear the area under the sink cabinet so I can easily access the pipes.', time: '10:25 AM' },
      { sender: 'Teresa Williams', text: "I'll bring all the necessary tools and parts.", time: '10:25 AM' },
      { sender: 'You', text: "Great, I'll make sure to clear everything out.", time: '10:27 AM' },
      { sender: 'Teresa Williams', text: "I'll be there on time tomorrow for the sink repair.", time: '2:30 PM' },
    ],
    'Dan Peters': [
      { sender: 'Dan Peters', text: 'Hi, this is Dan from HVAC Services.', time: 'Apr 10, 9:30 AM' },
      { sender: 'You', text: 'Hi Dan, looking forward to the AC maintenance.', time: 'Apr 10, 9:45 AM' },
      { sender: 'Dan Peters', text: "Just wanted to let you know that I've ordered the replacement parts for your AC unit.", time: 'Apr 10, 10:00 AM' },
      { sender: 'You', text: "That's great news! How long will it take to arrive?", time: 'Apr 10, 10:15 AM' },
      { sender: 'Dan Peters', text: 'The parts for your AC unit have arrived. We can schedule installation.', time: 'Yesterday, 3:15 PM' },
    ],
    'Rio Ronnie': [
      { sender: 'Rio Ronnie', text: "Hello, I'll be handling your electrical inspection tomorrow.", time: 'Apr 11, 11:20 AM' },
      { sender: 'You', text: 'Thanks Rio, what time should I expect you?', time: 'Apr 11, 11:30 AM' },
      { sender: 'Rio Ronnie', text: "I'll be there around 2 PM. The inspection should take about an hour.", time: 'Apr 11, 11:35 AM' },
      { sender: 'You', text: "Perfect, I'll be home at that time.", time: 'Apr 11, 11:40 AM' },
      { sender: 'Rio Ronnie', text: "I've completed the electrical inspection. Everything looks good!", time: 'Apr 12, 3:05 PM' },
    ],
    'Sophia Chen': [
      { sender: 'Sophia Chen', text: "Hi, I'm Sophia, your cabinet installation specialist.", time: 'Apr 8, 10:00 AM' },
      { sender: 'You', text: 'Hi Sophia, looking forward to the new cabinets.', time: 'Apr 8, 10:10 AM' },
      { sender: 'Sophia Chen', text: "I've reviewed your order and measurements. The cabinet installation is scheduled for next week.", time: 'Apr 8, 10:15 AM' },
    ],
  };
  
  const filteredContacts = contacts.filter(contact => 
    contact.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
    contact.role.toLowerCase().includes(searchQuery.toLowerCase())
  );
  
  const getCurrentMessages = () => {
    if (!selectedContact) return [];
    return messages[selectedContact as keyof typeof messages] || [];
  };
  
  const handleSendMessage = () => {
    if (messageInput.trim() === '' || !selectedContact) return;
    console.log(`Sending message to ${selectedContact}: ${messageInput}`);
    setMessageInput('');
  };
  
  useEffect(() => {
    if (initialTechnician) {
      setSelectedContact(initialTechnician);
    }
  }, [initialTechnician]);

  const toggleMobileContacts = () => {
    setShowMobileContacts(!showMobileContacts);
  };

  return (
    <div className="p-4 sm:p-6 text-[#F5EEDC]">
      <div className="flex items-center gap-4 mb-4 sm:mb-6">
        <div className="flex items-center gap-2">
          <BackButton 
            className="bg-[#23486A] text-[#EFB036] hover:text-[#f6f1e1]"
            iconSize={30}
            hoverColor="bg-[#EFB036]"
            size={30} 
          />
          <button 
            className="md:hidden p-2 rounded-lg bg-[#23486A] text-[#EFB036]"
            onClick={toggleMobileContacts}
            aria-label="Toggle contacts"
          >
            <svg xmlns="http://www.w3.org/2000/svg" className="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
            </svg>
          </button>
        </div>
        <h1 className="text-2xl sm:text-3xl md:text-4xl font-bold text-[#EFB036]">Messages</h1>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-4 sm:gap-6 h-full">
        {/* Contacts List */}
        <div className={`bg-[#3B6790] rounded-xl p-4 overflow-hidden flex flex-col h-full 
          ${showMobileContacts ? 'block' : 'hidden'} md:block`}>
          <div className="relative mb-4">
            <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-[#EFB036]" size={20} />
            <input
              type="text"
              placeholder="Search contacts..."
              className="w-full bg-[#23486A] border border-[#EFB036] rounded-lg py-2 px-10 text-[#F5EEDC] placeholder-[#EFB036]"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
            />
          </div>
          
          <div className="overflow-y-auto flex-1">
            {isLoading ? (
              <>
                {Array.from({ length: 5 }).map((_, index) => (
                  <ContactSkeleton key={index} />
                ))}
              </>
            ) : filteredContacts.length > 0 ? (
              filteredContacts.map((contact) => (
                <div 
                  key={contact.id}
                  className={`p-3 rounded-lg mb-2 cursor-pointer ${
                    selectedContact === contact.name 
                      ? 'bg-[#23486A]' 
                      : 'hover:bg-[#23486A]/50'
                  }`}
                  onClick={() => setSelectedContact(contact.name)}
                >
                  <div className="flex items-start space-x-3">
                    <div className="relative">
                      <img 
                        src={contact.avatar} 
                        alt={contact.name} 
                        className="w-10 h-10 sm:w-12 sm:h-12 rounded-full" 
                      />
                      {contact.online && (
                        <span className="absolute bottom-0 right-0 w-2 h-2 sm:w-3 sm:h-3 bg-green-500 rounded-full border-2 border-[#3B6790]"></span>
                      )}
                    </div>
                    <div className="flex-1 min-w-0">
                      <div className="flex justify-between items-center">
                        <h3 className="font-medium truncate text-sm sm:text-base">{contact.name}</h3>
                        <span className="text-xs text-[#4C7B8B]">{contact.timestamp}</span>
                      </div>
                      <p className="text-xs sm:text-sm text-[#EFB036]">{contact.role}</p>
                      <p className="text-xs text-[#4C7B8B] truncate mt-1">{contact.lastMessage}</p>
                    </div>
                  </div>
                </div>
              ))
            ) : (
              <div className="text-center py-6">
                <p>No contacts found</p>
              </div>
            )}
          </div>
        </div>
        
        {/* Chat Area */}
        <div className={`bg-[#f6f1e1] rounded-xl p-4 flex flex-col h-full 
          ${showMobileContacts ? 'hidden' : 'block'} md:col-span-2`}>
          {isLoading ? (
            <>
              {/* Chat Header Skeleton */}
              <div className="flex w-full justify-between items-center p-4 border-b bg-[#23486A] border-[#23486A] animate-pulse">
                <div className="flex items-center space-x-3">
                  <div className="w-10 h-10 rounded-full bg-[#4C7B8B]"></div>
                  <div className="space-y-2">
                    <div className="h-4 bg-[#4C7B8B] rounded w-32"></div>
                    <div className="h-3 bg-[#4C7B8B] rounded w-16"></div>
                  </div>
                </div>
                <div className="flex space-x-2">
                  <div className="p-2 rounded-full bg-[#4C7B8B] w-10 h-10"></div>
                  <div className="p-2 rounded-full bg-[#4C7B8B] w-10 h-10"></div>
                  <div className="p-2 rounded-full bg-[#4C7B8B] w-10 h-10"></div>
                </div>
              </div>
              
              {/* Messages Skeleton */}
              <div className="flex-1 overflow-y-auto py-4 space-y-4 px-4">
                <MessageSkeleton />
                <MessageSkeleton isUser />
                <MessageSkeleton />
                <MessageSkeleton isUser />
                <MessageSkeleton />
              </div>
              
              {/* Message Input Skeleton */}
              <div className="p-4 border-t bg-[#23486A] border-[#23486A] animate-pulse">
                <div className="flex space-x-2">
                  <div className="flex-1 bg-[#4C7B8B] rounded-lg h-10"></div>
                  <div className="p-2 rounded-lg bg-[#4C7B8B] w-10 h-10"></div>
                </div>
              </div>
            </>
          ) : selectedContact ? (
            <>
              {/* Chat Header */}
              <div className="flex w-full justify-between items-center p-4 border-b bg-[#23486A] border-[#23486A]">
                <div className="flex items-center space-x-3">
                  <img 
                    src={contacts.find(c => c.name === selectedContact)?.avatar} 
                    alt={selectedContact} 
                    className="w-10 h-10 rounded-full"
                  />
                  <div>
                    <h3 className="font-medium text-[#F5EEDC] text-sm sm:text-base">{selectedContact}</h3>
                    <p className="text-xs text-[#EFB036]">
                      {contacts.find(c => c.name === selectedContact)?.online ? 'Online' : 'Offline'}
                    </p>
                  </div>
                </div>
                <div className="flex space-x-2">
                  <Button className="p-2 rounded-full bg-[#3B6790] hover:bg-[#23486A] text-[#EFB036]">
                    <Phone size={16} />
                  </Button>
                  <Button className="p-2 rounded-full bg-[#3B6790] hover:bg-[#23486A] text-[#EFB036]">
                    <Calendar size={16} />
                  </Button>
                  <Button className="p-2 rounded-full bg-[#3B6790] hover:bg-[#23486A] text-[#EFB036]">
                    <User size={16} />
                  </Button>
                </div>
              </div>
              
              {/* Messages */}
              <div className="flex-1 overflow-y-auto py-4 space-y-4 px-4">
                {getCurrentMessages().map((msg, idx) => (
                  <div 
                    key={idx} 
                    className={`flex ${msg.sender === 'You' ? 'justify-end' : 'justify-start'}`}
                  >
                    <div 
                      className={`max-w-[85%] sm:max-w-[70%] rounded-lg px-3 py-2 text-sm sm:text-base ${
                        msg.sender === 'You' 
                          ? 'bg-[#EFB036] text-[#23486A]' 
                          : 'bg-[#23486A] text-[#F5EEDC]'
                      }`}
                    >
                      <p>{msg.text}</p>
                      <p className={`text-xs mt-1 ${
                        msg.sender === 'You' ? 'text-[#23486A]/70' : 'text-[#4C7B8B]'
                      }`}>{msg.time}</p>
                    </div>
                  </div>
                ))}
              </div>
              
              {/* Message Input */}
              <div className="p-4 border-t bg-[#23486A] border-[#23486A]">
                <div className="flex space-x-2">
                  <input
                    type="text"
                    placeholder="Type a message..."
                    className="flex-1 bg-[#F5EEDC] border border-[#F5EEDC] hover:border-[#EFB036] rounded-lg py-2 px-4 text-[#23486A] placeholder-[#4C7B8B] text-sm sm:text-base"
                    value={messageInput}
                    onChange={(e) => setMessageInput(e.target.value)}
                    onKeyDown={(e) => {
                      if (e.key === 'Enter') handleSendMessage();
                    }}
                  />
                  <Button 
                    className="p-2 rounded-lg bg-[#EFB036] hover:bg-[#d9a032] text-[#23486A]"
                    onClick={handleSendMessage}
                  >
                    <Send size={20} />
                  </Button>
                </div>
              </div>
            </>
          ) : (
            <div className="flex items-center justify-center h-full">
              <div className="text-center text-[#23486A]">
                <p className="text-lg mb-4">Select a contact to start messaging</p>
                <p className="text-sm text-[#4C7B8B]">
                  You can communicate with your service providers here
                </p>
                <button 
                  className="md:hidden mt-4 px-4 py-2 bg-[#23486A] text-[#EFB036] rounded-lg"
                  onClick={toggleMobileContacts}
                >
                  View Contacts
                </button>
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}