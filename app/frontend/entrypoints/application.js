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
import AppHeader from "../components/AppHeader.vue";
import Index from "../components/Index.vue";
import SignIn from "../components/SignIn.vue";
import SignUp from "../components/SignUp.vue";
import MapSearch from "../components/MapSearch.vue";
import SpotMapPicker from "../components/SpotMapPicker.vue";
import SpotMap from "../components/SpotMap.vue";
import Contact from "../components/Contact.vue";
import "../stylesheets/product.css";
import AppFooter from "../components/AppFooter.vue";
document.addEventListener("DOMContentLoaded", () => {
  createApp(AppHeader).mount("#app-header"); // header
  createApp(AppFooter).mount("#app-footer"); // footer
  createApp(Index).mount("#index"); // root
  createApp(SignIn).mount("#sign-in");
  createApp(SignUp).mount("#sign-up");
});

const mapSearchApp = document.getElementById("map-search-app");

if (mapSearchApp) {
  const app = createApp(MapSearch);
  app.mount("#map-search-app");
}

const spotMapPicker = document.getElementById("spot-map-picker");

if (spotMapPicker) {
  const app = createApp(SpotMapPicker);
  app.mount("#spot-map-picker");
}

const spotMap = document.getElementById("spot-map");

if (spotMap) {
  const app = createApp(SpotMap);
  app.mount("#spot-map");
}

const element = document.getElementById("index");

if (element) {
  createApp(ModelCourseIndex).mount("#index");
}

// モデルコース一覧画面専用の処理
const modelCourseListElement = document.getElementById("model-course-list");
if (modelCourseListElement) {
  import("../components/ModelCourseList.vue").then((module) => {
    const ModelCourseList = module.default;
    createApp(ModelCourseList).mount("#model-course-list");
  });
}

// お問い合わせ画面
const contactElement = document.getElementById("contact");
if (contactElement) {
  createApp(Contact).mount("#contact");
}
