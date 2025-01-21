import { createApp } from "vue";
import ModelCourseIndex from "../components/ModelCourseIndex.vue";
import UserProfile from "../components/UserProfile.vue"; // UserProfileコンポーネントをインポート

document.addEventListener("DOMContentLoaded", () => {
  // ModelCourseIndexのマウント
  const indexElement = document.getElementById("index");
  if (indexElement) {
    createApp(ModelCourseIndex).mount("#index");
  }

  // UserProfileのマウント
  const userProfileElement = document.getElementById("user-profile-app");
  if (userProfileElement) {
    try {
      const userData = userProfileElement.dataset.user;
      if (userData) {
        const user = JSON.parse(userData.replace(/&quot;/g, '"'));
        const app = createApp(UserProfile);
        app.provide("user", user);
        app.mount("#user-profile-app");
      } else {
        console.error("user data not found in dataset");
      }
    } catch (e) {
      console.error("Failed to parse user data:", e);
    }
  } else {
    console.error("user-profile-app element not found");
  }
});
