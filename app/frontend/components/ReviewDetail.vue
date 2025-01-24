<!-- ReviewDetail.vue -->
<template>
  <div class="container mx-auto px-4 py-8">
    <div
      class="mx-auto max-w-4xl overflow-hidden rounded-lg bg-white shadow-lg"
    >
      <div class="p-6">
        <!-- スポット名とレビュー投稿日時 -->
        <div class="mb-6 border-b pb-4">
          <h1 class="mb-2 text-2xl font-bold text-gray-900">
            {{ spot.name }}のレビュー
          </h1>
          <p class="text-gray-600">
            投稿日: {{ formatDate(review.createdAt) }}
          </p>
        </div>

        <!-- 評価（星） -->
        <div class="mb-6">
          <h2 class="mb-2 text-lg font-semibold text-gray-700">評価</h2>
          <div class="flex gap-1">
            <template v-for="n in 5" :key="n">
              <svg
                class="h-6 w-6"
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
        <div class="mb-6">
          <h2 class="mb-2 text-lg font-semibold text-gray-700">コメント</h2>
          <div class="rounded-lg bg-gray-50 p-4">
            <p class="whitespace-pre-wrap text-gray-800">
              {{ review.comment }}
            </p>
          </div>
        </div>

        <!-- 画像表示 -->
        <div v-if="review.images && review.images.length > 0" class="mb-6">
          <h2 class="mb-2 text-lg font-semibold text-gray-700">写真</h2>
          <div class="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
            <div
              v-for="(image, index) in review.images"
              :key="index"
              class="aspect-w-16 aspect-h-9 relative"
            >
              <img
                :src="image"
                :alt="`レビュー画像 ${index + 1}`"
                class="h-full w-full rounded-lg object-cover"
              />
            </div>
          </div>
        </div>

        <!-- 削除ボタン -->
        <div v-if="isOwner" class="mt-6">
          <button
            @click="confirmDelete"
            class="font-medium text-red-600 hover:text-red-800"
          >
            レビューを削除する
          </button>
        </div>

        <!-- 戻るボタン -->
        <div class="mt-8 flex justify-end">
          <router-link
            :to="{ name: 'spot-reviews', params: { spotId: spot.id } }"
            class="font-medium text-blue-600 hover:text-blue-800"
          >
            レビュー一覧に戻る →
          </router-link>
        </div>
      </div>
    </div>
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
  },
  data() {
    return {
      spot: {},
      review: {},
      currentUserId: null, // This should be set from your auth system
    };
  },
  computed: {
    isOwner() {
      return this.review.applicationUserId === this.currentUserId;
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
        this.review.images = data.images; // 画像URLの配列を設定
      } catch (error) {
        console.error("Error fetching review:", error);
        this.error = "データの取得に失敗しました";
      }
    },

    async confirmDelete() {
      if (
        confirm(
          "このレビューを削除してもよろしいですか？\n※削除すると復元できません。",
        )
      ) {
        try {
          await this.$axios.delete(
            `/api/spots/${this.spotId}/reviews/${this.reviewId}`,
          );
          // Navigate back to reviews list after successful deletion
          this.$router.push({
            name: "spot-reviews",
            params: { spotId: this.spotId },
          });
        } catch (error) {
          console.error("Error deleting review:", error);
          // Handle error appropriately
        }
      }
    },
  },
  created() {
    this.fetchReviewData();
  },
};
</script>
