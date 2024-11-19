<template>
  <div class="min-h-screen bg-gray-900">
    <main class="pt-16">
      <!-- ヘッダーの高さ分のパディングを追加 -->
      <!-- Hero Section -->
      <section class="bg-black py-12 sm:py-16">
        <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div class="text-center">
            <h1
              class="text-4xl font-bold tracking-tight text-white sm:text-5xl md:text-6xl"
            >
              <span class="text-yellow-300">Tanbou Maps</span>
              <span class="text-white"> - 新しい旅のために </span>
            </h1>
            <h1
              class="text-4xl font-bold tracking-tight text-white sm:text-5xl md:text-6xl"
            ></h1>
            <p
              class="mx-auto mt-3 max-w-md text-base text-gray-400 sm:text-lg md:mt-5 md:max-w-3xl md:text-xl"
            >
              最高の旅をお届けするために、まずは計画を立てましょう
            </p>
            <div
              class="mx-auto mt-5 max-w-md sm:flex sm:justify-center md:mt-8"
            >
              <div class="rounded-md shadow">
                <a
                  href="#"
                  class="flex w-full items-center justify-center rounded-md border border-transparent bg-yellow-300 px-8 py-3 text-base font-medium text-black hover:bg-yellow-400 md:px-10 md:py-4 md:text-lg"
                >
                  モデルコースを見る
                </a>
              </div>
              <div class="mt-3 rounded-md shadow sm:ml-3 sm:mt-0">
                <a
                  href="#"
                  class="flex w-full items-center justify-center rounded-md border border-yellow-300 bg-transparent px-8 py-3 text-base font-medium text-yellow-300 hover:bg-gray-900 md:px-10 md:py-4 md:text-lg"
                >
                  観光地を見る
                </a>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- Feature Section -->
      <section class="bg-black py-12">
        <div class="mx-auto max-w-7xl px-4 py-4 sm:px-6 lg:px-8">
          <div class="grid grid-cols-1 gap-8 sm:grid-cols-2 lg:grid-cols-3">
            <div
              v-for="(feature, index) in features"
              :key="index"
              class="rounded-lg border border-gray-700 bg-gray-800 p-6 shadow-lg"
            >
              <h2 class="mb-4 text-xl font-semibold text-white">
                {{ feature.title }}
              </h2>
              <p class="text-gray-300">{{ feature.description }}</p>
            </div>
          </div>
        </div>
      </section>

      <!-- Content Section -->
      <section class="bg-black py-12">
        <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div class="prose prose-invert prose-lg mx-auto">
            <h2 class="mb-6 text-3xl font-bold text-white">私たちについて</h2>
            <p class="mb-4 text-gray-300">
              ここに会社やサービスの詳細な説明を記載します。長めのコンテンツを配置することで、
              スクロール時のヘッダーの動作を確認することができます。
            </p>
            <!-- スクロールのテスト用に複数段落を追加 -->
            <p class="mb-4 text-gray-300" v-for="n in 5" :key="n">
              これはダミーテキストです。スクロール時のヘッダーの固定表示をテストするための
              コンテンツとして使用しています。実際のコンテンツに合わせて適切な文章に
              置き換えてください。
            </p>
          </div>
        </div>
      </section>
    </main>

    <!-- Footer -->
    <footer class="border-t border-gray-800 bg-black py-12 text-gray-400">
      <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <div class="text-center">
          <p>&copy; 2024 Team C Inc. All rights reserved.</p>
        </div>
      </div>
    </footer>
  </div>
</template>

<script setup>
const features = [
  {
    title: "高品質なサービス",
    description:
      "最高品質のサービスを提供することで、お客様の期待を超える価値を実現します。",
  },
  {
    title: "24時間サポート",
    description:
      "お客様のニーズに迅速に対応するため、24時間体制でサポートを提供しています。",
  },
  {
    title: "革新的なソリューション",
    description:
      "最新のテクノロジーを活用し、革新的なソリューションを提供します。",
  },
];
</script>
