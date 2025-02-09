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
      const formData = new FormData();
      formData.append("user[nickname]", this.user.nickname);
      formData.append("user[email]", this.user.email);
      if (this.avatarImage) {
        formData.append("user[avatar_image]", this.avatarImage);
      }
      if (this.coverImage) {
        formData.append("user[cover_image]", this.coverImage);
      }

      fetch(`/profile/${this.user.id}`, {
        method: "PATCH",
        headers: {
          "X-CSRF-Token": document
            .querySelector('meta[name="csrf-token"]')
            .getAttribute("content"),
        },
        body: formData,
      })
        .then((response) => {
          if (response.ok) {
            window.location.href = `/profile/${this.user.id}`;
          } else {
            alert("Failed to update profile.");
          }
        })
        .catch((error) => {
          console.error("Error:", error);
          alert("Failed to update profile.");
        });
    },
    onFileChange(event) {
      const file = event.target.files[0];
      if (event.target.id === "avatar_image") {
        this.avatarImage = file;
      } else if (event.target.id === "cover_image") {
        this.coverImage = file;
      }
    },
  },
  data() {
    return {
      avatarImage: null,
      coverImage: null,
    };
  },
};
</script>
