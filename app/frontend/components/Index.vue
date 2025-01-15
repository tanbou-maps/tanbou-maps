<template>
  <div
    :style="{ backgroundImage: `url(${backgroundImage})` }"
    class="min-h-screen bg-cover bg-center text-gray-900"
  >
    <AppHeader
      :navigationItems="customNavigationItems"
      :avatarUrl="customAvatarUrl"
    />
    <main
      class="mx-auto mt-16 max-w-7xl rounded-lg bg-white bg-opacity-80 px-4 py-8 sm:px-6 lg:px-8"
    >
      <section class="mb-8">
        <h2 class="mb-4 text-3xl font-bold">Tanbou Mapsへようこそ</h2>
        <p class="text-gray-700">
          Tanbou
          Mapsは、あなたの旅をより楽しくするためのスポット情報を提供します。
        </p>
      </section>
      <section class="mb-8">
        <h2 class="mb-4 text-3xl font-bold">スポット一覧</h2>
        <div class="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
          <div
            v-for="spot in spots"
            :key="spot.id"
            class="overflow-hidden rounded-lg bg-white shadow-md transition duration-200 hover:shadow-lg"
          >
            <img
              v-if="spot.photos.length"
              :src="spot.photos[0]"
              class="h-48 w-full object-cover"
            />
            <div
              v-else
              class="flex h-48 w-full items-center justify-center bg-gray-200"
            >
              <span class="text-gray-400">No image</span>
            </div>
            <div class="p-4">
              <h3 class="mb-2 text-xl font-semibold">{{ spot.name }}</h3>
              <p class="mb-4 text-gray-600">{{ spot.description }}</p>
              <div class="flex items-center justify-between">
                <span class="text-sm text-gray-500"
                  >投稿者ID: {{ spot.application_user_id }}</span
                >
                <a
                  :href="`/spots/${spot.id}`"
                  class="text-blue-500 hover:text-blue-600"
                  >詳細</a
                >
              </div>
            </div>
          </div>
        </div>
      </section>
      <section class="mb-8">
        <h2 class="mb-4 text-3xl font-bold">お問い合わせ</h2>
        <p class="text-gray-700">
          ご質問やご意見がございましたら、<a
            href="/contact"
            class="text-blue-500 hover:text-blue-600"
            >お問い合わせページ</a
          >からご連絡ください。
        </p>
      </section>
    </main>
    <footer class="mt-8 border-t border-gray-300 bg-white py-4">
      <div class="mx-auto max-w-7xl px-4 text-center sm:px-6 lg:px-8">
        <p class="text-gray-500">
          &copy; 2024 Tanbou Maps. All rights reserved.
        </p>
      </div>
    </footer>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import AppHeader from "@/components/AppHeader.vue";

const customNavigationItems = [
  { name: "ホーム", href: "/", current: true },
  { name: "モデルコース", href: "/model-courses", current: false },
  { name: "スポット", href: "/spots", current: false },
  { name: "スタンプラリー", href: "/stamp-rallying", current: false },
];

const customAvatarUrl = "path/to/custom/avatar.png";

const spots = [
  {
    id: 1,
    name: "test_spot1",
    description: "test",
    photos: [],
    application_user_id: 1,
  },
  // 他のスポットデータ
];

const backgroundImage = ref("");

onMounted(() => {
  backgroundImage.value =
    "https://source.unsplash.com/random/1600x900/?season,landscape";
});
</script>
