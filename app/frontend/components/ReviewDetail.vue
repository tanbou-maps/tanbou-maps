<template>
  <div>
    <!-- メインコンテンツ -->
    <div
      class="min-h-screen bg-gradient-to-t from-fuchsia-50 from-0% via-gray-100 via-50% to-orange-100 to-100%"
    >
      <div
        class="container mx-auto max-w-md px-4 py-8 sm:max-w-2xl lg:max-w-4xl"
      >
        <div class="rounded-lg bg-white p-6 shadow-lg">
          <!-- スポット名とレビュー投稿日時 -->
          <div class="mb-6 border-b border-gray-200 pb-6">
            <div
              class="flex flex-col items-start justify-between gap-4 sm:flex-row sm:items-center"
            >
              <h1 class="text-2xl font-bold text-gray-900">
                {{ spot.name }}のレビュー
              </h1>
              <p class="text-sm text-gray-500">
                投稿日: {{ formatDate(review.createdAt) }}
              </p>
            </div>
          </div>

          <!-- 評価（星） -->
          <div class="mb-8">
            <h2 class="mb-3 text-lg font-semibold text-gray-800">評価</h2>
            <div class="flex">
              <template v-for="n in 5" :key="n">
                <svg
                  class="h-8 w-8"
                  :class="
                    n <= review.rating ? 'text-yellow-400' : 'text-gray-300'
                  "
                  xmlns="http://www.w3.org/2000/svg"
                  viewBox="0 0 20 20"
                  fill="currentColor"
                >
                  <path
                    d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                  />
                </svg>
              </template>
            </div>
          </div>

          <!-- レビューコメント -->
          <div class="mb-8">
            <h2 class="mb-3 text-lg font-semibold text-gray-800">コメント</h2>
            <div class="rounded-lg bg-gray-50 p-4">
              <p class="whitespace-pre-wrap text-gray-700">
                {{ review.comment }}
              </p>
            </div>
          </div>

          <!-- 画像表示 -->
          <div v-if="review.images && review.images.length > 0" class="mb-8">
            <h2 class="mb-3 text-lg font-semibold text-gray-800">写真</h2>
            <div class="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
              <div
                v-for="(image, index) in review.images"
                :key="index"
                class="group relative aspect-video"
              >
                <img
                  :src="image"
                  :alt="`レビュー画像 ${index + 1}`"
                  class="h-full w-full rounded-lg object-cover transition duration-300 group-hover:opacity-95"
                />
              </div>
            </div>
          </div>

          <div
            class="mt-8 flex flex-col items-center justify-between gap-4 border-t border-gray-200 pt-6 sm:flex-row"
          >
            <!-- 戻るボタン -->
            <a
              :href="`/spots/${spotId}/reviews`"
              class="text-gray-600 underline hover:text-yellow-400"
            >
              スポット詳細に戻る
            </a>
            <!-- 削除ボタン -->
            <div v-if="isOwner">
              <button
                @click="openModal"
                class="w-full rounded-md bg-red-500 px-6 py-2 text-white transition duration-300 hover:bg-red-600 focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-opacity-50 sm:w-auto"
              >
                レビューを削除する
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 削除確認モーダル -->
    <transition name="modal-fade">
      <div
        v-if="isModalOpen"
        class="fixed inset-0 z-50 flex items-center justify-center"
        @click.self="closeModal"
      >
        <!-- オーバーレイ -->
        <div class="fixed inset-0 bg-black bg-opacity-50"></div>

        <!-- モーダルコンテンツ -->
        <div
          class="relative z-50 w-full max-w-md rounded-lg bg-white p-6 shadow-xl"
        >
          <h3 class="mb-4 text-lg font-medium text-gray-900">レビューの削除</h3>
          <p class="mb-6 text-sm text-gray-500">
            このレビューを削除してもよろしいですか？<br />
            ※削除すると復元できません。
          </p>

          <div class="flex justify-end space-x-4">
            <button
              @click="closeModal"
              class="rounded-md border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 focus:border-yellow-300 focus:outline-none focus:ring-2 focus:ring-yellow-300"
            >
              キャンセル
            </button>
            <button
              @click="deleteReview"
              class="rounded-md bg-red-500 px-4 py-2 font-medium text-white transition duration-300 hover:bg-red-600 focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-opacity-50 disabled:opacity-50"
            >
              削除する
            </button>
          </div>
        </div>
      </div>
    </transition>
  </div>
</template>

<script>
export default {
  name: "ReviewDetail",
  props: {
    spotId: {
      type: [Number, String],
      required: true,
    },
    reviewId: {
      type: [Number, String],
      required: true,
    },
    currentUserId: {
      type: [Number, String],
      required: true,
    },
  },
  data() {
    return {
      spot: {},
      review: {},
      isModalOpen: false,
    };
  },
  computed: {
    isOwner() {
      return this.review.application_user_id === parseInt(this.currentUserId);
    },
  },
  methods: {
    formatDate(date) {
      return new Date(date).toLocaleString("ja-JP", {
        year: "numeric",
        month: "long",
        day: "numeric",
        hour: "2-digit",
        minute: "2-digit",
      });
    },
    async fetchReviewData() {
      try {
        const response = await fetch(
          `/spots/${this.spotId}/reviews/${this.reviewId}.json`,
          {
            headers: {
              Accept: "application/json",
              "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
                ?.content,
            },
            credentials: "same-origin",
          },
        );

        if (!response.ok) throw new Error("Network response was not ok");

        const data = await response.json();
        this.review = data.review;
        this.spot = data.spot;
        this.review.images = data.images;
      } catch (error) {
        console.error("Error fetching review:", error);
        this.error = "データの取得に失敗しました";
      }
    },
    openModal() {
      this.isModalOpen = true;
    },
    closeModal() {
      this.isModalOpen = false;
    },
    async deleteReview() {
      try {
        const response = await fetch(
          `/spots/${this.spotId}/reviews/${this.reviewId}`,
          {
            method: "DELETE",
            headers: {
              "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
                ?.content,
              Accept: "application/json",
            },
            credentials: "same-origin",
          },
        );

        if (!response.ok) throw new Error("削除に失敗しました");

        // モーダルを閉じて一覧ページへ遷移
        this.closeModal();
        window.location.href = `/spots/${this.spotId}/reviews`;
      } catch (error) {
        console.error("Error deleting review:", error);
        alert("削除中にエラーが発生しました");
      }
    },
  },
  created() {
    this.fetchReviewData();
  },
};
</script>

<style scoped>
.modal-fade-enter-active,
.modal-fade-leave-active {
  transition: opacity 0.3s ease;
}

.modal-fade-enter-from,
.modal-fade-leave-to {
  opacity: 0;
}
</style>
