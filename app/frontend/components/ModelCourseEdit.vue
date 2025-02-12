<template>
  <div class="model-course-edit-container">
    <h2 class="title">モデルコース編集</h2>

    <form @submit.prevent="updateModelCourse">
      <div class="form-group">
        <label for="title">タイトル</label>
        <input v-model="modelCourse.title" id="title" type="text" class="input-field" required />
      </div>

      <div class="form-group">
        <label for="description">説明</label>
        <textarea v-model="modelCourse.description" id="description" class="input-field" rows="3"></textarea>
      </div>

      <div class="form-group">
        <label for="budget">予算</label>
        <input v-model="modelCourse.budget" id="budget" type="number" class="input-field" required />
      </div>

      <!-- 既存のテーマ画像を表示 -->
      <div class="form-group">
        <label>現在のテーマ画像</label>
        <img :src="modelCourse.theme_image_url" alt="テーマ画像" class="current-image" v-if="modelCourse.theme_image_url" />
      </div>

      <!-- 新しいテーマ画像をアップロード -->
      <div class="form-group">
        <label for="theme_image">新しいテーマ画像</label>
        <input type="file" @change="handleThemeImage" class="input-field" />
      </div>

      <!-- 既存のギャラリー画像を表示 -->
      <div class="form-group">
        <label>現在のギャラリー画像</label>
        <div class="gallery">
          <img v-for="(img, index) in modelCourse.gallery_image_urls" :key="index" :src="img" alt="ギャラリー画像" class="current-image" />
        </div>
      </div>

      <!-- 新しいギャラリー画像をアップロード -->
      <div class="form-group">
        <label for="gallery_images">新しいギャラリー画像</label>
        <input type="file" multiple @change="handleGalleryImages" class="input-field" />
      </div>

      <button type="submit" class="submit-button">更新</button>
    </form>
  </div>
</template>

<script>
export default {
  props: ["id"],
  data() {
    return {
      modelCourse: {
        title: "",
        description: "",
        budget: "",
        theme_image_url: "",
        gallery_image_urls: [],
      },
      theme_image: null,
      gallery_images: [],
    };
  },
  async created() {
    try {
      const response = await fetch(`/model-courses/${this.id}.json`);
      if (!response.ok) throw new Error("データ取得に失敗しました");
      const data = await response.json();
      this.modelCourse = data.model_course;
    } catch (error) {
      console.error("データ取得エラー:", error);
    }
  },
  methods: {
    handleThemeImage(event) {
      this.theme_image = event.target.files[0];
    },
    handleGalleryImages(event) {
      this.gallery_images = Array.from(event.target.files);
    },
    async updateModelCourse() {
      try {
        const formData = new FormData();
        formData.append("model_course[title]", this.modelCourse.title);
        formData.append("model_course[description]", this.modelCourse.description);
        formData.append("model_course[budget]", this.modelCourse.budget);

        if (this.theme_image) {
          formData.append("model_course[theme_image]", this.theme_image);
        }

        this.gallery_images.forEach((image, index) => {
          formData.append(`model_course[gallery_images][${index}]`, image);
        });

        const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
        const response = await fetch(`/model-courses/${this.id}`, {
          method: "PATCH",
          headers: {
            "X-CSRF-Token": csrfToken,
          },
          body: formData,
        });

        if (!response.ok) throw new Error("更新に失敗しました");
        alert("更新が完了しました");
        window.location.href = "/model-courses";
      } catch (error) {
        console.error("更新エラー:", error);
        alert("更新に失敗しました");
      }
    },
  },
};
</script>

<style scoped>
.model-course-edit-container {
  max-width: 600px;
  margin: 20px auto;
  padding: 20px;
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.title {
  font-size: 20px;
  font-weight: bold;
  text-align: center;
  margin-bottom: 20px;
}

.form-group {
  display: flex;
  flex-direction: column;
  margin-bottom: 15px;
}

label {
  font-weight: bold;
  margin-bottom: 5px;
}

.input-field {
  padding: 8px;
  border: 1px solid #ccc;
  border-radius: 4px;
}

.current-image {
  max-width: 100%;
  margin-bottom: 10px;
}

.gallery {
  display: flex;
  flex-wrap: wrap;
}

.gallery img {
  max-width: 100px;
  margin-right: 10px;
  margin-bottom: 10px;
}

.submit-button {
  width: 100%;
  padding: 10px;
  background-color: #007bff;
  color: white;
  font-size: 16px;
  font-weight: bold;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.submit-button:hover {
  background-color: #0056b3;
}
</style>
