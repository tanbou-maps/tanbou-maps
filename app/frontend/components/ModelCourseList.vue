<template>
  <div class="container mx-auto p-6">
    <h2 class="text-3xl font-bold mb-6 text-center">モデルコース一覧</h2>

    <div v-if="loading" class="text-center">読み込み中...</div>
    <div v-else-if="modelCourses.length === 0" class="text-center text-gray-600">モデルコースがありません</div>

    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      <div v-for="course in modelCourses" :key="course.id" class="bg-white shadow-lg rounded-lg overflow-hidden">
        <router-link :to="`/model-courses/${course.id}`">
          <img v-if="course.theme_image_url" :src="course.theme_image_url" alt="モデルコース画像"
            class="w-full h-40 object-cover" />
          <div v-else class="w-full h-40 bg-gray-300 flex items-center justify-center">
            <span class="text-gray-600">画像なし</span>
          </div>

          <div class="p-4">
            <h3 class="text-xl font-semibold">{{ course.title }}</h3>
            <p class="text-gray-600 text-sm mt-2">{{ truncateDescription(course.description) }}</p>
          </div>
        </router-link>
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
    };
  },
  async created() {
    try {
      const response = await axios.get("/model_courses.json"); // ← ここ修正！
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
  },
};
</script>
