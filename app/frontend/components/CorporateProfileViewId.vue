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
.background-image {
  position: relative;
  z-index: 1;
  width: 100%;
  height: 150px !important;
  background-size: cover;
  background-position: center;
  object-fit: cover;
}

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
.favorite-text {
  font-size: 15px;
  color: blue;
}

/* indexページ遷移用ボタン */
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
