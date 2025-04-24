"use client";

import { useRouter } from 'next/navigation';
import { ArrowLeft } from 'lucide-react';
import { Button } from '@/components/ui/Button/Button';
import { motion } from 'framer-motion';

interface BackButtonProps {
  className?: string;
  iconSize?: number;
  variant?: 'default' | 'ghost' | 'outline' | 'secondary';
  hoverColor?: string;
  size?: number;
}

export function BackButton({
  className = '',
  iconSize = 30,
  variant = 'default',
  hoverColor = 'bg-[#EFB036]',
  size = 30,
}: BackButtonProps) {
  const router = useRouter();

  return (
    <motion.div
      initial={{ opacity: 0.8, scale: 0.95 }}
      animate={{ opacity: 1, scale: 1 }}
      whileHover={{ 
        scale: 1.1,
        rotate: -5,
        transition: { type: 'spring', stiffness: 500 }
      }}
      whileTap={{ 
        scale: 0.9,
        rotate: 0,
        transition: { duration: 0.1 }
      }}
      transition={{
        default: { type: 'spring', stiffness: 400, damping: 15 },
        opacity: { duration: 0.2 }
      }}
      style={{ width: size, height: size }}
    >
      <Button
        onClick={() => router.back()}
        variant={variant}
        className={`rounded-full p-0 ${hoverColor ? `hover:${hoverColor}` : ''} ${className}`}
        aria-label="Go back"
        style={{ width: '100%', height: '100%' }}
      >
        <motion.div
          whileHover={{ x: -2 }} 
          transition={{ type: 'spring', stiffness: 500 }}
        >
          <ArrowLeft 
            size={iconSize} 
            className="m-auto"
          />
        </motion.div>
      </Button>
    </motion.div>
  );
}