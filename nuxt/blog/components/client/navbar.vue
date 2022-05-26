<template>
  <div id="nav" ref="headerRef">
    <nav class="navbar navbar-expand-lg navbar-light bg-dark">
      <div class="container">
        <div class="logo">
          <img :src="logo" alt="" />
        </div>
        <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

        <b-collapse id="nav-collapse" is-nav>
          <div class="navbar-nav mr-auto">
            <nuxt-link to="/" class="nav-item nav-link">
              <v-icon color="#fff">mdi-home</v-icon>
              <span>Home</span>
            </nuxt-link>
            <nuxt-link to="/About" class="nav-item nav-link"
              ><v-icon color="#fff">mdi-menu</v-icon>About</nuxt-link
            >
            <nuxt-link to="/Category" class="nav-link"
              ><v-icon color="#fff">mdi-home</v-icon>Category</nuxt-link
            >
            <div id="indicator"></div>
          </div>
          <div class="nav__searchbox">
            <form style="padding-right: 10px">
              <div class="input-group">
                <input
                  v-model="searchQuery"
                  @keyup="submitSearch"
                  class="form-control mr-sm-2"
                  type="search"
                  placeholder="Search..."
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
                          params: { id: item.id },
                        }"
                      >
                        <v-list-item-icon>
                          <img
                            height="70px"
                            width="100px"
                            :src="item.picture"
                            alt="Italian Trulli"
                          />
                        </v-list-item-icon>
                        <v-list-item-content>
                          <v-list-item-title>{{
                            item.title
                          }}</v-list-item-title>
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
          </div>
          <div class="nav">
            <nuxt-link class="nav-link" :to="{ name: 'checkout' }">
              <v-badge color="deep-purple accent-4" content="">
                <v-icon color="#fff">mdi-cart</v-icon>
                <span>Checkout</span>
                <span slot="badge"> {{ $store.state.cart.length }} </span>
              </v-badge>
            </nuxt-link>
          </div>
          <div>
            <div v-if="user == 0">
              <nuxt-link to="/login">
                <v-icon></v-icon>
                Login
              </nuxt-link>
            </div>
            <div class="action" v-else>
              <div class="profile" @click="toggleactive()">
                <img :src="user.picture" />
              </div>
              <div class="profileMenu">
                <h3>{{ user.name }}<br /><span>websitedesinger</span></h3>
                <ul>
                  <li>
                    <nuxt-link to="/profile">
                      <v-icon></v-icon>
                      Profile
                    </nuxt-link>
                  </li>
                  <li>
                    <nuxt-link to="/admin">
                      <v-icon></v-icon>
                      Admin
                    </nuxt-link>
                  </li>
                  <li>
                    <div @click="Logout()">
                      <v-icon>mdi-logout</v-icon>
                      LogOut
                    </div>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </b-collapse>
      </div>
    </nav>
  </div>
</template>

<script>
import { mapGetters } from "vuex";
import logo from "~/assets/logo.jpg";
import baseRequest from "~/store/baseRequest";
export default {
  data() {
    return {
      searchQuery: "",
      result: [],
      // user: [],
      token: "",
      fixed: false,
      logo: logo,
    };
  },

  methods: {
    shrinkHeader: function () {
      if (
        document.body.scrollTop > 100 ||
        document.documentElement.scrollTop > 100
      ) {
        //console.log(this.$refs.headerRef.classList.add("shrink"))
        //console.log(this.$refs.headerRef.classList)
        this.$refs.headerRef.classList.add("shrink");
      } else {
        this.$refs.headerRef.classList.remove("shrink");
      }
    },
    Logout: function () {
      baseRequest
        .post("logout")
        .then((response) => {
          localStorage.removeItem("token");
          this.$router.push({ path: "/login", force: true });
          this.$store.commit("updateUser", []);
          // this.user = [];
          this.toggleactive();
          console.log(response.data);
        })
        .catch(() => {});
    },
    toggleactive: function () {
      const togglemenu = document.querySelector(".profileMenu");
      console.log(togglemenu);
      togglemenu.classList.toggle("active");
    },
    CheckedLogin: function () {
      baseRequest
        .get("user")
        .then((response) => {
          //this.token = localStorage.getItem("token");
          this.user = response.data;
          console.log(this.user);
          // console.log(this.user.length)
        })
        .catch(() => {
          //this.$router.push({ name: "Login" });
        });
    },
    clear: function () {
      this.searchQuery = "";
      this.result = [];
    },
    submitSearch: function () {
      this.$axios
        .$get(
          "https://peaceful-journey-07506.herokuapp.com/api/shoe/search?name=" +
            this.searchQuery
        )
        .then((response) => {
          this.result = response;
          //console.log(response);
        })
        .catch(function (error) {
          console.log(error);
        });
    },
  },
  beforeMount() {
    window.addEventListener("scroll", this.shrinkHeader);
  },
  beforeDestroy() {
    window.removeEventListener("scroll", this.shrinkHeader);
  },
  mounted() {
    this.CheckedLogin();
  },
  computed: {
    user: {
      get() {
        return this.$store.state.user;
      },
      set() {
        
      },
    },
    // /...mapGetters(['user'])
  },
};
</script>
<style lang="scss" scoped>
.logo {
  font-size: 2.5rem;
  font-weight: 600;
  margin-right: 10px;

  @include flex(center, unset);

  img {
    margin-right: 10px;
    width: 50px;

    @include mobile {
      width: 30px;
      margin-right: 0;
    }
  }
}

