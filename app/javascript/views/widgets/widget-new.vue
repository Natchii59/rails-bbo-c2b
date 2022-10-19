<template>
  <div>
    <div v-if="error" class="alert alert-danger">{{ error }}</div>

    <h1>New widget</h1>

    <input type="text" placeholder="Name" v-model="name" class="form-control mb-2">
    <select v-if="products" v-model="product_id" class="form-control mb-2">
      <option v-for="product in products" :key="product.id" :value="product.id">
        {{ product.name }} ({{ product.id }})
      </option>
    </select>
    <router-link v-else :to="{name: 'ProductNew'}">Please create a product before</router-link>

    <button @click="createWidget" class="btn btn-primary" :disabled="disable">Create widget</button>
  </div>
</template>

<script>
export default {
  name: "WidgetNew",
  data: () => ({
    error: null,
    disable: false,
    name: "",
    product_id: null,
    products: []
  }),
  async mounted() {
    const res = await fetch('/api/products')
    this.products = await res.json()

    if (!this.products.length) {
      this.error = 'Please create a product before'
      this.disable = true
    }
  },
  methods: {
    createWidget: async function () {
      const body = {
        name: this.name,
        product_id: this.product_id
      }

      const res = await fetch('/api/widgets', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Accept: 'application/json'
        },
        body: JSON.stringify(body)
      })

      const data = await res.json()

      if (res.ok) return this.$router.push({name: 'WidgetShow', params: {id: data.id.toString()}})

      const entries = Object.entries(data)
      this.error = entries.map((e) => `${e[0]} ${e[1]}`).join('\n')
    }
  }
}
</script>

<style scoped>

</style>
