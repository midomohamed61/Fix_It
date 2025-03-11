import type { Config } from "tailwindcss";

export default {
  content: [
    "./pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./components/**/*.{js,ts,jsx,tsx,mdx}",
    "./app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      colors: {
        primary: "#6A1B9A",
        secondary: "#2A5C82",
        danger: "#E53935",
        warning: "#FFA726",
        info: "#FFD54F",
        success: "#4CAF50",
        light: "#F5F5F5",
        dark: "#212121",
        white:'#FFFFFF'
      },
    },
  },
  plugins: [],
} satisfies Config;
