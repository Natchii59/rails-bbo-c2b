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
  mounted() {
    fetch(`/api/widgets/${this.id}`)
    .then((res) => res.json())
    .then((data) => this.widget = data)
  },
  methods: {
    deleteWidget: function () {
      fetch(`/api/widgets/${this.id}`, {method: 'DELETE'})
      .then((res) => {
        if (res.ok) this.$router.push({name: 'Widgets'})
      })
    }
  }
}
</script>
