'use server';
// app/(auth)/login/actions.ts
import { loginUser } from '@/lib/api/auth';
import { storage } from '@/lib/utils/storage';

interface LoginData {
  email: string;
  password: string;
}

export async function login(data: LoginData) {
  try {
    const result = await loginUser(data.email, data.password);
    
    if (result.success && result.token) {
      // Store the token
      storage.setToken(result.token);
      
      // Store the user data if available 
      if (result.user) {
        storage.setCurrentUser(result.user);
      }
    }
    
    return result;
  } catch (error) {
    console.error('Login action failed:', error);
    return {
      success: false,
      error: 'An unexpected error occurred during login'
    };
  }
}