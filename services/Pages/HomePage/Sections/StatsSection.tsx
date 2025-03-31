"use client";

import React, { useState, useEffect, memo } from 'react';
import { Users, Trophy, Coffee, FolderCheck } from 'lucide-react';

// Memoized Loading Skeleton Component
const LoadingSkeleton = memo(({ className }: { className: string }) => (
  <div className={`bg-gray-300 animate-pulse rounded ${className}`}></div>
));

// Memoized Animated Number Component
const AnimatedNumber = memo(({ value }: { value: number }) => {
  const [current, setCurrent] = useState(0);

  useEffect(() => {
    const duration = 2000;
    const steps = 60;
    const stepValue = value / steps;
    let currentStep = 0;

    const timer = setInterval(() => {
      currentStep++;
      setCurrent(Math.min(Math.round(stepValue * currentStep), value));

      if (currentStep >= steps) {
        clearInterval(timer);
      }
    }, duration / steps);

    return () => clearInterval(timer);
  }, [value]);

  return <span>{current.toLocaleString()}</span>;
});

// Memoized Stat Card Component
const StatCard = memo(({ stat }: { stat: any }) => (
  <div className="text-center group">
    <div className="inline-flex items-center justify-center w-16 h-16 rounded-full bg-primary/10 group-hover:bg-primary/20 transition-colors duration-300 mb-4">
      {React.createElement(stat.icon, { className: "w-8 h-8 text-primary" })}
    </div>
    <div className="text-3xl font-bold text-primary mb-2">
      <AnimatedNumber value={stat.value} />
      {stat.value >= 1000 ? 'k' : ''}
    </div>
    <div className="text-muted-foreground capitalize">{stat.label}</div>
  </div>
));

export default function StatsSection() {
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    const timer = setTimeout(() => {
      setIsLoading(false);
    }, 2000);

    return () => clearTimeout(timer);
  }, []);

  const stats = [
    {
      value: 451000,
      label: "skilled workers",
      icon: Users,
    },
    {
      value: 12,
      label: "industry awards",
      icon: Trophy,
    },
    {
      value: 154000,
      label: "hours of training",
      icon: Coffee,
    },
    {
      value: 45,
      label: "global offices",
      icon: FolderCheck,
    },
  ];

  if (isLoading) {
    return (
      <div className="relative">
        <div className="absolute inset-0 bg-gradient-to-b from-background/50 to-background"></div>
        <div className="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-24">
          <LoadingSkeleton className="h-12 w-3/4 mx-auto mb-16" />
          <div className="grid grid-cols-2 md:grid-cols-4 gap-8">
            {[...Array(4)].map((_, i) => (
              <div key={i} className="text-center">
                <LoadingSkeleton className="h-16 w-16 mx-auto mb-4 rounded-full" />
                <LoadingSkeleton className="h-8 w-24 mx-auto mb-2" />
                <LoadingSkeleton className="h-4 w-32 mx-auto" />
              </div>
            ))}
          </div>
        </div>
      </div>
    );
  }

  return (
    <>
      {/* Hero Section */}
      <div className="relative overflow-hidden" style={{ height: '50vh' }}>
        {/* Background Image */}
        <div
          className="absolute inset-0 bg-cover bg-center bg-no-repeat opacity-20"
          style={{
            backgroundImage:
              "url('https://images.unsplash.com/photo-1529400971008-f566de0e6dfc?auto=format&fit=crop&w=2070&q=80')",
            backgroundAttachment: 'fixed',
          }}
        ></div>
        {/* Overlay */}
        <div className="absolute inset-0 bg-gradient-to-b from-background/50 to-background"></div>

        {/* Content */}
        <div className="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-24">
          <h1 className="text-4xl md:text-5xl font-bold text-center text-primary mb-16">
            Empowering Global Workforce Excellence
          </h1>

          <div className="grid grid-cols-2 md:grid-cols-4 gap-8">
            {stats.map((stat, index) => (
              <StatCard key={index} stat={stat} />
            ))}
          </div>
        </div>
      </div>
    </>
  );
}