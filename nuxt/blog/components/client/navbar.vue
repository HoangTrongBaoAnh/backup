<template>
  <div id="nav">
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container">
    <a class="navbar-brand" href="#">Logo Here</a>
      <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

      <b-collapse id="nav-collapse" is-nav>
        <div class="navbar-nav mr-auto">
          <nuxt-link to="/" class="nav-item nav-link">Home</nuxt-link>
          <nuxt-link to="/About" class="nav-item nav-link">About</nuxt-link>
          <nuxt-link to="/Contact" class="nav-link">Contact</nuxt-link>
          <div id="indicator"></div>
        </div>
        <form style="padding-right: 10px">
          <div class="input-group">
            <input
              v-model="searchQuery"
              @keyup="submitSearch"
              class="form-control mr-sm-2"
              type="search"
              placeholder="Search"
              aria-label="Search"
            />
            <span>
              <button class="btn btn-secondary" type="submit">
                Search
              </button>
            </span>
          </div>
          <div
            class="dropdown-menu dropdown-menu-right search"
            id="livesearch"
            v-show="searchQuery"
          >
            <div v-if="this.result != ''">
              <v-list>
                <v-list-item v-for="item in result" :key="item.id">
                  <nuxt-link
                    @click.native="clear"
                    :to="{
                      name: 'product_detail-id',
                      params: { id: item.id }
                    }"
                  >
                    <v-list-item-icon>
                      <img
                        height="70px"
                        width="100px"
                        :src="
                          'https://localhost/blog/public/images/' + item.picture
                        "
                        alt="Italian Trulli"
                      />
                    </v-list-item-icon>
                    <v-list-item-content>
                      <v-list-item-title>{{ item.title }}</v-list-item-title>
                      <v-list-item-subtitle>{{
                        item.price
                      }}</v-list-item-subtitle>
                    </v-list-item-content>
                  </nuxt-link>
                </v-list-item>
              </v-list>
            </div>
            <div class="float-left ml-2 pb-0" v-if="this.result == ''">
              <p>Không có kết quả...</p>
            </div>
          </div>
        </form>
        <nuxt-link :to="{ name: 'checkout' }">
          <v-badge color="deep-purple accent-4" content="">
            <span>Checkout</span>
            <span slot="badge"> {{ $store.state.cart.length }} </span>
            <v-icon>mdi-cart</v-icon>
          </v-badge>
        </nuxt-link>
      </b-collapse>
    </div>
      
    </nav>
    
  </div>
</template>

<script>
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
  // computed: {
  //   crumbs() {
  //   const fullPath = this.$route.fullPath
  //     const params = fullPath.startsWith('/')
  //       ? fullPath.substring(1).split('/')
  //       : fullPath.split('/')
  //     const crumbs = []

  //     let path = ''

  //     params.forEach((param, index) => {
  //       path = `${path}/${param}`
  //       const match = this.$router.match(path)

  //       if (match.name !== null) {
  //         crumbs.push({
  //           text: match.name,
  //           disabled: false,
  //           href: match.path
  //         })
  //       }
  //     })

      
  //     console.log(params) 
  //     return crumbs
  //   },
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
  }
};
</script>
<style>
.navbar-brand{
  padding-left: 0 !important;
}
nav{
  padding: 0 !important;
}
nav a {
  text-align: center;
  color: #949494;
  text-decoration: none;
  font-family: Verdana, Geneva, Tahoma, sans-serif;
  font-weight: bold;
  padding: 10px 20px;
  transition: 0.2s ease color;
}

#nav a {
  font-weight: bold;
  color: #2c3e50;
}

#nav a.nuxt-link-exact-active {
  color: whitesmoke;
  background: crimson;
  border-radius: 0.5rem;
}

.nav-link:hover {
  text-decoration: none;

  cursor: pointer;
}

body.dark-theme {
  background: #121212;
}

body.dark-theme h1,
body.dark-theme p {
  color: #eee;
}

body.dark-theme a {
  color: #809fff;
}

#setting {
  background-color: transparent;
}

html {
  overflow: auto;
}

#livesearch {
  z-index: 9999;
  background: #fff;
  border: 1px solid black;
  max-height: 250px;
  overflow: auto;
  width: 30%;
  right: 265px;
  display: block;
}

.v-list-item a {
  text-align: left;
  font-weight: normal;
  padding: 0px;
  display: inline-block;
  width:100%;
  
}

.v-list-item:hover {
  background-color:#F0F8FF;

}

.v-list-item a .v-list-item__icon{
  float: left;
  border: 1px solid black;
}

.v-list-item a .v-list-item__content{
  float: left;
  font-weight: normal;
  padding-top: 20px !important
}

.v-list-item a .v-list-item__content .v-list-item__title{
  font-weight: bold;
  
}
</style>
