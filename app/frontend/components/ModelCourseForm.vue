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
        <label for="season">季節</label>
        <select id="season" v-model="formData.season">
          <option value="春">春</option>
          <option value="夏">夏</option>
          <option value="秋">秋</option>
          <option value="冬">冬</option>
        </select>
      </div>

      <div>
        <label for="budget">予算</label>
        <input id="budget" type="range" min="0" max="100000" step="500" v-model="formData.budget" />
        <p>選択中の予算: {{ formData.budget }}円</p>
      </div>

      <div>
        <label for="genre_tags">ジャンルタグ</label>
        <input id="genre_tags" type="text" v-model="formData.genre_tags" placeholder="例: 自然, 観光, グルメ" />
      </div>

     <div>
        <label for="theme_image">テーマ画像</label>
        <input id="theme_image" type="file" @change="onThemeImageChange" />
        <p v-if="formData.theme_image">選択されたファイル: {{ formData.theme_image.name }}</p>
      </div>

      <div>
        <label for="gallery_images">フォトギャラリー</label>
        <input id="gallery_images" type="file" multiple @change="onGalleryImagesChange" />
        <p v-if="formData.gallery_images.length > 0">
          選択されたファイル: {{ formData.gallery_images.map(img => img.name).join(', ') }}
        </p>
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
      budget: 5000,
      season: "春",
      genre_tags: "",
      theme_image: null,
      gallery_images: [],
    });

    // テーマ画像変更時の処理
    const onThemeImageChange = (event) => {
      const file = event.target.files[0];
      formData.value.theme_image = file ? file : null;
    };

    // ギャラリー画像変更時の処理
    const onGalleryImagesChange = (event) => {
      const files = Array.from(event.target.files);
      formData.value.gallery_images = files.length > 0 ? files : [];
    };

    const submitForm = async () => {
  const payload = new FormData();
  payload.append("model_course[title]", formData.value.title);
  payload.append("model_course[description]", formData.value.description);
  payload.append("model_course[is_public]", formData.value.is_public);
  payload.append("model_course[budget]", formData.value.budget);
  payload.append("model_course[season]", formData.value.season);
  payload.append("model_course[genre_tags]", formData.value.genre_tags);

  if (formData.value.theme_image) {
    console.log("🖼 送信するテーマ画像:", formData.value.theme_image);
    payload.append("model_course[theme_image]", formData.value.theme_image);
  } else {
    console.warn("🚨 テーマ画像なし");
  }

  if (formData.value.gallery_images.length > 0) {
    formData.value.gallery_images.forEach((file, index) => {
      console.log(`📸 ギャラリー画像 #${index + 1}: `, file);
      payload.append("model_course[gallery_images][]", file);
    });
  } else {
    console.warn("🚨 ギャラリー画像なし");
  }

  try {
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute("content");

    const response = await fetch("/model-courses", {
      method: "POST",
      headers: { "X-CSRF-Token": csrfToken },
      body: payload,
    });

    if (response.ok) {
      const result = await response.json();
      alert(result.message);
      window.location.href = "/model-courses";
    } else {
      const error = await response.json();
      alert("エラー: " + error.errors.join(", "));
    }
  } catch (error) {
    console.error("🚨 送信エラー:", error);
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
