<template>
  <div :class="['w-full min-h-screen', darkMode ? 'bg-gray-900 text-white' : 'bg-yellow-50 text-black']"> <!-- ダークモードとライトモードの切り替え -->
    <div class="container mx-auto p-6">
      <h2 class="text-3xl font-bold mb-6 text-center">モデルコース一覧</h2>

      <!-- ホーム画面への遷移ボタン -->
      <div class="flex justify-between mb-6">
        <a href="/" class="bg-gray-500 text-white py-2 px-4 rounded-lg hover:bg-gray-600">
          ホームに戻る
        </a>

        <!-- 新規作成ボタン -->
        <a href="/model-courses/new" class="bg-blue-500 text-white py-2 px-4 rounded-lg hover:bg-blue-600">
          新規作成
        </a>
      </div>

      <!-- ダークモード切り替えボタン -->
      <div class="absolute top-4 right-4"> <!-- ボタンを画面右上に設置 -->
        <button @click="toggleDarkMode" class="bg-gray-700 text-white py-2 px-4 rounded-lg hover:bg-gray-800 text-2xl">
          {{ darkMode ? '🌚' : '🌞' }}
        </button>
      </div>

      <div v-if="loading" class="text-center">読み込み中...</div>
      <div v-else-if="modelCourses.length === 0" class="text-center text-gray-600">まだ登録されたモデルコースがありません
      あなたの手でモデルコースを登録してみませんか？</div>

      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <div v-for="course in modelCourses" :key="course.id" class="bg-white shadow-lg rounded-lg overflow-hidden">
          <a :href="`/model-courses/${course.id}`">
            <img v-if="course.theme_image_url" :src="course.theme_image_url" alt="モデルコース画像"
              class="w-full h-40 object-cover" />
            <div v-else class="w-full h-40 bg-gray-300 flex items-center justify-center">
              <span class="text-gray-600">画像なし</span>
            </div>

            <div class="p-4">
              <h3 class="text-xl font-semibold">{{ course.title }}</h3>
              <p class="text-gray-600 text-sm mt-2">{{ truncateDescription(course.description) }}</p>
            </div>
          </a>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      modelCourses: [],
      loading: true,
      darkMode: false, // ダークモードの状態を管理
    };
  },
  async created() {
    try {
      const response = await axios.get("/model_courses.json");
      this.modelCourses = response.data;
    } catch (error) {
      console.error("一覧取得に失敗しました:", error);
    } finally {
      this.loading = false;
    }
  },
  methods: {
    truncateDescription(text) {
      return text.length > 50 ? text.substring(0, 50) + "..." : text;
    },
    toggleDarkMode() {
      this.darkMode = !this.darkMode; // ダークモードの切り替え
    },
  },
};
</script>

<style scoped>
.form-input, .form-textarea, .form-select {
  border: 1px solid #ccc;
  padding: 8px;
  border-radius: 5px;
}
</style>
