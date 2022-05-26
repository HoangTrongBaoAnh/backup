<template>
  <div class="row pt-4">
    <div class="col-md-12 col-lg-3 shadow p-3 mb-5 bg-white rounded">
      <FilterBar
        v-if="categories"
        v-bind:categories="categories"
        v-bind:childcategories="childcategories"
        @update-push="updateSelected($event)"
      />
    </div>
    <div
      class="col-md-12 col-lg-9"
      style="box-shadow: 0 2.5rem 2rem -2rem hsl(200 50% 20% / 40%)"
    >
      <v-carousel
        class="shadow p-3 mb-5 bg-white rounded"
        hide-delimiters
        height="240px"
      >
        <v-carousel-item
          v-for="(item, i) in items"
          :key="i"
          :src="item.src"
        ></v-carousel-item>
      </v-carousel>
      <v-select
        class="pt-4"
        v-model="selected.orders"
        :menu-props="{ bottom: true, offsetY: true }"
        solo
        item-text="name"
        :items="orders"
        item-value="id"
        :selected="selected.orders"
      >
      </v-select>

      <div class="row">
        <v-col
          v-for="(selection, i) in selections"
          :key="i"
          class="mb-6 shrink"
        >
          <v-chip :disabled="loading" close @click:close="close(selection)">
            {{ selection.content.title }}
          </v-chip>
        </v-col>
      </div>
      <div class="row">
        <div
          class="col-md-6 col-lg-4"
          v-for="product in posts"
          :key="product.id"
        >
          <Card v-bind:product="product" />
        </div>
      </div>
      <div class="text-center mt-4">
        <v-pagination v-model="currentPage" :length="totalPage"></v-pagination>
      </div>
      <v-snackbar color="green" v-model="snackbar">
        {{ snackbarText }}
        <v-icon green>mdi-checkbox-marked-circle</v-icon>
        <template v-slot:action="{ attrs }">
          <v-btn text v-bind="attrs" @click="snackbar = false"> Close </v-btn>
        </template>
      </v-snackbar>
    </div>
  </div>
</template>
<script>
import baseRequest from "~/store/baseRequest";
import FilterBar from "~/components/client/filterbar.vue";
import Card from "~/components/client/card.vue";

