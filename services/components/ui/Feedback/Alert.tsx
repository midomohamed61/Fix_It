import { cn } from '@/lib/utils/formatting';
import { ReactNode } from 'react';
import { IoClose } from 'react-icons/io5';

export type AlertType = 'success' | 'error' | 'warning' | 'info';

interface AlertProps {
  type?: AlertType;
  title?: string;
  message: string | ReactNode;
  onClose?: () => void;
  className?: string;
  showIcon?: boolean;
}

const alertStyles = {
  success: {
    container: 'bg-[#3B6790] border-[#EFB036]/30',
    icon: 'text-[#EFB036]',
    title: 'text-[#EFB036]',
    message: 'text-[#EFE4D2]',
    close: 'text-[#EFE4D2] hover:text-[#EFB036]'
  },
  error: {
    container: 'bg-[#23486A] border-[#EFB036]/30',
    icon: 'text-[#EFB036]',
    title: 'text-[#EFB036]',
    message: 'text-[#EFE4D2]',
    close: 'text-[#EFE4D2] hover:text-[#EFB036]'
  },
  warning: {
    container: 'bg-[#4C7B8B] border-[#EFB036]/30',
    icon: 'text-[#EFB036]',
    title: 'text-[#EFB036]',
    message: 'text-[#EFE4D2]',
    close: 'text-[#EFE4D2] hover:text-[#EFB036]'
  },
  info: {
    container: 'bg-[#3B6790] border-[#EFB036]/30',
    icon: 'text-[#EFB036]',
    title: 'text-[#EFB036]',
    message: 'text-[#EFE4D2]',
    close: 'text-[#EFE4D2] hover:text-[#EFB036]'
  }
};

export function Alert({
  type = 'info',
  title,
  message,
  onClose,
  className,
  showIcon = true
}: AlertProps) {
  const styles = alertStyles[type];

  return (
    <div
      className={cn(
        'relative p-4 rounded-lg border-2 shadow-lg transition-all duration-300',
        styles.container,
        className
      )}
    >
      <div className="flex items-start gap-3">
        {showIcon && (
          <div className={cn('flex-shrink-0', styles.icon)}>
            {type === 'success' && (
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M5 13l4 4L19 7" />
              </svg>
            )}
            {type === 'error' && (
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M6 18L18 6M6 6l12 12" />
              </svg>
            )}
            {type === 'warning' && (
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
              </svg>
            )}
            {type === 'info' && (
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
            )}
          </div>
        )}
        <div className="flex-1">
          {title && (
            <h3 className={cn('text-sm font-semibold mb-1', styles.title)}>
              {title}
            </h3>
          )}
          <div className={cn('text-sm', styles.message)}>
            {message}
          </div>
        </div>
        {onClose && (
          <button
            onClick={onClose}
            className={cn(
              'flex-shrink-0 p-1 rounded-full hover:bg-[#EFB036]/10 transition-colors',
              styles.close
            )}
          >
            <IoClose className="w-5 h-5" />
          </button>
        )}
      </div>
    </div>
  );
} 