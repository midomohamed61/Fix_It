"use client";

import { createContext, useState, ReactNode, useContext, useEffect } from "react";

type Language = {
  code: string;
  name: string;
  flag: string;
};

type Translations = {
  [key: string]: {
    [key: string]: string;
  };
};

interface LanguageContextType {
  currentLanguage: Language;
  setCurrentLanguage: (language: Language) => void;
  t: (key: string) => string;
  languages: Language[];
}

const translations: Translations = {
  en: {
    "header.home": "Home",
    "header.about": "About",
    "header.contact": "Contact",
    "header.login": "Login",
    "header.register": "Register",
    "header.logout": "Logout",
    // Add more translations as needed
  },
  es: {
    "header.home": "Inicio",
    "header.about": "Acerca de",
    "header.contact": "Contacto",
    "header.login": "Iniciar sesión",
    "header.register": "Registrarse",
    "header.logout": "Cerrar sesión",
    // Add more translations as needed
  },
  fr: {
    "header.home": "Accueil",
    "header.about": "À propos",
    "header.contact": "Contact",
    "header.login": "Connexion",
    "header.register": "S'inscrire",
    "header.logout": "Déconnexion",
    // Add more translations as needed
  },
  // Add more languages as needed
};

const supportedLanguages: Language[] = [
  { code: "en", name: "English", flag: "🇺🇸" },
  { code: "es", name: "Español", flag: "🇪🇸" },
  { code: "fr", name: "Français", flag: "🇫🇷" },
  { code: "de", name: "Deutsch", flag: "🇩🇪" },
  { code: "ar", name: "العربية", flag: "🇸🇦" },
];

export const LanguageContext = createContext<LanguageContextType>({
  currentLanguage: supportedLanguages[0],
  setCurrentLanguage: () => {},
  t: (key: string) => key,
  languages: supportedLanguages,
});

export const LanguageProvider = ({ children }: { children: ReactNode }) => {
  const [currentLanguage, setCurrentLanguage] = useState<Language>(() => {
    // Try to get language from localStorage or use browser language
    if (typeof window !== 'undefined') {
      const savedLang = localStorage.getItem('language');
      if (savedLang) {
        const lang = supportedLanguages.find(l => l.code === savedLang);
        if (lang) return lang;
      }

      const browserLang = navigator.language.split('-')[0];
      const browserLangMatch = supportedLanguages.find(l => l.code === browserLang);
      if (browserLangMatch) return browserLangMatch;
    }
    return supportedLanguages[0];
  });

  useEffect(() => {
    if (typeof window !== 'undefined') {
      document.documentElement.lang = currentLanguage.code;
      localStorage.setItem('language', currentLanguage.code);
    }
  }, [currentLanguage]);

  const t = (key: string): string => {
    return translations[currentLanguage.code]?.[key] || translations['en'][key] || key;
  };

  return (
    <LanguageContext.Provider value={{
      currentLanguage,
      setCurrentLanguage,
      t,
      languages: supportedLanguages,
    }}>
      {children}
    </LanguageContext.Provider>
  );
};

export const useLanguage = () => {
  const context = useContext(LanguageContext);
  if (!context) {
    throw new Error('useLanguage must be used within a LanguageProvider');
  }
  return context;
};