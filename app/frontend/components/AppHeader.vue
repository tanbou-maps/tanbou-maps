<template>
  <header
    class="fixed left-0 right-0 top-0 z-50 border-b border-gray-300 bg-white/80 backdrop-blur-md"
  >
    <div
      class="mx-auto flex max-w-7xl items-center justify-between px-4 py-4 sm:px-6 lg:px-8"
    >
      <h1 class="text-2xl font-bold">Tanbou Maps</h1>
      <nav class="flex space-x-4">
        <a
          v-for="item in navigationItems"
          :key="item.name"
          :href="item.href"
          :class="{
            'text-blue-500': item.current,
            'text-gray-700': !item.current,
          }"
          class="hover:text-blue-600"
        >
          {{ item.name }}
        </a>
      </nav>
      <img :src="avatarUrl" alt="User Avatar" class="h-8 w-8 rounded-full" />
    </div>
  </header>
</template>

<script setup>
import { ref, defineProps } from "vue";
import defaultAvatar from "@/images/airou_small.png";

const props = defineProps({
  navigationItems: {
    type: Array,
    default: () => [
      { name: "ホーム", href: "/", current: true },
      { name: "モデルコース", href: "/model-courses", current: false },
      { name: "スポット", href: "/spots", current: false },
      { name: "スタンプラリー", href: "/stamp-rallying", current: false },
    ],
  },
  avatarUrl: {
    type: String,
    default: defaultAvatar,
  },
});
</script>
