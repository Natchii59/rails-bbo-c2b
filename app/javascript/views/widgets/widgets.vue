<template>
  <div>
    <h1>Widgets</h1>

    <table v-if="widgets.length" class="table">
      <thead>
      <tr>
        <th>Id</th>
        <th>Name</th>
        <th>Product</th>
        <th>Actions</th>
      </tr>
      </thead>

      <tbody>
      <tr v-for="widget in widgets" :key="widget.id">
        <td>{{ widget.id }}</td>
        <td>{{ widget.name }}</td>
        <td>{{ widget.product.name }}</td>
        <td>
          <router-link :to="{name: 'WidgetShow', params: {id: widget.id.toString()}}" class="btn btn-primary">Show
          </router-link>
          <router-link :to="{name: 'WidgetEdit', params: {id: widget.id.toString()}}" class="btn btn-success">Edit
          </router-link>
        </td>
      </tr>
      </tbody>
    </table>

    <p v-else>No Widgets</p>

    <router-link :to="{name: 'WidgetNew'}" class="btn btn-success">New Widget</router-link>
  </div>
</template>

<script>
export default {
  name: "Widgets",
  data: () => ({
    widgets: []
  }),
  mounted() {
    fetch('/api/widgets')
    .then((res) => res.json())
    .then((data) => this.widgets = data)
  }
}
</script>
