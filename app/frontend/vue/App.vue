<template>
  <p>{{ state.message }}</p>
  <div>Hello world!</div>
  <div>Font Test: Hello Everyone, It's rainy day.</div>
  <div>これは日本語フォント適用確認用</div>
  <div class="text-3xl text-red-500">Font Test: This is Huge font!</div>
  <div class="text-3xl text-blue-500">これはでっけえフォントです</div>
</template>

<script>
import { defineComponent } from "vue";

export default defineComponent({
  name: "App",
  setup() {
    return {
      state: {
        message: "Hello, Rails + Vue.js + Tailwind CSS!",
      },
    };
  },
});
</script>

<style scoped></style>
