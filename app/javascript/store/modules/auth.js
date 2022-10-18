export default {
  namespaced: true,
  state: {
    user: null,
    loading: null,
    error: null
  },
  getters: {
    user: state => state.user,
    loading: state => state.loading,
    error: state => state.error
  },
  mutations: {
    setUser: function (state, user) {
      state.user = user
    },
    setLoading: function (state, loading) {
      state.loading = loading
    },
    setError: function (state, error) {
      state.error = error
    }
  },
  actions: {
    loginSession: async ({commit}) => {
      commit('setLoading', true)
      commit('setError', null)

      const res = await fetch('/users/sign_in', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Accept: 'application/json'
        }
      })

      const data = await res.json()

      commit('setLoading', false)

      if (!res.ok) commit('setError', {status: res.status, data})
      else commit('setUser', data)
    },
    loginParams: async ({commit}, user) => {
      commit('setLoading', true)
      commit('setError', null)

      const res = await fetch('/users/sign_in', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Accept: 'application/json'
        },
        body: JSON.stringify(user)
      })

      const data = await res.json()

      commit('setLoading', false)

      if (!res.ok) commit('setError', {status: res.status, data})
      else commit('setUser', data)
    },
    logout: ({commit}) => {
      return fetch('/users/sign_out', {
        method: 'DELETE',
        headers: {
          Accept: 'application/json'
        }
      }).then(() => {
        commit('setUser', null)
      })
    }
  }
}
