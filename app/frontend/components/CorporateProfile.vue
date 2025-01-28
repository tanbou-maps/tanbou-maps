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

    <!-- おすすめ観光スポット表示 -->
    <div class="favorite-spots-box">
      <h2 class="favorite-text">自慢ポイント、おすすめスポット</h2>
      <div id="displayText" v-html="formattedFavoriteSpots"></div>
    </div>

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
        <h2 class="h2text">背景画像をアップロード</h2>
        <form @submit.prevent="uploadCroppedImage">
          <input type="file" @change="onFileChange" />
          <div v-if="imageUrl">
            <vue-cropper
              ref="cropper"
              :src="imageUrl"
              :aspect-ratio="16 / 9"
              style="width: 100%; height: 400px"
            ></vue-cropper>
          </div>
          <button type="submit" class="modal-button">アップロード</button>
        </form>
      </div>
    </div>

    <!-- ニックネーム変更用のモーダルウィンドウ -->
    <button class="nickname-button" @click="openModal('nickname')">
      名前変更
    </button>
    <div
      v-if="modals.nickname"
      class="modal"
      @click.self="closeModal('nickname')"
    >
      <div class="modal-content">
        <span class="close" @click="closeModal('nickname')">&times;</span>
        <h2 class="h2text">ニックネームを変更</h2>
        <form @submit.prevent="updateNickname">
          <div class="field">
            <p>現在のニックネーム: {{ user.nickname }}</p>
            <label for="nickname">ニックネーム変更後</label>
            <input
              type="text"
              v-model="user.nickname"
              id="nickname"
              name="nickname"
            />
          </div>
          <button type="submit" class="modal-button">更新</button>
        </form>
      </div>
    </div>

    <!-- おすすめ観光スポット用のモーダルウィンドウ -->
    <button class="favorite-button" @click="openModal('favoriteSpots')">
      自慢ポイント、おすすめスポット設定
    </button>
    <div
      v-if="modals.favoriteSpots"
      class="modal"
      @click.self="closeModal('favoriteSpots')"
    >
      <div class="modal-content">
        <span class="close" @click="closeModal('favoriteSpots')">&times;</span>
        <h2 class="h2text">あなたのおすすめの観光スポットを入力してください</h2>
        <form @submit.prevent="updateFavoriteSpots">
          <div class="field">
            <textarea
              class="textarea"
              v-model="user.favorite_spots"
              id="favoriteSpots"
              name="favoriteSpots"
              rows="5"
            ></textarea>
          </div>
          <button type="submit" class="modal-button">送信</button>
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
        <span class="close" @click="closeModal('deleteAccount')">&times;</span>
        <h2 class="delete-text">アカウントを削除しますか？</h2>
        <form @submit.prevent="deleteAccount">
          <button type="submit" class="modal-button">削除</button>
        </form>
      </div>
    </div>
  </div>

  <!-- indexぺージに遷移 -->
  <button class="back-button" @click="goToIndex">戻る</button>
</template>

<script>
import axios from "axios";
import VueCropper from "vue-cropperjs";
import "cropperjs/dist/cropper.css";

