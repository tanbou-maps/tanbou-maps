import { createRouter, createWebHistory } from "vue-router";

// 各ページのコンポーネントをインポート
import ModelCourseList from "./components/ModelCourseList.vue";
import ModelCourseDetail from "./components/ModelCourseDetail.vue";
import ModelCourseForm from "./components/ModelCourseForm.vue";
import ModelCourseEdit from "./components/ModelCourseEdit.vue";

const routes = [
  { path: "/model-courses", component: ModelCourseList },
  { path: "/model-courses/:record_uuid", component: ModelCourseDetail, props: route => ({ record_uuid: route.params.record_uuid }) },
  { path: "/model-courses/new", component: ModelCourseForm },
  { path: "/model-courses/:record_uuid/edit", component: ModelCourseEdit, props: route => ({ record_uuid: route.params.record_uuid }) }, 
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
