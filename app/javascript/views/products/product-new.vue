<template>
  <div>
    <div v-if="error" class="alert alert-danger">{{ error }}</div>

    <h1>Create new Product</h1>

    <input type="text" v-model="name" class="form-control mb-2">

    <button @click="createProduct" class="btn btn-primary">Create</button>
  </div>
</template>

<script>
export default {
  name: "ProductNew",
  data: () => ({
    error: null,
    name: ''
  }),
  methods: {
    createProduct: function () {
      const body = {
        name: this.name
      }

      fetch('/api/products', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Accept: 'application/json'
        },
        body: JSON.stringify(body)
      }).then((res) => {
        if (res.status === 201) res.json()
        .then((data) => {
          this.$router.push({name: 'ProductShow', params: {id: data.id.toString()}})
        })
        else res.json().then((data) => {
          const entries = Object.entries(data)
          this.error = entries.map((e) => `${e[0]} ${e[1]}`).join('\n')
        })
      })
    }
  }
}
</script>

<style scoped>

</style>
