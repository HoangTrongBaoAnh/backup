<template>
  <div class="row pt-4">
    <div class="col-md-3 border-right ">
    <!-- 
    <v-list>
      <v-list-group
        v-for="item in categories"
        :key="item.id"
        v-model="item.active"
      >
        <template v-slot:activator>
          <v-list-item-content>
            
            <v-list-item-title v-text="item.content"></v-list-item-title>
          </v-list-item-content>
        </template>

        <v-list-item
          v-for="child in item.child_caregory"
          :key="child.title"
        >
          <v-list-item-content>
            <NuxtLink :to="'/about?child='+child.id">
                <v-list-item-title v-text="child.title"></v-list-item-title>
            </NuxtLink>
            
          </v-list-item-content>
        </v-list-item>
      </v-list-group>
    </v-list>
    -->
    <v-list class="pb-4 border-bottom" flat>
      <v-subheader>Danh mục</v-subheader>
      <v-list-item-group
        
        color="primary"
      >
        <v-list-item
          v-for="(item, i) in categories"
          :key="i"
        >
          <v-list-item-content>
            <NuxtLink :to="'/About?tl='+item.id">
                <v-list-item-title v-text="item.content"></v-list-item-title>
            </NuxtLink>
          </v-list-item-content>
        </v-list-item>
      </v-list-item-group>
    </v-list>
      <h2>Category</h2>
      <div class="form-check p-2" v-for="item in childcategories" :key="item.id">
        <input
          :value="item.id"
          v-model="selected.child"
          :id="'category' + item.id"
          type="checkbox"
          class="form-check-input"
        />
        <label class="form-check-label" :for="'category' + item.id">
          {{ item.title }} 
        </label>
      </div>
      <h3 class="mt-2">Price</h3>
      <div
        class="form-check p-2"
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
      </div>
      <h3 class="mt-2">Publisher</h3>
    </div>
    <div class="col-md-9">
    <v-carousel hide-delimiters height="240px">
    <v-carousel-item
      v-for="(item,i) in items"
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
        <div class="col-md-4" v-for="product in posts" :key="product.id">
          <div class="product-grid">
            <div class="product-image">
              <nuxt-link
                :to="{ name: 'product_detail-id', params: { id: product.id } }"
                class="image"
              >
                <img
                  class="pic-1"
                  :src="
                    'https://localhost/blog/public/images/' + product.picture
                  "
                />
              </nuxt-link>
              <ul class="product-links">
                <li>
                  <a href="#"><i class="fa fa-shopping-bag"></i> Add to cart</a>
                </li>
                <li>
                  <a href="#"><i class="fa fa-search"></i> Quick View</a>
                </li>
              </ul>
            </div>
            <div class="product-content">
              <v-rating
                v-model="rating"
                background-color="#777"
                color="#f7bc3d"
                icon-label="custom icon label text {0} of {1}"
              ></v-rating>
              <h3 class="title">
                <nuxt-link
                  :to="{
                    name: 'product_detail-id',
                    params: { id: product.id }
                  }"
                  >{{ product.title }}</nuxt-link
                >
              </h3>
              <div class="price">${{ product.price }}</div>
            </div>
          </div>
        </div>
      </div>
      <div class="text-center">
        <v-pagination v-model="currentPage" :length="totalPage"></v-pagination>
      </div>
    </div>
  </div>
  <!-- <div class="form-group">
        <select class="custom-select" v-model="selected.orders" id="">
          <option v-for="(item, index) in orders" :key="index" :value="index">
            {{ item.name }}
          </option>
        </select>
      </div>
<div>
            <nuxt-link
              :to="{ name: 'product_detail-id', params: { id: product.id } }"
            >
              <img
                height="70px"
                width="100px"
                :src="'https://localhost/blog/public/images/' + product.picture"
                alt="Italian Trulli"
              />
            </nuxt-link>
            <div>
              <p><span>Name </span>{{ product.title }}</p>
              <p v-text="product.category"></p>
            </div>
            <div>
              <h3>price {{ product.price }}</h3>
            </div>
          </div>
