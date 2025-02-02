<template>
  <div class="max-w-3xl mx-auto p-6 bg-white shadow-xl rounded-lg">
    <!-- タイトル -->
    <h1 class="text-2xl font-bold text-gray-900 text-center">{{ modelCourse.title }}</h1>

    <!-- テーマ画像 -->
    <div class="flex justify-center mt-4">
      <img v-if="modelCourse.theme_image_url"
        :src="modelCourse.theme_image_url"
        alt="タイトル画像"
        class="w-full max-w-3xl rounded-xl shadow-lg hover:scale-105 transition-transform"
      />
    </div>

    <!-- 説明文 -->
    <p class="mt-4 text-gray-700 text-lg text-center">{{ modelCourse.description }}</p>

    <!-- Swiper.js ギャラリー -->
    <div v-if="modelCourse.gallery_image_urls?.length" class="mt-6">
      <swiper
        :modules="[SwiperNavigation, SwiperPagination]"
        :space-between="10"
        :slides-per-view="1"
        :navigation="true"
        :pagination="{ clickable: true }"
        class="gallery-swiper"
      >
        <swiper-slide v-for="(image, index) in modelCourse.gallery_image_urls" :key="index">
          <img :src="image" alt="ギャラリー画像" class="w-full h-60 object-cover rounded-lg shadow-md" />
        </swiper-slide>
      </swiper>
    </div>

    <!-- 削除ボタン -->
    <div class="text-center mt-6">
      <button @click="deleteCourse" class="bg-red-500 text-white px-4 py-2 rounded-lg shadow-md hover:bg-red-700 transition">
        削除
      </button>
    </div>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { Swiper, SwiperSlide } from 'swiper/vue';
import { Navigation, Pagination } from 'swiper/modules';

// SwiperのCSSをインポート
import 'swiper/css';
import 'swiper/css/navigation';
import 'swiper/css/pagination';

export default {
  components: {
    Swiper,
    SwiperSlide
  },
  setup() {
    const route = useRoute();
    const router = useRouter();
    const modelCourse = ref({});

    const fetchModelCourse = async () => {
      try {
        const response = await fetch(`/model-courses/${route.params.record_uuid}.json`);
        const data = await response.json();
        modelCourse.value = data.model_course;
      } catch (error) {
        console.error('モデルコース詳細の取得に失敗:', error);
      }
    };

    const deleteCourse = async () => {
      if (!confirm("本当に削除しますか？")) return;

      try {
        const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute("content");
        const response = await fetch(`/model-courses/${route.params.record_uuid}`, {
          method: "DELETE",
          headers: {
            "X-CSRF-Token": csrfToken,
          },
        });

        if (response.ok) {
          alert("モデルコースが削除されました！");
          router.push("/model-courses"); // 一覧ページにリダイレクト
        } else {
          const error = await response.json();
          alert("エラー: " + error.errors.join(", "));
        }
      } catch (error) {
        console.error("削除エラー:", error);
        alert("モデルコースの削除に失敗しました！");
      }
    };

    onMounted(fetchModelCourse);

    return {
      modelCourse,
      SwiperNavigation: Navigation,
      SwiperPagination: Pagination,
      deleteCourse
    };
  }
};
</script>

<style scoped>
/* Swiperのナビゲーションボタンとページネーションをカスタマイズ */
:deep(.swiper-button-prev),
:deep(.swiper-button-next) {
  color: #4a5568;
}

:deep(.swiper-pagination-bullet-active) {
  background-color: #4a5568;
}
</style>
