<template>
  <header class="fixed top-0 left-0 right-0 z-50 bg-black/80 backdrop-blur-md border-b border-gray-800">
    <nav class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <div class="flex justify-between items-center h-16">
        <!-- Logo -->
        <div class="flex-shrink-0">
          <a href="/" class="text-xl font-bold text-white">
            Logo
          </a>
        </div>

        <!-- Desktop Navigation -->
        <div class="hidden sm:flex sm:space-x-8">
          <a
            v-for="item in navigationItems"
            :key="item.name"
            :href="item.href"
            class="text-gray-300 hover:text-white px-3 py-2 rounded-md text-sm font-medium transition-colors"
            :class="{ 'text-white bg-gray-900': item.current }"
          >
            {{ item.name }}
          </a>
        </div>

        <!-- Mobile menu button -->
        <div class="sm:hidden">
          <button
            @click="isOpen = !isOpen"
            class="inline-flex items-center justify-center p-2 rounded-md text-gray-400 hover:text-white hover:bg-gray-800 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-purple-500"
          >
            <span class="sr-only">メインメニューを開く</span>
            <!-- Heroicon name: menu -->
            <svg
              :class="{ 'hidden': isOpen, 'block': !isOpen }"
              class="h-6 w-6"
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
            >
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
            </svg>
            <!-- Heroicon name: x -->
            <svg
              :class="{ 'block': isOpen, 'hidden': !isOpen }"
              class="h-6 w-6"
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
            >
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>
      </div>
    </nav>

    <!-- Mobile Navigation -->
    <div
      v-show="isOpen"
      class="sm:hidden bg-black"
    >
      <div class="px-2 pt-2 pb-3 space-y-1">
        <a
          v-for="item in navigationItems"
          :key="item.name"
          :href="item.href"
          class="block px-3 py-2 rounded-md text-base font-medium text-gray-300 hover:text-white hover:bg-gray-800"
          :class="{ 'text-white bg-gray-900': item.current }"
        >
          {{ item.name }}
        </a>
      </div>
    </div>
  </header>
</template>

<script setup>
import { ref } from 'vue'

const isOpen = ref(false)

const navigationItems = [
  { name: 'ホーム', href: '/', current: true },
  { name: '特徴', href: '/features', current: false },
  { name: '料金', href: '/pricing', current: false },
  { name: 'お問い合わせ', href: '/contact', current: false },
]
</script>
