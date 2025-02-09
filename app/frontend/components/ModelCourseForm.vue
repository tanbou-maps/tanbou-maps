<template>
  <div class="container mx-auto p-6">
    <h2 class="text-3xl font-bold mb-6 text-center">モデルコースの新規作成</h2>

    <form @submit.prevent="submitForm" class="bg-white p-6 shadow-md rounded-lg">
      <!-- タイトル -->
      <div class="mb-4">
        <label class="block text-gray-700">タイトル</label>
        <input v-model="form.title" type="text" required class="form-input mt-1 w-full border rounded-lg p-2" />
      </div>

      <!-- 詳細文 -->
      <div class="mb-4">
        <label class="block text-gray-700">詳細文</label>
        <textarea v-model="form.description" required class="form-textarea mt-1 w-full border rounded-lg p-2"></textarea>
      </div>

      <!-- テーマ画像 -->
      <div class="mb-4">
        <label class="block text-gray-700">テーマ画像</label>
        <input type="file" @change="handleThemeImage" class="form-input mt-1 w-full border rounded-lg p-2" />
      </div>

      <!-- ギャラリー画像 (複数可) -->
      <div class="mb-4">
        <label class="block text-gray-700">ギャラリー画像 (複数可)</label>
        <input type="file" multiple @change="handleGalleryImages" class="form-input mt-1 w-full border rounded-lg p-2" />
      </div>

      <!-- 予算 -->
      <div class="mb-4">
        <label class="block text-gray-700">予算 (円)</label>
        <input v-model="form.budget" type="number" required class="form-input mt-1 w-full border rounded-lg p-2" />
      </div>

      <!-- ジャンルタグ -->
      <div class="mb-4">
        <label class="block text-gray-700">ジャンルタグ</label>
        <div class="flex flex-wrap gap-2">
          <label v-for="tag in genreTags" :key="tag" class="inline-flex items-center">
            <input type="checkbox" v-model="form.genre_tags" :value="tag" class="form-checkbox" />
            <span class="ml-2">{{ tag }}</span>
          </label>
        </div>
      </div>

      <!-- 公開/非公開 -->
      <div class="mb-4">
        <label class="block text-gray-700">公開設定</label>
        <label class="inline-flex items-center">
          <input type="checkbox" v-model="form.public_status" class="form-checkbox" />
          <span class="ml-2">{{ form.public_status ? "公開" : "非公開" }}</span>
        </label>
      </div>

      <!-- 季節 -->
      <div class="mb-4">
        <label class="block text-gray-700">季節</label>
        <select v-model="form.season" class="form-select mt-1 w-full border rounded-lg p-2">
          <option disabled value="">選択してください</option>
          <option v-for="option in seasonOptions" :key="option" :value="option">{{ option }}</option>
        </select>
      </div>

      <!-- 送信ボタン -->
      <div class="text-center">
        <button type="submit" class="bg-blue-500 text-white py-2 px-4 rounded-lg hover:bg-blue-600">
          作成する
        </button>
      </div>
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
        budget: "",
        genre_tags: [],
        public_status: false,
        season: "",
        theme_image: null,
        gallery_images: [],
      },
      genreTags: ["観光", "グルメ", "歴史", "自然", "アクティビティ"],
      seasonOptions: ["春", "夏", "秋", "冬"],
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
      formData.append("model_course[budget]", this.form.budget);
      formData.append("model_course[public_status]", this.form.public_status);
      formData.append("model_course[season]", this.form.season);

      this.form.genre_tags.forEach(tag => {
        formData.append("model_course[genre_tags][]", tag);
      });

      if (this.form.theme_image) {
        formData.append("model_course[theme_image]", this.form.theme_image);
      }

      this.form.gallery_images.forEach((image, index) => {
        formData.append(`model_course[gallery_images][${index}]`, image);
      });

      try {
        await axios.post("/model-courses", formData, {
          headers: { "Content-Type": "multipart/form-data" },
        });
        alert("モデルコースが作成されました！");
        this.$router.push("/model-courses");
      } catch (error) {
        console.error("作成に失敗しました:", error);
        alert("作成に失敗しました。入力内容を確認してください。");
      }
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
