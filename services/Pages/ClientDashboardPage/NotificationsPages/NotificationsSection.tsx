"use client";

import { useState, useEffect } from 'react';
import { Bell } from 'lucide-react';
import { motion } from 'framer-motion';
import { cn } from '@/lib/utils';
import { Alert } from '@/components/ui/Feedback/Alert';
import { Button } from '@/components/ui/Button/Button';
import { BackButton } from '@/components/ui/Button/BackButton'; // تأكد من المسار الصحيح
import { SkeletonCircle } from '@/components/ui/Skeleton/Skeleton'; // تأكد من المسار الصحيح

interface Notification {
  id: string;
  type: 'success' | 'error' | 'warning' | 'info';
  title: string;
  message: string;
  timestamp: Date;
  read: boolean;
}

export default function NotificationsSection() {
  const [notifications, setNotifications] = useState<Notification[]>([
    {
      id: '1',
      type: 'success',
      title: 'Booking Confirmed',
      message: 'Your service booking has been confirmed for tomorrow at 2:00 PM',
      timestamp: new Date(),
      read: false
    },
    {
      id: '2',
      type: 'warning',
      title: 'Payment Pending',
      message: 'Please complete your payment for the recent service',
      timestamp: new Date(Date.now() - 3600000),
      read: false
    },
    {
      id: '3',
      type: 'info',
      title: 'New Service Available',
      message: 'Check out our new cleaning service packages',
      timestamp: new Date(Date.now() - 7200000),
      read: false
    }
  ]);

  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const timeout = setTimeout(() => setLoading(false), 1000);
    return () => clearTimeout(timeout);
  }, []);

  const unreadCount = notifications.filter(n => !n.read).length;

  const markAsRead = (id: string) => {
    setNotifications(prev =>
      prev.map(notification =>
        notification.id === id ? { ...notification, read: true } : notification
      )
    );
  };

  const markAllAsRead = () => {
    setNotifications(prev =>
      prev.map(notification => ({ ...notification, read: true }))
    );
  };

  return (
    <div className="min-h-screen bg-[#17446d] p-6">
      <div className="max-w-4xl mx-auto">
        
        {/* Back Button or Skeleton while loading */}
        <div className="mb-6">
          {loading ? (
            <SkeletonCircle size="40px" className="bg-[#EFB036]/30" />
          ) : (
            <BackButton
              variant="ghost"
              iconSize={24}
              size={40}
              // hoverColor="bg-[#EFB036]/30"
            />
          )}
        </div>

        {/* Header */}
        <div className="flex items-center justify-between mb-8">
          <div className="flex items-center gap-3">
            <Bell size={32} className="text-[#EFB036]" />
            <h1 className="text-2xl font-bold text-[#EFB036]">Notifications</h1>
            {unreadCount > 0 && (
              <motion.span
                initial={{ scale: 0 }}
                animate={{ scale: 1 }}
                className="px-2 py-1 bg-red-500 rounded-full text-xs text-white"
              >
                {unreadCount} new
              </motion.span>
            )}
          </div>
          {unreadCount > 0 && (
            <Button
              onClick={markAllAsRead}
              className="text-[#EFB036] hover:text-[#d9a032] transition-colors"
            >
              Mark all as read
            </Button>
          )}
        </div>

        {/* Notifications List */}
        <div className="space-y-4">
          {notifications.map((notification) => (
            <motion.div
              key={notification.id}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.3 }}
            >
              <Alert
                type={notification.type}
                title={notification.title}
                message={
                  <div className="space-y-2">
                    <p>{notification.message}</p>
                    <div className="flex items-center justify-between text-xs text-[#EFE4D2]/70">
                      <span>
                        {notification.timestamp.toLocaleTimeString([], {
                          hour: '2-digit',
                          minute: '2-digit'
                        })}
                      </span>
                      {!notification.read && (
                        <Button
                          onClick={() => markAsRead(notification.id)}
                          className="text-[#EFB036] hover:text-[#d9a032] transition-colors"
                        >
                          Mark as read
                        </Button>
                      )}
                    </div>
                  </div>
                }
                className={cn(
                  'transition-all duration-300',
                  notification.read ? 'opacity-70' : 'opacity-100'
                )}
              />
            </motion.div>
          ))}
        </div>

        {/* Empty State */}
        {notifications.length === 0 && (
          <div className="text-center py-12">
            <Bell size={48} className="mx-auto text-[#EFB036]/50 mb-4" />
            <h3 className="text-xl font-medium text-[#EFB036] mb-2">No Notifications</h3>
            <p className="text-[#EFE4D2]/70">
              You&apos;re all caught up! Check back later for updates.
            </p>
          </div>
        )}
      </div>
    </div>
  );
}
