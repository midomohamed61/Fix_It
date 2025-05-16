"use client";

import { Geist, Geist_Mono } from "next/font/google";
import "./globals.css";
import { Roboto } from "next/font/google";
import Header from "@/components/layouts/Header/Header";
import Footer from "@/components/layouts/Footer/Footer";
import { usePathname } from "next/navigation";
import { LanguageProvider } from "@/components/ui/LanguageToggle/LanguageContext";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

const roboto = Roboto({
  subsets: ['latin'],
  weight: ['400', '500', '700'],
  preload: true,
});

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  const pathname = usePathname();
  
  const noHeaderFooterPaths = [
    "/login",
    "/register",
    "/forgot-password",
    "/reset-password",
    "/client",
    "/workerinfo",
    "/worker-information"
  ];

  const shouldShowHeaderFooter = !noHeaderFooterPaths.some(path => 
    pathname?.startsWith(path)
  );

  return (
    <html lang="en">
      <body className={`${roboto.className} ${geistSans.variable} ${geistMono.variable} antialiased`}>
        <LanguageProvider>
          {shouldShowHeaderFooter && <Header />}
          {children}
          {shouldShowHeaderFooter && <Footer />}
        </LanguageProvider>
      </body>
    </html>
  );
}