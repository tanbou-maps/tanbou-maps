<script setup>
import { ref } from "vue";

const username = ref("");
const password = ref("");
const errorMessage = ref("");

async function signIn() {
  const response = await fetch("http://localhost:3000/login", {
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
    // ログイン成功時の処理
    console.log("Login successful!");
    // 例えばダッシュボードへのリダイレクトなど
  } else {
    // エラーメッセージの表示
    errorMessage.value = "Invalid username or password";
  }
}
</script>

<template>
  <div class="signin-container">
    <h1>Sign In</h1>
    <input v-model="username" type="text" placeholder="Username" required />
    <input v-model="password" type="password" placeholder="Password" required />
    <button type="submit" @click="signIn">Sign In</button>
    <p v-if="errorMessage">{{ errorMessage }}</p>
  </div>
</template>

<style>
.signin-container {
  width: 580px;
  margin: auto;
  padding: 20px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}
</style>
