<template>
  <div :class="['w-full min-h-screen', darkMode ? 'bg-gray-900 text-white' : 'bg-gray-100 text-black']">
    <div class="container mx-auto p-6">
      <div class="flex justify-between mb-4">
        <button @click="goToModelCourses" class="px-4 py-2 rounded-lg text-2xl bg-gray-500 text-white hover:bg-blue-600">
          戻る
        </button>
        <button @click="toggleDarkMode" class="px-4 py-2 rounded-lg text-2xl" :class="darkMode ? 'bg-gray-800 text-white' : 'bg-gray-200 text-black'">
          {{ darkMode ? '🌚' : '🌞' }}
        </button>
      </div>

      <h2 class="text-3xl font-bold mb-6 text-center">{{ isEditMode ? 'モデルコースの編集' : 'モデルコースの新規作成' }}</h2>

      <form @submit.prevent="submitForm" :class="['p-6 shadow-md rounded-lg max-w-3xl mx-auto', darkMode ? 'bg-gray-800 text-white' : 'bg-white text-black']">
        <!-- タイトル -->
        <div class="mb-4">
          <label :class="['block', darkMode ? 'text-gray-300' : 'text-black']">タイトル <span class="text-red-500">*</span></label>
          <input v-model="form.title" type="text" required maxlength="100" class="form-input mt-1 w-full border rounded-lg p-2 text-black" />
          <p v-if="errors.title" class="text-red-500">{{ errors.title }}</p>
        </div>

        <!-- 詳細文 -->
        <div class="mb-4">
          <label :class="['block', darkMode ? 'text-gray-300' : 'text-black']">詳細文 <span class="text-red-500">*</span></label>
          <textarea v-model="form.description" required maxlength="3000" class="form-textarea mt-1 w-full border rounded-lg p-2 text-black"></textarea>
          <p v-if="errors.description" class="text-red-500">{{ errors.description }}</p>
        </div>

        <!-- テーマ画像 -->
        <div class="mb-4">
          <label :class="['block', darkMode ? 'text-gray-300' : 'text-black']">テーマ画像</label>
          <input type="file" @change="handleThemeImage" class="form-input mt-1 w-full border rounded-lg p-2" />
        </div>

        <!-- ギャラリー画像 (複数可) -->
        <div class="mb-4">
          <label :class="['block', darkMode ? 'text-gray-300' : 'text-black']">ギャラリー画像 (複数可)</label>
          <input type="file" multiple @change="handleGalleryImages" class="form-input mt-1 w-full border rounded-lg p-2" />
        </div>

        <!-- 予算 -->
        <div class="mb-4">
          <label :class="['block', darkMode ? 'text-gray-300' : 'text-black']">予算 (円) <span class="text-red-500">*</span></label>
          <input v-model="form.budget" type="number" placeholder="スライダーは1000刻みです" required min="0" max="500000" class="form-input mt-1 w-full border rounded-lg p-2 text-black" />
          <input v-model="form.budget" type="range" min="0" max="500000" step="1000" class="w-full mt-2" />
          <p v-if="errors.budget" class="text-red-500">{{ errors.budget }}</p>
        </div>

        <!-- ジャンルタグ -->
        <div class="mb-4">
          <label :class="['block', darkMode ? 'text-gray-300' : 'text-black']">ジャンルタグ</label>
          <input v-model="form.genre_tags_input" @input="updateGenreTags" type="text" placeholder="カンマ区切りで入力 (例：観光, グルメ, コスパ, 日帰り)" class="form-input mt-1 w-full border rounded-lg p-2 text-black" />
        </div>

        <!-- 公開/非公開 -->
        <div class="mb-4">
          <label :class="['block', darkMode ? 'text-gray-300' : 'text-black']">公開設定</label>
          <select v-model="form.is_public" class="form-select mt-1 w-full border rounded-lg p-2 text-black">
            <option value="true">公開</option>
            <option value="false">非公開</option>
          </select>
        </div>

        <!-- 季節 -->
        <div class="mb-4">
          <label :class="['block', darkMode ? 'text-gray-300' : 'text-black']">季節</label>
          <select v-model="form.season" class="form-select mt-1 w-full border rounded-lg p-2 text-black">
            <option disabled value="">選択してください</option>
            <option v-for="option in seasonOptions" :key="option" :value="option">{{ option }}</option>
          </select>
        </div>

        <!-- 送信ボタン -->
        <div class="text-center">
          <button type="submit" class="bg-blue-500 text-white py-2 px-4 rounded-lg hover:bg-blue-600">
            {{ isEditMode ? '更新する' : '作成する' }}
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  props: ['id'],
  data() {
    return {
      form: {
        title: "",
        description: "",
        budget: "",
        genre_tags: [],
        genre_tags_input: "",
        is_public: "true",
        season: "春",
        theme_image: null,
        gallery_images: [],
      },
      errors: {},
      seasonOptions: ["春", "夏", "秋", "冬"],
      darkMode: false, // ダークモードの状態を管理
      isEditMode: !!this.id // idがある場合は編集モード
    };
  },
  async created() {
    if (this.isEditMode) {
      try {
        const response = await fetch(`/model-courses/${this.id}.json`);
        if (!response.ok) {
          throw new Error('データ取得に失敗しました');
        }
        const data = await response.json();
        this.form = {
          title: data.model_course.title,
          description: data.model_course.description,
          budget: data.model_course.budget,
          genre_tags: data.model_course.genre_tags,
          genre_tags_input: data.model_course.genre_tags.join(', '),
          is_public: data.model_course.is_public.toString(),
          season: data.model_course.season,
          theme_image: null,
          gallery_images: []
        };
      } catch (error) {
        console.error('データ取得に失敗しました:', error);
      }
    }
  },
  methods: {
    handleThemeImage(event) {
      this.form.theme_image = event.target.files[0];
    },
    handleGalleryImages(event) {
      this.form.gallery_images = Array.from(event.target.files);
    },
    updateGenreTags() {
      this.form.genre_tags = this.form.genre_tags_input.split(",").map(tag => tag.trim());
    },
    validateForm() {
      this.errors = {};
      if (!this.form.title) {
        this.errors.title = "タイトルは必須です。";
      }
      if (!this.form.description) {
        this.errors.description = "詳細文は必須です。";
      } else if (this.form.description.length > 3000) {
        this.errors.description = "詳細文は3000文字以内で入力してください。";
      }
      if (!this.form.budget) {
        this.errors.budget = "予算は必須です。";
      } else if (this.form.budget < 0 || this.form.budget > 500000) {
        this.errors.budget = "予算は0円から500,000円の間で入力してください。";
      }
      return Object.keys(this.errors).length === 0;
    },
    async submitForm() {
      if (!this.validateForm()) {
        return;
      }

      const formData = new FormData();
      formData.append("model_course[title]", this.form.title);
      formData.append("model_course[description]", this.form.description);
      formData.append("model_course[budget]", this.form.budget);
      formData.append("model_course[is_public]", this.form.is_public);
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
        const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
        const response = await fetch(this.isEditMode ? `/model-courses/${this.id}` : "/model-courses", {
          method: this.isEditMode ? "PATCH" : "POST",
          headers: {
            "X-CSRF-Token": csrfToken,
          },
          body: formData,
        });

        if (!response.ok) {
          throw new Error(this.isEditMode ? "更新に失敗しました" : "作成に失敗しました");
        }

        const data = await response.json();
        alert(this.isEditMode ? "モデルコースが更新されました！" : "モデルコースが作成されました！");
        this.$router.push("/model-courses");
      } catch (error) {
        console.error(this.isEditMode ? "更新に失敗しました:" : "作成に失敗しました:", error);
        alert(this.isEditMode ? "更新に失敗しました。入力内容を確認してください。" : "作成に失敗しました。入力内容を確認してください。");
      }
    },
    toggleDarkMode() {
      this.darkMode = !this.darkMode; // ダークモードの切り替え
    },
    goToModelCourses() {
      window.location.href = "/model-courses";
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
