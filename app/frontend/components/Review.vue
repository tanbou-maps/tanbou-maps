<template>
  <div
    class="min-h-screen bg-gradient-to-t from-fuchsia-50 from-0% via-gray-100 via-50% to-orange-100 to-100%"
  >
    <div class="container mx-auto max-w-md px-4 py-8 sm:max-w-2xl lg:max-w-4xl">
      <!-- エラー表示 -->
      <div
        v-if="error"
        class="mb-6 rounded-md border border-red-400 bg-red-100 px-4 py-3 text-red-700"
        role="alert"
      >
        <p class="font-bold">エラーが発生しました</p>
        <p>{{ error }}</p>
      </div>

      <!-- メインコンテンツ -->
      <template v-if="!error">
        <!-- ヘッダーセクション -->
        <div
          class="mb-8 flex flex-col items-center justify-between sm:flex-row"
        >
          <h1 class="mb-4 text-2xl font-bold text-gray-900 sm:mb-0">
            {{ spot?.name }} のレビュー
          </h1>
          <div class="flex flex-col gap-4 sm:flex-row">
            <button
              v-if="canAddReview"
              @click="showCreateReviewForm"
              class="group relative inline-flex items-center overflow-hidden rounded-xl border-2 border-yellow-300 px-8 py-2 text-yellow-300 hover:text-black"
            >
              <span
                class="duration-400 ease absolute left-0 top-1/2 block h-0 w-full bg-yellow-400 opacity-100 transition-all group-hover:top-0 group-hover:h-full"
              ></span>
              <span class="relative">レビューを投稿</span>
            </button>
          </div>
        </div>

        <!-- レビュー一覧セクション -->
        <div class="space-y-6">
          <template v-if="reviews.length > 0">
            <a
              v-for="review in reviews"
              :key="review.id"
              :href="`/spots/${spotId}/reviews/${review.id}`"
              class="block rounded-lg bg-white p-6 shadow-md transition duration-200 hover:shadow-lg"
            >
              <!-- レビューヘッダー -->
              <div
                class="mb-4 flex flex-col items-start justify-between sm:flex-row sm:items-center"
              >
                <div class="space-y-2">
                  <!-- 評価の星表示 -->
                  <div class="flex">
                    <svg
                      v-for="n in 5"
                      :key="n"
                      class="h-5 w-5"
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
                  </div>
                  <!-- レビュー投稿者名 -->
                  <span class="font-medium text-gray-700">
                    {{ getUserDisplayName(review.application_user) }}
                  </span>
                </div>
                <!-- 投稿日時 -->
                <span class="mt-2 text-sm text-gray-500 sm:mt-0">
                  {{ formatDate(review.created_at) }}
                </span>
              </div>

              <!-- レビューコメント -->
              <p class="mb-4 text-gray-600">{{ review.comment }}</p>

              <!-- 画像表示セクション -->
              <div
                v-if="review.images_urls && review.images_urls.length > 0"
                class="mb-4 grid grid-cols-1 gap-4 sm:grid-cols-2"
              >
                <div
                  v-for="image in review.images_urls"
                  :key="image.id"
                  class="relative aspect-video"
                >
                  <img
                    :src="image.url"
                    :alt="`レビュー画像 ${image.id}`"
                    @error="handleImageError"
                    class="h-full w-full rounded-lg object-cover"
                  />
                </div>
              </div>
            </a>
          </template>
          <div v-else class="py-8 text-center text-gray-500">
            まだレビューはありません。最初のレビューを投稿してみましょう！
          </div>
          <div class="text-center">
            <a
              :href="`/spots/${spotId}`"
              class="text-gray-600 underline hover:text-yellow-400"
            >
              スポット詳細に戻る
            </a>
          </div>
        </div>
      </template>
    </div>
    <!-- レビュー投稿モーダル -->
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
          <h3 class="mb-4 text-lg font-medium text-gray-900">レビューを投稿</h3>

          <form @submit.prevent="submitReview" class="space-y-6">
            <!-- 評価入力 -->
            <div class="space-y-2">
              <label class="block text-sm font-medium text-gray-700"
                >評価</label
              >
              <div class="flex space-x-2">
                <button
                  v-for="n in 5"
                  :key="n"
                  type="button"
                  @click="newReview.rating = n"
                  class="focus:outline-none"
                >
                  <svg
                    class="h-8 w-8"
                    :class="
                      n <= newReview.rating
                        ? 'text-yellow-400'
                        : 'text-gray-300'
                    "
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 20 20"
                    fill="currentColor"
                  >
                    <path
                      d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                    />
                  </svg>
                </button>
              </div>
            </div>

            <!-- コメント入力 -->
            <div class="space-y-2">
              <label
                for="comment"
                class="block text-sm font-medium text-gray-700"
                >コメント</label
              >
              <textarea
                id="comment"
                v-model="newReview.comment"
                rows="4"
                required
                class="w-full rounded-md border border-gray-300 px-3 py-2 shadow-sm focus:border-yellow-300 focus:outline-none focus:ring-2 focus:ring-yellow-300"
              ></textarea>
            </div>

            <!-- 画像アップロード -->
            <div class="space-y-2">
              <label class="block text-sm font-medium text-gray-700">
                画像を追加
              </label>
              <input
                type="file"
                @change="handleFileSelect"
                multiple
                accept="image/*"
                class="w-full text-sm text-gray-500 file:mr-4 file:rounded-full file:border-0 file:bg-yellow-50 file:px-4 file:py-2 file:text-sm file:text-yellow-700 hover:file:bg-yellow-100"
              />
            </div>

            <!-- ボタングループ -->
            <div class="flex justify-end space-x-4">
              <button
                type="button"
                @click="closeModal"
                class="rounded-md border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50"
              >
                キャンセル
              </button>
              <button
                type="submit"
                :disabled="submitting"
                class="rounded-md bg-yellow-400 px-4 py-2 text-sm font-medium text-white hover:bg-yellow-500 disabled:opacity-50"
              >
                {{ submitting ? "送信中..." : "投稿する" }}
              </button>
            </div>
          </form>
        </div>
      </div>
    </transition>
  </div>
