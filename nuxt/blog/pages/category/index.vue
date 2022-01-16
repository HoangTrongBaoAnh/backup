<template>
  <div class="row pt-4">
    <div class="col-md-12 col-lg-3 shadow p-3 mb-5 bg-white rounded">
      <v-list expand light dense nav>
        <v-list-group prepend-icon="mdi-book-multiple" :value="true">
          <template v-slot:activator>
            <v-list-item-title>Danh muc</v-list-item-title>
          </template>
          <v-list-item-group>
            <v-list-item
              style="padding-left: 40px"
              link
              v-for="(item, i) in categories"
              :key="i"
            >
              <NuxtLink
                :to="{
                  name: 'category-slug',
                  params: { slug: item.content, id: item.id },
                }"
                
              >
                <v-list-item-content>
                  <v-list-item-title v-text="item.content"></v-list-item-title>
                </v-list-item-content>
              </NuxtLink>
            </v-list-item>
          </v-list-item-group>
        </v-list-group>

        <v-list-group :value="true" no-action prepend-icon="mdi-account-circle">
          <template v-slot:activator>
            <v-list-item-title>Category</v-list-item-title>
          </template>
          <v-list-item-group>
            <v-list-item
              style="padding-left: 40px"
              v-for="item in childcategories"
              :key="item.id"
            >
              <v-list-item-content>
                <v-list-item-title>
                  <label class="form-check-label" :for="'category' + item.id">
                    {{ item.title }}
                  </label>
                </v-list-item-title>
              </v-list-item-content>
              <input
                :value="item.id"
                v-model="selected.child"
                :id="'category' + item.id"
                type="checkbox"
                class="form-check-input"
              />
            </v-list-item>
          </v-list-item-group>
        </v-list-group>
        <v-list-group prepend-icon="mdi-cash-multiple" :value="true" no-action>
          <template v-slot:activator>
            <v-list-item-title>Price</v-list-item-title>
          </template>
          <v-list-item-group>
            <v-list-item
              style="padding-left: 40px"
              v-for="item in prices"
              :key="'price' + item.id"
            >
              <input
                :value="item.id"
                v-model="selected.prices"
                :id="'price' + item.id"
                type="checkbox"
                class="form-check-input"
              />
              <label class="form-check-label" :for="'price' + item.id">
                {{ item.title }}
              </label>
            </v-list-item>
          </v-list-item-group>
        </v-list-group>
        <div class="v-list-group v-list-group--default v-list-group--no-action">
          <v-list-item-group>
            <v-list-item-content>
              <v-list-item-title>Publisher</v-list-item-title>
            </v-list-item-content>

            <v-list-item> </v-list-item>
          </v-list-item-group>
        </div>
      </v-list>
    </div>
    <div class="col-md-12 col-lg-9" style="box-shadow: 0 2.5rem 2rem -2rem hsl(200 50% 20% / 40%);">
      <v-carousel class="shadow p-3 mb-5 bg-white rounded" hide-delimiters height="240px">
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
        <div class="col-md-6 col-lg-4" v-for="product in posts" :key="product.id">
          <div class="card__container">
            <div class="card__top__section">
              <img :src="imgURL + product.picture" />
              <div class="card__top__section__icons">
                <div>
                  <i><v-icon dark>mdi-heart</v-icon></i>
                </div>
                <div @click="addToCart(product)">
                  <i><v-icon dark>mdi-shopping</v-icon></i>
                </div>
                <div>
                  <i><v-icon dark>mdi-share</v-icon></i>
                </div>
              </div>
            </div>
            <div class="card__body__section">
              <nuxt-link
                :to="{ name: 'product_detail-id', params: { id: product.id } }"
                class="image"
              >
                <p>{{ product.title }}</p>
              </nuxt-link>
              <span>A nice blue shirt for men. One size fit all.</span>
            </div>
            <div>
              <div class="rating-section">
                <div class="stars-rating">
                  <span>{{ product.rating }}</span>
                  <v-rating
                    v-model="product.rating"
                    background-color="#777"
                    size="18"
                    color="#f7bc3d"
                  ></v-rating>
                </div>
                <div class="c-price">
                  <span>$ {{ product.price }}</span>
                </div>
              </div>
            </div>
          </div>
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
import img from "~/store/img";
import baseRequest from "~/store/baseRequest";
export default {
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
      "http://localhost/blog/public/api/category"
    );
    return { categories };
  },
  mounted() {
    this.loadCategories();
    this.getChildCategory();
    if (this.$route.query.tl != null) {
      this.selected.categories.push(this.$route.query.tl);
    }
    this.imgURL = img.get();
    // if (this.$route.query.child != null) {
    //   this.selected.child.push(this.$route.query.child);
    // }
    console.log(this.selections);
    this.loadProducts();
  },
  watch: {
    "$route.query.tl": function (tl) {
      this.selected.categories = [];
      this.selected.categories.push(this.$route.query.tl);
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
      if (this.$route.query.tl == null) {
        baseRequest.get("childcategory").then((response) => {
          this.childcategories = response.data;
          //console.log(this.childcategories);
        });
      } else {
        //this.loading = true;
        baseRequest
          .get("childcategory/" + this.$route.query.tl)
          .then((response) => {
            this.childcategories = response.data;
            //console.log(this.childcategories);
          });
      }
    },
    async getPosts() {
      const ip = await this.$axios.$get(
        "http://localhost/blog/public/api/shoe?page=" + this.currentPage
      );
      this.posts = ip.data;
      this.totalPage = ip.last_page;
      console.log(this.posts);
    },
    loadProducts: function () {
      let data = new FormData();
      data.append("categories", this.selected.categories.id);
      //console.log(this.selected.categories.map(x => x.id));
      data.append("prices", this.selected.prices);
      data.append("publishers", this.selected.publishers);
      this.$axios
        .$get(
          "http://localhost/blog/public/api/shoe?page=" + this.currentPage,
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
        .$get("http://localhost/blog/public/api/category", {
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
.container {
  padding: 15px 0px !important;
}
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
  position: relative;

  display: block;
  border-radius: inherit;
}

.card__container {
  width: 260px;
  background-color: #fff;
  -webkit-box-shadow: 0 2.5rem 2rem -2rem hsl(200 50% 20% / 40%);
  box-shadow: 0 2.5rem 2rem -2rem hsl(200 50% 20% / 40%);
  margin: 0 auto;
  border-radius: 8px;
  border: 2px;
  /* position: relative; */
  top: 30px;
  margin-bottom: 60px;
  height: 90%;
}

.card__top__section {
  background: -webkit-gradient(
    linear,
    left top,
    right top,
    from(#64c1ff),
    to(#0064b7)
  );
  background: -o-linear-gradient(left, #64c1ff, #0064b7);
  background: linear-gradient(to right, #64c1ff, #0064b7);
  background-repeat: no-repeat;
  background-size: cover;
  background-position: 0 0;
  height: 220px;
  width: 100%;
  padding: 10px 0px 0px 0px;
  border-top-left-radius: 8px;
  border-top-right-radius: 8px;
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
}

.card__top__section__icons > div {
  width: 38px;
  height: 38px;
  background-color: rgb(83, 64, 64);
  border-radius: 50%;
  /* z-index: 100; */
  position: relative;
  left: -48px;
  margin-bottom: 10px;
  display: table;
}

.card__top__section__icons > div:hover {
  background-color: rgb(169, 197, 46);
  transform: scale(1.5);
}

.card__top__section__icons > div > i {
  vertical-align: middle;
  text-align: center;
  display: table-cell;
  color: #454545;
  font-size: 16px;
}

.card__body__section {
  text-align: center;
  padding: 8px 5px;
}

.card__body__section > p {
  font-weight: 700;
}

.rating-section {
  border-top: 1px solid #eee;
  padding: 8px 12px;
  margin-top: 5px;
  display: table;
  margin-bottom: 20px;
  clear: both;
  width: 100%;
}

.rating-with-color {
  color: #ffa500;
}

.stars-rating {
  float: left;
}

.stars-rating > span {
  font-size: small;
}

.c-price {
  padding-top: 5px;
  float: right;
}

@media screen and (max-width: 450px) {
  .card__container {
    width: 90% !important;
    
    left: 27px;
  }
}
</style>