export default {
  components: {
    Card,
    FilterBar,
  },
  data() {
    return {
      snackbar: false,
      snackbarText: "",
      rating: 4,
      items: [
        {
          src: "https://cdn.vuetifyjs.com/images/carousel/squirrel.jpg",
        },
        {
          src: "https://cdn.vuetifyjs.com/images/carousel/sky.jpg",
        },
        {
          src: "https://cdn.vuetifyjs.com/images/carousel/bird.jpg",
        },
        {
          src: "https://cdn.vuetifyjs.com/images/carousel/planet.jpg",
        },
      ],
      posts: [],
      loading: false,
      currentPage: 1,
      totalPage: 0,
      categories: [],
      publishers: [],
      childcategories: [],
      prices: [
        {
          id: 0,
          title: "less than 50",
        },
        {
          id: 1,
          title: "50 -> 100",
        },
        {
          id: 2,
          title: "more than 100",
        },
      ],
      orders: [
        {
          id: 0,
          name: "lasted upload",
        },
        {
          id: 1,
          name: "A->Z",
        },
        {
          id: 2,
          name: "Oldest upload",
        },
      ],
      selected: {
        prices: [],
        categories: [],
        publishers: [],
        child: [],
        orders: 2,
      },
    };
  },
  async asyncData({ $axios, route }) {
    //const { id } = route.params;
    //console.log(id);
    const categories = await $axios.$get(
      "https://peaceful-journey-07506.herokuapp.com/api/category"
    );
    return { categories };
  },
  mounted() {
    this.loadCategories();
    this.getChildCategory();
    if (this.$route.params.id != null) {
      this.selected.categories.push(this.$route.params.id);
    }
    // if (this.$route.query.child != null) {
    //   this.selected.child.push(this.$route.query.child);
    // }

    this.loadProducts();
  },
  watch: {
    "$route.params.id": function (id) {
      this.selected.categories = [];
      this.selected.categories.push(id);
      this.loadProducts();
    },
    currentPage() {
      this.loadProducts();
    },
    selected: {
      handler: function () {
        this.loadProducts();
        this.getChildCategory();
        this.currentPage = 1;
        //console.log(this.selected);
      },
      deep: true,
    },
  },
  // async asyncData({ $axios }) {
  //   // const post2 = await $axios.$get(
  //   //   "http://localhost/blog/public/api/shoe?page=1"
  //   // ).then((res) => {
  //   //   return { posts: res.data.data }
  //   // });

  //   // return { post2,posts };
  // },
  methods: {
    updateSelected(selected) {
      this.$nextTick(() => {
        this.selected.prices = selected.prices;
        this.selected.child = selected.child;
      });
    },
    addToCart(product) {
      this.cart = product;
      this.cart.quantity = 1;
      //console.log(this.cart);
      this.snackbar = true;
      this.snackbarText = "Add product " + product.title + " to cart";
      this.$store.commit("addToCart", this.cart);
    },
    close(selection) {
      if (selection.id == 0) {
        let index_category = this.selected.child.findIndex(
          (x) => x == selection.content.id
        );
        //console.log(this.selected.categories);
        //console.log(index_category);
        this.selected.child.splice(index_category, 1);
        return;
      }
      let index_price = this.selected.prices.findIndex(
        (x) => x == selection.content.id
      );
      //console.log(index_price);
      this.selected.prices.splice(index_price, 1);
    },
    // additem(item) {
    //   if (
    //     this.selected.categories.filter(e => e.id === item.id).length > 0
    //   ) {
    //     let index = this.selected.categories.findIndex(
    //       x => x.id === item.id
    //     );
    //     this.selected.categories.splice(index, 1);
    //     return;
    //   }
    //   //console.log(this.selected.categories.includes(item));
    //   this.selected.categories.push(item);
    // },
    getChildCategory: function () {
      baseRequest
        .get("childcategory/" + this.$route.params.id)
        .then((response) => {
          this.childcategories = response.data;
          //console.log(this.childcategories);
        });
    },
    loadProducts: function () {
      let data = new FormData();
      data.append("categories", this.selected.categories.id);
      //console.log(this.selected.categories.map(x => x.id));
      data.append("prices", this.selected.prices);
      data.append("publishers", this.selected.publishers);
      this.$axios
        .$get(
          "https://peaceful-journey-07506.herokuapp.com/api/shoe?page=" +
            this.currentPage,
          {
            params: {
              categories: this.selected.categories,
              prices: this.selected.prices,
              orders: this.selected.orders,
              child: this.selected.child,
              //publishers: this.selected.publishers,
            },
          }
        )
        .then((response) => {
          //console.log(this.selections);
          this.posts = response.data;
          this.totalPage = response.last_page;
          //this.loading = false;
        })
        .catch(function (error) {
          console.log(error);
        });
    },
    loadCategories: function () {
      this.$axios
        .$get("https://peaceful-journey-07506.herokuapp.com/api/category", {
          params: {
            categories: this.selected.categories,
          },
        })
        .then((response) => {
          //console.log(response);
          this.categories = response;
        })
        .catch(function (error) {
          console.log(error);
        });
    },
    // async loadCategories() {
    //   const cat = (
    //     await this.$axios.$get("http://localhost/blog/public/api/category")
    //   )
    //     .then(res => {
    //       this.categories = cat;
    //       console.log(res);
    //     })
    //     .catch(err => {
    //       console.log(err);
    //     });

    //   console.log(this.categories);
    // }
  },
  computed: {
    selections() {
      const selections = [];

      for (const selection of this.selected.child) {
        let index = this.childcategories.findIndex((x) => x.id == selection);
        selections.push({ id: 0, content: this.childcategories[index] });
      }

      for (const selection of this.selected.prices) {
        let index = this.prices.findIndex((x) => x.id == selection);
        selections.push({ id: 1, content: this.prices[index] });
      }

      return selections;
    },
  },
};
</script>
<style>
.v-list__group--active {
  border-left: 1px solid red;
}
*,
*::before,
*::after {
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
}

.v-input {
  width: 30%;
}

img {
  width: 100%;
  /* position: relative;

  display: block; */
  margin-right: -30px;
  border-radius: inherit;
}

@media screen and (max-width: 450px) {
  .card__container {
    width: 90% !important;

    left: 27px;
  }
}
</style>
