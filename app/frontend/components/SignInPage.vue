<template>
  <div
    class="flex min-h-screen items-center justify-center bg-gradient-to-t from-fuchsia-50 from-0% via-gray-100 via-50% to-orange-100 to-100%"
  >
    <div class="w-full max-w-md rounded-lg bg-white p-6 shadow-lg">
      <h1 class="mb-6 text-center text-2xl font-bold text-black">Sign In</h1>

      <div
        v-if="error"
        class="mb-4 rounded border border-red-200 bg-red-50 p-4 text-red-600"
      >
        {{ error }}
      </div>

      <form @submit.prevent="handleSubmit" class="space-y-4">
        <div>
          <label for="user_id" class="block text-sm font-medium text-black"
            >ユーザーIDまたはメールアドレス</label
          >
          <input
            id="user_id"
            v-model="user_id"
            type="text"
            class="mt-1 block w-full rounded-md border border-gray-300 p-1 shadow-sm sm:text-sm"
            placeholder="Enter your UserID or Email"
            required
          />
        </div>

        <div>
          <label for="password" class="block text-sm font-medium text-black"
            >パスワード</label
          >
          <div class="relative mt-1">
            <input
              id="password"
              v-model="password"
              :type="showPasswords ? 'text' : 'password'"
              class="block w-full rounded-md border border-gray-300 p-1 pr-12 shadow-sm sm:text-sm"
              placeholder="Enter your Password"
              required
            />
            <button
              type="button"
              class="absolute inset-y-0 right-0 flex items-center px-3 text-gray-500"
              @click="showPasswords = !showPasswords"
            >
              <template v-if="showPasswords">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke-width="2"
                  stroke="currentColor"
                  class="h-6 w-6"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    d="M12 4.5c-5.796 0-10.5 6.25-10.5 6.25s4.704 6.25 10.5 6.25 10.5-6.25 10.5-6.25-4.704-6.25-10.5-6.25zM12 15.25a3.25 3.25 0 100-6.5 3.25 3.25 0 000 6.5z"
                  />
                </svg>
              </template>
              <template v-else>
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke-width="2"
                  stroke="currentColor"
                  class="h-6 w-6"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    d="M3 3l18 18M12 4.5c-5.796 0-10.5 6.25-10.5 6.25s4.704 6.25 10.5 6.25 10.5-6.25 10.5-6.25-4.704-6.25-10.5-6.25zM15.25 12a3.25 3.25 0 01-5.25 2.719M3.784 3.784l16.432 16.432"
                  />
                </svg>
              </template>
            </button>
          </div>
        </div>

        <button
          type="submit"
          class="w-full rounded bg-yellow-300 py-2 text-black shadow hover:bg-yellow-400"
        >
          サインイン
        </button>
      </form>

      <div class="mt-4 text-center">
        <a href="sign-up" class="text-yellow-300 hover:underline">
          アカウントをお持ちでない方はこちら
        </a>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from "vue";

const user_id = ref("");
const password = ref("");
const showPasswords = ref(false);
const error = ref<string | null>(null);

// フォーム送信処理
async function handleSubmit() {
  error.value = null;

  // CSRFトークンを取得
  try {
    const csrfToken = document
      .querySelector('meta[name="csrf-token"]')
      ?.getAttribute("content");
    if (!csrfToken) {
      throw new Error("CSRF token is missing.");
    }

    // サインインリクエストを送信
    const response = await fetch("/sign-in", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken,
      },
      body: JSON.stringify({
        user_id: user_id.value,
        password: password.value,
      }),
    });

    if (response.ok) {
      const data = await response.json();
      if (data.redirect_url) {
        window.location.href = data.redirect_url;
      }
    } else if (response.status === 422) {
      const result = await response.json();
      error.value = result.error || "ログインに失敗しました。";
    } else {
      error.value = "予期しないエラーが発生しました。";
    }
  } catch (err) {
    console.error("Error during form submission:", err);
    error.value = "通信エラーが発生しました。";
  }
}
</script>
