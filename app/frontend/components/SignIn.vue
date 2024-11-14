<script setup>
import { ref } from "vue";

const username = ref("");
const password = ref("");
const errorMessage = ref("");

async function signIn() {
  // 関数名をキャメルケースに変更
  const response = await fetch("http://localhost:3000/sign_in", {
    // APIエンドポイントをスネークケースに変更
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      username: username.value,
      password: password.value,
    }),
  });

  if (response.ok) {
    console.log("Sign-in successful!");
  } else {
    errorMessage.value = "Invalid username or password";
  }
}
</script>

<template>
  <div class="sign-in-container">
    <!-- クラス名をケバブケースに変更 -->
    <h1>Sign In</h1>
    <input v-model="username" type="text" placeholder="Username" required />
    <input v-model="password" type="password" placeholder="Password" required />
    <button type="submit" @click="signIn">Sign In</button>
    <!-- 関数名の修正 -->
    <p v-if="errorMessage">{{ errorMessage }}</p>
  </div>
</template>

<style>
.sign-in-container {
  /* クラス名をケバブケースに変更 */
  width: 580px;
  margin: auto;
  padding: 20px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}
</style>
