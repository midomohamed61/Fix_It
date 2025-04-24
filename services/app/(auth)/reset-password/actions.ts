// app/(auth)/reset-password/actions.ts
import { resetPassword } from '@/lib/api/auth';

interface ResetPasswordParams {
  token: string;
  newPassword: string;
}

// In a real app, this would validate the token and then reset the password
export async function confirmPasswordReset({ token, newPassword }: ResetPasswordParams) {
  try {
    // In a real app, we'd extract the user email from the token
    // For this mock implementation, we'll parse it from the token
    // Example token format: auth-token-{userId}-{timestamp}
    const parts = token.split('-');
    const userId = parts.length >= 3 ? parts[2] : null;
    
    if (!userId) {
      return {
        success: false,
        error: 'Invalid reset token'
      };
    }
    
    // We'd typically look up the user by the token
    // For this mock, we're using a hardcoded email
    // In a real app, we'd verify the token is valid and not expired
    const email = 'demo@example.com'; // In reality, this would come from database lookup using the token
    
    // Perform the password reset
    const result = await resetPassword({
      email,
      newPassword
    });
    
    return result;
  } catch (error) {
    console.error('Password reset confirmation failed:', error);
    return {
      success: false,
      error: 'An unexpected error occurred during password reset'
    };
  }
}