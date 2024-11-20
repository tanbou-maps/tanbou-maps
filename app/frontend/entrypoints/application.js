// To see this message, add the following to the `<head>` section in your
// views/layouts/application.html.erb
//
//    <%= vite_client_tag %>
//    <%= vite_javascript_tag 'application' %>
console.log("Vite ⚡️ Rails");

// If using a TypeScript entrypoint file:
//     <%= vite_typescript_tag 'application' %>
//
// If you want to use .jsx or .tsx, add the extension:
//     <%= vite_javascript_tag 'application.jsx' %>

console.log(
  "Visit the guide for more information: ",
  "https://vite-ruby.netlify.app/guide/rails",
);

// Example: Load Rails libraries in Vite.
//
// import * as Turbo from '@hotwired/turbo'
// Turbo.start()
//
// import ActiveStorage from '@rails/activestorage'
// ActiveStorage.start()
//
// // Import all channels.
// const channels = import.meta.globEager('./**/*_channel.js')

// Example: Import a stylesheet in app/frontend/index.css
// import '~/index.css'

import { createApp } from "vue";
import "../stylesheets/style.css";
import App from "../vue/App.vue"; // テスト用 Vue コンポーネントを読み込む
import Header from "../components/Header.vue";
import Index from "../components/Index.vue";
import SignIn from "../components/SignIn.vue";
import SignUp from "../components/SignUp.vue";

document.addEventListener("DOMContentLoaded", () => {
  createApp(App).mount("#app"); // vue/index の場所にマウント
  createApp(Header).mount("#header"); // header
  createApp(Index).mount("#index"); // root
  createApp(SignIn).mount("#sign-in");
  createApp(SignUp).mount("#sign-up");
});
