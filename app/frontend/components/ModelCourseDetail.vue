<template>
  <div :class="['model-course-detail', darkMode ? 'bg-gray-900 text-white' : 'bg-yellow-50 text-black']">
    <LoadingScreen v-if="loading" />
    <div v-else>
      <div class="header">
        <button @click="goBack" class="btn">一覧に戻る</button>
        <div class="actions">
          <button @click="editCourse" class="btn">編集</button>
          <button @click="deleteCourse" class="btn btn-danger">削除</button>
        </div>
      </div>
      <h1 class="title">{{ modelCourse.title }}</h1>
      <img v-if="modelCourse.theme_image_url" :src="modelCourse.theme_image_url" alt="テーマ画像" class="theme-image" />
      <p class="description">{{ modelCourse.description }}</p>
      <p class="budget">予算: {{ modelCourse.budget }}</p>
      <p class="season">季節: {{ modelCourse.season }}</p>
      <p class="creator">作成者: {{ modelCourse.application_user.nickname }}</p>
      <div class="genre-tags">
        <h2>ジャンルタグ</h2>
        <ul>
          <li v-for="tag in modelCourse.genre_tags" :key="tag">{{ tag }}</li>
        </ul>
      </div>
      <div v-if="modelCourse.gallery_image_urls.length > 0" class="gallery">
        <h2>ギャラリー画像</h2>
        <div class="gallery-images">
          <div v-for="(img, index) in modelCourse.gallery_image_urls" :key="index" class="gallery-image">
            <img :src="img" alt="ギャラリー画像"  @click="openModal(img)" />
          </div>
        </div>
      </div>
      <div class="dark-mode-toggle">
        <button @click="toggleDarkMode" class="btn">
          {{ darkMode ? '🌚' : '🌞' }}
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import LoadingScreen from './LoadingScreen.vue';

export default {
  components: {
    LoadingScreen
  },
  props: ['id'],
  data() {
    return {
      modelCourse: {
        gallery_image_urls: [],
        genre_tags: [],
        application_user: {}
      },
      darkMode: false, // ダークモードの状態を管理
      loading: true // ローディング状態を管理
    };
  },
  async created() {
    const startTime = Date.now();
    try {
      const response = await fetch(`/model-courses/${this.id}.json`);
      if (!response.ok) {
        throw new Error('詳細取得に失敗しました');
      }
      const data = await response.json();
      this.modelCourse = data.model_course;
    } catch (error) {
      console.error('詳細取得に失敗しました:', error);
    } finally {
      const elapsedTime = Date.now() - startTime;
      const remainingTime = 1500 - elapsedTime;
      if (remainingTime > 0) {
        setTimeout(() => {
          this.loading = false;
        }, remainingTime);
      } else {
        this.loading = false;
      }
    }
  },
  methods: {
    goBack() {
      window.location.href = '/model-courses';
    },
    editCourse() {
      window.location.href = `/model-courses/${this.id}/edit`;
    },
    async deleteCourse() {
      if (confirm("本当にこのモデルコースを削除しますか？")) {
        try {
          const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
          const response = await fetch(`/model-courses/${this.id}`, {
            method: 'DELETE',
            headers: {
              'Content-Type': 'application/json',
              'X-CSRF-Token': csrfToken
            }
          });
          if (!response.ok) {
            const errorData = await response.json();
            alert(errorData.error);
            throw new Error('削除に失敗しました');
          }
          alert("モデルコースが削除されました");
          window.location.href = "/model-courses";
        } catch (error) {
          console.error("削除エラー:", error);
        }
      }
    },
    toggleDarkMode() {
      this.darkMode = !this.darkMode; // ダークモードの切り替え
    },
    openModal(imgUrl) {
      $.modaal({
        type: 'image',
        content_source: imgUrl,
      });
    }
  }
};
</script>

<style scoped>
.model-course-detail {
  max-width: 100%;
  margin: 0 auto;
  padding: 20px;
  font-family: Arial, sans-serif;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.actions {
  display: flex;
  gap: 10px;
}

.btn {
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  background-color: #3498db;
  color: #fff;
  font-size: 1em;
  transition: background-color 0.3s ease-in-out;
}

.btn-danger {
  background-color: #e74c3c;
}

.btn:hover {
  background-color: #2980b9;
}

.btn-danger:hover {
  background-color: #c0392b;
  transform: scale(1.05);
}

.title {
  font-size: 2em;
  margin-bottom: 20px;
  text-align: center;
}

.theme-image {
  width: 100%;
  height: auto;
  max-height: 400px;
  object-fit: cover;
  margin-bottom: 20px;
  border-radius: 8px;
}

.description {
  font-size: 1.2em;
  margin-bottom: 20px;
}

.budget, .season, .creator {
  font-size: 1em;
  margin-bottom: 10px;
}

.genre-tags {
  margin-top: 20px;
}

.genre-tags ul {
  list-style: none;
  padding: 0;
}

.genre-tags li {
  display: inline-block;
  background-color: #ffcc00;
  color: #333;
  padding: 8px 12px;
  border-radius: 20px;
  font-size: 0.9em;
  font-weight: bold;
  border: 1px solid #d4a017;
  box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
}

.gallery {
  margin-top: 40px;
}

.gallery-images {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}

.gallery-image img {
  width: 200px;
  height: 150px;
  object-fit: cover;
  border: 1px solid #ddd;
  border-radius: 4px;
  padding: 5px;
  background: #fff;
}

.dark-mode-toggle {
  position: fixed;
  top: 20px;
  right: 20px;
}
</style>
