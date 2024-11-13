/** @type {import('tailwindcss').Config} */
export default {
  /* Tailwind CSS を適用するファイルの設定 */
  content: [
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/views/**/*.{html,html.erb,erb}",
    "./app/frontend/**/*.{css,js,ts,vue}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
};
