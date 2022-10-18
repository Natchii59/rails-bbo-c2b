<template>
  <div>
    <div v-if="error" class="alert alert-danger">{{ error }}</div>

    <h1>Edit Product</h1>

    <input type="text" v-model="product.name" class="form-control mb-2">

    <button @click="updateProduct" class="btn btn-primary mb-2">Update Product</button>
    <p @click="$router.go(-1)" class="btn btn-link">
      Back</p>
  </div>
</template>

<script>
export default {
  name: "ProductEdit",
  props: {
    id: String,
  },
  data: () => ({
    error: null,
    product: {},
  }),
  mounted() {
    fetch(`/api/products/${this.id}`)
    .then((data) => data.json())
    .then((product) => this.product = product)
  },
  methods: {
    updateProduct: function () {
      const body = {
        name: this.product.name
      }

      fetch(`/api/products/${this.id}`, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          Accept: 'application/json'
        },
        body: JSON.stringify(body)
      })
      .then((res) => {
        if (res.ok) this.$router.push({name: 'ProductShow', params: {id: this.id}})
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
.link {
  cursor: pointer;
  text-decoration: underline;
}
</style>
