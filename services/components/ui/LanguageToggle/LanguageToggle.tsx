"use client";

import { useLanguage } from './LanguageContext';

export default function LanguageToggle() {
  const { currentLanguage, setCurrentLanguage, languages } = useLanguage();

  return (
    <select
      value={currentLanguage.code}
      onChange={e => {
        const lang = languages.find(l => l.code === e.target.value);
        if (lang) setCurrentLanguage(lang);
      }}
      style={{ padding: '4px 8px', borderRadius: 6, border: '1px solid #ccc', background: '#fff', color: '#23486A' }}
      aria-label="Select language"
    >
      {languages.map(lang => (
        <option key={lang.code} value={lang.code}>
          {lang.flag} {lang.name}
        </option>
      ))}
    </select>
  );
}