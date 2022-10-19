<template>
  <div>
    <div v-if="error" class="alert alert-danger">{{ error }}</div>

    <h1>Edit widget</h1>

    <input type="text" placeholder="Name" v-model="widget.name" class="form-control mb-2">
    <select v-model="widget.product_id" class="form-control mb-2">
      <option v-for="product in products" :key="product.id" :value="product.id">
        {{ product.name }} ({{ product.id }})
      </option>
    </select>

    <button @click="updateWidget" class="btn btn-primary mb-2">Update widget</button>

    <div @click="$router.go(-1)" class="btn btn-link">Back</div>
  </div>
</template>

<script>
export default {
  name: "WidgetEdit",
  props: {
    id: String
  },
  data: () => ({
    error: null,
    widget: {},
    products: {}
  }),
  async mounted() {
    const resWidget = await fetch(`/api/widgets/${this.id}`)

    if ([403, 404].includes(resWidget.status)) return this.$router.push('/widgets')

    this.widget = await resWidget.json()

    const resProducts = await fetch('/api/products')
    this.products = await resProducts.json()
  },
  methods: {
    updateWidget: async function () {
      const body = {
        name: this.widget.name,
        product_id: this.widget.product_id
      }

      const res = await fetch(`/api/widgets/${this.id}`, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          Accept: 'application/json'
        },
        body: JSON.stringify(body)
      })
      if (res.ok) return this.$router.push({name: 'WidgetShow', params: {id: this.id}})

      const data = await res.json()

      const entries = Object.entries(data)
      this.error = entries.map((e) => `${e[0]} ${e[1]}`).join('\n')
    }
  }
};
</script>
