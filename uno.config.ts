import { defineConfig } from "unocss";
import presetWind4 from "@unocss/preset-wind4";

export default defineConfig({
  content: {
    pipeline: {
      include: ["src/**/*.{gleam}"],
    },
  },
  presets: [presetWind4()],
  theme: {
    colors: {
        faffPink: "#ffaff3",
    },
  },
  shortcuts: {
    'shadow-faffpink': 'shadow-[8px_8px_0px_0px_rgba(255,255,255,1)] hover:shadow-[12px_12px_0px_0px_#ffaff3] transition-all duration-300 transform hover:-translate-x-1 hover:-translate-y-1',
    'shadow-faffpink-mobile': 'shadow-[6px_6px_0px_0px_rgba(255,255,255,1)] md:shadow-[8px_8px_0px_0px_rgba(255,255,255,1)] hover:shadow-[8px_8px_0px_0px_#ffaff3] md:hover:shadow-[12px_12px_0px_0px_#ffaff3] transition-all duration-300 transform hover:-translate-x-1 hover:-translate-y-1',
  },
  rules: [
    ['marker-faffpink', {
      'position': 'relative',
      'padding': '0 0.625rem',
      'color': '#000',
      'background-color': '#ffaff3',
      '&::before': {
        'position': 'absolute',
        'left': '0',
        'width': '0',
        'height': '100%',
        'content': '""',
        'background-color': '#fff',
        'mix-blend-mode': 'difference',
        'transition': '0.3s',
      },
      '&:hover::before': {
        'width': '100%',
      }
    }]
  ],
});
