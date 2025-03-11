'use server';

import { cookies } from 'next/headers';

// Define interface for registration data
interface RegistrationData {
  name: string;
  email: string;
  password: string;
}

// Define interface for validation result
interface ValidationResult {
  success: boolean;
  error?: string;
}

// Define interface for registration result
interface RegistrationResult {
  success?: boolean;
  error?: string;
}

/**
 * Simple validation function for registration data
 * @param {RegistrationData} data Registration form data
 * @returns {ValidationResult} Validation result with success flag and potential error message
 */
function validateRegistrationData(data: RegistrationData): ValidationResult {
  // Validate name
  if (!data.name || data.name.trim().length < 2) {
    return { success: false, error: "Name must be at least 2 characters" };
  }
  
  // Validate email
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (!data.email || !emailRegex.test(data.email)) {
    return { success: false, error: "Invalid email address" };
  }
  
  // Validate password
  if (!data.password || data.password.length < 8) {
    return { success: false, error: "Password must be at least 8 characters" };
  }
  
  return { success: true };
}

/**
 * Server action to handle user registration
 * @param {RegistrationData} data Registration form data containing name, email, and password
 * @returns {Promise<RegistrationResult>} Result object with success or error information
 */
export async function register(data: RegistrationData): Promise<RegistrationResult> {
  // Validate input data
  const validationResult = validateRegistrationData(data);
  
  if (!validationResult.success) {
    return { error: validationResult.error };
  }

  try {
    // Here you would integrate with your authentication system (e.g., Auth.js, Supabase, Firebase, etc.)
    // This is a simplified example that you would replace with your actual authentication logic
    
    // Example API call to your backend registration endpoint
    const response = await fetch(`${process.env.API_URL}/auth/register`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        name: data.name,
        email: data.email,
        password: data.password,
      }),
    });

    const result = await response.json();

    if (!response.ok) {
      return { error: result.message || 'Registration failed' };
    }

    // Set authentication cookies/session
    (await
          // Set authentication cookies/session
          cookies()).set('auth_token', result.token, {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production',
      maxAge: 60 * 60 * 24 * 7, // 1 week
      path: '/',
    });

    // Return success result
    return { success: true };
  } catch (error) {
    console.error('Registration error:', error);
    
    // Return error message
    return { 
      error: 'Failed to create account. Please try again later.' 
    };
  }
}