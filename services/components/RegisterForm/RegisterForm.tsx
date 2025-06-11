'use client';
import { useState, useEffect } from 'react';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import { Label } from '@/components/ui/Form/Label';
import { Input } from '@/components/ui/Form/Input';
import { Button } from '@/components/ui/Button/Button';
import { cn } from '@/lib/utils/formatting';
import { FaApple, FaFacebook, FaGoogle } from 'react-icons/fa';
import { HiOutlineMail, HiOutlineUser } from 'react-icons/hi';
import { Pages } from '@/lib/config/constants';
import { RadioGroup, RadioGroupItem } from "@/components/ui/RadioGroup/RadioGroup";
import PasswordValidation from '@/components/PasswordValidation/PasswordValidation';
import { signup } from '@/lib/api/auth';
import type { AxiosError } from 'axios';
import { Alert } from '@/components/ui/Feedback/Alert';

// Add these new interfaces
interface SocialUser {
  id: string;
  name: string;
  email: string;
  provider: 'google' | 'facebook' | 'apple';
}

export default function RegisterForm() {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    password: '',
    confirmPassword: '',
    role: 'client' // Default role
  });
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState('');
  const [success, setSuccess] = useState('');
  const [rememberMe, setRememberMe] = useState(false);
  const router = useRouter();

  useEffect(() => {
    if (typeof window === 'undefined') return;

    const token = localStorage.getItem('token');
    if (token) {
      router.push(Pages.LOGIN);
      return;
    }

    const rememberedEmail = localStorage.getItem('rememberedEmail');
    if (rememberedEmail) {
      setFormData(prev => ({ ...prev, email: rememberedEmail }));
      setRememberMe(true);
    }
  }, [router]);

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
    setSuccess('');

    if (!formData.name || !formData.email || !formData.password || !formData.confirmPassword || !formData.role) {
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
      // Get existing users from localStorage
      const existingUsers = JSON.parse(localStorage.getItem('users') || '[]');
      
      // Check if email already exists
      if (existingUsers.some((user: any) => user.email === formData.email)) {
        setError('Email already registered');
        setIsLoading(false);
        return;
      }

      // Create new user object
      const newUser = {
        id: Date.now().toString(),
        name: formData.name,
        email: formData.email,
        password: formData.password,
        role: formData.role.toUpperCase() === 'CLIENT' ? 'USER' : 'WORKER',
        createdAt: new Date().toISOString()
      };

      // Add new user to existing users
      existingUsers.push(newUser);
      localStorage.setItem('users', JSON.stringify(existingUsers));

      // Store current user session
      localStorage.setItem('currentUser', JSON.stringify(newUser));
      localStorage.setItem('token', Date.now().toString());

      // Handle remember me
      if (rememberMe) {
        localStorage.setItem('rememberedEmail', formData.email);
      } else {
        localStorage.removeItem('rememberedEmail');
      }

      setSuccess('Registration successful! Redirecting...');

      setTimeout(() => {
        if (formData.role === 'client') {
          router.push('/clientinfo');
        } else {
          router.push('/workerinfo');
        }
      }, 1500);
    } catch (error) {
      setError('An unexpected error occurred');
    } finally {
      setIsLoading(false);
    }
  };

  const handleSocialAuth = async (provider: 'google' | 'facebook' | 'apple') => {
    setIsLoading(true);
    setError('');
    setSuccess('');

    try {
      // Simulate social authentication
      const mockSocialUser: SocialUser = {
        id: `social_${Date.now()}`,
        name: `Social User ${provider}`,
        email: `user@${provider}.com`,
        provider
      };

      // Store the social user in localStorage
      localStorage.setItem('currentUser', JSON.stringify(mockSocialUser));
      localStorage.setItem('token', Date.now().toString());

      // Handle remember me
      if (rememberMe) {
        localStorage.setItem('rememberedEmail', mockSocialUser.email);
      }

      setSuccess(`Successfully authenticated with ${provider}! Redirecting...`);

      setTimeout(() => {
        router.push('/clientinfo');
      }, 1500);
    } catch (error) {
      setError(`Failed to authenticate with ${provider}`);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-[#17446d] flex items-center justify-center p-4">
      <div className="w-full max-w-md bg-[#23486A] rounded-xl overflow-hidden shadow-[0_0_20px_2px_rgba(239,176,54,0.3)] border-2 border-[#EFB036]/30 hover:shadow-[0_0_25px_5px_rgba(239,176,54,0.4)] hover:border-[#EFB036]/50">
        <div className="p-6 text-center border-b border-[#EFB036]/20">
          <h1 className="text-2xl font-bold text-[#EFB036]">Create Account</h1>
          <p className="text-[#F5EEDC] mt-1">Join our community</p>
        </div>

        <div className="p-6 space-y-6">
          {isLoading && (
            <Alert
              type="info"
              message="Creating account..."
              className="animate-pulse"
            />
          )}
          
          {error && (
            <Alert
              type="error"
              title="Error"
              message={error}
              onClose={() => setError('')}
            />
          )}

          {success && (
            <Alert
              type="success"
              title="Success"
              message={success}
            />
          )}

          <form onSubmit={handleSubmit} className="space-y-4">
            <div>
              <Label htmlFor="name" className="block text-[#F5EEDC] mb-2">
                Full Name
              </Label>
              <div className="relative">
                <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-[#4C7B8B]">
                  <HiOutlineUser className="h-5 w-5" />
                </div>
                <Input
                  id="name"
                  type="text"
                  placeholder="Enter Your Name"
                  required
                  className="w-full pl-10 bg-[#F5EEDC] text-[#23486A] border border-[#4C7B8B] focus:ring-2 focus:ring-[#EFB036] focus:border-transparent"
                  value={formData.name}
                  onChange={handleChange}
                />
              </div>
            </div>
            
            <div>
              <Label htmlFor="email" className="block text-[#F5EEDC] mb-2">
                Email Address
              </Label>
              <div className="relative">
                <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-[#4C7B8B]">
                  <HiOutlineMail className="h-5 w-5" />
                </div>
                <Input
                  id="email"
                  type="email"
                  placeholder="Enter Your Email Address"
                  required
                  className="w-full pl-10 bg-[#F5EEDC] text-[#23486A] border border-[#4C7B8B] focus:ring-2 focus:ring-[#EFB036] focus:border-transparent"
                  value={formData.email}
                  onChange={handleChange}
                />
              </div>
            </div>
            
            <PasswordValidation 
              password={formData.password}
              confirmPassword={formData.confirmPassword}
              onChange={handleChange}
              errors={error ? { 
                password: error.includes('Password') ? error : '',
                confirmPassword: error.includes('match') ? error : '' 
              } : {}}
            />
            
            <div className="flex items-center">
              <input
                id="remember-me"
                type="checkbox"
                checked={rememberMe}
                onChange={(e) => setRememberMe(e.target.checked)}
                className="h-4 w-4 text-[#EFB036] focus:ring-[#EFB036] border-[#4C7B8B] rounded"
              />
              <label htmlFor="remember-me" className="ml-2 block text-sm text-[#F5EEDC]">
                Remember me
              </label>
            </div>

            <div className="space-y-2">
              <Label className="block text-[#F5EEDC] mb-2">
                I am registering as a:
              </Label>
              <RadioGroup 
                defaultValue="client" 
                className="flex space-x-4"
                onValueChange={(value) => setFormData(prev => ({ ...prev, role: value }))}
                value={formData.role}
              >
                <div className="flex items-center space-x-2">
                  <RadioGroupItem value="client" id="client" className="text-[#EFB036]" />
                  <Label htmlFor="client" className="text-[#F5EEDC]">Client</Label>
                </div>
                <div className="flex items-center space-x-2">
                  <RadioGroupItem value="worker" id="worker" className="text-[#EFB036]" />
                  <Label htmlFor="worker" className="text-[#F5EEDC]">Service Provider</Label>
                </div>
              </RadioGroup>
            </div>

            <Button
              type="submit"
              disabled={isLoading}
              className={cn(
                "w-full py-2 px-4 bg-[#EFB036] hover:bg-[#e6a72b] text-[#23486A] font-medium rounded-lg transition-colors flex items-center justify-center",
                "border-2 border-[#EFB036]/70 hover:border-[#EFB036]",
                "shadow-[0_4px_10px_rgba(239,176,54,0.3)] hover:shadow-[0_6px_15px_rgba(239,176,54,0.4)]",
                isLoading && "opacity-70 cursor-not-allowed"
              )}
            >
              {isLoading ? (
                <>
                  <svg className="animate-spin -ml-1 mr-2 h-4 w-4 text-[#23486A]" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                    <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                    <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                  </svg>
                  Creating account...
                </>
              ) : (
                "Sign Up"
              )}
            </Button>
          </form>

          <div className="relative">
            <div className="absolute inset-0 flex items-center">
              <div className="w-full border-t border-[#EFB036]/30"></div>
            </div>
            <div className="relative flex justify-center">
              <span className="px-2 bg-[#3B6790] text-[#F5EEDC] text-sm">
                Or sign up with
              </span>
            </div>
          </div>
          
          <div className="grid grid-cols-3 gap-3">
            <Button  
              type="button"
              onClick={() => handleSocialAuth('apple')}
              disabled={isLoading}
              className={cn(
                "flex justify-center items-center py-2 px-4 rounded-lg transition-all",
                "bg-[#e6a72b] hover:bg-[#e6a72b]/90 text-[#F5EEDC] hover:text-[#23486A]",
                "border border-[#EFB036]/50 hover:border-[#EFB036]",
                "shadow-[0_2px_8px_rgba(239,176,54,0.2)] hover:shadow-[0_4px_12px_rgba(239,176,54,0.3)]",
                isLoading && "opacity-70 cursor-not-allowed"
              )}
            >
              <FaApple className="h-5 w-5" />
            </Button>
            <Button
              type="button"
              onClick={() => handleSocialAuth('google')}
              disabled={isLoading}
              className={cn(
                "flex justify-center items-center py-2 px-4 rounded-lg transition-all",
                "bg-[#e6a72b] hover:bg-[#e6a72b]/90 text-[#F5EEDC] hover:text-[#23486A]",
                "border border-[#EFB036]/50 hover:border-[#EFB036]",
                "shadow-[0_2px_8px_rgba(239,176,54,0.2)] hover:shadow-[0_4px_12px_rgba(239,176,54,0.3)]",
                isLoading && "opacity-70 cursor-not-allowed"
              )}
            >
              <FaGoogle className="h-5 w-5" />
            </Button>
            <Button
              type="button"
              onClick={() => handleSocialAuth('facebook')}
              disabled={isLoading}
              className={cn(
                "flex justify-center items-center py-2 px-4 rounded-lg transition-all",
                "bg-[#e6a72b] hover:bg-[#e6a72b]/90 text-[#F5EEDC] hover:text-[#23486A]",
                "border border-[#EFB036]/50 hover:border-[#EFB036]",
                "shadow-[0_2px_8px_rgba(239,176,54,0.2)] hover:shadow-[0_4px_12px_rgba(239,176,54,0.3)]",
                isLoading && "opacity-70 cursor-not-allowed"
              )}
            >
              <FaFacebook className="h-5 w-5" />
            </Button>
          </div>
        </div>
        
        <div className="bg-[#3B6790] px-6 py-4 text-center border-t border-[#EFB036]/20">
          <p className="text-[#F5EEDC] text-sm">
            Already have an account?{' '}
            <Link 
              href="/login" 
              className="text-[#EFB036] font-medium hover:underline hover:text-[#F5EEDC] transition-colors"
            >
              Login
            </Link>
          </p>
          <p className="mt-2 text-[#F5EEDC] text-xs">
            By continuing, you agree to our{' '}
            <Link href="/terms" className="text-[#EFB036] hover:underline hover:text-[#F5EEDC] transition-colors">
              Terms
            </Link>{' '}
            and{' '}
            <Link href="/privacy" className="text-[#EFB036] hover:underline hover:text-[#F5EEDC] transition-colors">
              Privacy Policy
            </Link>
          </p>
        </div>
      </div>
    </div>
  );
}
