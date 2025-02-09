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
      window.location.href = `/profile/${this.user.id}/edit`;
    },
    deleteAccount() {
      // アカウント削除ロジック
      if (confirm("Are you sure you want to delete your account?")) {
        fetch(`/profile/${this.user.id}`, {
          method: "DELETE",
          headers: {
            "X-CSRF-Token": document
              .querySelector('meta[name="csrf-token"]')
              .getAttribute("content"),
            "Content-Type": "application/json",
          },
        })
          .then((response) => {
            if (response.ok) {
              window.location.href = "/";
            } else {
              alert("Failed to delete account.");
            }
          })
          .catch((error) => {
            console.error("Error:", error);
            alert("Failed to delete account.");
          });
      }
    },
  },
};
</script>
