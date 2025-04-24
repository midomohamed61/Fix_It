'use client';
import { useSearchParams } from 'next/navigation';
import ResetPasswordForm from '../ResetPasswordForm';
import Link from 'next/link';

export default function ResetPasswordPage() {
  const searchParams = useSearchParams();
  const token = searchParams.get('token');

  if (!token) {
    return (
      <div className="min-h-screen bg-[#17446d] flex items-center justify-center p-4">
        <div className="w-full max-w-md bg-[#23486A] rounded-xl overflow-hidden shadow-[0_0_20px_2px_rgba(239,176,54,0.3)] border-2 border-[#EFB036]/30 hover:shadow-[0_0_25px_5px_rgba(239,176,54,0.4)] hover:border-[#EFB036]/50 p-6 text-center">
          <h1 className="text-2xl font-bold text-[#EFB036]">Invalid Reset Link</h1>
          <p className="text-[#F5EEDC] mt-4 mb-6">
            The password reset link is invalid or has expired. Please request a new password reset link.
          </p>
          <Link
            href="/forgot-password"
            className="inline-block py-2 px-4 bg-[#EFB036] hover:bg-[#d9a033] text-[#17446d] font-medium rounded-lg transition-colors duration-200"
          >
            Request New Link
          </Link>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-[#17446d] flex items-center justify-center p-4">
      <div className="w-full max-w-md bg-[#23486A] rounded-xl overflow-hidden shadow-[0_0_20px_2px_rgba(239,176,54,0.3)] border-2 border-[#EFB036]/30 hover:shadow-[0_0_25px_5px_rgba(239,176,54,0.4)] hover:border-[#EFB036]/50 p-6">
        <h1 className="text-2xl font-bold text-[#EFB036] text-center mb-6">Reset Your Password</h1>
        <ResetPasswordForm token={token} />
      </div>
    </div>
  );
}