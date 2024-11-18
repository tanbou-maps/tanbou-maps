<template>
  <div class="min-h-screen bg-gray-900">
    <main class="pt-16"> <!-- ヘッダーの高さ分のパディングを追加 -->
      <!-- Hero Section -->
      <section class="bg-black py-12 sm:py-16">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div class="text-center">
            <h1 class="text-4xl font-bold tracking-tight text-white sm:text-5xl md:text-6xl">
              <span class="text-yellow-300">Tanbou Maps</span>
              <span class="text-white"> - 新しい旅のために </span>
            </h1>
            <p class="mt-3 max-w-md mx-auto text-base text-gray-400 sm:text-lg md:mt-5 md:text-xl md:max-w-3xl">
              最高の旅をお届けするために、まずは計画を立てましょう
            </p>
            <div class="mt-5 max-w-md mx-auto sm:flex sm:justify-center md:mt-8">
              <div class="rounded-md shadow">
                <a href="#" class="w-full flex items-center justify-center px-8 py-3 border border-transparent text-base font-medium rounded-md text-black bg-yellow-300 hover:bg-yellow-400 md:py-4 md:text-lg md:px-10">
                  モデルコースを見る
                </a>
              </div>
              <div class="mt-3 rounded-md shadow sm:mt-0 sm:ml-3">
                <a href="#" class="w-full flex items-center justify-center px-8 py-3 border border-yellow-300 text-base font-medium rounded-md text-yellow-300 bg-transparent hover:bg-gray-400 md:py-4 md:text-lg md:px-10">
                  観光地を見る
                </a>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- Feature Section -->
      <section class="py-12 bg-gray-900">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div class="grid grid-cols-1 gap-8 sm:grid-cols-2 lg:grid-cols-3">
            <div v-for="(feature, index) in features" :key="index" class="bg-gray-800 rounded-lg shadow-lg border border-gray-700 p-6">
              <h2 class="text-xl font-semibold text-white mb-4">{{ feature.title }}</h2>
              <p class="text-gray-300">{{ feature.description }}</p>
            </div>
          </div>
        </div>
      </section>

      <!-- Content Section -->
      <section class="py-12 bg-black">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div class="prose prose-invert prose-lg mx-auto">
            <h2 class="text-3xl font-bold text-white mb-6">
              私たちについて
            </h2>
            <p class="text-gray-300 mb-4">
              ここに会社やサービスの詳細な説明を記載します。長めのコンテンツを配置することで、
              スクロール時のヘッダーの動作を確認することができます。
            </p>
            <!-- スクロールのテスト用に複数段落を追加 -->
            <p class="text-gray-300 mb-4" v-for="n in 5" :key="n">
              これはダミーテキストです。スクロール時のヘッダーの固定表示をテストするための
              コンテンツとして使用しています。実際のコンテンツに合わせて適切な文章に
              置き換えてください。
            </p>
          </div>
        </div>
      </section>
    </main>

    <!-- Footer -->
    <footer class="bg-black text-gray-400 py-12 border-t border-gray-800">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center">
          <p>&copy; 2024 Your Company. All rights reserved.</p>
        </div>
      </div>
    </footer>
  </div>
</template>

<script setup>

const features = [
  {
    title: '高品質なサービス',
    description: '最高品質のサービスを提供することで、お客様の期待を超える価値を実現します。'
  },
  {
    title: '24時間サポート',
    description: 'お客様のニーズに迅速に対応するため、24時間体制でサポートを提供しています。'
  },
  {
    title: '革新的なソリューション',
    description: '最新のテクノロジーを活用し、革新的なソリューションを提供します。'
  }
]
</script>
