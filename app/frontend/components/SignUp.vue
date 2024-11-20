<script setup lang="ts">
import { ref } from "vue";

const name = ref("");
const nickname = ref("");
const password_digest = ref("");
const email = ref("");
const account_type = ref("");
const errorMessage = ref("");
const corporate_types = ref([
  { id: "株式会社", name: "株式会社" },
  { id: 2, name: "有限会社" },
  { id: 3, name: "合同会社" },
  { id: 4, name: "一般社団法人" },
  { id: 5, name: "合資会社" },
  { id: 6, name: "一般財団法人" },
  { id: 7, name: "公益社団法人" },
  { id: 8, name: "公益財団法人" },
  { id: 9, name: "独立行政法人" },
  { id: 10, name: "国立大学法人" },
  { id: 11, name: "地方独立行政法人" },
  { id: 12, name: "公立大学法人" },
  { id: 13, name: "学校法人" },
  { id: 14, name: "宗教法人" },
  { id: 15, name: "医療法人" },
  { id: 16, name: "社会福祉法人" },
]);

const corporate_type = ref<number | null>(corporate_types.value[0].id);

async function signUp() {
  console.log("Account Type:", account_type.value); // デバッグ用ログ
  console.log("Corporate Type:", corporate_type.value);

  if (account_type.value === "individual") {
    corporate_type.value = null;
  }

  try {
    const response = await fetch("http://localhost:3000/sign-up", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        signup_user: {
          name: name.value,
          nickname: nickname.value,
          email: email.value,
          password_digest: password_digest.value,
          account_type: account_type.value,
          corporate_type: corporate_type.value,
        },
      }),
    });
    const data = await response.json();
    if (response.ok) {
      console.log("Sign-up successful!");
    } else {
      errorMessage.value = data.message || "Invalid username or password";
    }
  } catch (error) {
    console.error("Error:", error);
    errorMessage.value = "An error occurred during sign-up";
  }
}
</script>

<template>
  <div class="sign-up-container">
    <h1>Sign Up</h1>
    <label for="name">User Name</label><br />
    <input
      id="name"
      v-model="name"
      type="text"
      placeholder="User name"
      required
    /><br />
    <label for="nickname">Nick Name</label><br />
    <input
      id="nickname"
      v-model="nickname"
      type="text"
      placeholder="Nick name"
      required
    /><br />
    <label for="email">Email</label><br />
    <input
      id="email"
      v-model="email"
      type="email"
      placeholder="Email Address"
      required
    /><br />
    <label for="password_digest">Password</label><br />
    <input
      id="password_digest"
      v-model="password_digest"
      type="password"
      placeholder="Password"
      required
    /><br />
    <div>
      <label for="individual">Select Account Type</label><br />
      <input
        type="radio"
        id="individual"
        value="individual"
        v-model="account_type"
      />
      <label for="individual">For User</label><br />
      <input
        type="radio"
        id="corporate"
        value="corporate"
        v-model="account_type"
      />
      <label for="corporate">For Corporate</label><br />
    </div>

    <div v-if="account_type === 'corporate'">
      <label for="corporatetype">Select Corporate Type</label><br />
      <select v-model="corporate_type" id="corporatetype">
        <option disabled value="">Please Select</option>
        <option v-for="type in corporate_types" :key="type.id" :value="type.id">
          {{ type.name }}
        </option>
      </select>
    </div>
    <br />

    <button type="submit" @click="signUp">Sign Up</button>
    <p v-if="errorMessage">{{ errorMessage }}</p>
  </div>
</template>
