<template>
  <div v-if="modelCourse">
    <h1>{{ modelCourse.title }}</h1>

    <!-- テーマ画像 -->
    <img v-if="modelCourse.theme_image_url" :src="modelCourse.theme_image_url" alt="テーマ画像" />
    <p v-else>テーマ画像が設定されていません</p>

    <p>{{ modelCourse.description }}</p>

    <!-- ギャラリー画像 -->
    <div v-if="modelCourse.gallery_image_urls.length > 0">
      <h3>ギャラリー画像</h3>
      <div v-for="(image, index) in modelCourse.gallery_image_urls" :key="index">
        <img :src="image" alt="ギャラリー画像" />
      </div>
    </div>
    <p v-else>ギャラリー画像が設定されていません</p>

    <p>予算: {{ modelCourse.budget }}円</p>
    <p>ジャンルタグ: {{ modelCourse.genre_tags }}</p>
    <p>季節: {{ modelCourse.season }}</p>

    <!-- 更新・削除ボタン -->
    <div>
      <router-link :to="`/model-courses/${modelCourse.record_uuid}/edit`">
        <button>編集</button>
      </router-link>
      <button @click="deleteModelCourse">削除</button>
    </div>

  </div>
  <div v-else>
    <p>モデルコース情報を取得中...</p>
  </div>
</template>

<script>
import { ref, onMounted } from "vue";
import { useRoute } from "vue-router";

export default {
  setup() {
    const modelCourse = ref(null);
    const route = useRoute();

    const fetchModelCourse = async () => {
      try {
        const response = await fetch(`/model-courses/${route.params.record_uuid}`);
        if (response.ok) {
          const data = await response.json();
          modelCourse.value = data.model_course;
        } else {
          console.error("データ取得に失敗しました");
        }
      } catch (error) {
        console.error("エラー:", error);
      }
    };

    const deleteModelCourse = async () => {
      if (!confirm("このモデルコースを削除しますか？")) return;

      try {
        const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute("content");
        const response = await fetch(`/model-courses/${route.params.record_uuid}`, {
          method: "DELETE",
          headers: {
            "X-CSRF-Token": csrfToken,
          },
        });

        if (response.ok) {
          alert("モデルコースが削除されました！");
          router.push("/model-courses");
        } else {
          const error = await response.json();
          alert("削除エラー: " + error.error);
        }
      } catch (error) {
        console.error("削除エラー:", error);
        alert("モデルコースの削除に失敗しました！");
      }
    };

    onMounted(fetchModelCourse);

    return { modelCourse };
  }
};
</script>
