<script setup lang="ts">
import { ref } from "vue";

const links = ref([
  { name: "Manage Spots", url: "/admin/contents/spots" },
  // { name: "Manage Events", url: "/admin/events/" },
]);
</script>

<template>
  <div class="relative flex min-h-screen flex-col items-center bg-gray-100 p-8">
    <h1
      class="absolute left-1/2 top-16 -translate-x-1/2 transform text-4xl font-bold text-gray-800"
    >
      <a href="/admin" class="transition hover:text-yellow-300"
        >Contents Management</a
      >
    </h1>
    <!-- signoutボタン -->
    <div class="absolute right-4 top-4">
      <a
        href="/sign-out"
        class="group relative inline-flex items-center justify-center overflow-hidden rounded-lg bg-gray-300 px-6 py-3 text-lg font-semibold shadow-lg transition duration-300 hover:bg-gray-400"
      >
        <span
          class="absolute inset-0 h-full w-full bg-gradient-to-br from-gray-300 via-gray-200 to-gray-100"
        ></span>
        <span
          class="ease absolute bottom-0 right-0 mb-32 mr-4 block h-64 w-64 origin-bottom-left translate-x-24 rotate-45 transform rounded-full bg-gray-300 opacity-30 transition duration-500 group-hover:rotate-90"
        ></span>
        <span class="relative text-black">Sign out</span>
      </a>
    </div>

    <div class="flex w-full flex-grow items-center justify-center">
      <div class="grid gap-10">
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
    <!-- logo,title -->
    <div class="absolute bottom-4 left-1/2 flex -translate-x-1/2 items-center">
      <img class="h-auto w-14" src="@/images/airou_small.png" alt="Logo" />
      <a
        href="/"
        class="ml-2 text-xl font-semibold text-black transition hover:text-yellow-300"
      >
        Tanbou Maps
      </a>
    </div>
  </div>
</template>