export default {
  components: {
    VueCropper,
  },
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
      imageUrl: null,
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
    onFileChange(e) {
      const file = e.target.files[0];
      if (file) {
        this.imageUrl = URL.createObjectURL(file);
      }
    },
    uploadCroppedImage() {
      if (!this.imageUrl) {
        alert("ファイルを選択してください");
        return;
      }
      this.$refs.cropper.getCroppedCanvas().toBlob((blob) => {
        if (!blob) {
          alert("ファイルを選択してください");
          return;
        }
        const formData = new FormData();
        formData.append("file", blob);

        axios
          .post(`/user_profile/upload_background_picture`, formData)
          .then(() => {
            // alert("File uploaded successfully");
            this.fetchUser(); // データを再取得
            this.closeModal("background");
          })
          .catch((error) => {
            console.error("File upload failed:", error);
            alert("File upload failed");
          });
      });
    },
    uploadFile(type) {
      const fileInput = this.$refs[`${type}File`];
      if (fileInput && fileInput.files && fileInput.files[0]) {
        const formData = new FormData();
        formData.append("file", fileInput.files[0]);

        axios
          .post(`/user_profile/upload_${type}_picture`, formData)
          .then(() => {
            // alert("File uploaded successfully");
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
          // alert("ニックネームが更新されました");
          this.fetchUser(); // データを再取得
          this.closeModal("nickname");
        })
        .catch((error) => {
          console.error("Nickname update failed:", error);
          alert("ニックネームの変更に失敗しました");
        });
    },
    updateFavoriteSpots() {
      axios
        .patch("/user_profile/update_text", {
          application_user: { favorite_spots: this.user.favorite_spots },
        })
        .then(() => {
          // alert("テキストが送信されました");
          this.fetchUser(); // データを再取得
          this.closeModal("favoriteSpots");
        })
        .catch((error) => {
          console.error("Text update failed:", error);
          alert("テキストの変更に失敗しました");
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
          // alert("アカウントが削除されました");
          window.location.href = "/sign-in"; // サインインページのURLに変更
        })
        .catch((error) => {
          console.error("Account deletion failed:", error);
          alert("アカウント削除が失敗しました");
        });
    },
  },
  computed: {
    formattedFavoriteSpots() {
      return this.user.favorite_spots
        ? this.user.favorite_spots.replace(/\n/g, "<br>")
        : "";
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

/* 背景 */
.background-image {
  position: relative;
  z-index: 1;
  width: 100%;
  height: 150px !important;
  background-size: cover;
  background-position: center;
  object-fit: cover;
}
.background-button {
  display: block; /* ブロック要素にする */
  margin-bottom: 10px; /* 下に余白を追加 */
}

/* ニックネーム */
.nickname-box {
  position: absolute;
  top: 15%;
  left: 50%;
  transform: translate(-50%, -50%);
  z-index: 2;
  padding: 10px;
  border-radius: 5px;
}
.nickname-overlay {
  color: white;
  font-size: 60px;
  font-weight: bolder;
  z-index: 3;
}
.nickname-button {
  display: block; /* ブロック要素にする */
  margin-bottom: 10px; /* 下に余白を追加 */
}

/* おすすめ観光スポット */
.favorite-spots-box {
  position: fixed;
  right: 2px;
  padding-left: 60px;
  padding-right: 75px;
  padding-bottom: 365px;
  padding-top: 10px;
  border-radius: 5px;
  margin: 0 0 0 900px;
  text-align: center;
  background-color: rgb(226, 227, 222);
  white-space: pre-wrap; /* 改行を反映させる */
}
.h2text {
  font-size: 20px;
  color: blue;
}
.textarea {
  width: 100%;
}
.favorite-button {
  display: block; /* ブロック要素にする */
  margin-bottom: 10px; /* 下に余白を追加 */
}
.favorite-text {
  font-size: 15px;
  color: blue;
}

/* アカウント削除 */
.account-delete-button {
  top: 100%;
}
.delete-text {
  color: red;
}

/* ボタン全般 */
button {
  display: block; /* ボタンをブロック要素にする */
  width: auto; /* ボタンの幅を自動にする */
  font-size: 18px;
  padding: 10px 20px;
  color: black; /* テキストの色を白に設定 */
  border: none; /* ボーダーを削除 */
  border-radius: 5px; /* 角を丸くする */
  cursor: pointer; /* カーソルをポインターに変更 */
  transition: transform 0.2s; /* トランジションを追加 */
  font-weight: bold; /* フォントを太くする */
}
button:hover {
  color: blue; /* ホバー時の背景色を濃い青に設定 */
  transform: translateY(-5px); /* ホバー時に浮かせる */
}

/* モーダル内のボタン */
.modal-button {
  background-color: #007bff; /* ボタンの背景色を設定 */
  color: white; /* テキストの色を白に設定 */
  border: none; /* ボーダーを削除 */
  padding: 10px 20px; /* ボタンの内側の余白を設定 */
  border-radius: 5px; /* 角を丸くする */
  cursor: pointer; /* カーソルをポインターに変更 */
  font-size: 16px; /* フォントサイズを設定 */
  font-weight: bold; /* フォントを太くする */
  transition: background-color 0.3s ease; /* 背景色のトランジションを追加 */
}
.modal-button:hover {
  background-color: #0056b3; /* ホバー時の背景色を変更 */
  color: yellow;
}

/* 戻るボタン */
.back-button {
  margin-top: 20px;
  position: fixed; /* 固定位置にする */
  bottom: 20px; /* 下から20pxの位置に配置 */
  right: 30%; /* 右から20pxの位置に配置 */
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
