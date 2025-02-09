<template>
  <div>
    <h1>Edit Profile</h1>
    <form @submit.prevent="updateProfile">
      <label for="nickname">Nickname:</label>
      <input type="text" v-model="user.nickname" id="nickname" />
      <label for="email">Email:</label>
      <input type="email" v-model="user.email" id="email" />
      <label for="avatar_image">Avatar Image:</label>
      <input type="file" @change="onFileChange" id="avatar_image" />
      <label for="cover_image">Cover Image:</label>
      <input type="file" @change="onFileChange" id="cover_image" />
      <button type="submit">Save</button>
    </form>
  </div>
</template>

<script>
export default {
  props: ["user"],
  methods: {
    updateProfile() {
      // プロフィール更新ロジック
    },
    onFileChange(event) {
      // ファイル変更ロジック
    },
  },
};
</script>
