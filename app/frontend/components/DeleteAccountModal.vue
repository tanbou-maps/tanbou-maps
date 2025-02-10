<template>
  <div v-if="showModal" class="fixed inset-0 z-50 overflow-y-auto">
    <!-- 背景オーバーレイ -->
    <div class="fixed inset-0 bg-black bg-opacity-50 transition-opacity"></div>

    <!-- モーダルコンテンツ -->
    <div
      class="flex min-h-full items-end justify-center p-4 text-center sm:items-center sm:p-0"
    >
      <div
        class="relative transform overflow-hidden rounded-lg bg-white px-4 pb-4 pt-5 text-left shadow-xl transition-all sm:my-8 sm:w-full sm:max-w-lg sm:p-6"
      >
        <div class="sm:flex sm:items-start">
          <!-- 警告アイコン -->
          <div
            class="mx-auto flex h-12 w-12 flex-shrink-0 items-center justify-center rounded-full bg-red-100 sm:mx-0 sm:h-10 sm:w-10"
          >
            <svg
              class="h-6 w-6 text-red-600"
              fill="none"
              viewBox="0 0 24 24"
              stroke-width="1.5"
              stroke="currentColor"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126zM12 15.75h.007v.008H12v-.008z"
              />
            </svg>
          </div>

          <!-- モーダルテキスト -->
          <div class="mt-3 text-center sm:ml-4 sm:mt-0 sm:text-left">
            <h3 class="text-base font-semibold leading-6 text-gray-900">
              アカウントの削除
            </h3>
            <div class="mt-2">
              <p class="text-sm text-gray-500">
                本当にアカウントを削除しますか？この操作は取り消すことができません。
                削除すると、すべてのデータが完全に削除されます。
              </p>
            </div>
          </div>
        </div>

        <!-- ボタングループ -->
        <div class="mt-5 gap-3 sm:mt-4 sm:flex sm:flex-row-reverse">
          <button
            type="button"
            @click="handleDelete"
            class="inline-flex w-full justify-center rounded-md bg-red-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-red-500 sm:w-auto"
          >
            削除する
          </button>
          <button
            type="button"
            @click="closeModal"
            class="mt-3 inline-flex w-full justify-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 sm:mt-0 sm:w-auto"
          >
            キャンセル
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      showModal: false,
    };
  },
  props: {
    userId: {
      type: [String, Number],
      required: true,
    },
  },
  methods: {
    openModal() {
      this.showModal = true;
    },
    closeModal() {
      this.showModal = false;
    },
    async handleDelete() {
      try {
        const response = await fetch(`/profiles/${this.userId}`, {
          method: "DELETE",
          headers: {
            "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
              .content,
            Accept: "application/json",
          },
        });

        if (response.ok) {
          window.location.href = "/sign-in";
        } else {
          console.error("削除に失敗しました");
        }
      } catch (error) {
        console.error("エラーが発生しました:", error);
      }
    },
  },
};
</script>
