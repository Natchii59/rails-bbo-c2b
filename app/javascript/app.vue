<template>
  <div>
    <Appbar/>

    <div class="container mt-4">
      <router-view/>
    </div>
  </div>
</template>

<script>
import Appbar from "./components/appbar";

export default {
  components: {Appbar}
}
</script>
