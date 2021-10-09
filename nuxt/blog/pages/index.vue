<template>
  <v-row>
    <v-col cols="3">
      <h2>Category</h2>
      <div class="form-check p-2" v-for="item in categories" :key="item.id">
        <input
          :value="item.id"
          v-model="selected.categories"
          :id="'category' + item.id"
          type="checkbox"
          class="form-check-input"
        />
        <label class="form-check-label" :for="'category' + item.id">
          {{ item.content }} ({{ item.shoe_count }})
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
          {{ item.content }}
        </label>
      </div>
      <h3 class="mt-2">Publisher</h3>
    </v-col>
    <v-col cols="9">
      <v-select
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
            {{ selection.content.content }}
          </v-chip>
        </v-col>
      </div>
      <div class="row text-center">
        <div
          class="col-md-4"
          v-for="product in posts"
          :key="product.id"
        >
          <div class="product-grid">
            <div class="product-image">
              <a href="#" class="image">
                <img
                  class="pic-1"
                  :src="
                    'https://localhost/blog/public/images/' + product.picture
                  "
                />
                <img
                  class="pic-2"
                  :src="
                    'https://localhost/blog/public/images/' + product.picture
                  "
                />
              </a>
              <ul class="product-links">
                <li>
                  <a href="#"><b-icon icon="cart3"></b-icon></a>
                </li>
                <li>
                  <a href="#"><i class="fab fa-algolia"></i></a>
                </li>
                <li>
                  <a href="#"><i class="fas fa-random"></i></a>
                </li>
                <li>
                  <a href="#"><i class="fas fa-search"></i></a>
                </li>
              </ul>
            </div>
            <div class="product-content">
              <ul class="rating">
                <li class="fa fa-star"></li>
                <li class="fa fa-star"></li>
                <li class="fa fa-star"></li>
                <li class="fa fa-star"></li>
                <li class="far fa-star"></li>
              </ul>
              <h3 class="title">
                <a href="#">{{ product.title }}</a>
              </h3>
              <div class="price">${{ product.price }}</div>
            </div>
          </div>
        
        </div>
      </div>
      <div class="text-center">
        <v-pagination v-model="currentPage" :length="totalPage"></v-pagination>
      </div>
    </v-col>
  </v-row>
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
export default {
  data() {
    return {
      posts: [],
      loading: false,
      currentPage: 1,
      totalPage: 0,
      categories: [],
      publishers: [],
      prices: [
        {
          id: 0,
          content: "less than 50"
        },
        {
          id: 1,
          content: "50 -> 100"
        },
        {
          id: 2,
          content: "more than 100"
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
        orders: 2
      }
    };
  },
  mounted() {
    this.loadProducts();
    this.loadCategories();
  },
  watch: {
    currentPage() {
      this.loadProducts();
    },
    selected: {
      handler: function() {
        this.loadProducts();
        this.loadCategories();
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
        let index_category = this.selected.categories.findIndex(
          x => x == selection.content.id
        );
        //console.log(this.selected.categories);
        //console.log(index_category);
        this.selected.categories.splice(index_category, 1);
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
              orders: this.selected.orders
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

      for (const selection of this.selected.categories) {
        let index = this.categories.findIndex(x => x.id == selection);
        selections.push({ id: 0, content: this.categories[index] });
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
.v-input {
  width: 30%;
}

.product-grid {
  background-color: #fff;
  font-family: "Work Sans", sans-serif;
  text-align: center;
  transition: all 0.3s ease 0s;
}
.product-grid:hover {
  box-shadow: 0 0 20px -10px rgba(237, 29, 36, 0.3);
}
.product-grid .product-image {
  overflow: hidden;
  position: relative;
  transition: all 0.3s ease 0s;
}
.product-grid:hover .product-image {
  border-radius: 0 0 30px 30px;
}
.product-grid .product-image a.image {
  display: block;
}
.product-grid .product-image img {
  width: 100%;
  height: auto;
}
.product-image .pic-1 {
  backface-visibility: hidden;
  transition: all 0.5s ease 0s;
}
.product-grid:hover .product-image .pic-1 {
  opacity: 0;
}
.product-image .pic-2 {
  width: 100%;
  height: 100%;
  backface-visibility: hidden;
  opacity: 0;
  position: absolute;
  top: 0;
  left: 0;
  transition: all 0.5s ease 0s;
}
.product-grid:hover .product-image .pic-2 {
  opacity: 1;
}
.product-grid .product-links {
  padding: 0;
  margin: 0;
  list-style: none;
  opacity: 0;
  position: absolute;
  bottom: 0;
  right: 10px;
  transition: all 0.3s ease 0s;
}
.product-grid:hover .product-links {
  opacity: 1;
}
.product-grid .product-links li {
  margin: 0 0 10px 0;
  transform: rotate(360deg) scale(0);
  transition: all 0.3s ease 0s;
}
.product-grid:hover .product-links li {
  transform: rotate(0) scale(1);
}
.product-grid:hover .product-links li:nth-child(3) {
  transition-delay: 0.1s;
}
.product-grid:hover .product-links li:nth-child(2) {
  transition-delay: 0.2s;
}
.product-grid:hover .product-links li:nth-child(1) {
  transition-delay: 0.3s;
}
.product-grid .product-links li a {
  color: #666;
  background-color: #fff;
  font-size: 18px;
  line-height: 42px;
  width: 40px;
  height: 40px;
  border-radius: 50px;
  display: block;
  transition: all 0.3s ease 0s;
}
.product-grid .product-links li a:hover {
  color: #fff;
  background-color: #ed1d24;
}
.product-grid .product-content {
  text-align: left;
  padding: 15px 10px;
}
.product-grid .rating {
  padding: 0;
  margin: 0 0 7px;
  list-style: none;
}
.product-grid .rating li {
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
@media screen and (max-width: 990px) {
  .product-grid {
    margin: 0 0 30px;
  }
}
</style>
