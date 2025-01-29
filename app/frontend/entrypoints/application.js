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
import AppHeaderComponent from "../components/AppHeaderComponent.vue";
import AppFooterComponent from "../components/AppFooterComponent.vue";
import IndexPage from "../components/IndexPage.vue";
import SignInPage from "../components/SignInPage.vue";
import SignUpPage from "../components/SignUpPage.vue";
import SignUpCompletePage from "../components/SignUpCompletePage.vue";
import SignOutPage from "../components/SignOutPage.vue";
import SpotsSearchPage from "../components/SpotsSearchPage.vue";
import SpotPickerComponent from "../components/SpotPickerComponent.vue";
import SpotShowComponent from "../components/SpotShowComponent.vue";
import Contact from "../components/Contact.vue";
import UserProfile from "../components/UserProfile.vue";
import UserProfileViewId from "../components/UserProfileViewId.vue";
import UserProfileView from "../components/UserProfileView.vue";
// import ModelCourseIndex from "../components/ModelCourseIndex.vue";
import Review from "../components/Review.vue";
import AdminIndex from "../components/AdminIndex.vue";
import ContentsManagement from "../components/ContentsManagement.vue";

document.addEventListener("DOMContentLoaded", () => {
  createApp(AppHeaderComponent).mount("#app-header-component"); // header
  createApp(AppFooterComponent).mount("#app-footer-component"); // footer
  createApp(IndexPage).mount("#index-page"); // root
  createApp(SignInPage).mount("#sign-in-page");
  createApp(SignUpPage).mount("#sign-up-page");
  createApp(SignUpCompletePage).mount("#sign-up-complete-page");
  createApp(SignOutPage).mount("#sign-out-page");
  createApp(Review).mount("#review");
  createApp(AdminIndex).mount("#adminindex");
  createApp(ContentsManagement).mount("#contentsmanagement");
});

// --- spots start ---
const spotsSearchPage = document.getElementById("spots-search-page");

if (spotsSearchPage) {
  const app = createApp(SpotsSearchPage);
  app.mount("#spots-search-page");
}

const spotPickerComponent = document.getElementById("spot-picker-component");

if (spotPickerComponent) {
  const app = createApp(SpotPickerComponent);
  app.mount("#spot-picker-component");
}

const spotShowComponent = document.getElementById("spot-show-component");

if (spotShowComponent) {
  const app = createApp(SpotShowComponent);
  app.mount("#spot-show-component");
}
// --- spots end ---

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
