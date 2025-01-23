<template>
  <div class="container mx-auto px-4 py-8">
    <div class="mx-auto max-w-2xl">
      <div class="rounded-lg bg-white p-6 shadow-md">
        <h1 class="mb-6 text-2xl font-bold text-gray-900">
          {{ spot?.name }}のレビューを投稿
        </h1>

        <form @submit.prevent="submitReview" class="space-y-6">
          <!-- 評価入力 -->
          <div>
            <label class="mb-2 block text-sm font-medium text-gray-700">
              評価
            </label>
            <div class="flex gap-4">
              <div v-for="rating in 5" :key="rating" class="flex items-center">
                <input
                  type="radio"
                  :id="`rating_${rating}`"
                  v-model="reviewData.rating"
                  :value="rating"
                  class="peer hidden"
                />
                <label
                  :for="`rating_${rating}`"
                  class="cursor-pointer peer-checked:text-yellow-400"
                >
                  <svg
                    class="h-8 w-8"
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 20 20"
                    fill="currentColor"
                  >
                    <path
                      d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                    />
                  </svg>
                </label>
              </div>
            </div>
          </div>

          <!-- コメント入力 -->
          <div>
            <label class="mb-2 block text-sm font-medium text-gray-700">
              コメント
            </label>
            <textarea
              v-model="reviewData.comment"
              class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500"
              rows="4"
            ></textarea>
          </div>

          <!-- 画像アップロード -->
          <div>
            <label class="mb-2 block text-sm font-medium text-gray-700">
              画像
            </label>
            <input
              type="file"
              @change="handleImageUpload"
              multiple
              accept="image/*"
              class="block w-full text-sm text-gray-500 file:mr-4 file:rounded-md file:border-0 file:bg-blue-50 file:px-4 file:py-2 file:text-sm file:font-medium file:text-blue-700 hover:file:bg-blue-100"
            />
          </div>

          <!-- ボタン -->
          <div class="flex justify-end gap-4">
            <router-link
              :to="{ name: 'spot-detail', params: { id: spotId } }"
              class="px-4 py-2 text-sm font-medium text-gray-700 hover:text-gray-500"
            >
              キャンセル
            </router-link>
            <button
              type="submit"
              class="rounded-lg bg-blue-600 px-4 py-2 text-white hover:bg-blue-700"
            >
              レビューを投稿
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, reactive, onMounted } from "vue";
import { useRouter } from "vue-router";

export default {
  props: {
    spotId: {
      type: String,
      required: true,
    },
  },

  setup(props) {
    const router = useRouter();
    const spot = ref(null);
    const reviewData = reactive({
      rating: null,
      comment: "",
      images: [],
    });

    const handleImageUpload = (event) => {
      reviewData.images = Array.from(event.target.files);
    };

    const submitReview = async () => {
      try {
        // API call would go here
        // const formData = new FormData()
        // formData.append('rating', reviewData.rating)
        // formData.append('comment', reviewData.comment)
        // reviewData.images.forEach(image => {
        //   formData.append('images[]', image)
        // })
        // await axios.post(`/api/spots/${props.spotId}/reviews`, formData)
        router.push({ name: "spot-reviews", params: { spotId: props.spotId } });
      } catch (error) {
        console.error("Error submitting review:", error);
      }
    };

    const fetchSpot = async () => {
      try {
        // API call would go here
        // const response = await axios.get(`/api/spots/${props.spotId}`)
        // spot.value = response.data
      } catch (error) {
        console.error("Error fetching spot:", error);
      }
    };

    onMounted(() => {
      fetchSpot();
    });

    return {
      spot,
      reviewData,
      handleImageUpload,
      submitReview,
    };
  },
};
</script>
