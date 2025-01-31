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
        class="background-modal"
        @click.self="closeModal('background')"
      >
        <div class="background-modal-content">
          <span class="close" @click="closeModal('background')">&times;</span>
          <h2 class="h2text">背景画像をアップロード</h2>
          <form @submit.prevent="uploadCroppedImage">
            <input
              class="input-background"
              type="file"
              @change="onFileChange"
            />
            <div v-if="imageUrl">
              <vue-cropper
                ref="cropper"
                :src="imageUrl"
                :aspect-ratio="16 / 9"
                style="width: 100%; height: 400px"
              ></vue-cropper>
            </div>
            <button type="submit" class="background-modal-button">
              アップロード
            </button>
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
          <h2 class="h2text">プロフィール写真をアップロード</h2>
          <form @submit.prevent="uploadFile('profile')">
            <input
              class="input-profile"
              type="file"
              ref="profileFile"
              id="profileFile"
              name="profileFile"
            />
            <button type="submit" class="modal-button">アップロード</button>
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
          <h2 class="h2text">ニックネームを変更</h2>
          <form @submit.prevent="updateNickname">
            <div class="field">
              <p class="current-name">
                現在のニックネーム: {{ user.nickname }}
              </p>
              <label class="new-name" for="nickname"
                >ニックネーム変更後:
              </label>
              <input
                class="nickname"
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
        おすすめ観光スポット設定
      </button>
      <div
        v-if="modals.favoriteSpots"
        class="favorite-modal"
        @click.self="closeModal('favoriteSpots')"
      >
        <div class="modal-content">
          <span class="close" @click="closeModal('favoriteSpots')"
            >&times;</span
          >
          <h2 class="h2text">
            あなたのおすすめの観光スポットを入力してください
          </h2>
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
          <span class="close" @click="closeModal('deleteAccount')"
            >&times;</span
          >
          <h2 class="delete-text">アカウントを削除しますか？</h2>
          <form @submit.prevent="deleteAccount">
            <button type="submit" class="modal-button">削除</button>
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
import VueCropper from "vue-cropperjs";
import "cropperjs/dist/cropper.css";
import { useToast } from "vue-toastification";

