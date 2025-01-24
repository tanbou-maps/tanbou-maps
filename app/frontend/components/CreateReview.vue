<template>
  <div class="container mx-auto px-4 py-8">
    <div class="mx-auto max-w-2xl">
      <div class="rounded-lg bg-white p-6 shadow-md">
        <h1 class="mb-6 text-2xl font-bold text-gray-900">レビューを投稿</h1>

        <!-- form_withを使用するためにERBテンプレートに変更 -->
        <form
          action="/spots/<%= @spot.id %>/reviews"
          method="post"
          enctype="multipart/form-data"
        >
          <%= csrf_token_tag %>

          <!-- 評価入力セクション -->
          <div>
            <label class="mb-2 block text-sm font-medium text-gray-700"
              >評価</label
            >
            <div class="flex gap-4">
              <% (1..5).each do |rating| %>
              <div class="flex items-center">
                <input
                  type="radio"
                  name="review[rating]"
                  value="<%= rating %>"
                  id="rating_<%= rating %>"
                  class="peer hidden"
                />
                <label
                  for="rating_<%= rating %>"
                  class="cursor-pointer text-gray-300 peer-checked:text-yellow-400"
                >
                  <!-- 星のSVG -->
                  // ...existing code...
                </label>
              </div>
              <% end %>
            </div>
          </div>

          <!-- コメント入力セクション -->
          <div class="mt-6">
            <label class="mb-2 block text-sm font-medium text-gray-700"
              >コメント</label
            >
            <textarea
              name="review[comment]"
              rows="4"
              class="mt-1 block w-full rounded-md border-gray-300 shadow-sm"
            >
            </textarea>
          </div>

          <!-- 画像アップロードセクション -->
          <div class="mt-6">
            <label class="mb-2 block text-sm font-medium text-gray-700"
              >画像</label
            >
            <input
              type="file"
              name="review[images][]"
              multiple
              accept="image/*"
              class="block w-full text-sm"
            />
          </div>

          <!-- フォームボタン -->
          <div class="mt-6 flex justify-end gap-4">
            <a
              href="/spots/<%= @spot.id %>"
              class="px-4 py-2 text-sm font-medium text-gray-700"
            >
              キャンセル
            </a>
            <button
              type="submit"
              class="rounded-lg bg-blue-600 px-4 py-2 text-white"
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
export default {
  name: "CreateReview",
  data() {
    return {
      rating: 0,
      imagePreviewUrls: [],
    };
  },
  methods: {
    handleImagePreview(event) {
      const files = Array.from(event.target.files);
      this.imagePreviewUrls = [];

      files.forEach((file) => {
        if (file.type.startsWith("image/")) {
          const reader = new FileReader();
          reader.onload = (e) => this.imagePreviewUrls.push(e.target.result);
          reader.readAsDataURL(file);
        }
      });
    },
  },
};
</script>
