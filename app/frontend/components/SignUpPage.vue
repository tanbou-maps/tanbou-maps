<template>
  <div
    class="flex min-h-screen items-center justify-center bg-gradient-to-t from-fuchsia-50 from-0% via-gray-100 via-50% to-orange-100 to-100%"
  >
    <div class="w-full max-w-md rounded-lg bg-white p-6 shadow-lg">
      <h1 class="mb-6 text-center text-2xl font-bold">Sign Up</h1>

      <div
        v-if="errorMessages.length"
        class="mb-4 rounded border border-red-200 bg-red-50 p-4 text-red-600"
      >
        <ul>
          <li v-for="(error, index) in errorMessages" :key="index">
            {{ error }}
          </li>
        </ul>
      </div>

      <form @submit.prevent="submitForm" class="space-y-4">
        <div>
          <label for="user_id" class="block text-sm font-medium text-gray-700"
            >ユーザーID</label
          >
          <input
            id="user_id"
            v-model="user_id"
            type="text"
            class="w-full rounded-md border border-gray-300 px-3 py-2 shadow-sm focus:border-yellow-300 focus:outline-none focus:ring-2 focus:ring-yellow-300"
            placeholder="Enter your UserID"
            required
          />
        </div>

        <div>
          <label for="nickname" class="block text-sm font-medium text-gray-700"
            >ニックネーム</label
          >
          <input
            id="nickname"
            v-model="nickname"
            type="text"
            class="w-full rounded-md border border-gray-300 px-3 py-2 shadow-sm focus:border-yellow-300 focus:outline-none focus:ring-2 focus:ring-yellow-300"
            placeholder="Enter your NickName"
            required
          />
        </div>

        <div>
          <label for="email" class="block text-sm font-medium text-gray-700"
            >メールアドレス</label
          >
          <input
            id="email"
            v-model="email"
            type="email"
            class="w-full rounded-md border border-gray-300 px-3 py-2 shadow-sm focus:border-yellow-300 focus:outline-none focus:ring-2 focus:ring-yellow-300"
            placeholder="Enter your Email"
            required
          />
        </div>

        <div>
          <label for="password" class="block text-sm font-medium text-gray-700"
            >パスワード</label
          >
          <div class="relative mt-1">
            <input
              id="password"
              v-model="password"
              :type="showPasswords ? 'text' : 'password'"
              class="w-full rounded-md border border-gray-300 px-3 py-2 shadow-sm focus:border-yellow-300 focus:outline-none focus:ring-2 focus:ring-yellow-300"
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

        <div>
          <label
            for="password_confirmation"
            class="block text-sm font-medium text-gray-700"
            >パスワード確認</label
          >
          <div class="relative mt-1">
            <input
              id="password_confirmation"
              v-model="password_confirmation"
              :type="showPasswords ? 'text' : 'password'"
              class="w-full rounded-md border border-gray-300 px-3 py-2 shadow-sm focus:border-yellow-300 focus:outline-none focus:ring-2 focus:ring-yellow-300"
              placeholder="Enter your Password again"
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

        <div>
          <label class="block text-sm font-medium text-gray-700"
            >アカウントタイプ</label
          >
          <div class="mt-1 flex items-center space-x-4">
            <label class="inline-flex items-center">
              <input
                type="radio"
                value="individual"
                v-model="account_type"
                class="form-radio h-4 w-4 text-yellow-300"
              />
              <span class="ml-2">個人</span>
            </label>
            <label class="inline-flex items-center">
              <input
                type="radio"
                value="corporate"
                v-model="account_type"
                class="form-radio h-4 w-4 text-yellow-300"
              />
              <span class="ml-2">法人</span>
            </label>
          </div>
        </div>

        <div v-if="isCorporateAccount">
          <label
            for="corporate_type"
            class="block text-sm font-medium text-gray-700"
            >法人の種類</label
          >
          <select
            id="corporate_type"
            v-model="corporate_type"
            class="w-full rounded-md border border-gray-300 px-3 py-2 shadow-sm focus:border-yellow-300 focus:outline-none focus:ring-2 focus:ring-yellow-300"
          >
            <option value="" disabled>選択してください</option>
            <option v-for="type in corporate_types" :key="type" :value="type">
              {{ type }}
            </option>
          </select>
        </div>

        <button
          type="submit"
          class="w-full rounded bg-yellow-300 py-2 text-black shadow hover:bg-yellow-400 focus:border-yellow-300 focus:outline-none focus:ring-2 focus:ring-yellow-300"
        >
          サインアップ
        </button>
      </form>

      <div class="mt-4 text-center">
        <a href="sign-in" class="text-yellow-300 hover:underline">
          アカウントをお持ちの方はこちら
        </a>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from "vue";

const user_id = ref("");
const nickname = ref("");
const email = ref("");
const password = ref("");
const password_confirmation = ref("");
const showPasswords = ref(false);
const account_type = ref("individual");
const corporate_type = ref("");
const errorMessages = ref<string[]>([]);

// !TODO: 法人の種類の定義はアプリケーショ全体で統一する必要があるので config\corporate_types.yml から取得するように修正する
const corporate_types = [
  "株式会社",
  "有限会社",
  "合同会社",
  "一般社団法人",
  "合資会社",
  "一般財団法人",
  "公益社団法人",
  "公益財団法人",
  "独立行政法人",
  "国立大学法人",
  "地方独立行政法人",
  "公立大学法人",
  "学校法人",
  "宗教法人",
  "医療法人",
  "社会福祉法人",
];

const isCorporateAccount = computed(() => account_type.value === "corporate");

// フォーム送信処理
async function submitForm() {
  errorMessages.value = [];

  try {
    // CSRFトークンの取得
    const csrfToken = document
      .querySelector('meta[name="csrf-token"]')
      ?.getAttribute("content");
    if (!csrfToken) {
      throw new Error("CSRF token is missing.");
    }
    // サインアップリクエストを送信
    const response = await fetch("/sign-up", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken,
      },
      body: JSON.stringify({
        sign_up_user: {
          user_id: user_id.value,
          nickname: nickname.value,
          email: email.value,
          password: password.value,
          password_confirmation: password_confirmation.value,
          account_type: account_type.value,
          corporate_type: isCorporateAccount.value
            ? corporate_type.value
            : null,
        },
      }),
    });
    const data = await response.json();
    if (response.ok) {
      if (data.redirect_url) {
        // jump to success page
        window.location.href = data.redirect_url;
      } else {
        resetForm();
      }
    } else if (data.errors) {
      errorMessages.value = data.errors.map(
        (error: any) => `${error.field}: ${error.messages.join(", ")}`,
      );
    } else {
      errorMessages.value = ["An unexpected error occurred."];
    }
  } catch (error) {
    console.error("Error submitting form:", error);
    errorMessages.value = ["Network error occurred. Please try again later."];
  }
}

// フォームをリセットする
function resetForm() {
  user_id.value = "";
  nickname.value = "";
  email.value = "";
  password.value = "";
  password_confirmation.value = "";
  account_type.value = "individual";
  corporate_type.value = "";
  errorMessages.value = [];
}
</script>
