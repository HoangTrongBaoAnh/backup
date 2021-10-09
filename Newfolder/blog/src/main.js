import Vue from "vue";
import App from "./App.vue";
import vuetify from "./plugins/vuetify";
import VueRouter from "vue-router";
import Vuex from "vuex";
import VueMeta from "vue-meta";
import "../node_modules/bootstrap/dist/css/bootstrap.css";
import createPersistedState from "vuex-persistedstate";

Vue.use(Vuex);

const store = new Vuex.Store({
  state: {
    products: [],
    cart: [],
    order: [],
    user: [],
    drawerState: false,
  },
  mutations: {
    sidebar(state, data) {
      state.drawerState = data;
    },
    updateProducts(state, products) {
      state.products = products;
    },
    addToCart(state, product) {
      let productInCartIndex = state.cart.findIndex(
        (item) => item.id == product.id
      );
      if (productInCartIndex != -1) {
        state.cart[productInCartIndex].quantity++;
        return;
      }
      product.quantity = 1;
      state.cart.push(product);
    },
    removeFromCart(state, index) {
      state.cart.splice(index, 1);
    },
    updateOrder(state, order) {
      state.order = order;
    },
    updateUser(state, user) {
      state.user = user;
    },
    updateCart(state, cart) {
      state.cart = cart;
    },
  },
  actions: {
    clearCart({ commit }) {
      commit("updateCart", []);
    },
  },
  getters: {
    drawerState: (state) => state.drawerState,
  },
  plugins: [
    createPersistedState({
      storage: window.sessionStorage,
    }),
  ],
});

Vue.use(VueRouter);
Vue.config.productionTip = false;

import login from "./components/login.vue";
import profile from "./components/profile.vue";
import shop from "./components/shop.vue";
import product_detail from "./components/shoe_detail.vue";
import checkout from "./components/checkout.vue";
import admin from "./components/admin/admin.vue";
import category from "./components/admin/datatable_category.vue";
import product from "./components/admin/product.vue";
import product_image from "./components/product_image.vue";
import Nav from "./components/nav_header";

const routes = [
  {
    path: "/login",
    component: login,
    name: "Login",
  },
  {
    path: "/Nav",
    component: Nav,
    name: "Nav",
  },
  {
    path: "/shop",
    component: shop,
    name: "shop",
  },
  {
    path: "/product_detail/:id",
    component: product_detail,
    name: "product_detail",
  },
  {
    path: "/checkout",
    component: checkout,
    name: "Checkout",
  },
  {
    path: "/admin",
    component: admin,
    name: "admin",
    children: [
      {
        // UserProfile will be rendered inside User's <router-view>
        // when /user/:id/profile is matched
        path: "category",
        component: category,
      },
      {
        // UserProfile will be rendered inside User's <router-view>
        // when /user/:id/profile is matched
        path: "product",
        component: product,
      },
      {
        // UserProfile will be rendered inside User's <router-view>
        // when /user/:id/profile is matched
        path: "profile",
        component: profile,
        name: "profile",
      },
      {
        // UserProfile will be rendered inside User's <router-view>
        // when /user/:id/profile is matched
        path: "product_image/:id",
        component: product_image,
        name: "Product_image",
      },
    ],
  },
];

const router = new VueRouter({
  mode: "history",
  routes, // short for `routes: routes`
});

Vue.use(VueMeta, {
  // optional pluginOptions
  refreshOnceOnNavigation: true,
});

new Vue({
  vuetify,
  router,
  store,
  created: function() {
    window.fbAsyncInit = function() {
      window.FB.init({
        appId: "1449621782097242",
        autoLogAppEvents: true,
        xfbml: true,
        version: "v3.2",
      });

      //This function should be here, inside window.fbAsyncInit
      //  FB.getLoginStatus(function(response) {
      //    console.log(response);
      // });
    };

    (function(d, s, id) {
      var js,
        fjs = d.getElementsByTagName(s)[0];
      if (d.getElementById(id)) {
        return;
      }
      js = d.createElement(s);
      js.id = id;
      js.src = "//connect.facebook.net/en_US/sdk.js";
      fjs.parentNode.insertBefore(js, fjs);
    })(document, "script", "facebook-jssdk");
  },

  render: (h) => h(App),
}).$mount("#app");
