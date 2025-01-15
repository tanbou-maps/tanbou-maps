import Vue from "vue";
import Vuex from "vuex";
import userProfile from "./modules/userProfile"; // モジュールをインポート

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    userProfile,
  },
});
