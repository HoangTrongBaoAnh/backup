<template>
  <v-app class="home">
    <Nav />

    <Side />

    <v-main>
      <!-- Provides the application the proper gutter -->
      <v-container fluid>
        <!-- If using vue-router -->
        <nuxt />
      </v-container>
      <Footer />
    </v-main>
  </v-app>
</template>

<script>
// @ is an alias to /src
import Nav from "../components/admin/navbar.vue";
import Side from "../components/admin/sidebar.vue";
import Footer from "../components/admin/footer.vue";
export default {
  name: "home",
  components: {
    Nav,
    Side,
    Footer,
  },
};
</script>
