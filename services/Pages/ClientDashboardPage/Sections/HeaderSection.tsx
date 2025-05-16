"use client";

import React from 'react';
import { motion } from 'framer-motion';
import { Settings, Home, Bell } from 'lucide-react';
import Link from 'next/link';

interface HeaderSectionProps {
  title: string;
  subtitle: string;
  profileImage?: string;
}

export const HeaderSection: React.FC<HeaderSectionProps> = ({
  title,
  subtitle,
  profileImage
}) => {
  return (
    <div className="bg-[#3B6790] rounded-xl p-6 mb-6">
      <div className="flex justify-between items-center">
        <div className="flex items-center space-x-4">
          {profileImage ? (
            <motion.img
              initial={{ scale: 0 }}
              animate={{ scale: 1 }}
              transition={{ type: "spring", stiffness: 200, damping: 20 }}
              src={profileImage}
              alt="Profile"
              className="w-24 h-24 rounded-full object-cover border-4 border-[#EFB036]"
            />
          ) : (
            <motion.div
              initial={{ scale: 0 }}
              animate={{ scale: 1 }}
              transition={{ type: "spring", stiffness: 200, damping: 20 }}
              className="w-24 h-24 rounded-full bg-[#23486A] flex items-center justify-center"
            >
              <span className="text-4xl text-[#EFB036]">
                {title.charAt(0).toUpperCase()}
              </span>
            </motion.div>
          )}
          <div>
            <motion.h1
              initial={{ opacity: 0, x: -20 }}
              animate={{ opacity: 1, x: 0 }}
              className="text-3xl font-bold text-[#EFB036]"
            >
              {title}
            </motion.h1>
            <motion.p
              initial={{ opacity: 0, x: -20 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ delay: 0.1 }}
              className="text-[#F5EEDC] mt-1"
            >
              {subtitle}
            </motion.p>
          </div>
        </div>
        <div className="flex items-center space-x-4">
          <Link href="/" className="p-3 bg-[#EFB036] hover:bg-[#d9a032] transform hover:scale-110 transition-all duration-300 ease-in-out rounded-xl text-[#F5EEDC] shadow-lg hover:shadow-xl">
            <Home size={30} className="transform hover:rotate-6 hover:animate-bounce" />
          </Link>
          <Link href="/client/notifications" className="p-3 bg-[#EFB036] hover:bg-[#d9a032] transform hover:scale-110 transition-all duration-300 ease-in-out rounded-xl text-[#F5EEDC] shadow-lg hover:shadow-xl relative">
            <Bell size={30} className="transform hover:rotate-6 hover:animate-pulse" />
            <motion.span
              initial={{ scale: 0 }}
              animate={{ scale: 1 }}
              className="absolute -top-1 -right-1 w-4 h-4 bg-red-500 rounded-full flex items-center justify-center text-xs text-white"
            >
              3
            </motion.span>
          </Link>
          <Link href="/client/settings" className="p-3 bg-[#EFB036] hover:bg-[#d9a032] transform hover:scale-110 transition-all duration-300 ease-in-out rounded-xl text-[#F5EEDC] shadow-lg hover:shadow-xl">
            <Settings size={30} className="transform hover:rotate-6 hover:animate-spin" />
          </Link>
        </div>
      </div>
    </div>
  );
}; 