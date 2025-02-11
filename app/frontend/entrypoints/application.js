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
import router from "../router"; // Vue Router をインポート
import App from "../components/App.vue"; // Vue アプリのルートコンポーネント
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
import Review from "../components/Review.vue";
import AdminIndex from "../components/AdminIndex.vue";
import ContentsManagement from "../components/ContentsManagement.vue";
import ReviewDetail from "../components/ReviewDetail.vue";
import DeleteAccountModal from "../components/DeleteAccountModal.vue";
import LoadingScreen from "../components/LoadingScreen.vue";

document.addEventListener("DOMContentLoaded", () => {
  createApp(AppHeaderComponent).mount("#app-header-component"); // header
  createApp(AppFooterComponent).mount("#app-footer-component"); // footer
  createApp(IndexPage).mount("#index-page"); // root
  createApp(SignInPage).mount("#sign-in-page");
  createApp(SignUpPage).mount("#sign-up-page");
  createApp(SignUpCompletePage).mount("#sign-up-complete-page");
  createApp(SignOutPage).mount("#sign-out-page");
  createApp(Review).mount("#review");
  createApp(AdminIndex).mount("#admin-index");
  createApp(ContentsManagement).mount("#contents-management");

  // Delete Account Modal
  const deleteAccountModalElement = document.getElementById(
    "delete-account-modal",
  );
  if (deleteAccountModalElement) {
    const app = createApp(DeleteAccountModal, {
      userId: deleteAccountModalElement.dataset.userId,
    });
    const vm = app.mount("#delete-account-modal");

    // ボタンクリックイベントの設定
    const deleteButton = document.getElementById("delete-account-button");
    if (deleteButton) {
      deleteButton.addEventListener("click", () => {
        vm.openModal();
      });
    }
  }
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

// --- reviews start ---
document.addEventListener("DOMContentLoaded", () => {
  // レビュー関連の処理
  const reviewContainer = document.getElementById("review");

  if (reviewContainer && reviewContainer.dataset) {
    try {
      const app = createApp(Review, {
        spotId: reviewContainer.dataset.spotId,
        currentUserId: reviewContainer.dataset.currentUserId,
      });
      app.mount(reviewContainer);
      console.log("Review component mounted successfully");
    } catch (error) {
      console.error("Error mounting Review component:", error);
    }
  } else {
    console.log("Review container not found or missing dataset");
  }
});

// レビュー詳細コンポーネントのマウント処理を有効化
const reviewDetailElement = document.getElementById("review-detail");
if (reviewDetailElement) {
  const app = createApp(ReviewDetail, {
    spotId: reviewDetailElement.dataset.spotId,
    reviewId: reviewDetailElement.dataset.reviewId,
    currentUserId: reviewDetailElement.dataset.currentUserId,
  });
  app.mount("#review-detail");
}
// --- reviews end ---

// VueRouter
document.addEventListener("DOMContentLoaded", () => {
  const appElement = document.getElementById("app");
  if (appElement) {
    const app = createApp(App);
    app.use(router); // Vue Router を適用
    app.mount("#app"); // Vue アプリを #app にマウント
  }
});

// --- model courses start ---
// モデルコース一覧
const modelCourseListElement = document.getElementById("model-course-list");
if (modelCourseListElement) {
  import("../components/ModelCourseList.vue").then((module) => {
    const ModelCourseList = module.default;
    createApp(ModelCourseList).mount("#model-course-list");
  });
}

// モデルコース新規作成
const modelCourseNewElement = document.getElementById("model-course-new");
if (modelCourseNewElement) {
  import("../components/ModelCourseForm.vue").then((module) => {
    const ModelCourseForm = module.default;
    createApp(ModelCourseForm).mount("#model-course-new");
  });
}

// モデルコース編集
const modelCourseEditElement = document.getElementById("model-course-edit");
if (modelCourseEditElement) {
  import("../components/ModelCourseEdit.vue").then((module) => {
    const ModelCourseForm = module.default;
    createApp(ModelCourseForm).mount("#model-course-edit");
  });
}


// モデルコース詳細
const modelCourseShowElement = document.getElementById("model-course-show");
if (modelCourseShowElement) {
  import("../components/ModelCourseDetail.vue").then((module) => {
    const ModelCourseDetail = module.default;
    createApp(ModelCourseDetail, {
      id: modelCourseShowElement.dataset.id
    }).mount("#model-course-show");
  });
}
// --- model courses end ---

const loadingScreenElement = document.getElementById("loading-screen");
if (loadingScreenElement) {
  createApp(LoadingScreen).mount("#loading-screen");
}

// お問い合わせフォームコンポーネント
const contactElement = document.getElementById("contact");
if (contactElement) {
  console.log("Mounting Contact");
  createApp(Contact).mount("#contact");
  console.log("Mounted Contact");
}
