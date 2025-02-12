<template>
  <div :class="['w-full min-h-screen', darkMode ? 'bg-gray-900 text-white' : 'bg-yellow-50 text-black']"> <!-- ダークモードとライトモードの切り替え -->
    <LoadingScreen v-if="loading" />
    <div v-else class="container mx-auto p-6">
      <div class="flex justify-between items-center mb-6">
        <h2 class="text-3xl font-bold">モデルコース一覧</h2>
        <div class="absolute top-4 right-4">
          <button @click="toggleDarkMode" class="bg-gray-700 text-white py-2 px-4 rounded-lg hover:bg-gray-800 text-2xl">
            {{ darkMode ? '🌚' : '🌞' }}
          </button>
        </div>
      </div>

      <div class="flex justify-between mb-6">
        <a href="/" class="bg-gray-500 text-white py-2 px-4 rounded-lg hover:bg-gray-600">
          ホームに戻る
        </a>
        <a href="/model-courses/new" class="bg-blue-500 text-white py-2 px-4 rounded-lg hover:bg-blue-600">
          新規作成
        </a>
      </div>

      <div class="sort-links mb-6 flex flex-wrap justify-center gap-2">
        <button @click="sort('title_asc')" class="sort-button">タイトル順 (昇順)</button>
        <button @click="sort('title_desc')" class="sort-button">タイトル順 (降順)</button>
        <button @click="sort('created_at_asc')" class="sort-button">作成日順 (昇順)</button>
        <button @click="sort('created_at_desc')" class="sort-button">作成日順 (降順)</button>
      </div>

      <div v-if="modelCourses.length === 0" class="text-center text-gray-600">まだ登録されたモデルコースがありません
      あなたの手でモデルコースを登録してみませんか？</div>

      <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <div v-for="course in modelCourses" :key="course.id" :class="['shadow-lg rounded-lg overflow-hidden', darkMode ? 'bg-gray-800 text-white' : 'bg-white text-black']">
          <a :href="`/model-courses/${course.id}`">
            <img v-if="course.theme_image_url" :src="course.theme_image_url" alt="モデルコース画像" class="w-full h-40 object-cover" />
            <div v-else class="w-full h-40 bg-gray-300 flex items-center justify-center">
              <span class="text-gray-600">画像なし</span>
            </div>

            <div class="p-4">
              <h3 class="text-xl font-semibold">{{ course.title }}</h3>
              <p class="text-gray-600 text-sm mt-2">{{ truncateDescription(course.description) }}</p>
              <p class="text-gray-600 text-sm mt-2">作成者: {{ course.application_user.nickname }}</p>
            </div>
          </a>
        </div>
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
  props: {
    searchQuery: {
      type: String,
      default: "",
    },
  },
  data() {
    return {
      modelCourses: [],
      loading: true,
      darkMode: false,
      sortOrder: 'created_at_desc'
    };
  },
  async created() {
    await this.fetchModelCourses();
  },
  methods: {
    async fetchModelCourses() {
      this.loading = true;
      const startTime = Date.now();
      try {
        const response = await fetch(`/model-courses.json?sort=${this.sortOrder}&search=${this.searchQuery}`);
        if (!response.ok) {
          throw new Error('データ取得に失敗しました');
        }
        const data = await response.json();
        this.modelCourses = data;
      } catch (error) {
        console.error("一覧取得に失敗しました:", error);
      } finally {
        const elapsedTime = Date.now() - startTime;
        const remainingTime = 1000 - elapsedTime;
        if (remainingTime > 0) {
          setTimeout(() => {
            this.loading = false;
          }, remainingTime);
        } else {
          this.loading = false;
        }
      }
    },
    truncateDescription(text) {
      return text.length > 50 ? text.substring(0, 50) + "..." : text;
    },
    toggleDarkMode() {
      this.darkMode = !this.darkMode; // ダークモードの切り替え
    },
    sort(order) {
      this.sortOrder = order;
      this.fetchModelCourses();
    }
  }
};
</script>

<style scoped>
.search-form {
  display: flex;
  justify-content: center;
  margin-bottom: 20px;
}

.search-input {
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
  margin-right: 10px;
  width: 300px;
}

.search-button {
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  background-color: #007bff;
  color: white;
  font-size: 16px;
}

.search-button:hover {
  background-color: #0056b3;
}

.form-input, .form-textarea, .form-select {
  border: 1px solid #ccc;
  padding: 8px;
  border-radius: 5px;
}

.sort-links {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 10px;
}

.sort-button {
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  background-color:rgb(201, 183, 26);
  color: #fff;
  font-size: 1em;
  transition: background-color 0.3s ease;
}

.sort-button:hover {
  background-color:rgb(143, 138, 69);
}

@media (max-width: 768px) {
  .sort-button {
    padding: 8px 16px;
    font-size: 0.9em;
  }
}

@media (max-width: 480px) {
  .sort-button {
    padding: 6px 12px;
    font-size: 0.8em;
  }
}
</style>
