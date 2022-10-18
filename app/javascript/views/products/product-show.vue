<template>
  <div>
    <h1>{{ product.name }}</h1>

    <p>Id: {{ product.id }}</p>

    <router-link :to="{name: 'ProductEdit', params: {id: product.id && product.id.toString()}}"
                 class="btn btn-primary">Edit
    </router-link>
    <button @click="deleteProduct" class="btn btn-danger">Delete</button>
    <p @click="$router.go(-1)" class="btn btn-link">Back</p>
  </div>
</template>

<script>
export default {
  name: "ProductShow",
  props: {
    id: String
  },
  data: () => ({
    product: {}
  }),
  mounted() {
    fetch(`/api/products/${this.id}`)
    .then((data) => data.json())
    .then((data) => this.product = data)
  },
  methods: {
    deleteProduct: function () {
      fetch(`/api/products/${this.id}`, {method: 'DELETE'})
      .then((res) => {
        if (res.ok) this.$router.push({name: 'Products'})
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
