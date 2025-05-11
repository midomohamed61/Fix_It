module.exports = {
  content: [
    "./pages/**/*.{js,ts,jsx,tsx}",
    "./components/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        gold: '#EFB036',
        'blue-medium': '#3B6790',
        'blue-dark': '#23486A',
        'blue-light': '#4C7B8B',
        cream: '#FEF3E2',
      },
      animation: {
        'wave': 'wave 8s linear infinite',
        'fadeIn': 'fadeIn 1s ease-out',
        'slideIn': 'slideIn 0.5s ease',
        'shake': 'shake 0.5s cubic-bezier(.36,.07,.19,.97)',
        'fill': 'fill 0.4s ease-in-out 0.4s forwards',
        'scale': 'scale 0.3s ease-in-out 0.9s both',
        'stroke': 'stroke 0.6s cubic-bezier(0.65, 0, 0.45, 1) forwards',
        'stroke-check': 'stroke 0.3s cubic-bezier(0.65, 0, 0.45, 1) 0.8s forwards',
        'shine': 'shine 3s infinite',
        'spin': 'spin 1s ease-in-out infinite',
      },
      keyframes: {
        wave: {
          '0%': { 'background-position-x': '0' },
          '100%': { 'background-position-x': '1000px' },
        },
        fadeIn: {
          from: { opacity: '0' },
          to: { opacity: '1' },
        },
        slideIn: {
          from: { transform: 'translateX(-50px)', opacity: '0' },
          to: { transform: 'translateX(0)', opacity: '1' },
        },
        shake: {
          '10%, 90%': { transform: 'translate3d(-1px, 0, 0)' },
          '20%, 80%': { transform: 'translate3d(2px, 0, 0)' },
          '30%, 50%, 70%': { transform: 'translate3d(-3px, 0, 0)' },
          '40%, 60%': { transform: 'translate3d(3px, 0, 0)' },
        },
        fill: {
          '100%': { 'box-shadow': 'inset 0px 0px 0px 30px #4bb71b' },
        },
        scale: {
          '0%, 100%': { transform: 'none' },
          '50%': { transform: 'scale3d(1.1, 1.1, 1)' },
        },
        stroke: {
          '100%': { 'stroke-dashoffset': '0' },
        },
        shine: {
          '0%': { left: '-100%' },
          '20%': { left: '100%' },
          '100%': { left: '100%' },
        },
        spin: {
          to: { transform: 'rotate(360deg)' },
        },
      },
    },
  },
  plugins: [],
}