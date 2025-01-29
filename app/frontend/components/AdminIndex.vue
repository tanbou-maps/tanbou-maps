<script setup lang="ts">
import { ref } from "vue";

const links = ref([
  { name: "Manage Contents", url: "/admin/contents" },
  { name: "Manage Users", url: "/admin/users" },
]);
</script>

<template>
  <div class="min-h-screen bg-gray-100 p-8">
    <h1 class="mb-8 text-4xl font-bold text-gray-800">Admin Dashboard</h1>

    <div class="flex flex-grow items-center justify-center">
      <div class="grid gap-10 sm:grid-cols-2">
        <a
          v-for="(link, index) in links"
          :key="index"
          :href="link.url"
          class="flex h-48 w-80 items-center justify-center rounded-xl bg-white p-10 shadow-lg transition duration-300 hover:bg-yellow-300 hover:text-white hover:shadow-xl"
        >
          <h2 class="text-2xl font-semibold">{{ link.name }}</h2>
        </a>
      </div>
    </div>
  </div>
</template>
