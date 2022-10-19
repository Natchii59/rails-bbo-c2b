<template>
  <div>
    <h1>{{ widget.name }}</h1>

    <p>Id: {{ widget.id }}</p>
    <p>Product: {{ widget.product && widget.product.name }}</p>

    <router-link :to="{name: 'WidgetEdit', params: {id}}" class="btn btn-primary">Edit</router-link>
    <button @click="deleteWidget" class="btn btn-danger">Delete</button>

    <div @click="$router.go(-1)" class="btn btn-link">Back</div>
  </div>
</template>

<script>
export default {
  name: "WidgetShow",
  props: {
    id: String
  },
  data: () => ({
    widget: {}
  }),
  async mounted() {
    const res = await fetch(`/api/widgets/${this.id}`)

    if ([403, 404].includes(res.status)) return this.$router.push('/widgets')

    this.widget = await res.json()
  },
  methods: {
    deleteWidget: async function () {
      const res = await fetch(`/api/widgets/${this.id}`, {method: 'DELETE'})

      if (res.status === 403 || res.ok) this.$router.push({name: 'Widgets'})
    }
  }
}
</script>
