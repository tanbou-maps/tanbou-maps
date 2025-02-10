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
      <div v-if="modelCourse.gallery_image_urls.length > 0" class="gallery">
        <h2>ギャラリー画像</h2>
        <div class="gallery-images">
          <div v-for="(img, index) in modelCourse.gallery_image_urls" :key="index" class="gallery-image">
            <img :src="img" alt="ギャラリー画像" />
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
        gallery_image_urls: []
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
      if (confirm('本当に削除しますか？')) {
        try {
          const response = await fetch(`/model-courses/${this.id}`, {
            method: 'DELETE',
            headers: {
              'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
            }
          });
          if (response.ok) {
            alert('削除されました');
            this.goBack();
          } else {
            alert('削除に失敗しました');
          }
        } catch (error) {
          console.error('削除に失敗しました:', error);
          alert('削除に失敗しました');
        }
      }
    },
    toggleDarkMode() {
      this.darkMode = !this.darkMode; // ダークモードの切り替え
    }
  }
};
</script>

<style scoped>
.model-course-detail {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
  font-family: Arial, sans-serif;
  border-radius: 8px;
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
}

.btn-danger {
  background-color: #e74c3c;
}

.btn:hover {
  background-color: #2980b9;
}

.btn-danger:hover {
  background-color: #c0392b;
}

.title {
  font-size: 2em;
  margin-bottom: 20px;
  text-align: center;
}

.theme-image {
  width: 100%;
  height: auto;
  margin-bottom: 20px;
  border-radius: 8px;
}

.description {
  font-size: 1.2em;
  margin-bottom: 20px;
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
  width: 100%;
  height: auto;
  max-width: 200px;
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
