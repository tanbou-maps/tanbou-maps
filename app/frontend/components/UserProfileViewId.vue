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
      required: true, // userプロパティは必須
    },
    rootPath: {
      type: String,
      required: true, // rootPathプロパティは必須
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
  object-fit: cover;
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

.favorite-spots-box {
  text-align: center;
  padding: 30px;
  height: 100px;
  overflow-y: auto;
  color: black;
  font-family: monospace;
  font-size: 25px;
}

.h2text {
  font-size: 35px;
  font-family: monospace;
  color: blue;
  text-align: center;
  margin-top: 40px;
}
</style>
