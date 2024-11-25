<template>
  <div>
    <h1>モデルコース一覧</h1>
    <ul>
      <li v-for="course in modelCourses" :key="course.id">
        <strong>{{ course.title }}</strong> - 作成者: {{ course.application_user.nickname }}
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  data() {
    return {
      modelCourses: [],
    };
  },
  mounted() {
    // RailsのAPIからデータを取得
    fetch('/model_courses.json')
      .then((response) => response.json())
      .then((data) => {
        this.modelCourses = data;
      });
  },
};
</script>
