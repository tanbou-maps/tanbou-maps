<template>
  <div>
    <h1>{{ modelCourse.title }}</h1>
    <img v-if="modelCourse.theme_image_url" :src="modelCourse.theme_image_url" alt="テーマ画像" />
    <p>{{ modelCourse.description }}</p>
    <div v-if="modelCourse.gallery_image_urls.length > 0">
      <h2>ギャラリー画像</h2>
      <div v-for="(img, index) in modelCourse.gallery_image_urls" :key="index">
        <img :src="img" alt="ギャラリー画像" />
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ['id'],
  data() {
    return {
      modelCourse: {
        gallery_image_urls: []
      }
    };
  },
  async created() {
    try {
      const response = await fetch(`/model_courses/${this.id}.json`);
      if (!response.ok) {
        throw new Error('詳細取得に失敗しました');
      }
      const data = await response.json();
      this.modelCourse = data.model_course;
    } catch (error) {
      console.error('詳細取得に失敗しました:', error);
    }
  }
};
</script>
