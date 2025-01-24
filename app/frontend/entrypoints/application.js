// 以下を views/layouts/application.html.erb の `<head>` セクションに追加してください
//
//    <%= vite_client_tag %>
//    <%= vite_javascript_tag 'application' %>
console.log("Vite ⚡️ Rails");

// TypeScriptのエントリーポイントファイルを使用する場合：
//     <%= vite_typescript_tag 'application' %>
//
// .jsx または .tsx を使用する場合は、拡張子を追加してください：
//     <%= vite_javascript_tag 'application.jsx' %>

console.log(
  "詳細については以下のガイドを参照してください： ",
  "https://vite-ruby.netlify.app/guide/rails",
);

// 例：ViteでRailsライブラリを読み込む
//
// import * as Turbo from '@hotwired/turbo'
// Turbo.start()
//
// import ActiveStorage from '@rails/activestorage'
// ActiveStorage.start()
//
// // 全チャンネルをインポート
// const channels = import.meta.globEager('./**/*_channel.js')

// 例：app/frontend/index.cssのスタイルシートをインポート
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
import "../stylesheets/product.css";
import Review from "../components/Review.vue";
import CreateReview from "../components/CreateReview.vue";
import ReviewDetail from "../components/ReviewDetail.vue";

// 主要なアプリケーションコンポーネントのマウント
document.addEventListener("DOMContentLoaded", () => {
  createApp(AppHeader).mount("#app-header"); // ヘッダー
  createApp(AppFooter).mount("#app-footer"); // フッター
  createApp(Index).mount("#index"); // ルート
  createApp(SignIn).mount("#sign-in");
  createApp(SignUp).mount("#sign-up");
});

// 地図関連コンポーネントのマウント
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

// レビュー関連の処理
document.addEventListener("DOMContentLoaded", () => {
  // レビュー関連の処理
  const reviewContainer = document.getElementById("review");

  if (reviewContainer && reviewContainer.dataset) {
    console.log("Review container found:", reviewContainer);
    console.log("Spot ID:", reviewContainer.dataset.spotId);
    console.log("Current User ID:", reviewContainer.dataset.currentUserId);

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

// レビューフォームコンポーネント
const reviewFormElement = document.getElementById("#create-review");
if (reviewFormElement) {
  const app = createApp(CreateReview, {
    spotId: reviewFormElement.dataset.spotId,
    currentUserId: reviewFormElement.dataset.currentUserId,
  });
  app.mount("#create-review");
}

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

const element = document.getElementById("index");
if (element) {
  createApp(ModelCourseIndex).mount("#index");
}

// モデルコース一覧コンポーネント（遅延読み込み）
const modelCourseListElement = document.getElementById("model-course-list");
if (modelCourseListElement) {
  import("../components/ModelCourseList.vue").then((module) => {
    const ModelCourseList = module.default;
    createApp(ModelCourseList).mount("#model-course-list");
  });
}

// お問い合わせフォームコンポーネント
const contactElement = document.getElementById("contact");
if (contactElement) {
  createApp(Contact).mount("#contact");
}
