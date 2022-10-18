<template>
  <div>
    <h1>Home</h1>

    <router-link :to="{ name: 'Products' }" class="btn btn-link">Products</router-link>
    <router-link :to="{ name: 'Widgets' }" class="btn btn-link">Widgets</router-link>
  </div>
</template>

<script>
export default {
  name: "Home"
}
</script>
