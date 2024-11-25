import Vue from 'vue';
import ModelCourseIndex from '../components/ModelCourseIndex.vue';

document.addEventListener('DOMContentLoaded', () => {
  const element = document.getElementById('index');
  if (element) {
    new Vue({
      render: (h) => h(ModelCourseIndex),
    }).$mount('#index');
  }
});