export default {
  components: {
    VueCropper, // 画像のクロッピングコンポーネント
  },
  props: {
    userId: {
      type: Number,
      required: true, // userIdは必須のプロパティ
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
      imageUrl: null, // アップロードする画像のURL
    };
  },
  created() {
    this.fetchUser(); // コンポーネント作成時にユーザーデータを取得
  },
  methods: {
    goToIndex() {
      window.location.href = "/"; // ホームページにリダイレクト
    },
    fetchUser() {
      axios
        .get(`/user_profile/${this.userId}`) // ユーザーデータを取得
        .then((response) => {
          this.user = response.data; // 取得したデータをuserにセット
        })
        .catch((error) => {
          console.error("Failed to fetch user data:", error);
        });
    },
    openModal(modal) {
      console.log(`Opening modal: ${modal}`);
      this.modals[modal] = true; // 指定したモーダルを開く
    },
    closeModal(modal) {
      console.log(`Closing modal: ${modal}`);
      this.modals[modal] = false; // 指定したモーダルを閉じる
    },
    onFileChange(e) {
      const file = e.target.files[0];
      if (file) {
        this.imageUrl = URL.createObjectURL(file); // 選択したファイルのURLをセット
      }
    },
    uploadCroppedImage() {
      const toast = useToast();
      if (!this.imageUrl) {
        toast.error("ファイルを選択してください");
        return;
      }
      this.$refs.cropper.getCroppedCanvas().toBlob((blob) => {
        const formData = new FormData();
        formData.append("file", blob); // クロップした画像をフォームデータに追加

        axios
          .post(`/user_profile/upload_background_picture`, formData) // 背景画像をアップロード
          .then(() => {
            toast.success("アップロード成功");
            this.fetchUser(); // データを再取得
            this.closeModal("background");
            this.imageUrl = null; // アップロード後にimageUrlをリセット
          })
          .catch((error) => {
            console.error("File upload failed:", error);
            toast.error("アップロードに失敗しました");
          });
      });
    },
    uploadFile(type) {
      const toast = useToast();
      const fileInput = this.$refs[`${type}File`];
      if (fileInput && fileInput.files && fileInput.files[0]) {
        const formData = new FormData();
        formData.append("file", fileInput.files[0]); // 選択したファイルをフォームデータに追加

        axios
          .post(`/user_profile/upload_${type}_picture`, formData) // プロフィール画像をアップロード
          .then(() => {
            toast.success("アップロード成功");
            this.fetchUser(); // データを再取得
            this.closeModal(type);
          })
          .catch((error) => {
            console.error("File upload failed:", error);
            toast.error("アップロードに失敗しました");
          });
      } else {
        toast.error("ファイルを選択してください");
      }
    },
    updateNickname() {
      const toast = useToast();
      axios
        .patch("/user_profile/update_nickname", {
          application_user: { nickname: this.user.nickname }, // ニックネームを更新
        })
        .then(() => {
          toast.success("ニックネームが更新されました");
          this.fetchUser(); // データを再取得
          this.closeModal("nickname");
        })
        .catch((error) => {
          console.error("Nickname update failed:", error);
          toast.error("ニックネームの変更に失敗しました");
        });
    },
    updateFavoriteSpots() {
      const toast = useToast();
      axios
        .patch("/user_profile/update_text", {
          application_user: { favorite_spots: this.user.favorite_spots }, // お気に入りスポットを更新
        })
        .then(() => {
          toast.success("おすすめ観光スポットが更新されました");
          this.fetchUser(); // データを再取得
          this.closeModal("favoriteSpots");
        })
        .catch((error) => {
          console.error("Text update failed:", error);
          toast.error("お気に入りスポットの変更に失敗しました");
        });
    },
    deleteAccount() {
      const toast = useToast();
      const csrfToken = document
        .querySelector('meta[name="csrf-token"]')
        .getAttribute("content");
      axios
        .delete("/user_profile/destroy_account", {
          headers: {
            "X-CSRF-Token": csrfToken, // CSRFトークンをヘッダーに追加
          },
        })
        .then(() => {
          toast.success("アカウントが削除されました");
          window.location.href = "/sign-in"; // サインインページにリダイレクト
        })
        .catch((error) => {
          console.error("Account deletion failed:", error);
          toast.error("アカウント削除が失敗しました");
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
  top: 10px;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.4);
}
.modal-content {
  background-color: #fefefe;
  margin: 10% auto;
  padding: 20px;
  border: 1px solid #888;
  height: 40%;
  width: 60%;
  max-width: 600px;
  z-index: 4;
  position: relative;
}

.h2text {
  font-size: 20px;
  color: blue;
  text-align: center;
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
.modal-button {
  background-color: #007bff;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 5px;
  cursor: pointer;
  font-size: 16px;
  font-weight: bold;
  position: absolute;
  left: 0;
  right: 0;
  margin-left: auto;
  margin-right: auto;
  bottom: 20px;
  width: fit-content;
}
.modal-button:hover {
  background-color: #0056b3;
  color: yellow;
}

/* 背景 */
.background-modal {
  display: block;
  position: fixed;
  z-index: 3;
  left: 0;
  top: 0;
  width: 100%;
  height: 200%;
  background-color: rgba(0, 0, 0, 0.4);
}
.background-modal-content {
  background-color: #fefefe;
  margin: 5% auto;
  padding: 20px 20px 80px 20px;
  border: 1px solid #888;
  width: 80%;
  max-width: 600px;
  z-index: 4;
  position: relative;
  max-height: 90vh;
  overflow: auto;
}
.background-modal-button {
  background-color: #007bff;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 5px;
  cursor: pointer;
  font-size: 16px;
  font-weight: bold;
  position: absolute;
  text-align: center;
  float: fixed;
  left: 38%;
  bottom: 10px;
  width: fit-content;
}
.background-modal-button:hover {
  background-color: #0056b3;
  color: yellow;
}
.background-image {
  position: relative;
  z-index: 1;
  width: 100%;
  height: 200px !important;
  background-size: cover;
  background-position: center;
  object-fit: fill;
}
.background-button-container {
  display: flex;
}
.background-button {
  display: block;
  position: absolute;
  left: 19%;
  top: 60%;
  font-size: 30px;
}
.input-background {
  text-align: center;
  position: relative;
  left: 24%;
  margin-top: 20px;
}

/* プロフィール写真 */
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
.profile-button-container {
  display: flex;
}
.profile-button {
  display: block;
  position: absolute;
  left: 19%;
  top: 75%;
  font-size: 30px;
}
.input-profile {
  text-align: center;
  position: relative;
  left: 24%;
  margin-top: 20px;
}

/* ニックネーム */
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
.nickname-button-container {
  display: flex;
}
.nickname-button {
  display: block;
  position: absolute;
  right: 19%;
  top: 66%;
  font-size: 30px;
}
.current-name {
  position: relative;
  font-size: 20px;
  text-align: center;
}
.new-name {
  position: relative;
  font-size: 20px;
  left: 27%;
  text-align: center;
}
.nickname {
  width: 40%;
  left: 27%;
  position: relative;
  font-size: 20px;
}

/* お気に入りスポット */
.favorite-modal {
  display: block;
  position: fixed;
  z-index: 3;
  left: 0;
  top: 0;
  width: 100%;
  height: 120%;
  overflow: auto;
  background-color: rgba(0, 0, 0, 0.4);
}
.favorite-spots-box {
  border: 2px solid rgb(77, 77, 95);
  text-align: center;
  padding: 30px;
  height: 100px;
  overflow-y: auto;
}
.textarea {
  width: 100%;
  text-align: center;
  overflow-y: auto;
}
.favorite-button-container {
  display: flex;
}
.favorite-button {
  display: block;
  position: absolute;
  right: 19%;
  top: 57%;
  font-size: 30px;
}

/* アカウント削除ボタン */
.account-delete-button-container {
  display: flex;
}
.account-delete-button {
  display: block;
  position: absolute;
  right: 19%;
  top: 75%;
  font-size: 30px;
}
.delete-text {
  color: red;
  text-align: center;
  font-size: 30px;
  position: relative;
  top: 40px;
}

/* ボタン */
button {
  display: inline-block;
  width: auto;
  font-size: 18px;
  padding: 10px 20px;
  color: black;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: transform 0.2s;
  font-weight: bold;
}
button:hover {
  color: blue;
  transform: translateY(-5px);
}
/* 戻るボタン */
.back-button {
  position: fixed;
  bottom: 20px;
  right: 20px;
  background-color: black;
  color: white;
  padding: 10px 20px;
  border-radius: 5px;
  display: inline-block;
  transition: transform 0.2s;
}
.back-button:hover {
  color: yellow;
  transform: translateY(-5px);
}
</style>
