<template>
  <p>{{ state.message }}</p>
  <div class="text-3xl font-bold underline">Hello world!</div>
</template>

<script>
import { defineComponent } from "vue";

export default defineComponent({
  name: "App",
  setup() {
    return {
      state: {
        message: "Hello Vue3 + TypeScript!",
      },
    };
  },
});
</script>

<style scoped></style>
