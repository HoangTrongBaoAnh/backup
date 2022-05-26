<template>
  <v-app>
    <Nav />
    <v-main style="padding-bottom:300px;margin-top: 10%;">
      <div class="scroll" ref="headerRef">
        <button @click="toTop"><v-icon>mdi-arrow-up-bold</v-icon></button>
      </div>
      <v-container fluid>
        <Breadcrumb style="padding-bottom:50px;margin-top: 2%;" />
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
    shrinkHeader: function () {
      if (
        document.body.scrollTop > 100 ||
        document.documentElement.scrollTop > 100
      ) {
        //console.log(this.$refs.headerRef.classList.add("shrink"))
        //console.log(this.$refs.headerRef.classList)
        this.$refs.headerRef.classList.add("vis");
      } else {
        this.$refs.headerRef.classList.remove("vis");
      }
    },
    toTop: function () {
        window.scrollTo({
          top: 0,
          behavior: "smooth"
        });
      },
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
  beforeMount() {
    window.addEventListener("scroll", this.shrinkHeader);
  },
  beforeDestroy() {
    window.removeEventListener("scroll", this.shrinkHeader);
  },
  components: {
    Nav,
    Footer,
    Breadcrumb
  }
};
</script>
<style>
.v-main{
  position: relative;

}

.scroll{
  position: fixed;
  bottom: 5%;
  right: 2%;
  visibility: hidden;
  z-index: 100;
  border-radius: 10px;
  width:50px;
  height: 50px;
  align-items: center;
  justify-content: center;
  display: flex;
  background: #fff;
  box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
  cursor: pointer;
}

.scroll:hover{
  background-color: #C0C0BC;
}

.vis{
  visibility: visible;
}
</style>
