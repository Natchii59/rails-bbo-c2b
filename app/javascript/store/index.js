import Vue from "vue";
import Vuex from 'vuex'

import auth from "./modules/auth";
import {abilityPlugin} from "./ability";

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    auth
  },
  plugins: [abilityPlugin]
})
