<template>
  <div>
    <h1>{{ course.title }}</h1>
    <p>{{ course.description }}</p>
    <img v-if="course.theme_image_url" :src="course.theme_image_url" alt="テーマ画像" />
    <div v-for="image in course.gallery_images" :key="image.id">
      <img :src="image.url" alt="ギャラリー画像" />
    </div>
  </div>
</template>

<script>
import { ref, onMounted } from "vue";

export default {
  setup() {
    const course = ref(null);

    onMounted(async () => {
      const response = await fetch(`/model-courses/${courseId}.json`);
      course.value = await response.json();
    });

    return { course };
  },
};
</script>
