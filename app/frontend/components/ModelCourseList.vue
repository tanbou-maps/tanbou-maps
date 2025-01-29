<template>
  <div class="container mx-auto p-6">
    <h2 class="text-2xl font-bold mb-4">モデルコース一覧</h2>

    <!-- ローディング表示 -->
    <div v-if="loading" class="loading-container">
      <div class="spinner"></div>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      <router-link
        v-for="course in modelCourses"
        :key="course.id"
        :to="{ path: `/model-courses/${course.id}` }"
        class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition duration-200 p-4"
      >
        <div>
          <h3 class="text-xl font-semibold mb-2">{{ course.title }}</h3>
          <p class="text-gray-600">{{ course.description }}</p>
        </div>
      </router-link>
    </div>

    <!-- ページネーション部分 -->
    <div class="pagination flex justify-center items-center mt-6">
      <button @click="changePage(currentPage - 1)" :disabled="currentPage <= 1" class="bg-blue-500 text-white px-4 py-2 rounded-md mx-2">
        前へ
      </button>
      <span class="text-lg font-medium">Page {{ currentPage }} / {{ totalPages }}</span>
      <button @click="changePage(currentPage + 1)" :disabled="currentPage >= totalPages" class="bg-blue-500 text-white px-4 py-2 rounded-md mx-2">
        次へ
      </button>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      modelCourses: [],
      currentPage: 1,
      totalPages: 1,
      loading: true, // ローディング状態
    };
  },
  methods: {
    async fetchCourses(page = 1) {
      this.loading = true; // データ取得開始
      try {
        const response = await axios.get(`/model-courses.json?page=${page}`);
        this.modelCourses = response.data.model_courses;
        this.currentPage = response.data.current_page;
        this.totalPages = response.data.total_pages;
      } catch (error) {
        console.error("データの取得に失敗しました", error);
      } finally {
        this.loading = false; // データ取得完了
      }
    },
    changePage(page) {
      if (page > 0 && page <= this.totalPages) {
        this.fetchCourses(page);
      }
    }
  },
  mounted() {
    this.fetchCourses();
  }
};
</script>

<style scoped>
/* ローディングアニメーション */
.loading-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 200px;
}

.spinner {
  width: 50px;
  height: 50px;
  border: 5px solid rgba(0, 0, 0, 0.3);
  border-top-color: #3498db;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}
</style>