</template>

<script>
export default {
  name: "ReviewIndex",
  props: {
    spotId: {
      type: String,
      required: true,
    },
    currentUserId: {
      type: String,
      required: true,
    },
  },

  data() {
    return {
      spot: null,
      reviews: [],
      error: null,
      isModalOpen: false,
      submitting: false,
      newReview: {
        rating: 0,
        comment: "",
        images: [],
      },
    };
  },

  computed: {
    canAddReview() {
      return this.currentUserId;
    },
  },

  async created() {
    await this.fetchData();
  },

  methods: {
    getUserDisplayName(user) {
      if (!user) return "名無し";
      return user.nickname || user.name || "名無し";
    },

    getRequestOptions(method = "GET", body = null) {
      const options = {
        method,
        headers: {
          Accept: "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
            ?.content,
        },
        credentials: "same-origin",
      };

      if (body) {
        if (body instanceof FormData) {
          options.body = body;
        } else {
          options.headers["Content-Type"] = "application/json";
          options.body = JSON.stringify(body);
        }
      }

      return options;
    },

    async fetchData() {
      this.error = null;

      try {
        const [reviewsResponse, spotResponse] = await Promise.all([
          fetch(`/spots/${this.spotId}/reviews.json`, this.getRequestOptions()),
          fetch(`/spots/${this.spotId}.json`, this.getRequestOptions()),
        ]);

        if (!reviewsResponse.ok || !spotResponse.ok) {
          throw new Error("Network response was not ok");
        }

        const reviewsData = await reviewsResponse.json();
        const spotData = await spotResponse.json();

        this.reviews = reviewsData.reviews;
        this.spot = spotData.spot;
      } catch (error) {
        console.error("Error fetching data:", error);
        this.error = "データの読み込み中にエラーが発生しました。";
      }
    },

    formatDate(dateString) {
      return new Date(dateString).toLocaleDateString("ja-JP", {
        year: "numeric",
        month: "long",
        day: "numeric",
        hour: "2-digit",
        minute: "2-digit",
      });
    },

    showCreateReviewForm() {
      this.newReview = {
        rating: 0,
        comment: "",
        images: [],
      };
      this.isModalOpen = true;
    },

    closeModal() {
      this.isModalOpen = false;
    },

    handleFileSelect(event) {
      this.newReview.images = Array.from(event.target.files);
    },

    async submitReview() {
      if (this.submitting) return;

      this.submitting = true;
      const formData = new FormData();
      formData.append("review[rating]", this.newReview.rating);
      formData.append("review[comment]", this.newReview.comment);

      this.newReview.images.forEach((image) => {
        formData.append("review[images][]", image);
      });

      try {
        const response = await fetch(`/spots/${this.spotId}/reviews`, {
          method: "POST",
          body: formData,
          headers: {
            "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
              ?.content,
          },
          credentials: "same-origin",
        });

        if (!response.ok) {
          throw new Error("レビューの投稿に失敗しました");
        }

        await this.fetchData();
        this.showCreateModal = false;
      } catch (error) {
        console.error("Error submitting review:", error);
        this.error = error.message;
      } finally {
        this.submitting = false;
      }
    },

    handleImageError(event) {
      console.error("Image loading failed:", event);
      event.target.src = "/images/fallback-image.jpg";
    },
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
