<template>
  <div>
    <h1>モデルコース作成</h1>
    <form @submit.prevent="submitForm">
      <div>
        <label for="title">タイトル</label>
        <input id="title" v-model="formData.title" type="text" required />
      </div>

      <div>
        <label for="description">説明</label>
        <textarea id="description" v-model="formData.description" required></textarea>
      </div>

      <div>
        <label for="is_public">公開状態</label>
        <select id="is_public" v-model="formData.is_public">
          <option value="true">公開</option>
          <option value="false">非公開</option>
        </select>
      </div>

      <div>
        <label for="theme_image">テーマ画像</label>
        <input id="theme_image" type="file" @change="onThemeImageChange" />
      </div>

      <div>
        <label for="gallery_images">フォトギャラリー</label>
        <input id="gallery_images" type="file" multiple @change="onGalleryImagesChange" />
      </div>

      <button type="submit">作成</button>
    </form>
  </div>
</template>

<script>
import { ref } from "vue";

export default {
  setup() {
    const formData = ref({
      title: "",
      description: "",
      is_public: true,
      theme_image: null,
      gallery_images: [],
    });

    const onThemeImageChange = (event) => {
      formData.value.theme_image = event.target.files[0]; // 単一ファイル
    };

    const onGalleryImagesChange = (event) => {
      formData.value.gallery_images = Array.from(event.target.files); // 複数ファイル
    };

    const submitForm = async () => {
      const payload = new FormData();
      payload.append("model_course[title]", formData.value.title);
      payload.append("model_course[description]", formData.value.description);
      payload.append("model_course[is_public]", formData.value.is_public);

      if (formData.value.theme_image) {
        payload.append("model_course[theme_image]", formData.value.theme_image);
      }

      formData.value.gallery_images.forEach((file) => {
        payload.append("model_course[gallery_images][]", file);
      });

      try {
        const csrfToken = document
          .querySelector('meta[name="csrf-token"]')
          ?.getAttribute("content");

        const response = await fetch("/model-courses", {
          method: "POST",
          headers: {
            "X-CSRF-Token": csrfToken, // CSRF トークンを追加
          },
          body: payload,
        });

        if (response.ok) {
          const result = await response.json();
          alert(result.message);
          window.location.href = "/model-courses"; // 一覧画面にリダイレクト
        } else {
          const error = await response.json();
          alert("エラー: " + error.errors.join(", "));
        }
      } catch (error) {
        console.error(error);
        alert("モデルコースを作成できませんでした！");
      }
    };

    return {
      formData,
      onThemeImageChange,
      onGalleryImagesChange,
      submitForm,
    };
  },
};
</script>
