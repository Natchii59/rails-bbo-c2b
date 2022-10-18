<template>
  <div>
    <h1>Products Me</h1>

    <table v-if="products.length" class="table">
      <thead>
      <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Action</th>
      </tr>
      </thead>

      <tbody>
      <tr v-for="product in products" :key="products.id">
        <td>{{ product.id }}</td>
        <td>{{ product.name }}</td>
        <td>
          <router-link :to="{ name: 'ProductShow', params: { id: product.id.toString() } }" class="btn btn-primary">
            Show
          </router-link>
          <router-link :to="{ name: 'ProductEdit', params: { id: product.id.toString() } }" class="btn btn-success">
            Edit
          </router-link>
        </td>
      </tr>
      </tbody>
    </table>

    <p v-else>No Products</p>

    <router-link :to="{ name: 'ProductNew' }" class="btn btn-success">New Product</router-link>
  </div>
</template>

<script>
export default {
  name: "Product",
  data: () => ({
    products: [],
  }),
  async mounted() {
    const res = await fetch('/api/products/me')
    this.products = await res.json()
  }
}
</script>
