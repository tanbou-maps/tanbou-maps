<script setup lang="ts">
import { ref, watch, computed } from "vue";

// 各種入力値を管理するref変数
const name = ref("");
const nickname = ref("");
const password_digest = ref("");
const email = ref("");
const account_type = ref("individual");
const errorMessage = ref("");
const showPassword = ref(false);
const corporate_types = ref([
  { id: "株式会社", name: "株式会社" },
  { id: "有限会社", name: "有限会社" },
  { id: "合同会社", name: "合同会社" },
  { id: "一般社団法人", name: "一般社団法人" },
  { id: "合資会社", name: "合資会社" },
  { id: "一般財団法人", name: "一般財団法人" },
  { id: "公益社団法人", name: "公益社団法人" },
  { id: "公益財団法人", name: "公益財団法人" },
  { id: "独立行政法人", name: "独立行政法人" },
  { id: "国立大学法人", name: "国立大学法人" },
  { id: "地方独立行政法人", name: "地方独立行政法人" },
  { id: "公立大学法人", name: "公立大学法人" },
  { id: "学校法人", name: "学校法人" },
  { id: "宗教法人", name: "宗教法人" },
  { id: "医療法人", name: "医療法人" },
  { id: "社会福祉法人", name: "社会福祉法人" },
]);

// 法人タイプを管理するref変数（初期値は最初の法人タイプ）
const corporate_type = ref<string | null>(corporate_types.value[0].id);

// アカウントタイプが法人かどうかを判定する計算プロパティ
const isCorporateAccount = computed(() => account_type.value === "corporate");

const nameError = ref("");
const nicknameError = ref("");
const emailError = ref("");
const passwordError = ref("");

// アカウントタイプが変更された場合の処理
watch(account_type, (newValue) => {
  if (newValue === "individual") {
    corporate_type.value = null;
  }
});

// 入力値が変更された場合にエラーメッセージをリセット
watch(
  [name, nickname, email, password_digest, account_type, corporate_type],
  () => {
    errorMessage.value = "";
  },
);

async function signUp() {
  console.log("Account Type:", account_type.value);
  console.log("Corporate Type:", corporate_type.value);

  if (
    !name.value ||
    !nickname.value ||
    !email.value ||
    !password_digest.value
  ) {
    errorMessage.value = "All fields are required.";
    return;
  }

  if (isCorporateAccount.value && corporate_type.value === null) {
    errorMessage.value = "Please select a corporate type.";
    return;
  }

  try {
    const requestData: Record<string, any> = {
      signup_user: {
        name: name.value,
        nickname: nickname.value,
        email: email.value,
        password_digest: password_digest.value,
        account_type: account_type.value,
      },
    };

    if (isCorporateAccount.value) {
      requestData.signup_user.corporate_type = corporate_type.value;
    }

    // サーバーへのPOSTリクエスト
    const response = await fetch("http://localhost:3000/sign-up", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(requestData),
    });

    // サーバーからのレスポンスを処理
    const data = await response.json();
    if (response.ok) {
      console.log("Sign-up successful!");
      alert(`${data.message}`);
      resetForm();
    } else {
      handleErrors(data.errors);
    }
  } catch (error) {
    console.error("Error:", error);
    errorMessage.value = "A network error occurred.";
  }
}

function handleErrors(errors) {
  nameError.value = "";
  nicknameError.value = "";
  emailError.value = "";
  passwordError.value = "";

  errors.forEach((error) => {
    if (error.field === "name") {
      nameError.value = error.messages.join(", ");
    } else if (error.field === "email") {
      emailError.value = error.messages.join(", ");
    } else if (error.field === "nickname") {
      nicknameError.value = error.messages.join(", ");
    } else if (error.field === "password_digest") {
      passwordError.value = error.messages.join(", ");
    }
  });
}

function setCustomNameValidity(event) {
  const value = event.target.value;
  if (!/^[a-zA-Z0-9_]+$/.test(value)) {
    event.target.setCustomValidity(
      "Name can only contain letters, numbers, and underscores.",
    );
  } else {
    event.target.setCustomValidity("");
  }
}

function validateEmail(event) {
  const value = event.target.value;
  emailError.value = "";
  if (!value.includes("@")) {
    event.target.setCustomValidity("Email must contain '@'.");
  } else {
    event.target.setCustomValidity("");
  }
  event.target.reportValidity();
}

