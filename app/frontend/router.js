import { createRouter, createWebHistory } from "vue-router";

// 各ページのコンポーネントをインポート
import ModelCourseList from "./components/ModelCourseList.vue";
import ModelCourseDetail from "./components/ModelCourseDetail.vue";
import ModelCourseForm from "./components/ModelCourseForm.vue";

const routes = [
  { path: "/model-courses", component: ModelCourseList },
  { path: "/model-courses/:record_uuid", component: ModelCourseDetail, props: route => ({ record_uuid: route.params.record_uuid }) },
  { path: "/model-courses/new", component: ModelCourseForm },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
