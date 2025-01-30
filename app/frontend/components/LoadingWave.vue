<template>
  <div class="loading-overlay">
    <div class="loading-wave">
      <div v-for="n in 5" :key="n"></div>
    </div>
  </div>
</template>

<script>
export default {
  name: "LoadingWave",
};
</script>

<style scoped>
/* 🔹 ローディング時の背景オーバーレイ */
.loading-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background: rgba(0, 0, 0, 0.5); /* 半透明の暗い背景 */
  display: flex;
  justify-content: flex-end; /* 右寄せ */
  align-items: flex-end; /* 下寄せ */
  padding: 20px;
  z-index: 9999; /* すべての要素の最前面に */
}

/* 🔹 ローディングアイコン */
.loading-wave {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 4px;
  background: rgba(255, 255, 255, 0.9); /* 白い背景 */
  padding: 10px 15px;
  border-radius: 10px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
}

/* 🔹 アニメーション */
.loading-wave div {
  width: 5px;
  height: 20px;
  background-color: #3498db;
  animation: wave 1.2s infinite ease-in-out;
}

.loading-wave div:nth-child(1) { animation-delay: -1.1s; }
.loading-wave div:nth-child(2) { animation-delay: -1s; }
.loading-wave div:nth-child(3) { animation-delay: -0.9s; }
.loading-wave div:nth-child(4) { animation-delay: -0.8s; }
.loading-wave div:nth-child(5) { animation-delay: -0.7s; }

@keyframes wave {
  0%, 100% {
    transform: scaleY(1);
  }
  50% {
    transform: scaleY(2);
  }
}
</style>
