<template>
  <v-app class="home">
    <Nav />

    <Side />

    <v-main>
      <!-- Provides the application the proper gutter -->
      <v-container fluid>
        <!-- If using vue-router -->
        <router-view></router-view>
      </v-container>
      <Footer />
    </v-main>
  </v-app>
</template>

<script>
// @ is an alias to /src
import Nav from "./partials/navbar.vue";
import Side from "./partials/sidebar.vue";
import Footer from "./partials/footer.vue";
export default {
  name: "home",
  components: {
    Nav,
    Side,
    Footer,
  },
};
</script>
