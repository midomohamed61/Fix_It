// app/(auth)/reset-password/ResetPasswordForm.tsx
'use client';
import { useState } from 'react';
import { useRouter } from 'next/navigation';
import Link from 'next/link';
import { Label } from '@/components/ui/Form/Label';
import { Input } from '@/components/ui/Form/Input';
import { Button } from '@/components/ui/Button/Button';
import { cn } from '@/lib/utils/formatting';
import { FaEye, FaEyeSlash } from 'react-icons/fa';
import { HiOutlineLockClosed } from 'react-icons/hi';
import { confirmPasswordReset } from './actions';

interface ResetPasswordFormProps {
  token: string;
}

export default function ResetPasswordForm({ token }: ResetPasswordFormProps) {
  const [formData, setFormData] = useState({
    password: '',
    confirmPassword: ''
  });
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState('');
  const [success, setSuccess] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  const router = useRouter();

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { id, value } = e.target;
    setFormData(prev => ({ ...prev, [id]: value }));
  };

  const validatePassword = (password: string): boolean => {
    return password.length >= 8 && /[A-Z]/.test(password) && /[0-9]/.test(password);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');

    if (!formData.password || !formData.confirmPassword) {
      setError('Please fill in all fields');
      return;
    }

    if (formData.password !== formData.confirmPassword) {
      setError('Passwords do not match');
      return;
    }

    if (!validatePassword(formData.password)) {
      setError('Password must be at least 8 characters with 1 uppercase and 1 number');
      return;
    }

    setIsLoading(true);

    try {
      const result = await confirmPasswordReset({
        token,
        newPassword: formData.password
      });
      
      if (result.success) {
        setSuccess(true);
        // Redirect to login after 3 seconds
        setTimeout(() => {
          router.push('/login');
        }, 3000);
      } else {
        setError(result.error || 'Failed to reset password');
      }
    } catch (error) {
      console.error('Password reset failed:', error);
      setError('An unexpected error occurred');
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-[#17446d] flex items-center justify-center p-4">
      <div className="w-full max-w-md bg-[#23486A] rounded-xl overflow-hidden shadow-[0_0_20px_2px_rgba(239,176,54,0.3)] border-2 border-[#EFB036]/30 hover:shadow-[0_0_25px_5px_rgba(239,176,54,0.4)] hover:border-[#EFB036]/50">
        {/* Header */}
        <div className="p-6 text-center">
          <h1 className="text-2xl font-bold text-[#EFB036]">Reset Your Password</h1>
          <p className="text-[#F5EEDC] mt-1">Create a new secure password</p>
        </div>

        {/* Form Container */}
        <div className="p-6 space-y-6">
          {/* Status Messages */}
          {isLoading && (
            <div className="bg-[#4C7B8B] text-[#F5EEDC] p-3 rounded-lg text-center animate-pulse">
              Updating your password...
            </div>
          )}
          
          {error && (
            <div className="bg-[#EFB036] text-[#23486A] p-3 rounded-lg text-center font-medium">
              {error}
            </div>
          )}
          
          {success && (
            <div className="bg-green-600 text-white p-3 rounded-lg text-center font-medium">
              Password successfully reset! Redirecting to login page...
            </div>
          )}

          {/* Reset Password Form */}
          {!success && (
            <form onSubmit={handleSubmit} className="space-y-4">
              <div>
                <Label htmlFor="password" className="block text-[#F5EEDC] mb-2">
                  New Password
                </Label>
                <div className="relative">
                  <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-[#4C7B8B]">
                    <HiOutlineLockClosed className="h-5 w-5" />
                  </div>
                  <Input
                    id="password"
                    type={showPassword ? "text" : "password"}
                    required
                    className="w-full pl-10 bg-[#F5EEDC] text-[#23486A] border border-[#4C7B8B] focus:outline-none focus:ring-2 focus:ring-[#EFB036] focus:border-transparent"
                    value={formData.password}
                    onChange={handleChange}
                  />
                  <button
                    type="button"
                    className="absolute inset-y-0 right-0 pr-3 flex items-center text-[#4C7B8B] hover:text-[#EFB036]"
                    onClick={() => setShowPassword(!showPassword)}
                  >
                    {showPassword ? <FaEyeSlash className="h-5 w-5" /> : <FaEye className="h-5 w-5" />}
                  </button>
                </div>
                <p className="mt-1 text-xs text-[#F5EEDC]">
                  Must be 8+ chars with uppercase and number
                </p>
              </div>
              
              <div>
                <Label htmlFor="confirmPassword" className="block text-[#F5EEDC] mb-2">
                  Confirm New Password
                </Label>
                <div className="relative">
                  <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-[#4C7B8B]">
                    <HiOutlineLockClosed className="h-5 w-5" />
                  </div>
                  <Input
                    id="confirmPassword"
                    type={showPassword ? "text" : "password"}
                    required
                    className="w-full pl-10 bg-[#F5EEDC] text-[#23486A] border border-[#4C7B8B] focus:outline-none focus:ring-2 focus:ring-[#EFB036] focus:border-transparent"
                    value={formData.confirmPassword}
                    onChange={handleChange}
                  />
                </div>
              </div>
              
              <Button
                type="submit"
                disabled={isLoading}
                className={cn(
                  "w-full py-2 px-4 bg-[#EFB036] hover:bg-[#e6a72b] text-[#23486A] font-medium rounded-lg transition-colors flex items-center justify-center",
                  isLoading && "opacity-70 cursor-not-allowed"
                )}
              >
                {isLoading ? (
                  <>
                    <svg className="animate-spin -ml-1 mr-2 h-4 w-4 text-[#23486A]" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                      <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                      <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                    </svg>
                    Resetting...
                  </>
                ) : (
                  "Reset Password"
                )}
              </Button>
            </form>
          )}
        </div>
        
        {/* Footer */}
        <div className="bg-[#3B6790] px-6 py-4 text-center">
          <p className="text-[#F5EEDC] text-sm">
            Remember your password?{' '}
            <Link 
              href="/login" 
              className="text-[#EFB036] font-medium hover:underline"
            >
              Back to Login
            </Link>
          </p>
        </div>
      </div>
    </div>
  );
}