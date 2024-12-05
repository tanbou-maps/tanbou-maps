<template>
  <header
    class="fixed left-0 right-0 top-0 z-50 border-b border-gray-800 bg-black/80 backdrop-blur-md"
  >
    <nav class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
      <div class="flex h-16 items-center justify-between">
        <!-- Logo -->
        <div class="flex-shrink-0">
          <a href="/" class="text-xl font-bold text-white"> Tanbou Maps </a>
        </div>

        <!-- Desktop Navigation -->
        <div class="hidden sm:flex sm:space-x-8">
          <a
            v-for="item in navigationItems"
            :key="item.name"
            :href="item.href"
            class="rounded-md px-3 py-2 text-sm font-medium text-gray-300 transition-colors hover:text-white"
            :class="{ 'bg-gray-900 text-white': item.current }"
          >
            {{ item.name }}
          </a>
          <button
            type="button"
            class="flex items-center focus:outline-none"
            aria-label="toggle profile dropdown"
          >
            <div
              class="h-8 w-8 overflow-hidden rounded-full border-2 border-gray-400"
            >
              <!-- TODO: ユーザーが設定したアイコンを表示 -->
              <img
                :src="avatarUrl"
                class="h-full w-full object-cover"
                alt="avatar"
              />
            </div>
          </button>
        </div>

        <!-- Mobile menu button -->
        <div class="sm:hidden">
          <button
            @click="isOpen = !isOpen"
            class="inline-flex items-center justify-center rounded-md p-2 text-gray-400 hover:bg-gray-800 hover:text-white focus:outline-none focus:ring-2 focus:ring-inset focus:ring-yellow-500"
          >
            <span class="sr-only">メインメニューを開く</span>
            <!-- Heroicon name: menu -->
            <svg
              :class="{ hidden: isOpen, block: !isOpen }"
              class="h-6 w-6"
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M4 6h16M4 12h16M4 18h16"
              />
            </svg>
            <!-- Heroicon name: x -->
            <svg
              :class="{ block: isOpen, hidden: !isOpen }"
              class="h-6 w-6"
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M6 18L18 6M6 6l12 12"
              />
            </svg>
          </button>
        </div>
      </div>
    </nav>

    <!-- Mobile Navigation -->
    <div v-show="isOpen" class="bg-black sm:hidden">
      <div class="space-y-1 px-2 pb-3 pt-2">
        <a
          v-for="item in navigationItems"
          :key="item.name"
          :href="item.href"
          class="block rounded-md px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-800 hover:text-white"
          :class="{ 'bg-gray-900 text-white': item.current }"
        >
          {{ item.name }}
        </a>
      </div>
    </div>
  </header>
</template>

<script setup>
import { ref } from "vue";
import defaultAvatar from "@/images/airou_small.png";

const isOpen = ref(false);
const avatarUrl = ref(defaultAvatar);

const navigationItems = [
  { name: "ホーム", href: "/", current: true },
  { name: "モデルコース", href: "/model-courses", current: false },
  { name: "スポット", href: "/spots", current: false },
  { name: "スタンプラリー", href: "/stamp-rallying", current: false },
];
</script>
