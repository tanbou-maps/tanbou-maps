<template>
  <div
    class="flex min-h-screen items-center justify-center bg-gradient-to-t from-fuchsia-50 from-0% via-gray-100 via-50% to-orange-100 to-100%"
  >
    <div class="w-full max-w-md rounded-lg bg-white p-6 shadow-lg">
      <h1 class="mb-6 text-center text-2xl font-bold">Contact Us</h1>
      <p class="text-center">お問い合わせは以下のフォームからお願いします</p>
      <br />

      <div
        v-if="errors.length"
        class="mb-4 rounded border border-red-300 bg-red-50 p-4 text-red-700"
      >
        <ul>
          <li v-for="(error, index) in errors" :key="index">{{ error }}</li>
        </ul>
      </div>

      <form @submit.prevent="handleSubmit" class="space-y-4">
        <div>
          <label for="name" class="block text-sm font-medium text-gray-700"
            >お名前</label
          >
          <input
            id="name"
            v-model="name"
            type="text"
            class="mt-1 block w-full rounded-md border p-2 shadow-sm focus:ring-indigo-300"
            placeholder="Enter your name"
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
            class="mt-1 block w-full rounded-md border p-2 shadow-sm focus:ring-indigo-300"
            placeholder="Enter your email"
            required
            readonly
          />
        </div>

        <div>
          <label for="message" class="block text-sm font-medium text-gray-700"
            >メッセージ</label
          >
          <textarea
            id="message"
            v-model="message"
            class="mt-1 block w-full rounded-md border p-2 shadow-sm focus:ring-indigo-300"
            rows="4"
            placeholder="Enter your message"
            required
          ></textarea>
        </div>
        <div class="mt-4 flex items-center">
          <input
            id="agree-to-terms"
            v-model="agreeToTerms"
            type="checkbox"
            class="mr-2 rounded border-gray-300 text-indigo-600 focus:ring-indigo-500"
            required
          />
          <label for="agree-to-terms" class="text-sm text-gray-700">
            利用規約に同意します
          </label>
          <a
            href="/contacts/terms"
            target="_blank"
            class="ml-2 text-sm text-yellow-300 hover:underline"
            >利用規約を確認</a
          >
        </div>

        <button
          type="submit"
          :disabled="isSubmitting"
          class="w-full rounded bg-yellow-300 px-4 py-2 text-black shadow hover:bg-yellow-400 disabled:opacity-50"
        >
          送信
        </button>
      </form>
      <div class="mt-4 text-center">
        <a href="/" class="text-sm text-yellow-300 hover:underline">
          ホームページに戻る
        </a>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from "vue";

declare global {
  interface Window {
    defaultEmail?: string;
  }
}

const name = ref("");
const email = ref(window.defaultEmail || "");
const message = ref("");
const agreeToTerms = ref(false);
const errors = ref<string[]>([]);
const isSubmitting = ref(false);

// フォーム送信処理
async function handleSubmit() {
  errors.value = [];
  isSubmitting.value = true;

  if (!agreeToTerms.value) {
    errors.value.push("利用規約に同意してください。");
    isSubmitting.value = false;
    return;
  }

  if (!name.value.trim() || !message.value.trim()) {
    errors.value.push(
      "お名前またはメッセージには、スペース以外の内容を入力してください。",
    );
    isSubmitting.value = false;
    return;
  }

  try {
    // CSRF トークン取得
    const csrfToken = document
      .querySelector('meta[name="csrf-token"]')
      ?.getAttribute("content");
    if (!csrfToken) {
      throw new Error("CSRF トークンが見つかりません。");
    }

    // リクエスト送信
    const response = await fetch("/contacts", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken,
      },
      body: JSON.stringify({
        name: name.value,
        email: email.value,
        message: message.value,
      }),
    });

    const data = await response.json();
    if (response.ok) {
      if (data.redirect_url) {
        window.location.href = data.redirect_url;
      } else {
        resetForm();
      }
    } else if (data.errors) {
      errors.value = data.errors.map(
        (error: { field: string; messages: string[] }) =>
          `${error.field}: ${error.messages.join(", ")}`,
      );
    } else {
      errors.value = ["予期しないエラーが発生しました。"];
    }
  } catch (error) {
    console.error("フォーム送信中のエラー:", error);
    errors.value = ["通信エラーが発生しました。"];
  } finally {
    isSubmitting.value = false;
  }
}

// フォームをリセットする
function resetForm() {
  name.value = "";
  email.value = "";
  message.value = "";
}
</script>
