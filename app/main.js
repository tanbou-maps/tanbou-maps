import Vue from "vue";
import store from "./store"; // ストアをインポート

Vue.config.productionTip = false;

new Vue({
  store, // ストアを登録
}).$mount("#userprofilecrud");
