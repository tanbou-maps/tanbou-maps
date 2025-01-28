<!-- filepath: /c:/Users/admin/Rails/tanbou-maps/app/frontend/components/UserProfile.vue -->
<template>
  <div>
    <!-- 背景画像 -->
    <div v-if="user.background_picture_url" class="background-container">
      <img
        :src="user.background_picture_url"
        alt="Uploaded Image"
        class="background-image"
      />
    </div>

    <!-- ニックネーム -->
    <div class="nickname-box">
      <div class="nickname-overlay">{{ user.nickname }}</div>
    </div>

    <!-- プロフィール写真 -->
    <div v-if="user.profile_picture_url">
      <img
        :src="user.profile_picture_url"
        alt="Profile Image"
        class="profile-icon"
      />
    </div>

    <!-- おすすめ観光スポット表示 -->
    <div class="favorite-spots-box">
      <h2 class="h2text">おすすめ観光スポット</h2>
      <div id="displayText">
        <p>{{ user.favorite_spots }}</p>
      </div>
    </div>

    <div class="button-container">
      <!-- 背景画像のモーダルウィンドウ -->
      <button class="background-button" @click="openModal('background')">
        背景設定
      </button>
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

      <!-- プロフィール画像用のモーダルウィンドウ -->
      <button class="profile-button" @click="openModal('profile')">
        プロフィール写真設定
      </button>
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

      <!-- ニックネーム変更用のモーダルウィンドウ -->
      <button class="nickname-button" @click="openModal('nickname')">
        ニックネーム変更
      </button>
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

      <!-- おすすめ観光スポット用のモーダルウィンドウ -->
      <button class="favorite-button" @click="openModal('favoriteSpots')">
        おすすめ観光スポット設定
      </button>
      <div
        v-if="modals.favoriteSpots"
        class="modal"
        @click.self="closeModal('favoriteSpots')"
      >
        <div class="modal-content">
          <span class="close" @click="closeModal('favoriteSpots')"
            >&times;</span
          >
          <h2>あなたのおすすめの観光スポットを入力してください</h2>
          <form @submit.prevent="updateFavoriteSpots">
            <div class="field">
              <textarea
                v-model="user.favorite_spots"
                id="favoriteSpots"
                name="favoriteSpots"
                rows="5"
              ></textarea>
            </div>
            <button type="submit">送信</button>
          </form>
        </div>
      </div>

      <!-- アカウント削除用のモーダルウィンドウ -->
      <button class="account-delete-button" @click="openModal('deleteAccount')">
        アカウント削除
      </button>
      <div
        v-if="modals.deleteAccount"
        class="modal"
        @click.self="closeModal('deleteAccount')"
      >
        <div class="modal-content">
          <span class="close" @click="closeModal('deleteAccount')"
            >&times;</span
          >
          <h2>アカウントを削除しますか？</h2>
          <form @submit.prevent="deleteAccount">
            <button type="submit">削除</button>
          </form>
        </div>
      </div>
    </div>
  </div>

  <!-- indexぺージに遷移 -->
  <button class="back-button" @click="goToIndex">戻る</button>
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
    goToIndex() {
      window.location.href = "/";
    },
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
/* モーダルウィンドウ */
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
  width: 50%; /* 幅を50%に変更して横幅を狭くする */
  max-width: 600px; /* 最大幅を600pxに設定 */
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
  height: 200px !important;
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
  top: 4%;
  left: 2%;
}

.nickname-box {
  position: absolute;
  top: 74px;
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
  text-align: center;
  padding: 30px;
  height: 100px; /* 固定の高さを設定 */
  overflow-y: auto; /* 垂直方向にスクロールバーを表示 */
}

.h2text {
  font-size: 20px;
  color: rgb(240, 125, 54);
}

.button-container {
}

/* 背景設定ボタン */
.background-button-container {
  display: flex;
}
.background-button {
  display: block; /* ブロック要素にする */
  position: absolute;
  left: 19%;
  top: 60%;
  font-size: 30px;
}

/* プロフィール設定ボタン */
.profile-button-container {
  display: flex;
}
.profile-button {
  display: block; /* ブロック要素にする */
  position: absolute;
  left: 19%;
  top: 75%;
  font-size: 30px;
}

/* おすすめスポットボタン */
.favorite-button-container {
  display: flex;
}
.favorite-button {
  display: block; /* ブロック要素にする */
  position: absolute;
  right: 19%;
  top: 55%;
  font-size: 30px;
}

/* ニックネームボタン */
.nickname-button-container {
  display: flex;
}
.nickname-button {
  display: block; /* ブロック要素にする */
  position: absolute;
  right: 19%;
  top: 65%;
  font-size: 30px;
}

/* アカウント削除ボタン */
.account-delete-button-container {
  display: flex;
}
.account-delete-button {
  display: block; /* ブロック要素にする */
  position: absolute;
  right: 19%;
  top: 75%;
  font-size: 30px;
}

/* ボタン */
button {
  display: inline-block; /* ボタンをインラインブロック要素にする */
  width: auto; /* ボタンの幅を自動にする */
  font-size: 18px;
  padding: 10px 20px;
  color: black; /* テキストの色を黒に設定 */
  border: none; /* ボーダーを削除 */
  border-radius: 5px; /* 角を丸くする */
  cursor: pointer; /* カーソルをポインターに変更 */
  transition: transform 0.2s; /* トランジションを追加 */
  font-weight: bold; /* フォントを太くする */
}
button:hover {
  color: blue; /* ホバー時のテキスト色を青に設定 */
  transform: translateY(-5px); /* ホバー時に浮かせる */
}

/* indexページ遷移用ボタン */
.back-button {
  position: fixed; /* 固定位置にする */
  bottom: 20px; /* 下から20pxの位置に配置 */
  right: 20px; /* 右から20pxの位置に配置 */
  background-color: black; /* 背景色を黒に設定 */
  color: white; /* テキストの色を白に設定 */
  padding: 10px 20px; /* ボックスの内側の余白を追加 */
  border-radius: 5px; /* 角を丸くする */
  display: inline-block; /* ボックスをインラインブロックにする */
  transition: transform 0.2s; /* トランジションを追加 */
}
.back-button:hover {
  color: yellow;
  transform: translateY(-5px); /* ホバー時に浮かせる */
}
</style>
