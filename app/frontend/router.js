import { createRouter, createWebHistory } from "vue-router";

// 各ページのコンポーネントをインポート
import ModelCourseList from "./components/ModelCourseList.vue";
import ModelCourseDetail from "./components/ModelCourseDetail.vue";
import ModelCourseForm from "./components/ModelCourseForm.vue";
import ModelCourseEdit from "./components/ModelCourseEdit.vue";

const routes = [
  { path: "/model-courses", component: ModelCourseList },
  { path: "/model-courses/:id", component: ModelCourseDetail, props: true },
  { path: "/model-courses/new", component: ModelCourseForm },
  { path: "/model-courses/:id/edit", component: ModelCourseEdit, props: true },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
