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
  mounted() {
    fetch(`/api/widgets/${this.id}`)
    .then((res) => res.json())
    .then((data) => this.widget = data)

    fetch('/api/products')
    .then((res) => res.json())
    .then((data) => this.products = data)
  },
  methods: {
    updateWidget: function () {
      const body = {
        name: this.widget.name,
        product_id: this.widget.product_id
      }

      fetch(`/api/widgets/${this.id}`, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          Accept: 'application/json'
        },
        body: JSON.stringify(body)
      })
      .then((res) => {
        if (res.ok) this.$router.push({name: 'WidgetShow', params: {id: this.id}})
        else res.json().then((data) => {
          const entries = Object.entries(data)
          this.error = entries.map((e) => `${e[0]} ${e[1]}`).join('\n')
        })
      })
    }
  }
}
</script>
