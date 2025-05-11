// // context/AuthContext.tsx
// import React, { createContext, useState, useContext, useEffect } from 'react';

// // Define types
// interface User {
//   name: string;
//   email: string;
//   createdAt: number;
// }

// interface AuthContextType {
//   isLoggedIn: boolean;
//   user: User | null;
//   login: (email: string, password: string, remember?: boolean) => boolean;
//   logout: () => void;
//   register: (name: string, email: string, password: string) => boolean;
//   getAuthToken: () => string | null;
// }

// // Create context with default values
// const AuthContext = createContext<AuthContextType>({
//   isLoggedIn: false,
//   user: null,
//   login: () => false,
//   logout: () => {},
//   register: () => false,
//   getAuthToken: () => null
// });

// // Auth Provider component
// export const AuthProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
//   const [isLoggedIn, setIsLoggedIn] = useState<boolean>(false);
//   const [user, setUser] = useState<User | null>(null);

//   // Initialize auth state from localStorage on component mount
//   useEffect(() => {
//     const token = localStorage.getItem('auth_token');
//     const userStr = localStorage.getItem('current_user');
    
//     if (token && userStr) {
//       try {
//         const userData = JSON.parse(userStr);
//         setUser(userData);
//         setIsLoggedIn(true);
//       } catch (error) {
//         console.error('Failed to parse user data:', error);
//         localStorage.removeItem('current_user');
//         localStorage.removeItem('auth_token');
//       }
//     }
//   }, []);

//   // Login function
//   const login = (email: string, password: string, remember: boolean = false): boolean => {
//     // Get users from localStorage
//     const usersStr = localStorage.getItem('users');
//     if (!usersStr) return false;

//     try {
//       const users = JSON.parse(usersStr);
//       const foundUser = users.find((u: any) => 
//         u.email === email && u.password === password
//       );

//       if (foundUser) {
//         // Create user object without password
//         // eslint-disable-next-line @typescript-eslint/no-unused-vars
//         const { password, ...userWithoutPassword } = foundUser;
//         setUser(userWithoutPassword);
//         setIsLoggedIn(true);

//         // Generate demo token
//         const token = `demo-token-${generateUUID()}`;
        
//         // Save to localStorage
//         localStorage.setItem('auth_token', token);
//         localStorage.setItem('current_user', JSON.stringify(userWithoutPassword));
        
//         if (remember) {
//           localStorage.setItem('remembered_email', email);
//         } else {
//           localStorage.removeItem('remembered_email');
//         }
        
//         return true;
//       }
//       return false;
//     } catch (error) {
//       console.error('Login error:', error);
//       return false;
//     }
//   };

//   // Logout function
//   const logout = (): void => {
//     setIsLoggedIn(false);
//     setUser(null);
//     localStorage.removeItem('auth_token');
//     localStorage.removeItem('current_user');
//     // Keep remembered_email if it exists
//   };

//   // Register function
//   const register = (name: string, email: string, password: string): boolean => {
//     // Get existing users
//     const usersStr = localStorage.getItem('users');
//     let users = [];
    
//     if (usersStr) {
//       try {
//         users = JSON.parse(usersStr);
//       } catch (error) {
//         console.error('Failed to parse users:', error);
//         users = [];
//       }
//     }

//     // Check if email already exists
//     if (users.some((u: any) => u.email === email)) {
//       return false;
//     }

//     // Create new user
//     const newUser = {
//       name,
//       email,
//       password,
//       createdAt: Date.now()
//     };

//     // Add to users array
//     users.push(newUser);
    
//     // Save updated users array
//     localStorage.setItem('users', JSON.stringify(users));

//     // Auto login after registration
//     const { password: _, ...userWithoutPassword } = newUser;
//     setUser(userWithoutPassword);
//     setIsLoggedIn(true);

//     // Generate token
//     const token = `demo-token-${generateUUID()}`;
    
//     // Save auth data
//     localStorage.setItem('auth_token', token);
//     localStorage.setItem('current_user', JSON.stringify(userWithoutPassword));
    
//     return true;
//   };

//   // Get auth token
//   const getAuthToken = (): string | null => {
//     return localStorage.getItem('auth_token');
//   };

//   // Helper function to generate UUID
//   function generateUUID(): string {
//     return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
//       const r = Math.random() * 16 | 0, 
//             v = c === 'x' ? r : (r & 0x3 | 0x8);
//       return v.toString(16);
//     });
//   }

//   return (
//     <AuthContext.Provider value={{ 
//       isLoggedIn, 
//       user, 
//       login, 
//       logout, 
//       register,
//       getAuthToken
//     }}>
//       {children}
//     </AuthContext.Provider>
//   );
// };

// // Custom hook to use auth context
// export const useAuth = () => useContext(AuthContext);