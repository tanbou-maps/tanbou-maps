<template>
  <div class="container mx-auto px-4 py-8">
    <div class="mx-auto max-w-4xl">
      <!-- ヘッダーセクション -->
      <div class="mb-8">
        <div class="flex items-center justify-between">
          <h1 class="text-3xl font-bold text-gray-900">
            {{ spot.name }}のレビュー
          </h1>
          <div class="flex gap-4">
            <router-link
              :to="{ name: 'new-review', params: { spotId: spot.id } }"
              class="rounded-lg bg-blue-600 px-4 py-2 text-white hover:bg-blue-700"
            >
              レビューを投稿
            </router-link>
            <router-link
              :to="{ name: 'spot-detail', params: { id: spot.id } }"
              class="text-blue-600 hover:text-blue-800"
            >
              スポット詳細に戻る
            </router-link>
          </div>
        </div>
      </div>

      <!-- レビュー一覧 -->
      <div class="space-y-6">
        <template v-if="reviews.length">
          <router-link
            v-for="review in reviews"
            :key="review.id"
            :to="{
              name: 'review-detail',
              params: { spotId: spot.id, reviewId: review.id },
            }"
            class="block"
          >
            <div
              class="rounded-lg bg-white p-6 shadow transition-shadow duration-200 hover:shadow-lg"
            >
              <div class="mb-4 flex items-center justify-between">
                <div class="flex">
                  <star-rating :rating="review.rating" />
                </div>
                <span class="text-sm text-gray-500">
                  {{ formatDate(review.createdAt) }}
                </span>
              </div>
              <p class="mb-4 text-gray-700">{{ review.comment }}</p>
              <div
                v-if="review.images.length"
                class="mt-4 grid grid-cols-1 gap-4 sm:grid-cols-2"
              >
                <div
                  v-for="image in review.images"
                  :key="image.id"
                  class="aspect-w-16 aspect-h-9 relative overflow-hidden rounded-lg"
                >
                  <img
                    :src="image.url"
                    class="absolute inset-0 h-full w-full object-cover"
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

    const formatDate = (date) => {
      return new Date(date).toLocaleDateString("ja-JP", {
        year: "numeric",
        month: "long",
        day: "numeric",
        hour: "2-digit",
        minute: "2-digit",
      });
    };

    const fetchSpotAndReviews = async () => {
      try {
        // スポットとレビューを同時に取得
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
      } catch (error) {
        console.error("Error fetching data:", error);
        // エラーハンドリングの実装（例：エラーメッセージの表示）
      }
    };

    onMounted(() => {
      fetchSpotAndReviews();
    });

    return {
      spot,
      reviews,
      formatDate,
    };
  },
};
</script>
