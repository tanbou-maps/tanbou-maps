<template>
  <p>{{ state.message }}</p>
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

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
