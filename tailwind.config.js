/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/views/**/*.{html,html.erb,erb}",
    "./app/frontend/components/**/*.js",
    "./app/frontend/stylesheets/*.css",
    "./app/frontend/entrypoints/*.js",
    "./app/frontend/vue/*.vue",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
};
