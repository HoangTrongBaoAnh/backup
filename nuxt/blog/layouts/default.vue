<template>
  <v-app>
    <Nav />
    <v-main style="padding-bottom:300px">
      <v-container>
        <Breadcrumb />
        <Nuxt />
      </v-container>
    </v-main>
    <Footer />
  </v-app>
</template>

<script>
import Nav from "~/components/client/navbar.vue";
import Footer from "~/components/client/footer.vue";
import Breadcrumb from "~/components/client/breadcrumb.vue";
import "~/assets/custom.scss";
export default {
  data() {
    return {
      // crumbs: [
      //   {
      //     text: "Home",
      //     disabled: false,
      //     href: "/"
      //   },
      // ],
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
  // watch:{
  //   $route: function(to, from){
  //     this.crumbs.push({
  //         text: this.$route.name,
  //         disabled: false,
  //         href: "/" + this.$route.name
  //       });
  //     console.log(this.$route.name);
  //   }
  // },
  
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
    Footer,
    Breadcrumb
  }
};
</script>
<style>
.container {
  padding-right: 0;
  padding-left: 0;
}
</style>
