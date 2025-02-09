<template>
  <div class="container mx-auto p-4">
    <h2 class="text-2xl font-bold mb-4">モデルコースの新規作成</h2>
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

      <button type="submit" class="btn-primary">作成</button>
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
  methods: {
    handleThemeImage(event) {
      this.form.theme_image = event.target.files[0];
    },
    handleGalleryImages(event) {
      this.form.gallery_images = Array.from(event.target.files);
    },
    async submitForm() {
      const formData = new FormData();
      formData.append("model_course[title]", this.form.title);
      formData.append("model_course[description]", this.form.description);

      if (this.form.theme_image) {
        formData.append("model_course[theme_image]", this.form.theme_image);
      }

      this.form.gallery_images.forEach((file) => {
        formData.append("model_course[gallery_images][]", file);
      });

      try {
        await axios.post("/model_courses", formData);
        this.$router.push("/model-courses");
      } catch (error) {
        console.error("作成に失敗しました:", error);
      }
    },
  },
};
</script>

<style scoped>
.input {
  width: 100%;
  padding: 8px;
  border: 1px solid #ccc;
  border-radius: 4px;
}
.btn-primary {
  background-color: #3490dc;
  color: white;
  padding: 10px 15px;
  border-radius: 4px;
}
</style>