function handleInput(field: string) {
  if (field === "name") {
    if (name.value.trim() !== "") {
      nameError.value = "";
    }
  } else if (field === "email") {
    if (email.value.trim() !== "") {
      emailError.value = "";
    }
  }
}
// フォームのリセット
function resetForm() {
  name.value = "";
  nickname.value = "";
  email.value = "";
  password_digest.value = "";
  account_type.value = "";
  corporate_type.value = null;
  errorMessage.value = "";
}
</script>

<template>
  <div class="flex min-h-screen items-center justify-center bg-gray-50">
    <div class="w-full max-w-md rounded-lg bg-white p-6 shadow-lg">
      <h1 class="mb-6 text-center text-2xl font-bold">Sign Up</h1>
      <form @submit.prevent="signUp" class="space-y-4">
        <div>
          <label for="name" class="block text-sm font-medium text-gray-700"
            >User Name</label
          >
          <input
            id="name"
            v-model="name"
            type="text"
            class="mt-1 block w-full rounded-md border border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
            placeholder="Enter your name"
            required
            @input="handleInput('name')"
          />
          <p v-if="nameError" class="mt-1 text-sm text-red-600">
            {{ nameError }}
          </p>
        </div>
        <div>
          <label for="nickname" class="block text-sm font-medium text-gray-700"
            >Nick Name</label
          >
          <input
            id="nickname"
            v-model="nickname"
            type="text"
            class="mt-1 block w-full rounded-md border border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
            placeholder="Enter your nickname"
            required
          />
          <p v-if="nicknameError" class="mt-1 text-sm text-red-600">
            {{ nicknameError }}
          </p>
        </div>
        <div>
          <label for="email" class="block text-sm font-medium text-gray-700"
            >Email</label
          >
          <input
            id="email"
            v-model="email"
            type="email"
            class="mt-1 block w-full rounded-md border border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
            placeholder="Enter your email"
            required
            @input="validateEmail"
          />
          <p v-if="emailError" class="mt-1 text-sm text-red-600">
            {{ emailError }}
          </p>
        </div>
        <div>
          <label
            for="password_digest"
            class="block text-sm font-medium text-gray-700"
            >Password</label
          >
          <div class="relative mt-1">
            <input
              id="password_digest"
              v-model="password_digest"
              :type="showPassword ? 'text' : 'password'"
              class="block w-full rounded-md border border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
              placeholder="Enter your password"
              required
            />
            <button
              type="button"
              class="absolute inset-y-0 right-0 flex items-center px-3 text-gray-500"
              @click="showPassword = !showPassword"
            >
              <template v-if="showPassword">
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
          <p class="block text-sm font-medium text-gray-700">Account Type</p>
          <div class="mt-1 flex items-center space-x-4">
            <label class="inline-flex items-center">
              <input
                type="radio"
                value="individual"
                v-model="account_type"
                class="form-radio h-4 w-4 text-indigo-600"
              />
              <span class="ml-2 text-gray-700">Individual</span>
            </label>
            <label class="inline-flex items-center">
              <input
                type="radio"
                value="corporate"
                v-model="account_type"
                class="form-radio h-4 w-4 text-indigo-600"
              />
              <span class="ml-2 text-gray-700">Corporate</span>
            </label>
          </div>
        </div>
        <div v-if="isCorporateAccount">
          <label
            for="corporatetype"
            class="block text-sm font-medium text-gray-700"
            >Corporate Type</label
          >
          <select
            id="corporatetype"
            v-model="corporate_type"
            class="mt-1 block w-full rounded-md border border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
          >
            <option value="" disabled>Please select</option>
            <option
              v-for="type in corporate_types"
              :key="type.id"
              :value="type.id"
            >
              {{ type.name }}
            </option>
          </select>
        </div>
        <p v-if="errorMessage" class="text-sm text-red-600">
          {{ errorMessage }}
        </p>
        <button
          type="submit"
          class="w-full rounded-md bg-indigo-600 px-4 py-2 text-white hover:bg-indigo-700 focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
        >
          Sign Up
        </button>
      </form>

      <div class="mt-4 text-center">
        <a href="/" class="text-indigo-600 underline hover:text-indigo-800">
          Return to Index
        </a>
      </div>
    </div>
  </div>
</template>
