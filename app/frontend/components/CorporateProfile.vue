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
      class="background-modal"
      @click.self="closeModal('background')"
    >
      <div class="background-modal-content">
        <span class="close" @click="closeModal('background')">&times;</span>
        <h2 class="h2text">背景画像をアップロード</h2>
        <form @submit.prevent="uploadCroppedImage">
          <input class="input-background" type="file" @change="onFileChange" />
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
            <p class="current-name">現在のニックネーム: {{ user.nickname }}</p>
            <label class="new-name" for="nickname">ニックネーム変更後: </label>
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
import { useToast } from "vue-toastification";

export default {
  // コンポーネントの登録
  components: {
    VueCropper, // 画像のクロッピングコンポーネント
  },
  // プロパティの定義
  props: {
    userId: {
      type: Number,
      required: true, // userIdは必須のプロパティ
    },
  },

  data() {
    return {
      // ユーザーデータを管理
      user: {
        background_picture_url: null,
        profile_picture_url: null,
        favorite_spots: null,
        nickname: "",
      },
      // モーダルの表示状態を管理
      modals: {
        background: false,
        profile: false,
        nickname: false,
        favoriteSpots: false,
        deleteAccount: false,
      },
      // クロップした画像のURLを管理
      imageUrl: null,
    };
  },
  // コンポーネント作成時にユーザーデータを取得
  created() {
    this.fetchUser();
  },
  methods: {
    // ホームページにリダイレクト
    goToIndex() {
      window.location.href = "/";
    },
    fetchUser() {
      axios
        // ユーザーデータを取得
        .get(`/user_profile/${this.userId}`)
        // 取得したデータをuserにセット
        .then((response) => {
          this.user = response.data;
        })
        .catch((error) => {
          console.error("Failed to fetch user data:", error);
        });
    },
    // 指定したモーダルを開く
    openModal(modal) {
      this.modals[modal] = true;
    },
    // 指定したモーダルを閉じる
    closeModal(modal) {
      this.modals[modal] = false;
    },
    // 選択したファイルのURLをセット
    onFileChange(e) {
      const file = e.target.files[0];
      console.log(file);
      if (file) {
        this.imageUrl = URL.createObjectURL(file);
      }
    },
    uploadCroppedImage() {
      const toast = useToast();
      // ファイルが選択されているか確認
      if (!this.imageUrl) {
        toast.error("ファイルを選択してください");
        return;
      }
      // クロップした画像をBlob形式に変換
      this.$refs.cropper.getCroppedCanvas().toBlob((blob) => {
        if (!blob) {
          toast.error("ファイルを選択してください");
          return;
        }
        // フォームデータを作成
        const formData = new FormData();
        // クロップした画像をフォームデータに追加
        formData.append("file", blob);

        // 背景画像をアップロード
        axios
          .post(`/user_profile/upload_background_picture`, formData)
          .then(() => {
            toast.success("アップロード成功");
            // ユーザーデータを再取得
            this.fetchUser();
            // モーダルを閉じる
            this.closeModal("background");
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
  computed: {
    formattedFavoriteSpots() {
      // favorite_spotsが存在する場合、改行を<br>タグに置換して返す
      return this.user.favorite_spots
        ? this.user.favorite_spots.replace(/\n/g, "<br>")
        : ""; // 存在しない場合は空文字を返す
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
  width: 60%; /* 幅を50%に変更して横幅を狭くする */
  max-width: 600px; /* 最大幅を600pxに設定 */
  z-index: 4;
  position: relative; /* 相対位置に変更 */
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
  position: absolute;
  left: 0;
  right: 0;
  margin-left: auto;
  margin-right: auto;
  bottom: 20px; /* 下端から20pxの位置に配置 */
  width: fit-content; /* ボタンの幅を内容に合わせる */
}
.modal-button:hover {
  background-color: #0056b3; /* ホバー時の背景色を変更 */
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
  display: block; /* ブロック要素にする */
  position: absolute;
  left: 10%;
  top: 51%;
  font-size: 30px;
}
.input-background {
  text-align: center;
  position: relative;
  left: 24%;
  margin-top: 20px;
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
.nickname-button-container {
  display: flex;
}
.nickname-button {
  display: block; /* ブロック要素にする */
  position: absolute;
  left: 10%;
  top: 70%;
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
  /* text-align: center; */
}

/* おすすめ観光スポット */
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
.textarea {
  width: 100%;
  text-align: center;
  overflow-y: auto; /* 垂直方向にスクロールバーを表示 */
}
.favorite-button {
  display: block; /* ブロック要素にする */
  position: absolute;
  right: 40%;
  top: 51%;
  font-size: 30px;
}
.favorite-text {
  font-size: 15px;
  color: blue;
}

/* アカウント削除ボタン */
.account-delete-button-container {
  display: flex;
}
.account-delete-button {
  display: block; /* ブロック要素にする */
  position: absolute;
  right: 40%;
  top: 70%;
  font-size: 30px;
}
.delete-text {
  color: red;
  text-align: center;
  font-size: 30px;
  position: relative;
  top: 40px;
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
