<template>
  <div class="container mx-auto p-4">
    <h2 class="text-2xl font-bold">{{ modelCourse.title }}</h2>
    <img v-if="modelCourse.theme_image_url" :src="modelCourse.theme_image_url" class="w-full h-60 object-cover mb-4" />
    <p class="text-gray-600">{{ modelCourse.description }}</p>

    <div v-if="modelCourse.gallery_image_urls.length > 0" class="mt-4">
      <swiper :slides-per-view="1" navigation>
        <swiper-slide v-for="(img, index) in modelCourse.gallery_image_urls" :key="index">
          <img :src="img" class="w-full h-40 object-cover" />
        </swiper-slide>
      </swiper>
    </div>

    <router-link :to="`/model-courses/${modelCourse.id}/edit`" class="btn-primary mt-4">編集</router-link>
  </div>
</template>

<script>
import axios from "axios";
import { Swiper, SwiperSlide } from "swiper/vue";
import "swiper/css";
import "swiper/css/navigation";

export default {
  components: { Swiper, SwiperSlide },
  data() {
    return {
      modelCourse: {},
    };
  },
  async created() {
    try {
      const response = await axios.get(`/model_courses/${this.$route.params.id}`);
      this.modelCourse = response.data;
    } catch (error) {
      console.error("詳細取得に失敗しました:", error);
    }
  },
};
</script>
