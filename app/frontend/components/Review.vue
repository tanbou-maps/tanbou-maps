<template>
  <div class="container mx-auto px-4 py-8">
    <div class="mx-auto max-w-4xl">
      <!-- ローディング表示 -->
      <div v-if="loading" class="flex items-center justify-center py-8">
        <div class="text-center">
          <div
            class="mb-4 h-12 w-12 animate-spin rounded-full border-4 border-blue-500 border-t-transparent"
          ></div>
          <p class="text-gray-600">データを読み込み中...</p>
        </div>
      </div>

      <!-- エラー表示 -->
      <div
        v-if="error"
        class="mb-4 rounded border border-red-400 bg-red-100 px-4 py-3 text-red-700"
        role="alert"
      >
        <p class="font-bold">エラーが発生しました</p>
        <p>{{ error }}</p>
      </div>

      <!-- メインコンテンツ -->
      <template v-if="!loading && !error">
        <!-- ヘッダーセクション -->
        <div class="mb-8">
          <div class="flex items-center justify-between">
            <h1 class="text-3xl font-bold text-gray-900">
              {{ spot?.name }}のレビュー
            </h1>
            <div class="flex gap-4">
              <button
                v-if="canAddReview"
                @click="showCreateReviewForm"
                class="rounded-lg bg-blue-600 px-4 py-2 text-white transition-colors hover:bg-blue-700"
              >
                レビューを投稿
              </button>
              <a
                :href="`/spots/${spotId}`"
                class="text-blue-600 transition-colors hover:text-blue-800"
              >
                スポット詳細に戻る
              </a>
            </div>
          </div>
        </div>

        <!-- レビュー一覧セクション -->
        <div class="space-y-6">
          <template v-if="reviews.length > 0">
            <a
              v-for="review in reviews"
              :key="review.id"
              :href="`/spots/${spotId}/reviews/${review.id}`"
              class="review-card block rounded-lg bg-white p-6 shadow transition-shadow duration-200 hover:shadow-lg"
            >
              <!-- レビューヘッダー -->
              <div class="mb-4 flex items-center justify-between">
                <div class="flex items-center space-x-4">
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
                  <span class="text-sm font-medium text-gray-700">
                    {{ getUserDisplayName(review.application_user) }}さん
                  </span>
                </div>
                <!-- 投稿日時 -->
                <span class="text-sm text-gray-500">
                  {{ formatDate(review.created_at) }}
                </span>
              </div>

              <!-- レビューコメント -->
              <p class="mb-4 whitespace-pre-wrap text-gray-700">
                {{ review.comment }}
              </p>

              <!-- 画像表示セクション -->
              <div
                v-if="review.images_urls && review.images_urls.length > 0"
                class="mt-4 grid grid-cols-1 gap-4 sm:grid-cols-2"
              >
                <div
                  v-for="image in review.images_urls"
                  :key="image.id"
                  class="aspect-w-16 aspect-h-9 relative overflow-hidden rounded-lg"
                >
                  <img
                    :src="image.url"
                    :alt="`レビュー画像 ${image.id}`"
                    class="absolute inset-0 h-full w-full object-cover"
                    @error="handleImageError"
                  />
                </div>
              </div>

              <!-- 操作ボタン（レビュー投稿者のみ表示） -->
              <div
                v-if="review.application_user_id === currentUserId"
                class="mt-4 flex justify-end space-x-2"
              >
                <button
                  @click.prevent="deleteReview(review.id)"
                  class="rounded bg-red-500 px-3 py-1 text-sm text-white transition-colors hover:bg-red-600"
                >
                  削除
                </button>
              </div>
            </a>
          </template>
          <div v-else class="py-8 text-center text-gray-500">
            まだレビューはありません。最初のレビューを投稿してみましょう！
          </div>
        </div>
      </template>
    </div>

    <!-- レビュー投稿モーダル -->
    <div
      v-if="showCreateModal"
      class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50"
    >
      <div class="w-full max-w-2xl rounded-lg bg-white p-6">
        <h2 class="mb-4 text-2xl font-bold">レビューを投稿</h2>
        <form @submit.prevent="submitReview" class="space-y-4">
          <!-- 評価入力 -->
          <div>
            <label class="mb-2 block text-sm font-medium text-gray-700">
              評価
            </label>
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
                    n <= newReview.rating ? 'text-yellow-400' : 'text-gray-300'
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
          <div>
            <label
              for="comment"
              class="mb-2 block text-sm font-medium text-gray-700"
            >
              コメント
            </label>
            <textarea
              id="comment"
              v-model="newReview.comment"
              rows="4"
              class="w-full rounded-md border border-gray-300 p-2 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
              required
            ></textarea>
          </div>

          <!-- 画像アップロード -->
          <div>
            <label class="mb-2 block text-sm font-medium text-gray-700">
              画像を追加
            </label>
            <input
              type="file"
              @change="handleFileSelect"
              multiple
              accept="image/*"
              class="w-full rounded-md border border-gray-300 p-2"
            />
          </div>

          <!-- 送信ボタン -->
          <div class="flex justify-end space-x-2">
            <button
              type="button"
              @click="showCreateModal = false"
              class="rounded-md border border-gray-300 px-4 py-2 text-gray-700 hover:bg-gray-50"
            >
              キャンセル
            </button>
            <button
              type="submit"
              :disabled="submitting"
              class="rounded-md bg-blue-600 px-4 py-2 text-white hover:bg-blue-700 disabled:opacity-50"
            >
              {{ submitting ? "送信中..." : "投稿する" }}
            </button>
          </div>
        </form>
      </div>
    </div>
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
      loading: true,
      error: null,
      showCreateModal: false,
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
      return this.currentUserId && !this.loading;
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
      this.loading = true;
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
      } finally {
        this.loading = false;
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
      this.showCreateModal = true;
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

    async deleteReview(reviewId) {
      if (!confirm("このレビューを削除してもよろしいですか？")) return;

      try {
        const response = await fetch(
          `/spots/${this.spotId}/reviews/${reviewId}`,
          this.getRequestOptions("DELETE"),
        );

        if (!response.ok) {
          throw new Error("レビューの削除に失敗しました");
        }

        await this.fetchData();
      } catch (error) {
        console.error("Error deleting review:", error);
        this.error = "削除中にエラーが発生しました。";
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
.aspect-w-16 {
  position: relative;
  padding-bottom: 56.25%;
}

.aspect-h-9 {
  position: absolute;
  width: 100%;
  height: 100%;
  left: 0;
  top: 0;
}

.modal-enter-active,
.modal-leave-active {
  transition: opacity 0.3s ease;
}

.modal-enter-from,
.modal-leave-to {
  opacity: 0;
}

.review-card {
  transition: transform 0.2s ease-in-out;
}

.review-card:hover {
  transform: translateY(-2px);
}

.star-rating button:hover svg {
  transform: scale(1.1);
  transition: transform 0.2s ease-in-out;
}

.image-preview {
  max-height: 200px;
  object-fit: contain;
}
</style>