-->
</template>
<script>
import baseRequest from "~/store/baseRequest";
export default {
  data() {
    return {
      rating: 4,
      items: [
          {
            src: 'https://cdn.vuetifyjs.com/images/carousel/squirrel.jpg',
          },
          {
            src: 'https://cdn.vuetifyjs.com/images/carousel/sky.jpg',
          },
          {
            src: 'https://cdn.vuetifyjs.com/images/carousel/bird.jpg',
          },
          {
            src: 'https://cdn.vuetifyjs.com/images/carousel/planet.jpg',
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
          title: "less than 50"
        },
        {
          id: 1,
          title: "50 -> 100"
        },
        {
          id: 2,
          title: "more than 100"
        }
      ],
      orders: [
        {
          id: 0,
          name: "lasted upload"
        },
        {
          id: 1,
          name: "A->Z"
        },
        {
          id: 2,
          name: "Oldest upload"
        }
      ],
      selected: {
        prices: [],
        categories: [],
        publishers: [],
        child:[],
        orders: 2
      }
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
    // if (this.$route.query.child != null) {
    //   this.selected.child.push(this.$route.query.child);
    // }
    console.log(this.selections);
    this.loadProducts();
  },
  watch: {
    '$route.query.tl': function (tl) {
      this.selected.categories = [];
      this.selected.categories.push(this.$route.query.tl);
      this.loadProducts();
    },
    currentPage() {
      this.loadProducts();
    },
    selected: {
      handler: function() {
        this.loadProducts();
        this.getChildCategory();
        this.currentPage = 1;
        //console.log(this.selected);
      },
      deep: true
    }
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
    close(selection) {
      if (selection.id == 0) {
        let index_category = this.selected.child.findIndex(
          x => x == selection.content.id
        );
        //console.log(this.selected.categories);
        //console.log(index_category);
        this.selected.child.splice(index_category, 1);
        return;
      }
      let index_price = this.selected.prices.findIndex(
        x => x == selection.content.id
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
     baseRequest.get("childcategory")
            .then((response) => {
                this.childcategories = response.data;
                //console.log(this.childcategories);
            });
    }
    else{
//this.loading = true;
            baseRequest.get("childcategory/"+this.$route.query.tl)
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
    loadProducts: function() {
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
              child: this.selected.child
              //publishers: this.selected.publishers,
            }
          }
        )
        .then(response => {
          //console.log(this.selections);
          this.posts = response.data;
          this.totalPage = response.last_page;
          //this.loading = false;
        })
        .catch(function(error) {
          console.log(error);
        });
    },
    loadCategories: function() {
      this.$axios
        .$get("http://localhost/blog/public/api/category", {
          params: {
            categories: this.selected.categories
          }
        })
        .then(response => {
          //console.log(response);
          this.categories = response;
        })
        .catch(function(error) {
          console.log(error);
        });
    }
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
        let index = this.childcategories.findIndex(x => x.id == selection);
        selections.push({ id: 0, content: this.childcategories[index] });
      }

      for (const selection of this.selected.prices) {
        let index = this.prices.findIndex(x => x.id == selection);
        selections.push({ id: 1, content: this.prices[index] });
      }

      return selections;
    }
  }
};
</script>
<style>

.product-grid:hover {
  box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25), 0 10px 10px rgba(0, 0, 0, 0.22);
}

.product-grid .product-content {
  text-align: center;
  padding: 15px 10px;
}
.product-grid .v-rating {
  padding: 0;
  margin: 0 0 7px;
  list-style: none;
}
.product-grid .v-rating div {
  color: #f7bc3d;
  font-size: 13px;
}
.product-grid .rating li.far {
  color: #777;
}
.product-grid .title {
  font-size: 16px;
  font-weight: 600;
  text-transform: capitalize;
  margin: 0 0 6px;
}
.product-grid .title a {
  color: #555;
  text-decoration: none;
  transition: all 0.3s ease 0s;
}
.product-grid .title a:hover {
  color: #ed1d24;
}
.product-grid .price {
  color: #ed1d24;
  font-size: 18px;
  font-weight: 700;
}
.v-input {
  width: 30%;
}
.product-grid {
  font-family: "Poppins", sans-serif;
  text-align: center;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12), 0 1px 2px rgba(0, 0, 0, 0.24);
  transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
}
.product-grid .product-image {
  position: relative;
}
.product-grid .product-image a.image {
  display: block;
}
.product-grid .product-image img {
  width: 100%;
  height: 220px;
  transition: all 0.3s ease 0s;
}
.product-grid .product-image:hover img {
  transform: translate(10px, -10px);
}
.product-grid .product-sale-label {
  color: #fff;
  background: #1abc9c;
  font-size: 13px;
  text-transform: capitalize;
  line-height: 35px;
  width: 55px;
  height: 35px;
  position: absolute;
  top: 0;
  right: 0;
  animation: bg-animate 5s infinite linear;
}
.product-grid .product-links {
  padding: 0;
  margin: 0;
  list-style: none;
  opacity: 0;
  overflow: hidden;
  position: absolute;
  bottom: 15px;
  left: 20px;
  transition: all 0.3s ease 0s;
}
.product-grid:hover .product-links {
  opacity: 1;
}
.product-grid .product-links li {
  margin: 0 0 5px;
  opacity: 0;
  transform: translateX(-100%);
  transition: all 0.3s ease 0s;
}
.product-grid:hover .product-links li:nth-child(2) {
  transition: all 0.3s ease 0.15s;
}
.product-grid:hover .product-links li {
  opacity: 1;
  transform: translateX(0);
}
.product-grid .product-links li a {
  color: #fff;
  background-color: #00b894;
  font-size: 14px;
  text-shadow: 0 0 3px rgba(0, 0, 0, 0.7);
  padding: 8px 10px;
  display: block;
  opacity: 0.9;
  transition: all 0.3s ease 0s;
  animation: bg-animate 5s infinite linear;
}
.product-grid .product-links li a:hover {
  color: #fff;
  text-decoration: none;
  box-shadow: 0 0 0 3px #fff inset;
  opacity: 1;
}
.product-grid .product-links li a i {
  margin: 0 5px 0 0;
}

@keyframes color-animate {
  0% {
    color: #00b894;
  }
  20% {
    color: #00cec9;
  }
  40% {
    color: #0984e3;
  }
  60% {
    color: #6c5ce7;
  }
  80% {
    color: #e84393;
  }
  100% {
    color: #00b894;
  }
}
@keyframes bg-animate {
  0% {
    background-color: #00b894;
  }
  20% {
    background-color: #00cec9;
  }
  40% {
    background-color: #0984e3;
  }
  60% {
    background-color: #6c5ce7;
  }
  80% {
    background-color: #e84393;
  }
  100% {
    background-color: #00b894;
  }
}
@media screen and (max-width: 1200px) {
  .product-grid {
    margin: 0 0 30px;
  }
}
</style>
