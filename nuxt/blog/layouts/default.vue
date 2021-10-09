<template>
  <v-app>
    <Nav />
    <v-main>
      <v-container>
        <Nuxt />
      </v-container>
    </v-main>
    <Footer />
  </v-app>
</template>

<script>
import Nav from "~/components/client/navbar.vue";
import Footer from "~/components/client/footer.vue";
import "~/assets/custom.scss";
export default {
  data() {
    return {
      searchQuery: "",
      result: [],
      //   clipped: false,
      //   drawer: false,
      fixed: false
      //   items: [
      //     {
      //       icon: 'mdi-apps',
      //       title: 'Welcome',
      //       to: '/'
      //     },
      //     {
      //       icon: 'mdi-chart-bubble',
      //       title: 'Inspire',
      //       to: '/inspire'
      //     }
      //   ],
      //   miniVariant: false,
      //   right: true,
      //   rightDrawer: false,
      //   title: 'Vuetify.js'
    };
  },
  methods: {
    clear: function() {
      this.searchQuery = "";
      this.result = [];
    },
    submitSearch: function() {
      this.$axios
        .$get(
          "http://localhost/blog/public/api/shoe/search?name=" +
            this.searchQuery
        )
        .then(response => {
          this.result = response;
          //console.log(response);
        })
        .catch(function(error) {
          console.log(error);
        });
    }
  },
  components: {
    Nav,
    Footer
  },
};
</script>
<style>
.v-main{
  
  margin-bottom: 300px
}
</style>
