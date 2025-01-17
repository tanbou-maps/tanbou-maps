<template>
  <div class="container mx-auto px-4 py-8">
    <div class="mx-auto max-w-4xl">
      <!-- スポット情報とヘッダー部分 -->
      <div class="mb-8">
        <div class="flex items-center justify-between">
          <h1 class="text-3xl font-bold text-gray-900">
            {{ spot?.name }}のレビュー
          </h1>
          <div class="flex gap-4">
            <router-link
              :to="{ name: 'new-review', params: { spotId: spotId } }"
              class="rounded-lg bg-blue-600 px-4 py-2 text-white hover:bg-blue-700"
            >
              レビューを投稿
            </router-link>
            <router-link
              :to="{ name: 'spot-detail', params: { id: spotId } }"
              class="text-blue-600 hover:text-blue-800"
            >
              スポット詳細に戻る
            </router-link>
          </div>
        </div>
      </div>

      <!-- ローディングとエラー状態の表示 -->
      <div v-if="isLoading" class="py-8 text-center">
        <div
          class="mx-auto h-12 w-12 animate-spin rounded-full border-b-2 border-blue-600"
        ></div>
      </div>

      <div
        v-else-if="error"
        class="mb-6 rounded-lg bg-red-100 p-4 text-red-600"
      >
        {{ error }}
      </div>

      <!-- レビュー一覧の表示 -->
      <div v-else class="space-y-6">
        <template v-if="reviews.length">
          <router-link
            v-for="review in reviews"
            :key="review.id"
            :to="{
              name: 'review-detail',
              params: { spotId, reviewId: review.id },
            }"
            class="block"
          >
            <div
              class="rounded-lg bg-white p-6 shadow transition-shadow duration-200 hover:shadow-lg"
            >
              <div class="mb-4 flex items-center justify-between">
                <div class="flex items-center">
                  <star-rating :rating="review.rating" />
                </div>
                <span class="text-sm text-gray-500">
                  {{ formatDate(review.created_at) }}
                </span>
              </div>

              <p class="mb-4 text-gray-700">{{ review.comment }}</p>

              <!-- 画像の表示部分 -->
              <div
                v-if="review.images?.length"
                class="mt-4 grid grid-cols-1 gap-4 sm:grid-cols-2"
              >
                <div
                  v-for="(image, index) in review.images"
                  :key="image.id"
                  class="aspect-w-16 aspect-h-9 relative overflow-hidden rounded-lg"
                >
                  <img
                    :src="image.url"
                    :alt="`レビュー画像 ${index + 1}`"
                    class="absolute inset-0 h-full w-full object-cover"
                    loading="lazy"
                    @error="handleImageError"
                  />
                </div>
              </div>
            </div>
          </router-link>
        </template>
        <div v-else class="py-8 text-center text-gray-500">
          まだレビューはありません。最初のレビューを投稿してみましょう！
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, onMounted } from "vue";
import StarRating from "./StarRating.vue";

export default {
  name: "SpotReviews",

  components: {
    StarRating,
  },

  props: {
    spotId: {
      type: String,
      required: true,
    },
  },

  setup(props) {
    const spot = ref(null);
    const reviews = ref([]);
    const isLoading = ref(true);
    const error = ref(null);

    // 画像読み込みエラー時の処理
    const handleImageError = (event) => {
      event.target.src = "/assets/default-review-image.jpg";
    };

    // 日付のフォーマット処理
    const formatDate = (dateString) => {
      return new Date(dateString).toLocaleDateString("ja-JP", {
        year: "numeric",
        month: "long",
        day: "numeric",
        hour: "2-digit",
        minute: "2-digit",
      });
    };

    // データ取得処理
    const fetchSpotAndReviews = async () => {
      try {
        isLoading.value = true;
        error.value = null;

        const response = await fetch(`/api/spots/${props.spotId}/reviews`, {
          headers: {
            Accept: "application/json",
            "X-CSRF-Token": document.querySelector('[name="csrf-token"]')
              .content,
          },
        });

        if (!response.ok) {
          throw new Error("データの取得に失敗しました");
        }

        const data = await response.json();
        spot.value = data.spot;
        reviews.value = data.reviews;
      } catch (err) {
        console.error("Error fetching data:", err);
        error.value = "データの取得中にエラーが発生しました";
      } finally {
        isLoading.value = false;
      }
    };

    onMounted(() => {
      fetchSpotAndReviews();
    });

    return {
      spot,
      reviews,
      isLoading,
      error,
      formatDate,
      handleImageError,
    };
  },
};
</script>
