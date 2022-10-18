<template>
  <div>
    <div v-if="error" class="alert alert-danger">{{ error.data.error }}</div>

    <h1>Sign in</h1>

    <input type="text" v-model="email" placeholder="Email" class="form-control mb-2">
    <input type="password" v-model="password" placeholder="Password" class="form-control mb-2">
    <div>
      <input type="checkbox" v-model="remember">
      <label>Remember me</label>
    </div>

    <button @click="loginSend" class="btn btn-primary">Sign in</button>
  </div>
</template>

<script>
import {mapActions, mapGetters} from 'vuex'

export default {
  name: "Login",
  data: () => ({
    email: "",
    password: "",
    remember: false
  }),
  computed: {
    ...mapGetters('auth', ['loading', 'error'])
  },
  methods: {
    ...mapActions('auth', ['loginParams']),
    loginSend: async function () {
      await this.loginParams({
        user: {
          email: this.email,
          password: this.password,
          remember_me: this.remember
        }
      })

      if (!this.error) this.$router.push('/')
    }
  }
}
</script>

<style scoped>

</style>
