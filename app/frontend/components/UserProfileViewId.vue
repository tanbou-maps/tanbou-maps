<!-- filepath: /c:/Users/admin/Rails/tanbou-maps/app/views/user_profile/ProfileView.vue -->
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

    <!-- おすすめ観光スポット表示エリア -->
    <h2 class="h2text">おすすめ観光スポット</h2>
    <div class="favorite-spots-box">
      <div id="displayText">
        <p>{{ user.favorite_spots }}</p>
      </div>
    </div>

    <br />
    <!-- 戻るボタン -->
    <div class="back-button">
      <a :href="rootPath">戻る</a>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    user: {
      type: Object,
      required: true,
    },
    rootPath: {
      type: String,
      required: true,
    },
  },
};
</script>

<style scoped>
/* 背景画像 */
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

.favorite-spots-box {
  /* border: 2px solid #ddd; */
  text-align: center;
  padding: 30px;
  height: 100px; /* 固定の高さを設定 */
  overflow-y: auto; /* 垂直方向にスクロールバーを表示 */
  color: black;
  font-family: monospace;
  font-size: 25px;
}

.h2text {
  font-size: 35px;
  font-family: monospace;
  color: rgb(240, 125, 54);
  text-align: center;
  margin-top: 40px;
}
</style>
