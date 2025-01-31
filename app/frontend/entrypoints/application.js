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
import AppFooter from "../components/AppFooter.vue";
import Index from "../components/Index.vue";
import SignIn from "../components/SignIn.vue";
import SignUp from "../components/SignUp.vue";
import MapSearch from "../components/MapSearch.vue";
import SpotMapPicker from "../components/SpotMapPicker.vue";
import SpotMap from "../components/SpotMap.vue";
import Contact from "../components/Contact.vue";
import UserProfile from "../components/UserProfile.vue";
import UserProfileViewId from "../components/UserProfileViewId.vue";
import UserProfileView from "../components/UserProfileView.vue";
import CorporateProfile from "../components/CorporateProfile.vue";
import CorporateProfileView from "../components/CorporateProfileView.vue";
import CorporateProfileViewId from "../components/CorporateProfileViewId.vue";
import Review from "../components/Review.vue";
import Toast from "vue-toastification";
import "vue-toastification/dist/index.css";

document.addEventListener("DOMContentLoaded", () => {
  createApp(AppHeader).mount("#app-header"); // header
  createApp(AppFooter).mount("#app-footer"); // footer
  createApp(Index).mount("#index"); // root
  createApp(SignIn).mount("#sign-in");
  createApp(SignUp).mount("#sign-up");
  createApp(Review).mount("#review");
});

const mapSearchApp = document.getElementById("map-search-app");

if (mapSearchApp) {
  console.log("Mounting MapSearch");
  const app = createApp(MapSearch);
  app.mount("#map-search-app");
  console.log("Mounted MapSearch");
}

const spotMapPicker = document.getElementById("spot-map-picker");

if (spotMapPicker) {
  console.log("Mounting SpotMapPicker");
  const app = createApp(SpotMapPicker);
  app.mount("#spot-map-picker");
  console.log("Mounted SpotMapPicker");
}

const spotMap = document.getElementById("spot-map");

if (spotMap) {
  console.log("Mounting SpotMap");
  const app = createApp(SpotMap);
  app.mount("#spot-map");
  console.log("Mounted SpotMap");
}

// レビュー関連の処理
const reviewElements = document.querySelectorAll("#review");
reviewElements.forEach((element) => {
  if (element) {
    const app = createApp(Review, {
      spotId: element.dataset.spotId,
    });
    app.mount(element);
  }
});

const element = document.getElementById("index");

if (element) {
  // createApp(ModelCourseIndex).mount("#index");
}

// モデルコース新規作成画面専用の処理
const modelCourseNewElement = document.getElementById("model-course-new");
if (modelCourseNewElement) {
  import("../components/ModelCourseForm.vue").then((module) => {
    const ModelCourseForm = module.default;
    createApp(ModelCourseForm).mount("#model-course-new");
  });
}

// モデルコース編集画面専用の処理
const modelCourseEditElement = document.getElementById("model-course-edit");
if (modelCourseEditElement) {
  import("../components/ModelCourseForm.vue").then((module) => {
    const ModelCourseForm = module.default;
    createApp(ModelCourseForm).mount("#model-course-edit");
  });
}

// モデルコース詳細画面専用の処理
const modelCourseShowElement = document.getElementById("model-course-show");
if (modelCourseShowElement) {
  import("../components/ModelCourseDetail.vue").then((module) => {
    const ModelCourseDetail = module.default;
    createApp(ModelCourseDetail).mount("#model-course-show");
  });
}

// お問い合わせ画面
const contactElement = document.getElementById("contact");
if (contactElement) {
  console.log("Mounting Contact");
  createApp(Contact).mount("#contact");
  console.log("Mounted Contact");
}

// ユーザープロフィールCRUD画面
const userProfileApp = document.getElementById("user-profile-app");
if (userProfileApp) {
  try {
    const userData = userProfileApp.dataset.user;
    if (userData) {
      const sanitizedUserData = userData
        .replace(/\\\"/g, '"')
        .replace(/\\\$/g, "$");
      const user = JSON.parse(sanitizedUserData);
      const app = createApp(UserProfile);
      app.use(Toast); // Toastを使用するように設定
      app.provide("user", user);
      app.mount("#user-profile-app");
    } else {
      console.error("user data not found in dataset");
    }
  } catch (e) {
    console.error("Failed to parse user data:", e);
  }
}

const userProfileViewIdApp = document.getElementById(
  "user-profile-view-id-app",
);
if (userProfileViewIdApp) {
  console.log("Mounting UserProfileViewId");
  const user = JSON.parse(userProfileViewIdApp.dataset.user);
  const rootPath = userProfileViewIdApp.dataset.rootPath;
  const app = createApp(UserProfileViewId, { user, rootPath });
  app.mount("#user-profile-view-id-app");
  console.log("Mounted UserProfileViewId");
}

const userProfileViewApp = document.getElementById("user-profile-view-app");
if (userProfileViewApp) {
  console.log("Mounting UserProfileView");
  const user = JSON.parse(userProfileViewApp.dataset.user);
  const rootPath = userProfileViewApp.dataset.rootPath;
  const app = createApp(UserProfileView, { user, rootPath });
  app.mount("#user-profile-view-app");
  console.log("Mounted UserProfileView");
}

// 企業プロフィールCRUD画面
const corporateProfileApp = document.getElementById("corporate-profile-app");
if (corporateProfileApp) {
  try {
    const userData = corporateProfileApp.dataset.user;
    if (userData) {
      const sanitizedUserData = userData
        .replace(/\\\"/g, '"')
        .replace(/\\\$/g, "$");
      const user = JSON.parse(sanitizedUserData);
      const app = createApp(CorporateProfile);
      app.use(Toast); // Toastを使用するように設定
      app.provide("user", user);
      app.mount("#corporate-profile-app");
    } else {
      console.error("user data not found in dataset");
    }
  } catch (e) {
    console.error("Failed to parse user data:", e);
  }
}

// idを使って企業プロフィールを表示する画面
const corporateProfileViewIdApp = document.getElementById(
  "corporate-profile-view-id-app",
);
if (corporateProfileViewIdApp) {
  const userData = corporateProfileViewIdApp.dataset.user;
  if (userData) {
    const user = JSON.parse(corporateProfileViewIdApp.dataset.user);
    const rootPath = corporateProfileViewIdApp.dataset.rootPath;
    const app = createApp(CorporateProfileViewId, { user, rootPath });
    app.mount("#corporate-profile-view-id-app");
  }
}

// idを使わずに企業プロフィールを表示する画面
const corporateProfileViewApp = document.getElementById(
  "corporate-profile-view-app",
);
if (corporateProfileViewApp) {
  const userData = corporateProfileViewApp.dataset.user;
  if (userData) {
    console.log("Raw user data:", userData); // デバッグ用
    const user = JSON.parse(corporateProfileViewApp.dataset.user);
    console.log("Parsed user data:", user); // デバッグ用
    const rootPath = corporateProfileViewApp.dataset.rootPath;
    const app = createApp(CorporateProfileView, { user, rootPath });
    app.mount("#corporate-profile-view-app");
  }
}
