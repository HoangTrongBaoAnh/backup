<template>
  <div>
    <nav
      class="
        navbar navbar-expand-lg navbar-light
        bg-light
        sticky-top
        text-nowrap
      "
    >
      <div class="container">
        <button
          class="navbar-toggler"
          type="button"
          data-toggle="modal"
          data-target="#left_Modal"
          aria-controls="navbarSupportedContent"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span class="navbar-toggler-icon"></span>
        </button>
        <a class="p-0 navbar-brand mx-2" href="index.php"> </a>
        <button
          class="navbar-toggler"
          type="button"
          id="setting"
          data-toggle="modal"
          data-target="#modal"
        >
          <span class="fas fa-cog fa-fw"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item active dropdown">
              <a
                class="nav-link dropdown-toggle"
                href="#"
                id="navbarDropdownMenuLink"
                data-toggle="dropdown"
                aria-haspopup="true"
                aria-expanded="false"
              >
                Dropdown link
              </a>
              <div
                class="dropdown-menu"
                aria-labelledby="navbarDropdownMenuLink"
              >
                <a class="dropdown-item" href="#">Action</a>
                <a class="dropdown-item" href="#">Another action</a>
                <a class="dropdown-item" href="#">Something else here</a>
              </div>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Features</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Pricing</a>
            </li>
            <li class="nav-item">
              <a class="nav-link disabled" href="#">Disabled</a>
            </li>
          </ul>
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
                <button class="btn btn-secondary" type="submit">Search</button>
              </span>
            </div>
            <div
              class="dropdown-menu dropdown-menu-right search"
              id="livesearch"
              v-show="searchQuery"
            >
              <div v-if="this.result != ''">
                <a class="link-p-colr">
                  <div class="live-outer">
                    <div
                      class="live-product-det"
                      v-for="item in result"
                      :key="item.id"
                    >
                      <router-link
                        :to="{
                          name: 'product_detail',
                          params: { id: item.id },
                        }"
                      >
                        <div class="live-im"></div>
                        <div class="live-product-name">
                          <p>{{ item.title }}</p>
                        </div>
                        <div class="live-product-price">
                          <div class="live-product-price-text">
                            <p>{{ item.content }}</p>
                          </div>
                        </div>
                      </router-link>
                    </div>
                  </div>
                </a>
              </div>
              <div class="float-left ml-2 pb-0" v-if="this.result == ''">
                <p>Không có kết quả...</p>
              </div>
            </div>
          </form>
          <ul class="navbar-nav mr-2">
            <li class="nav-item active">
              <button
                type="button"
                class="nav-link btn d-none d-lg-block"
                id="setting"
                data-toggle="modal"
                data-target="#modal"
              >
                <span class="fas fa-cog fa-fw"></span>
              </button>
            </li>
            <li class="nav-item dropdown">
              <a
                class="nav-link dropdown-toggle"
                href="#"
                id="navbarDropdownMenuLink"
                data-toggle="dropdown"
                aria-haspopup="true"
                aria-expanded="false"
              >
                Dropdown link
              </a>
              <div
                class="dropdown-menu"
                aria-labelledby="navbarDropdownMenuLink"
              >
                <a class="dropdown-item" href="#">Action 1</a>
                <a class="dropdown-item" href="#">Another action</a>
                <a class="dropdown-item" href="#">Something else here</a>
              </div>
            </li>
          </ul>
          <router-link :to="{ name: 'Checkout' }">
            Checkout<span
              v-text="'(' + $store.state.cart.length + ') items'"
            ></span>
          </router-link>
        </div>
      </div>
    </nav>
  </div>
</template>
<script>
import baseRequest from "../core/baseRequest";
export default {
  data() {
    return {
      searchQuery: "",
      result: [],
    };
  },
  methods: {
    submitSearch: function () {
      baseRequest
        .get("shoe/search?name=" + this.searchQuery)
        .then((response) => {
          this.result = response.data;

          //console.log(this.searchQuery);
        })
        .catch((error) => {
          console.error(error);
        });
    },
  },
};
</script>
<style>
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
.live-outer {
  width: 100%;
  height: 60px;
  border-bottom: 1px solid #ccc;
  background: #fff;
}
.live-outer:hover {
  background: #f3f3f3;
}
.live-im {
  float: left;
  width: 10%;
  height: 60px;
}
.live-im img {
  width: 100%;
  height: 100%;
}
.live-product-det {
  float: left;
  width: 100%;
  height: 60px;
}
.live-product-name {
  width: inherit;
  height: 22px;
  margin-top: 4px;
}
.live-product-name p {
  margin: 0px;
  color: #333;
  text-shadow: 1px 1px 1px #dddddd;
  font-size: 17px;
}
.live-product-price {
  width: 100%;
  height: 25px;
}
.live-product-price-text {
  float: left;
  width: 50%;
}
.live-product-price-text p {
  margin: 0px;
  font-size: 16px;
}
.link-p-colr {
  color: #333;
}
#livesearch {
  z-index: 9999;
  background: #fff;
  border: 1px solid black;
  max-height: 250px;
  overflow: auto;
  width: 30%;
  right: 370px;
  display: block;
}
.search::-webkit-scrollbar-thumb {
  background-color: rgba(255, 255, 255, 0.1);
  border-radius: 3px;
}
.bootstrap-select .dropdown-menu {
  outline: none !important;
}
.dropdown a {
  background-color: #fff transparent !important;
}
</style>
