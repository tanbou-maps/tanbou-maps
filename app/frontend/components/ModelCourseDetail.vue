<template>
  <div class="container">

    <LoadingWave v-if="isLoading" />

    <div class="course-card">
      <h1 class="course-title">{{ course.title }}</h1>
      <p class="course-date">{{ formattedDate }}</p>

      <!-- 拡大画像のオーバーレイ -->
      <div v-if="expandedImage" class="overlay" @click="expandedImage = null">
        <img :src="expandedImage" class="expanded-image" />
      </div>

      <!-- クリックで拡大表示 -->
      <img
        v-if="course.theme_image_url"
        :src="course.theme_image_url"
        alt="コース画像"
        class="course-image"
        @click="expandedImage = course.theme_image_url"
      />

      <p class="course-description">本文： {{ course.description }}</p>

      <div class="course-meta">
        <p>作成者: <strong>{{ course.application_user.nickname }}</strong></p>
      </div>

      <router-link to="/model-courses" class="back-button">一覧に戻る</router-link>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import LoadingWave from "./LoadingWave.vue";

export default {
  components: {
    LoadingWave,
  },
  data() {
    return {
      course: null,
      expandedImage: null, // 拡大画像の状態を管理
      isLoading: true, // 初期状態はローディング
    };
  },
  computed: {
    formattedDate() {
      if (this.course && this.course.created_at) {
        const date = new Date(this.course.created_at);
        return date.toLocaleDateString("ja-JP", {
          year: "numeric",
          month: "long",
          day: "numeric",
          weekday: "long",
        });
      }
      return "";
    }
  },
  async mounted() {
    const courseId = this.$route.params.id;

    // ローディングの開始時間を記録
    const startTime = Date.now();

    try {
      const response = await axios.get(`/model-courses/${courseId}.json`);
      this.course = response.data;
    } catch (error) {
      console.error("データの取得に失敗しました", error);
    }

    // 最低 1.5 秒間はローディングを表示
    const elapsedTime = Date.now() - startTime;
    const delay = Math.max(1500 - elapsedTime, 0);

    setTimeout(() => {
      this.isLoading = false;
    }, delay);
  }
};
</script>

<style scoped>
.container {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 20px;
}

.course-card {
  background: white;
  padding: 20px;
  border-radius: 12px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  width: 80%;
  max-width: 600px;
  text-align: center;
}

.course-title {
  font-size: 24px;
  font-weight: bold;
  margin-bottom: 10px;
}

.course-date {
  font-size: 14px;
  color: gray;
  margin-bottom: 10px;
}

.course-image {
  width: 100%;
  max-height: 300px;
  object-fit: cover;
  border-radius: 8px;
  margin-bottom: 15px;
  cursor: pointer;
  transition: transform 0.2s;
}

.course-description {
  font-size: 16px;
  line-height: 1.6;
  margin-bottom: 15px;
}

.course-meta {
  font-size: 14px;
  color: #555;
}

.back-button {
  display: inline-block;
  padding: 10px 15px;
  background: #007bff;
  color: white;
  border-radius: 5px;
  text-decoration: none;
  margin-top: 20px;
}

.back-button:hover {
  background: #0056b3;
}

.course-image:hover {
  transform: scale(1.05);
}

.overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.8);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.expanded-image {
  max-width: 90%;
  max-height: 90%;
  border-radius: 8px;
}
</style>
