"use client"

import { useState } from "react";
import { Pages, Routes } from "@/lib/config/constants"; 
import Link from "../../ui/Link/Link";
import LanguageToggle from "../../ui/LanguageToggle/LanguageToggle";
import SearchBar from "../../ui/SearchBar/SearchBar";
import { Button } from "@/components/ui/Button/Button";

export default function Header() {
  const links = [
    { id: crypto.randomUUID(), title: "Menu", href: Routes.MENU },
    { id: crypto.randomUUID(), title: "About", href: Routes.ABOUT },
    { id: crypto.randomUUID(), title: "Contact", href: Pages.CONTACT }, 
    { id: crypto.randomUUID(), title: "Login", href: Pages.LOGIN } 
  ];
  const [openMenu, setOpenMenu] = useState(false);
  const [showSearch, setShowSearch] = useState(false);

  return (
    <header className="bg-[#23486A] shadow-md fixed top-0 w-full z-50">
      <div className="container mx-auto px-4 py-3 flex justify-between items-center">
        <div className="flex items-center">
          <Link href="/" className="text-[#F5EEDC] text-2xl font-bold">YourLogo</Link>
        </div>

        {showSearch && (
          <div className="fixed inset-0 bg-[#23486A] z-50 p-4 md:hidden">
            <div className="flex items-center">
              <Button 
                onClick={() => setShowSearch(false)}
                className="mr-2 text-[#F5EEDC]"
                aria-label="Close search"
              >
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" className="w-6 h-6">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                </svg>
              </Button>
              <SearchBar />
            </div>
          </div>
        )}

        <div className="hidden md:flex items-center space-x-6">
          <div className="relative w-64">
            <SearchBar />
          </div>
          
          {links.map((link) => (
            <Link 
              key={link.id} 
              href={link.href}
              className="text-[#F5EEDC] hover:text-[#EFB036] transition-colors duration-200"
            >
              {link.title}
            </Link>
          ))}
          
          <LanguageToggle />
          
          <Button className="bg-[#EFB036] hover:bg-[#EFB036]/90 text-[#23486A] font-bold ml-4">
            Get Started
          </Button>
        </div>

        <div className="flex items-center space-x-4 md:hidden">
          <Button 
            onClick={() => setShowSearch(true)}
            className="text-[#F5EEDC]"
            aria-label="Open search"
          >
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" className="w-6 h-6">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
            </svg>
          </Button>
          
          <LanguageToggle isMobile={true} />
          
          <Button 
            className="text-[#F5EEDC]"
            onClick={() => setOpenMenu(!openMenu)}
            aria-label="Toggle menu"
          >
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" className="w-6 h-6">
              {openMenu ? (
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
              ) : (
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
              )}
            </svg>
          </Button>
        </div>

        {openMenu && (
          <div className="md:hidden absolute top-16 left-0 right-0 bg-[#23486A] shadow-md z-50">
            <div className="container mx-auto px-4 py-3">
              {links.map((link) => (
                <Link 
                  key={link.id} 
                  href={link.href}
                  className="block py-2 text-[#F5EEDC] hover:text-[#EFB036] transition-colors duration-200"
                >
                  {link.title}
                </Link>
              ))}
              <Button className="bg-[#EFB036] hover:bg-[#EFB036]/90 text-[#23486A] font-bold w-full mt-4">
                Get Started
              </Button>
            </div>
          </div>
        )}
      </div>
    </header>
  );
}