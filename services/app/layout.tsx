import type { Metadata } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import "./globals.css";
import {Roboto} from "next/font/google";
import Header from "@/components/layouts/Header/Header";
import Footer from "@/components/layouts/Footer/Footer";

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
  weight:[ '400','500','700'],
  preload: true,
})

export const metadata: Metadata = {
  title: "Services",
  description: "Explore a range of professional services tailored  ",
}

export default function RootLayout({children,}: Readonly<{children: React.ReactNode;}>) {
  return (
    <html lang="en">
      {/*className={`${geistSans.variable} ${geistMono.variable} antialiased`}  */}
      <body className={roboto.className +`${geistSans.variable} ${geistMono.variable} antialiased`}>
        <Header/>
        {children}
        <Footer/>
      </body>
    </html>
  );
}
