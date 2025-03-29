import { useState } from "react";
import { Button } from "../Button/Button";

interface LanguageToggleProps {
  isMobile?: boolean;
}

type Language = {
  code: string;
  name: string;
  flag: string;
};

export default function LanguageToggle({ isMobile = false }: LanguageToggleProps) {
  const languages: Language[] = [
    { code: "en", name: "English", flag: "🇺🇸" },
    { code: "es", name: "Español", flag: "🇪🇸" },
    { code: "fr", name: "Français", flag: "🇫🇷" },
    { code: "de", name: "Deutsch", flag: "🇩🇪" },
  ];

  const [currentLanguage, setCurrentLanguage] = useState<Language>(languages[0]);
  const [isOpen, setIsOpen] = useState(false);

  const handleLanguageChange = (language: Language) => {
    setCurrentLanguage(language);
    setIsOpen(false);
    // You would typically handle language change in your app context/state here
  };

  return (
    <div className="relative">
      <Button
        onClick={() => setIsOpen(!isOpen)}
        className="flex items-center space-x-1 text-secondary hover:text-primary transition-colors duration-200"
        aria-expanded={isOpen}
        aria-haspopup="true"
      >
        {isMobile ? (
          <span className="text-xl">{currentLanguage.flag}</span>
        ) : (
          <>
            <span className="text-xl">{currentLanguage.flag}</span>
            <span>{currentLanguage.code.toUpperCase()}</span>
            <svg
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
              className="w-4 h-4"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2}
                d={isOpen ? "M5 15l7-7 7 7" : "M19 9l-7 7-7-7"}
              />
            </svg>
          </>
        )}
      </Button>

      {/* Dropdown Menu */}
      {isOpen && (
        <div className="absolute right-0 mt-2 w-48 bg-light rounded shadow-lg z-50">
          <ul className="py-1">
            {languages.map((language) => (
              <li key={language.code}>
                <Button
                  onClick={() => handleLanguageChange(language)}
                  className={`w-full text-left px-4 py-2 flex items-center space-x-2 ${
                    currentLanguage.code === language.code
                      ? "bg-primary bg-opacity-10 text-primary"
                      : "hover:bg-light text-secondary hover:text-primary"
                  }`}
                >
                  <span className="text-xl">{language.flag}</span>
                  <span>{language.name}</span>
                </Button>
              </li>
            ))}
          </ul>
        </div>
      )}
    </div>
  );
}