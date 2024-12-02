<template>
  <div>
    <h1>モデルコース一覧</h1>
    <div v-if="courses.length" class="model-course-list">
      <div v-for="course in courses" :key="course.id" class="model-course-card">
        <!-- モデルコース情報 -->
        <h2>{{ course.title }}</h2>
        <p>{{ truncate(course.description, 100) }}</p>
        <p><strong>公開状態:</strong> {{ course.is_public ? "公開" : "非公開" }}</p>
        <img
          v-if="course.theme_image_url"
          :src="course.theme_image_url"
          :alt="`${course.title}のテーマ画像`"
        />
        <!-- 削除ボタン -->
        <button @click="deleteCourse(course.id)" class="btn btn-danger">
          削除
        </button>
      </div>
    </div>
    <p v-else>表示するモデルコースがありません。何か登録してみましょう！</p>
  </div>
</template>

<script>
export default {
  data() {
    return {
      courses: [], // モデルコース一覧データ
    };
  },
  methods: {
    // テキストを指定文字数で切り詰める
    truncate(text, length) {
      if (!text) return "";
      return text.length > length ? text.substring(0, length) + "..." : text;
    },
    // モデルコースの削除
    async deleteCourse(courseId) {
      const confirmDelete = confirm("本当に削除しますか？");
      if (!confirmDelete) return;

      try {
        const csrfToken = document
          .querySelector('meta[name="csrf-token"]')
          ?.getAttribute("content");
        const response = await fetch(`/model-courses/${courseId}`, {
          method: "DELETE",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": csrfToken,
          },
        });

        if (response.ok) {
          const result = await response.json();
          alert(result.message);
          // ローカルデータから削除
          this.courses = this.courses.filter((course) => course.id !== courseId);
        } else {
          throw new Error("削除に失敗しました。");
        }
      } catch (error) {
        console.error("削除中にエラーが発生しました:", error);
        alert("削除に失敗しました。");
      }
    },
  },
  async mounted() {
    // モデルコース一覧を取得
    try {
      const response = await fetch("/model-courses.json");
      if (!response.ok) {
        throw new Error("データの取得に失敗しました。");
      }
      this.courses = await response.json();
    } catch (error) {
      console.error("データ取得中にエラーが発生しました:", error);
      alert("データの取得に失敗しました。");
    }
  },
};
</script>

<style>
.model-course-list {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
}

.model-course-card {
  border: 1px solid #ddd;
  border-radius: 5px;
  padding: 15px;
  width: 300px;
  background-color: #f9f9f9;
}

.model-course-card h2 {
  font-size: 20px;
  margin-bottom: 10px;
}

.model-course-card p {
  margin: 5px 0;
}

.model-course-card img {
  max-width: 100%;
  height: auto;
  display: block;
  margin: 10px 0;
}

.btn-danger {
  background-color: #dc3545;
  color: #fff;
  border: none;
  padding: 10px 15px;
  border-radius: 5px;
  cursor: pointer;
}

.btn-danger:hover {
  background-color: #c82333;
}
</style>
