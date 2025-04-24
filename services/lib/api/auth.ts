import axios from 'axios';
import { storage } from '@/lib/utils/storage';

const API_URL = 'https://6802ab350a99cb7408ea3413.mockapi.io';

export interface User {
  id?: string;
  name: string;
  email: string;
  password?: string; // Optional for returned user objects
  createdAt?: number;
  updatedAt?: number;
}

export interface AuthResponse {
  success: boolean;
  error?: string;
  user?: User;
  token?: string;
}

export interface ResetPasswordData {
  email: string;
  newPassword: string;
}

// API instance with error handling
const api = axios.create({
  baseURL: API_URL,
  headers: {
    'Content-Type': 'application/json'
  }
});

// Request interceptor for adding auth token
api.interceptors.request.use(
  (config) => {
    const token = storage.getToken();
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => Promise.reject(error)
);

// Get all users
export const getUsers = async (): Promise<User[]> => {
  try {
    const response = await api.get('/users');
    return response.data;
  } catch (error) {
    console.error('Failed to fetch users:', error);
    throw error;
  }
};

// Get user by ID
export const getUserById = async (id: string): Promise<User | null> => {
  try {
    const response = await api.get(`/users/${id}`);
    return response.data;
  } catch (error) {
    console.error(`Failed to fetch user with ID ${id}:`, error);
    if (axios.isAxiosError(error) && error.response?.status === 404) {
      return null;
    }
    throw error;
  }
};

// Get user by email
export const getUserByEmail = async (email: string): Promise<User | null> => {
  try {
    // Using query parameter to filter by email (MockAPI supports this)
    const response = await api.get(`/users`, {
      params: { email: email }
    });
    
    const users = response.data;
    return users && users.length > 0 ? users[0] : null;
  } catch (error) {
    console.error(`Failed to fetch user with email ${email}:`, error);
    throw error;
  }
};

// Register a new user
export const registerUser = async (userData: Omit<User, 'id'>): Promise<AuthResponse> => {
  try {
    // Check if user with email already exists
    const existingUser = await getUserByEmail(userData.email);
    
    if (existingUser) {
      return {
        success: false,
        error: 'User with this email already exists'
      };
    }
    
    // Add timestamps
    const user = {
      ...userData,
      createdAt: Date.now(),
      updatedAt: Date.now()
    };
    
    const response = await api.post('/users', user);
    
    // Generate a token
    const token = `auth-token-${response.data.id}-${Date.now()}`;
    
    return {
      success: true,
      user: response.data,
      token: token
    };
  } catch (error) {
    console.error('Registration failed:', error);
    return {
      success: false,
      error: 'Failed to register user. Please try again.'
    };
  }
};

// Login user
export const loginUser = async (email: string, password: string): Promise<AuthResponse> => {
  try {
    const user = await getUserByEmail(email);
    
    if (!user) {
      return {
        success: false,
        error: 'Invalid email or password'
      };
    }
    
    // In a real app, you'd hash and compare passwords
    // For this mock, we're doing a direct comparison
    if (user.password !== password) {
      return {
        success: false,
        error: 'Invalid email or password'
      };
    }
    
    // Generate token
    const token = `auth-token-${user.id}-${Date.now()}`;
    
    // Return sanitized user (without password)
    const { password: _, ...safeUser } = user;
    
    return {
      success: true,
      user: safeUser,
      token: token
    };
  } catch (error) {
    console.error('Login failed:', error);
    return {
      success: false,
      error: 'Failed to log in. Please try again.'
    };
  }
};

// Reset password
export const resetPassword = async ({ email, newPassword }: ResetPasswordData): Promise<AuthResponse> => {
  try {
    const user = await getUserByEmail(email);
    
    if (!user || !user.id) {
      return {
        success: false,
        error: 'User not found'
      };
    }
    
    const updatedUser = {
      ...user,
      password: newPassword,
      updatedAt: Date.now()
    };
    
    await api.put(`/users/${user.id}`, updatedUser);
    
    // Return sanitized user
    const { password: _, ...safeUser } = updatedUser;
    
    return {
      success: true,
      user: safeUser
    };
  } catch (error) {
    console.error('Password reset failed:', error);
    return {
      success: false,
      error: 'Failed to reset password. Please try again.'
    };
  }
};

// Delete user
export const deleteUser = async (id: string): Promise<AuthResponse> => {
  try {
    await api.delete(`/users/${id}`);
    
    return {
      success: true
    };
  } catch (error) {
    console.error(`Failed to delete user with ID ${id}:`, error);
    return {
      success: false,
      error: 'Failed to delete user. Please try again.'
    };
  }
};