const state = {
  profiles: JSON.parse(localStorage.getItem("profiles")) || [],
};

const getters = {
  profiles: (state) => state.profiles.sort((a, b) => b.id - a.id),
};

const mutations = {
  setProfiles: (state, profiles) => {
    state.profiles = profiles;
    localStorage.setItem("profiles", JSON.stringify(state.profiles));
  },
  appendProfile: (state, profile) => {
    state.profiles = [...state.profiles, profile];
    localStorage.setItem("profiles", JSON.stringify(state.profiles));
  },
  removeProfile: (state, id) => {
    state.profiles = state.profiles.filter((profile) => profile.id !== id);
    localStorage.setItem("profiles", JSON.stringify(state.profiles));
  },
};

const actions = {
  fetchProfiles({ commit }) {
    const profiles = JSON.parse(localStorage.getItem("profiles")) || [];
    commit("setProfiles", profiles);
  },
  createProfile({ commit }, profile) {
    commit("appendProfile", profile);
  },
  deleteProfile({ commit }, id) {
    commit("removeProfile", id);
  },
  async uploadImage({ commit }, formData) {
    try {
      const response = await fetch(
        "http://localhost:3000/api/user_profile/upload",
        {
          method: "POST",
          body: formData,
        },
      );
      const data = await response.json();
      commit("appendProfile", data);
    } catch (e) {
      console.error(e);
    }
  },
};

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
};
