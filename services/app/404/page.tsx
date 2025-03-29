'use client';

import { useEffect, useState } from 'react';
import Link from 'next/link';
import { Button } from '@/components/ui/Button/Button';
import { Routes } from '@/lib/config/constants';

export default function NotFoundPage() {
  const [position, setPosition] = useState({ x: 50, y: 50 });
  const [opacity, setOpacity] = useState(0);
  
  
  useEffect(() => {
    setOpacity(0);
    const fadeTimer = setTimeout(() => {
      setOpacity(1);
    }, 300);
    const animationInterval = setInterval(() => {
      setPosition(prev => ({
        x: prev.x + (Math.random() * 2 - 1),
        y: prev.y + (Math.random() * 2 - 1)
      }));
    }, 50);
    
    return () => {
      clearTimeout(fadeTimer);
      clearInterval(animationInterval);
    };
  }, []);
  
  return (
    <div className="min-h-screen bg-light flex flex-col items-center justify-center p-4">
      <div className="max-w-lg w-full text-center relative">
        {/* Animated 404 */}
        <div 
          className="transition-all duration-700 ease-in-out absolute w-full"
          style={{ 
            opacity: opacity,
            transform: `translate(${position.x / 10}px, ${position.y / 10}px)`,
          }}
        >
          <h1 className="text-9xl font-bold text-primary">404</h1>
        </div>
        
        {/* Static content */}
        <div className="mt-32 mb-8">
          <h2 className="text-4xl font-bold text-secondary mb-4">Page Not Found</h2>
          <div className="h-1 w-16 bg-warning mx-auto mb-6"></div>
          <p className="text-secondary mb-8">
            Oops! The page you&apos;re looking for seems to have wandered off into the digital wilderness.
          </p>
          
          <div className="space-y-4">
            <p className="text-secondary">
              Let&apos;s get you back on track:
            </p>
            
            <div className="flex flex-col sm:flex-row justify-center gap-4 mt-6">
              <Button 
                onClick={() => window.history.back()} 
                variant="secondary" 
                className="flex items-center justify-center"
              >
                <svg 
                  xmlns="http://www.w3.org/2000/svg" 
                  className="h-5 w-5 mr-2" 
                  fill="none" 
                  viewBox="0 0 24 24" 
                  stroke="currentColor"
                >
                  <path 
                    strokeLinecap="round" 
                    strokeLinejoin="round" 
                    strokeWidth={2} 
                    d="M10 19l-7-7m0 0l7-7m-7 7h18" 
                  />
                </svg>
                Go Back
              </Button>
              
              <Link href={Routes.ROOT} passHref>
                <Button 
                  variant="default" 
                  className="flex items-center justify-center"
                >
                  <svg 
                    xmlns="http://www.w3.org/2000/svg" 
                    className="h-5 w-5 mr-2" 
                    fill="none" 
                    viewBox="0 0 24 24" 
                    stroke="currentColor"
                  >
                    <path 
                      strokeLinecap="round" 
                      strokeLinejoin="round" 
                      strokeWidth={2} 
                      d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" 
                    />
                  </svg>
                  Return Home
                </Button>
              </Link>
            </div>
          </div>
        </div>
        
        {/* Visual elements */}
        <div className="hidden sm:block absolute -top-16 -left-16 w-32 h-32 bg-info bg-opacity-20 rounded-full"></div>
        <div className="hidden sm:block absolute -bottom-16 -right-16 w-32 h-32 bg-primary bg-opacity-20 rounded-full"></div>
        <div className="hidden sm:block absolute top-1/4 right-0 w-16 h-16 bg-danger bg-opacity-10 rounded-full"></div>
        <div className="hidden sm:block absolute bottom-1/4 left-0 w-16 h-16 bg-success bg-opacity-10 rounded-full"></div>
      </div>
      
      {/* Status cards */}
      <div className="mt-12 grid grid-cols-1 md:grid-cols-3 gap-4 max-w-md">
        <div className="bg-white p-4 rounded-lg shadow-md border-t-4 border-primary text-center">
          <h3 className="font-bold text-primary">Lost?</h3>
          <p className="text-secondary text-sm">We couldn&apos;t find the page you requested.</p>
        </div>
        
        <div className="bg-white p-4 rounded-lg shadow-md border-t-4 border-warning text-center">
          <h3 className="font-bold text-secondary">Need Help?</h3>
          <p className="text-secondary text-sm">Visit our support center for assistance.</p>
        </div>
        
        <div className="bg-white p-4 rounded-lg shadow-md border-t-4 border-success text-center">
          <h3 className="font-bold text-secondary">Report Issue</h3>
          <p className="text-secondary text-sm">Let us know about any problems.</p>
        </div>
      </div>
    </div>
  );
}