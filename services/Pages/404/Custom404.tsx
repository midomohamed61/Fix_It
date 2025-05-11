"use client";

import { useEffect, useState } from "react";
import { Button } from "@/components/ui/Button/Button";
import { motion } from "framer-motion";
import Link from "@/components/ui/Link/Link";
import { Routes } from "@/lib/config/constants";
import { usePathname } from "next/navigation";
import { FaTools, FaCog, FaWrench } from "react-icons/fa";
// import { CustomImage } from "@/components/ui/Images/Image";

const Custom404 = () => {
  const pathname = usePathname();
  const [mounted, setMounted] = useState(false);
  const [windowSize, setWindowSize] = useState({ width: 0, height: 0 });
  const [activeWorker, setActiveWorker] = useState(0);

  useEffect(() => {
    setMounted(true);
    setWindowSize({
      width: window.innerWidth,
      height: window.innerHeight
    });
    
    // Only log error for actual 404s, not for the intentional not-found page
    if (pathname !== "/not-found") {
      console.error(
        "404 Error: User attempted to access non-existent route:",
        pathname
      );
    }

    // Cycle between workers
    const interval = setInterval(() => {
      setActiveWorker(prev => (prev === 0 ? 1 : 0));
    }, 5000);

    return () => clearInterval(interval);
  }, [pathname]);

  const containerVariants = {
    hidden: { opacity: 0 },
    visible: {
      opacity: 1,
      transition: {
        staggerChildren: 0.3,
        delayChildren: 0.2
      }
    }
  };

  const itemVariants = {
    hidden: { y: 20, opacity: 0 },
    visible: {
      y: 0,
      opacity: 1,
      transition: {
        type: "spring",
        stiffness: 100
      }
    }
  };

  const serviceManVariants = {
    hidden: { y: 50, opacity: 0, scale: 0.8 },
    visible: {
      y: 0,
      opacity: 1,
      scale: 1,
      transition: {
        type: "spring",
        stiffness: 50,
        damping: 10
      }
    },
    hover: {
      y: [-10, 0, -5, 0],
      transition: {
        duration: 2,
        repeat: Infinity,
        repeatType: "loop"
      }
    }
  };

  const gearVariants = {
    hidden: { rotate: 0, opacity: 0 },
    visible: { rotate: 0, opacity: 1 },
    animate: {
      rotate: 360,
      transition: { 
        duration: 20, 
        repeat: Infinity, 
        ease: "linear" 
      }
    }
  };

  const wrenchVariants = {
    hidden: { rotate: -30, opacity: 0 },
    visible: { rotate: 0, opacity: 1 },
    animate: {
      rotate: [0, 20, 0, -20, 0],
      transition: { 
        duration: 2, 
        repeat: Infinity,
        repeatType: "reverse",
        ease: "easeInOut" 
      }
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-[#F5EEDC] to-[#F5EEDC]/80 overflow-hidden">
      <motion.div
        initial="hidden"
        animate={mounted ? "visible" : "hidden"}
        variants={containerVariants}
        className="max-w-4xl w-full px-4 py-12"
      >
        <div className="relative">
          {/* Background decorative elements */}
          <motion.div
            initial={{ scale: 0 }}
            animate={{ scale: 1, rotate: 45 }}
            transition={{
              type: "spring",
              stiffness: 100,
              delay: 0.5
            }}
            className="absolute -top-20 -left-16 w-40 h-40 rounded-full bg-[#EFB036]/20 z-0"
          />
          <motion.div
            initial={{ scale: 0 }}
            animate={{ scale: 1 }}
            transition={{
              type: "spring",
              stiffness: 100,
              delay: 0.8
            }}
            className="absolute -bottom-16 -right-16 w-64 h-64 rounded-full bg-[#4C7B8B]/10 z-0"
          />
          
          {/* Main content */}
          <div className="bg-white rounded-2xl shadow-xl p-8 md:p-12 relative z-10 border border-[#3B6790]/10">
            <div className="flex flex-col md:flex-row items-center justify-between">
              <div className="md:w-1/2">
                <motion.div variants={itemVariants} className="mb-6">
                  <span className="inline-block text-[#EFB036] font-extrabold text-7xl md:text-9xl">
                    404
                  </span>
                </motion.div>
                
                <motion.h1 variants={itemVariants} className="text-[#23486A] text-3xl md:text-4xl font-bold mb-4">
                  Page Not Found
                </motion.h1>
                
                <motion.div variants={itemVariants} className="h-1 w-20 bg-gradient-to-r from-[#EFB036] to-[#4C7B8B] mb-6" />
                
                <motion.p variants={itemVariants} className="text-[#3B6790] text-lg mb-8 max-w-lg">
                  The page you are looking for might have been removed, had its name changed,
                  or is temporarily unavailable.
                </motion.p>
                
                <motion.div
                  variants={itemVariants}
                  whileHover={{ scale: 1.05 }}
                  whileTap={{ scale: 0.95 }}
                >
                  <Link href={Routes.ROOT}>
                    <Button className="bg-[#23486A] hover:bg-[#3B6790] text-white px-8 py-6 h-auto text-lg rounded-xl transition-all duration-300">
                      Return to Homepage
                    </Button>
                  </Link>
                </motion.div>
              </div>
              
              {/* Service Worker Images */}
              <motion.div 
                className="mt-10 md:mt-0 md:w-1/2 flex justify-center"
                variants={serviceManVariants as any}
                whileHover="hover"
              >
                <div className="relative w-64 h-64">
                  {/* Background gear */}
                  <motion.div 
                    className="absolute inset-0 text-[#e63946] z-0"
                    variants={gearVariants}
                    animate="animate"
                  >
                    <svg viewBox="0 0 100 100" className="w-full h-full">
                      <path 
                        d="M50,20 L54,5 L46,5 L50,20 Z M50,80 L46,95 L54,95 L50,80 Z M20,50 L5,46 L5,54 L20,50 Z M80,50 L95,54 L95,46 L80,50 Z M26,26 L15,15 L9,21 L26,26 Z M74,74 L85,85 L91,79 L74,74 Z M26,74 L9,79 L15,85 L26,74 Z M74,26 L91,21 L85,15 L74,26 Z" 
                        fill="#e63946"
                      />
                      <circle cx="50" cy="50" r="30" fill="#e63946" />
                    </svg>
                  </motion.div>
                  
                  {/* Worker images */}
                  <motion.div 
                    className="absolute inset-0 z-10"
                    initial={{ opacity: 0 }}
                    animate={{ 
                      opacity: activeWorker === 0 ? 1 : 0,
                      scale: activeWorker === 0 ? 1 : 0.8
                    }}
                    transition={{ duration: 0.5 }}
                  >
                    <img 
                      src="images/worker1.png" 
                      alt="Builder Mascot 1" 
                      className="w-full h-full object-contain"
                      onError={(e) => {
                        e.currentTarget.src = "https://via.placeholder.com/200x200?text=Builder+Mascot+1";
                      }}
                    />
                  </motion.div>
                  
                  <motion.div 
                    className="absolute inset-0 z-10"
                    initial={{ opacity: 0 }}
                    animate={{ 
                      opacity: activeWorker === 1 ? 1 : 0,
                      scale: activeWorker === 1 ? 1 : 0.8
                    }}
                    transition={{ duration: 0.5 }}
                  >
                    <img 
                      src="/images/worker2.jpg" 
                      alt="Service Worker" 
                      className="w-full h-full object-contain"
                      onError={(e) => {
                        e.currentTarget.src = "https://via.placeholder.com/200x200?text=Worker+2";
                      }}
                    />
                  </motion.div>
                  
                  {/* Animated wrench */}
                  <motion.div 
                    className="absolute -bottom-5 -right-5 text-5xl text-[#4C7B8B] z-20"
                    variants={wrenchVariants}
                    animate="animate"
                  >
                    <FaWrench />
                  </motion.div>
                  
                  {/* Animated cog */}
                  <motion.div 
                    className="absolute -top-5 -left-5 text-4xl text-[#EFB036] z-20"
                    animate={{ 
                      rotate: 360,
                      transition: { duration: 10, repeat: Infinity, ease: "linear" }
                    }}
                  >
                    <FaCog />
                  </motion.div>
                </div>
              </motion.div>
            </div>
          </div>
        </div>
        
        {/* Animated elements */}
        {mounted && (
          <div className="absolute inset-0 overflow-hidden pointer-events-none">
            {[...Array(8)].map((_, i) => (
              <motion.div
                key={i}
                initial={{ 
                  x: Math.random() * windowSize.width, 
                  y: -20,
                  opacity: 0.3 + Math.random() * 0.5,
                  scale: 0.1 + Math.random() * 0.3
                }}
                animate={{ 
                  y: windowSize.height + 50,
                  rotate: Math.random() * 360
                }}
                transition={{
                  duration: 15 + Math.random() * 20,
                  repeat: Infinity,
                  delay: i * 2,
                  ease: "linear"
                }}
                className={`absolute w-8 h-8 rounded-full bg-[${
                  [
                    "#EFB036",
                    "#3B6790",
                    "#23486A",
                    "#4C7B8B"
                  ][i % 4]
                }]/10`}
              />
            ))}
            
            {/* Floating tools */}
            {[...Array(4)].map((_, i) => (
              <motion.div
                key={`tool-${i}`}
                className="absolute text-2xl"
                initial={{ 
                  x: Math.random() * windowSize.width,
                  y: Math.random() * windowSize.height,
                  opacity: 0.7,
                  rotate: Math.random() * 180
                }}
                animate={{ 
                  x: Math.random() * windowSize.width,
                  y: Math.random() * windowSize.height,
                  rotate: Math.random() * 360
                }}
                transition={{
                  duration: 20 + Math.random() * 10,
                  repeat: Infinity,
                  repeatType: "reverse"
                }}
                style={{
                  color: [
                    "#EFB036",
                    "#3B6790",
                    "#23486A",
                    "#4C7B8B"
                  ][i % 4]
                }}
              >
                <FaTools />
              </motion.div>
            ))}
          </div>
        )}
      </motion.div>
    </div>
  );
};

export default Custom404;
