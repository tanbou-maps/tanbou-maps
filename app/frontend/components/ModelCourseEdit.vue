<template>
  <div class="container mx-auto p-4">
    <h2 class="text-2xl font-bold">モデルコース編集</h2>
    <form @submit.prevent="submitForm">
      <div class="mb-4">
        <label class="block font-medium">タイトル</label>
        <input v-model="form.title" type="text" class="input" required />
      </div>

      <div class="mb-4">
        <label class="block font-medium">説明</label>
        <textarea v-model="form.description" class="input" required></textarea>
      </div>

      <div class="mb-4">
        <label class="block font-medium">テーマ画像</label>
        <input type="file" @change="handleThemeImage" />
      </div>

      <div class="mb-4">
        <label class="block font-medium">ギャラリー画像</label>
        <input type="file" multiple @change="handleGalleryImages" />
      </div>

      <button type="submit" class="btn-primary">更新</button>
    </form>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      form: {
        title: "",
        description: "",
        theme_image: null,
        gallery_images: [],
      },
    };
  },
  async created() {
    try {
      const response = await axios.get(`/model_courses/${this.$route.params.id}`);
      this.form = { ...response.data };
    } catch (error) {
      console.error("取得に失敗しました:", error);
    }
  },
  methods: {
    handleThemeImage(event) {
      this.form.theme_image = event.target.files[0];
    },
    handleGalleryImages(event) {
      this.form.gallery_images = Array.from(event.target.files);
    },
    async submitForm() {
      try {
        await axios.put(`/model_courses/${this.$route.params.id}`, this.form);
        this.$router.push("/model-courses");
      } catch (error) {
        console.error("更新に失敗しました:", error);
      }
    },
  },
};
</script>
