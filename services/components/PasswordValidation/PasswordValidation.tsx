import { useState } from 'react';
import { Input } from '@/components/ui/Form/Input';
import { Label } from '@/components/ui/Form/Label';
import { FaEye, FaEyeSlash } from 'react-icons/fa';
import { HiOutlineLockClosed } from 'react-icons/hi';

interface PasswordValidationProps {
  password: string;
  confirmPassword: string;
  onChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
  errors: Record<string, string>;
}

export default function PasswordValidation({ 
  password, 
  confirmPassword, 
  onChange, 
  errors 
}: PasswordValidationProps) {
  const [showPassword, setShowPassword] = useState(false);

  return (
    <>
      <div>
        <Label htmlFor="password" className="block text-[#F5EEDC] mb-2">
          Password
        </Label>
        <div className="relative">
          <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-[#4C7B8B]">
            <HiOutlineLockClosed className="h-5 w-5" />
          </div>
          <Input
            id="password"
            name="password"
            type={showPassword ? "text" : "password"}
            required
            className="w-full pl-10 bg-[#F5EEDC] text-[#23486A] border border-[#4C7B8B] focus:outline-none focus:ring-2 focus:ring-[#EFB036] focus:border-transparent"
            value={password}
            onChange={onChange}
            placeholder="Password (8+ chars, 1 uppercase, 1 number)"
          />
          <button
            type="button"
            className="absolute inset-y-0 right-0 pr-3 flex items-center text-[#4C7B8B] hover:text-[#EFB036]"
            onClick={() => setShowPassword(!showPassword)}
          >
            {showPassword ? <FaEyeSlash className="h-5 w-5" /> : <FaEye className="h-5 w-5" />}
          </button>
        </div>
        {errors.password && (
          <p className="text-red-500 text-sm mt-1">{errors.password}</p>
        )}
        <p className="mt-1 text-xs text-[#F5EEDC]">
          Must be 8+ chars with uppercase and number
        </p>
      </div>
      
      <div>
        <Label htmlFor="confirmPassword" className="block text-[#F5EEDC] mb-2">
          Confirm Password
        </Label>
        <div className="relative">
          <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-[#4C7B8B]">
            <HiOutlineLockClosed className="h-5 w-5" />
          </div>
          <Input
            id="confirmPassword"
            name="confirmPassword"
            type={showPassword ? "text" : "password"}
            required
            className="w-full pl-10 bg-[#F5EEDC] text-[#23486A] border border-[#4C7B8B] focus:outline-none focus:ring-2 focus:ring-[#EFB036] focus:border-transparent"
            value={confirmPassword}
            onChange={onChange}
            placeholder='Confirm Password'
          />
        </div>
        {errors.confirmPassword && (
          <p className="text-red-500 text-sm mt-1">{errors.confirmPassword}</p>
        )}
      </div>
    </>
  );
}