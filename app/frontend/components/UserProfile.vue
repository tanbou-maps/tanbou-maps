<!-- filepath: /c:/Users/admin/Rails/tanbou-maps/app/frontend/components/UserProfile.vue -->
<template>
  <div>
    <div v-if="user.background_picture_url" class="background-container">
      <img
        :src="user.background_picture_url"
        alt="Uploaded Image"
        class="background-image"
      />
    </div>

    <div class="nickname-box">
      <div class="nickname-overlay">{{ user.nickname }}</div>
    </div>

    <div v-if="user.profile_picture_url">
      <img
        :src="user.profile_picture_url"
        alt="Profile Image"
        class="profile-icon"
      />
    </div>

    <div class="favorite-spots-box">
      <h2>おすすめ観光スポット</h2>
      <div id="displayText">
        <p>{{ user.favorite_spots }}</p>
      </div>
    </div>

    <button @click="openModal('background')">背景設定</button>
    <div
      v-if="modals.background"
      class="modal"
      @click.self="closeModal('background')"
    >
      <div class="modal-content">
        <span class="close" @click="closeModal('background')">&times;</span>
        <h2>背景画像をアップロード</h2>
        <form @submit.prevent="uploadFile('background')">
          <input
            type="file"
            ref="backgroundFile"
            id="backgroundFile"
            name="backgroundFile"
          />
          <button type="submit">アップロード</button>
        </form>
      </div>
    </div>

    <button @click="openModal('profile')">プロフィール写真設定</button>
    <div
      v-if="modals.profile"
      class="modal"
      @click.self="closeModal('profile')"
    >
      <div class="modal-content">
        <span class="close" @click="closeModal('profile')">&times;</span>
        <h2>プロフィール写真をアップロード</h2>
        <form @submit.prevent="uploadFile('profile')">
          <input
            type="file"
            ref="profileFile"
            id="profileFile"
            name="profileFile"
          />
          <button type="submit">アップロード</button>
        </form>
      </div>
    </div>

    <button @click="openModal('nickname')">ニックネーム変更</button>
    <div
      v-if="modals.nickname"
      class="modal"
      @click.self="closeModal('nickname')"
    >
      <div class="modal-content">
        <span class="close" @click="closeModal('nickname')">&times;</span>
        <h2>ニックネームを変更</h2>
        <form @submit.prevent="updateNickname">
          <div class="field">
            <p>現在のニックネーム: {{ user.nickname }}</p>
            <label for="nickname">ニックネーム変更</label>
            <input
              type="text"
              v-model="user.nickname"
              id="nickname"
              name="nickname"
            />
          </div>
          <button type="submit">更新</button>
        </form>
      </div>
    </div>

    <button @click="openModal('favoriteSpots')">
      おすすめ観光スポット設定
    </button>
    <div
      v-if="modals.favoriteSpots"
      class="modal"
      @click.self="closeModal('favoriteSpots')"
    >
      <div class="modal-content">
        <span class="close" @click="closeModal('favoriteSpots')">&times;</span>
        <h2>あなたのおすすめの観光スポットを入力してください</h2>
        <form @submit.prevent="updateFavoriteSpots">
          <div class="field">
            <label for="favoriteSpots">テキスト</label>
            <input
              type="text"
              v-model="user.favorite_spots"
              id="favoriteSpots"
              name="favoriteSpots"
            />
          </div>
          <button type="submit">送信</button>
        </form>
      </div>
    </div>

    <button @click="openModal('deleteAccount')">アカウント削除</button>
    <div
      v-if="modals.deleteAccount"
      class="modal"
      @click.self="closeModal('deleteAccount')"
    >
      <div class="modal-content">
        <span class="close" @click="closeModal('deleteAccount')">&times;</span>
        <h2>アカウントを削除しますか？</h2>
        <form @submit.prevent="deleteAccount">
          <button type="submit">削除</button>
        </form>
      </div>
    </div>

    <div class="back-button">
      <router-link :to="{ name: 'root' }">戻る</router-link>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  props: {
    userId: {
      type: Number,
      required: true,
    },
  },
  data() {
    return {
      user: {
        background_picture_url: null,
        profile_picture_url: null,
        favorite_spots: null,
        nickname: "",
      },
      modals: {
        background: false,
        profile: false,
        nickname: false,
        favoriteSpots: false,
        deleteAccount: false,
      },
    };
  },
  created() {
    this.fetchUser();
  },
  methods: {
    fetchUser() {
      axios
        .get(`/user_profile/${this.userId}`)
        .then((response) => {
          this.user = response.data;
        })
        .catch((error) => {
          console.error("Failed to fetch user data:", error);
        });
    },
    openModal(modal) {
      console.log(`Opening modal: ${modal}`);
      this.modals[modal] = true;
    },
    closeModal(modal) {
      console.log(`Closing modal: ${modal}`);
      this.modals[modal] = false;
    },
    uploadFile(type) {
      const fileInput = this.$refs[`${type}File`];
      if (fileInput && fileInput.files && fileInput.files[0]) {
        const formData = new FormData();
        formData.append("file", fileInput.files[0]);

        axios
          .post(`/user_profile/upload_${type}_picture`, formData)
          .then(() => {
            alert("File uploaded successfully");
            this.fetchUser(); // データを再取得
            this.closeModal(type);
          })
          .catch((error) => {
            console.error("File upload failed:", error);
            alert("File upload failed");
          });
      } else {
        alert("No file selected");
      }
    },
    updateNickname() {
      axios
        .patch("/user_profile/update_nickname", {
          application_user: { nickname: this.user.nickname },
        })
        .then(() => {
          alert("ニックネームが更新されました");
          this.fetchUser(); // データを再取得
          this.closeModal("nickname");
        })
        .catch((error) => {
          console.error("Nickname update failed:", error);
          alert("Nickname update failed");
        });
    },
    updateFavoriteSpots() {
      axios
        .patch("/user_profile/update_text", {
          application_user: { favorite_spots: this.user.favorite_spots },
        })
        .then(() => {
          alert("テキストが送信されました");
          this.fetchUser(); // データを再取得
          this.closeModal("favoriteSpots");
        })
        .catch((error) => {
          console.error("Text update failed:", error);
          alert("Text update failed");
        });
    },
    deleteAccount() {
      const csrfToken = document
        .querySelector('meta[name="csrf-token"]')
        .getAttribute("content");
      axios
        .delete("/user_profile/destroy_account", {
          headers: {
            "X-CSRF-Token": csrfToken,
          },
        })
        .then(() => {
          alert("アカウントが削除されました");
          window.location.href = "/sign-in"; // サインインページのURLに変更
        })
        .catch((error) => {
          console.error("Account deletion failed:", error);
          alert("Account deletion failed");
        });
    },
  },
};
</script>

<style scoped>
.modal {
  display: block;
  position: fixed;
  z-index: 3;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0, 0, 0, 0.4);
}

.modal-content {
  background-color: #fefefe;
  margin: 15% auto;
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
  z-index: 4;
}

.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}

.background-image {
  position: relative;
  z-index: 1;
  width: 100%;
  height: 150px !important;
  background-size: cover;
  background-position: center;
}

.profile-icon {
  position: absolute;
  z-index: 2;
  width: 150px;
  height: 150px;
  border-radius: 50%;
  object-fit: cover;
  border: 2px solid #ddd;
  top: 0%;
  left: 2%;
}

.nickname-box {
  position: absolute;
  top: 50px;
  left: 200px;
  z-index: 2;
  background-color: white;
  padding: 10px;
  border-radius: 5px;
}

.nickname-overlay {
  color: black;
  font-size: 16px;
  z-index: 3;
}

.favorite-spots-box {
  border: 2px solid #ddd;
  padding: 10px;
  border-radius: 5px;
  margin-top: 20px;
}

.favorite-spots-box h2 {
  margin-top: 0;
}

.back-button {
  margin-top: 20px;
}
</style>