.nav__searchbox {
  margin-bottom: 12px;
  @include tablet {
    // visibility: visible;
  }
}

.action {
  padding-left: 10px;
  margin-bottom: 12px;
}
.action .profile {
  position: relative;
  width: 50px;
  height: 50px;
  border-radius: 50%;
  overflow: hidden;
  cursor: pointer;

  @include tablet {
    position: absolute;
    top: 16px;
    left: 25%;
    width: 40px;
    height: 40px;
  }
}

.action .profileMenu {
  position: absolute;
  top: 80px;
  right: 13%;
  padding: 10px 20px;
  background: #fff;
  width: 200px;
  box-sizing: 0 5px 25px rgba(0, 0, 0, 1);
  border-radius: 15px;
  transition: 0.5s ease;
  visibility: hidden;
  opacity: 0;
}

.action .profileMenu.active {
  visibility: visible;
  opacity: 1;
}

.action .profileMenu h3 {
  width: 100%;
  text-align: center;
  font-weight: 500;
  font-size: 18px;
  line-height: 1.8em;
  color: #555;
}

.action .profileMenu h3 span {
  font-weight: 400;
  font-size: 14px;
  color: #cecece;
}

.action .profileMenu ul li {
  list-style: none;
  align-items: center;
  display: flex;
  padding: 10px 0;
  border-top: 1px solid rgba(0, 0, 0, 0.05);
}
.action .profileMenu ul li a {
  color: #555 !important;
  background: none !important;
  display: inline-block;
  text-decoration: none;
  font-weight: 500;
  transition: 0.5s;
}

.action .profileMenu ul li div {
  cursor: pointer;
  color: #555 !important;
  background: none !important;
  display: inline-block;
  text-decoration: none;
  font-weight: 500;
  transition: 0.5s;
}

.action .profileMenu ul li a::hover {
  background-color: #ff5d94;
}

.action .profileMenu::before {
  content: "";
  position: absolute;
  top: 0;
  right: 0;
  height: 20px;
  width: 20px;
  background: #fff;
  transform: rotate(90deg);
}

.action .profile img {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.navbar-brand {
  padding-left: 0 !important;
}

#nav {
  position: fixed;
  width: 100%;
  z-index: 999;
  //height: $header-height;
  transition: height 0.3s ease, background-color 0.3s ease;
  // @include flex(center, space-between);
  height: 8rem;
  //padding: 0 2rem;

  text-align: center;
  &.shrink {
    & nav {
      height: 6.3rem;

      transition: 0.3 ease;
      // background-color: red;
    }
  }
}
.nav {
  display: block;
}

nav a {
  margin-right: 20px;
  margin-bottom: 12px;
  color: #949494;
  text-decoration: none;
  font-family: Verdana, Geneva, Tahoma, sans-serif;
  font-weight: bold;
  padding: 10px 20px;
  transition: 0.2s ease color;
  align-items: center;
  & i {
    margin-bottom: 5px;
    margin-right: 3px;
  }
}

#nav a {
  font-weight: bold;
  color: #fff;
}

#nav a.nuxt-link-exact-active {
  color: whitesmoke;
  background: crimson;
  border-radius: 0.5rem;
}

.btn:hover {
  background-color: greenyellow;
  color: black;
}

.nav-link:hover {
  text-decoration: none;
  border-bottom: 1px solid red;
  cursor: pointer;
}

#nav-collapse {
  width: 100%;
  margin-top: 15px;

  @include tablet {
    background: #343a40;
    //height: 4rem;
  }
  @include mobile {
  }
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
  width: 100%;
}

.v-list-item:hover {
  background-color: #f0f8ff;
}

.v-list-item a .v-list-item__icon {
  float: left;
  border: 1px solid black;
}

.v-list-item a .v-list-item__content {
  float: left;
  font-weight: normal;
  padding-top: 20px !important;
}

.v-list-item a .v-list-item__content .v-list-item__title {
  font-weight: bold;
  color: #809fff;
}

@media (min-width: 769px) and (max-width: 1024px) {
  .nav__searchbox {
    // visibility: hidden;
  }
}
</style>
