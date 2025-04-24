// lib/utils/storage.ts
import { User } from '@/lib/api/auth';

const TOKEN_KEY = 'auth_token';
const REMEMBERED_EMAIL_KEY = 'remembered_email';
const USER_KEY = 'current_user';

// Helper to safely access localStorage (to prevent SSR issues)
const safeStorage = {
  getItem: (key: string): string | null => {
    if (typeof window !== 'undefined') {
      return localStorage.getItem(key);
    }
    return null;
  },
  setItem: (key: string, value: string): void => {
    if (typeof window !== 'undefined') {
      localStorage.setItem(key, value);
    }
  },
  removeItem: (key: string): void => {
    if (typeof window !== 'undefined') {
      localStorage.removeItem(key);
    }
  }
};

export const storage = {
  // Token management
  getToken: (): string | null => {
    return safeStorage.getItem(TOKEN_KEY);
  },
  
  setToken: (token: string): void => {
    safeStorage.setItem(TOKEN_KEY, token);
  },
  
  clearToken: (): void => {
    safeStorage.removeItem(TOKEN_KEY);
  },
  
  // Current user management
  getCurrentUser: (): User | null => {
    const userString = safeStorage.getItem(USER_KEY);
    if (!userString) return null;
    
    try {
      return JSON.parse(userString);
    } catch (e) {
      console.error("Failed to parse user data from storage", e);
      return null;
    }
  },
  
  setCurrentUser: (user: User): void => {
    safeStorage.setItem(USER_KEY, JSON.stringify(user));
  },
  
  clearCurrentUser: (): void => {
    safeStorage.removeItem(USER_KEY);
  },
  
  // Remember me feature
  getRememberedEmail: (): string | null => {
    return safeStorage.getItem(REMEMBERED_EMAIL_KEY);
  },
  
  setRememberedEmail: (email: string): void => {
    safeStorage.setItem(REMEMBERED_EMAIL_KEY, email);
  },
  
  clearRememberedEmail: (): void => {
    safeStorage.removeItem(REMEMBERED_EMAIL_KEY);
  },
  
  // Logout helper
  logout: () => {
    storage.clearToken();
    storage.clearCurrentUser();
    // We don't clear remembered email on logout
  },
  
  // Check if user is authenticated
  isAuthenticated: (): boolean => {
    return !!storage.getToken();
  },
  
  // Local development/demo functions - these should use the API in production
  getUserByEmail: (email: string): User | null => {
    if (typeof window !== 'undefined') {
      const usersStr = localStorage.getItem('users') || '[]';
      const users = JSON.parse(usersStr) as User[];
      return users.find(user => user.email === email) || null;
    }
    return null;
  },
  
  setUser: (user: User): void => {
    if (typeof window !== 'undefined') {
      // Store a basic user record for demo purposes
      const usersStr = localStorage.getItem('users') || '[]';
      const users = JSON.parse(usersStr) as User[];
      
      // Check if user already exists
      const existingIndex = users.findIndex(u => u.email === user.email);
      
      if (existingIndex >= 0) {
        // Update existing user
        users[existingIndex] = { ...user };
      } else {
        // Add new user
        users.push(user);
      }
      
      localStorage.setItem('users', JSON.stringify(users));
    }
  }
};