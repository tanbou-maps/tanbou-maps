<template>
  <div>
    <h1>{{ user.nickname }}'s Profile</h1>
    <p>User ID: {{ user.id }}</p>
    <p>Account Type: {{ user.account_type }}</p>
    <img :src="user.avatar_image" alt="Avatar Image" />
    <img :src="user.cover_image" alt="Cover Image" />
    <button v-if="isCurrentUser" @click="editProfile">Edit Profile</button>
    <button v-if="isCurrentUser" @click="deleteAccount">Delete Account</button>
  </div>
</template>

<script>
export default {
  props: ["user", "isCurrentUser"],
  methods: {
    editProfile() {
      // 編集画面への遷移ロジック
    },
    deleteAccount() {
      // アカウント削除ロジック
    },
  },
};
</script>
