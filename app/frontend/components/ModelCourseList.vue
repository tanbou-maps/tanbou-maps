<template>
  <div class="container">
    <h1>モデルコース一覧</h1>
    <ul class="course-list">
      <li v-for="course in modelCourses" :key="course.id" class="course-item">
        <router-link :to="`/model-courses/${course.record_uuid}`" class="course-link">
          <div class="course-card">
            <img v-if="course.theme_image_url" :src="course.theme_image_url" alt="モデルコース画像" class="theme-image" />
            <div class="course-info">
              <h2>{{ course.title }}</h2>
              <p>{{ course.description }}</p>
            </div>
          </div>
        </router-link>
      </li>
    </ul>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue';

export default {
  setup() {
    const modelCourses = ref([]);

    const fetchModelCourses = async () => {
      try {
        const response = await fetch('/model-courses.json');
        const data = await response.json();
        modelCourses.value = data.model_courses;
      } catch (error) {
        console.error('モデルコースの取得に失敗:', error);
      }
    };

    onMounted(fetchModelCourses);

    return {
      modelCourses
    };
  }
};
</script>

<style scoped>
.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
}

.course-list {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
  justify-content: center;
  padding: 0;
}

.course-item {
  list-style: none;
}

.course-link {
  text-decoration: none;
  color: inherit;
}

.course-card {
  width: 300px;
  background: #fff;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  overflow: hidden;
  transition: transform 0.2s;
}

.course-card:hover {
  transform: scale(1.05);
}

.theme-image {
  width: 100%;
  height: 180px;
  object-fit: cover;
}

.course-info {
  padding: 15px;
}

h1 {
  text-align: center;
  margin-bottom: 20px;
}
</style>
