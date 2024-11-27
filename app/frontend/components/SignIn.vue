<script>
export default {
  data() {
    return {
      form: {
        user_id: "",
        password: "",
      },
      error: null,
    };
  },
  methods: {
    async handleSubmit() {
      this.error = null;
      try {
        const csrfMetaTag = document.querySelector('[name="csrf-token"]');
        if (!csrfMetaTag) {
          throw new Error("CSRF token not found.");
        }
        const csrfToken = csrfMetaTag.content;

        const response = await fetch("/sign-in", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": csrfToken,
          },
          body: JSON.stringify(this.form),
        });
        if (response.ok) {
          const data = await response.json();
          if (data.redirect_url) {
            window.location.href = "/";
          }
        } else if (response.status === 422) {
          const result = await response.json();
          this.error = result.error || "ログインに失敗しました。";
        } else {
          this.error = "予期しないエラーが発生しました。";
        }
      } catch (err) {
        console.error("Error during form submission:", err);
        this.error = "通信エラーが発生しました。";
      }
    },
  },
};
</script>

<template>
  <div class="flex min-h-screen items-center justify-center bg-gray-50">
    <div class="w-full max-w-md rounded-lg bg-white p-6 shadow-lg">
      <h1 class="mb-6 text-center text-2xl font-bold">Sign In</h1>

      <div
        v-if="error"
        class="mb-4 rounded border border-red-200 bg-red-50 p-4 text-red-600"
      >
        {{ error }}
      </div>

      <form @submit.prevent="handleSubmit" class="space-y-4">
        <div>
          <label for="user_id" class="block text-sm font-medium text-gray-700"
            >ユーザーIDまたはメールアドレス</label
          >
          <input
            id="user_id"
            v-model="form.user_id"
            type="text"
            class="mt-1 block w-full rounded-md border border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
            placeholder="Enter your UserID or Email"
            required
          />
        </div>

        <div>
          <label for="password" class="block text-sm font-medium text-gray-700"
            >パスワード</label
          >
          <input
            id="password"
            v-model="form.password"
            type="password"
            class="mt-1 block w-full rounded-md border border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
            placeholder="Enter your Password"
            required
          />
        </div>

        <button
          type="submit"
          class="w-full rounded bg-indigo-600 py-2 text-white shadow hover:bg-indigo-700"
        >
          サインイン
        </button>
      </form>

      <div class="mt-4 text-center">
        <a
          href="sign-up"
          class="text-indigo-600 underline hover:text-indigo-800"
        >
          アカウントをお持ちでない方はこちら
        </a>
      </div>
    </div>
  </div>
</template>
