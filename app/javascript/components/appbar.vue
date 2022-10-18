<template>
  <div class="m-0 p-2 d-flex justify-content-between align-items-center" style="gap: 1rem">
    <h3>Click2Buy</h3>

    <div style="flex: 1"/>

    <p v-if="user" class="m-0">{{ user.email }}</p>

    <button v-if="user" @click="logout" class="btn btn-danger">Logout</button>
  </div>
</template>

<script>
import {mapActions, mapGetters} from "vuex";

export default {
  name: "Appbar",
  computed: {
    ...mapGetters('auth', ['user'])
  },
  methods: {
    ...mapActions('auth', ['logout'])
  }
}
</script>

<style scoped>

</style>
