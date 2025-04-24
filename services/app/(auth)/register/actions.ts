'use server';
// app/(auth)/register/actions.ts
import { registerUser } from '@/lib/api/auth';
import { storage } from '@/lib/utils/storage';

interface RegisterData {
  name: string;
  email: string;
  password: string;
}

export async function register(data: RegisterData) {
  try {
    const result = await registerUser({
      name: data.name,
      email: data.email,
      password: data.password
    });
    
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
    console.error('Registration action failed:', error);
    return {
      success: false,
      error: 'An unexpected error occurred during registration'
    };
  }
}