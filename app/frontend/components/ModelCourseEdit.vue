<template>
  <div>
    <h1>モデルコース編集</h1>
    <form @submit.prevent="updateCourse">
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

      <button type="submit">更新</button>
    </form>
  </div>
</template>

<script>
import { ref, onMounted } from "vue";
import { useRoute } from "vue-router";

export default {
  setup() {
    const route = useRoute();
    const formData = ref({
      title: "",
      description: "",
      is_public: true,
      budget: 5000,
      season: "春",
    });

    const fetchModelCourse = async () => {
      try {
        const response = await fetch(`/model-courses/${route.params.record_uuid}.json`);
        const data = await response.json();
        formData.value = data.model_course;
      } catch (error) {
        console.error("モデルコースの取得に失敗:", error);
      }
    };

    const updateCourse = async () => {
      try {
        const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute("content");
        const response = await fetch(`/model-courses/${route.params.record_uuid}`, {
          method: "PATCH",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": csrfToken,
          },
          body: JSON.stringify({ model_course: formData.value }),
        });

        if (response.ok) {
          alert("モデルコースが更新されました！");
          window.location.href = `/model-courses/${route.params.record_uuid}`;
        } else {
          const error = await response.json();
          alert("エラー: " + error.errors.join(", "));
        }
      } catch (error) {
        console.error("更新エラー:", error);
        alert("モデルコースの更新に失敗しました！");
      }
    };

    onMounted(fetchModelCourse);

    return {
      formData,
      updateCourse,
    };
  },
};
</script>
