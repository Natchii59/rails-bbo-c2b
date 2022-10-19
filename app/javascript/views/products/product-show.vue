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
  async mounted() {
    const res = await fetch(`/api/products/${this.id}`)

    if ([403, 404].includes(res.status)) return this.$router.push('/products')

    this.product = await res.json()
  },
  methods: {
    deleteProduct: async function () {
      const res = await fetch(`/api/products/${this.id}`, {method: 'DELETE'})

      if (res.status === 403 || res.ok) this.$router.push({name: 'Products'})
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
