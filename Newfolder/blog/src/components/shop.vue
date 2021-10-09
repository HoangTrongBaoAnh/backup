<template>
  <section class="text-gray-700 body-font">
    <Nav class="pd-2" />
    <div class="container">
      <div class="row">
        <div class="col-3 p-2">
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
          <div class="form-check p-2" v-for="(item,index) in prices" :key="'price' + index">
            <input
              :value="index"
              v-model="selected.prices"
              :id="'price' + index"
              type="checkbox"
              class="form-check-input"
            />
            <label class="form-check-label" :for="'price' + index">
              {{ item.price }}
            </label>
          </div>
          <h3 class="mt-2">Publisher</h3>
          <div class="form-check p-2" v-for="item in publishers" :key="'publisher' + item.id">
            <input
              :value="item.id"
              v-model="selected.publishers"
              :id="'publisher' + item.id"
              type="checkbox"
              class="form-check-input"
            />
            <label class="form-check-label" :for="'publisher' + item.id">
              {{ item.content }}
            </label>
          </div> 
        </div>
        <div class="col-9">
          <div class="row text-center">
            <div class="col-4" v-for="product in posts" :key="product.id">
              <div>
                <router-link
                  :to="{ name: 'product_detail', params: { id: product.id } }"
                >
                  <img
                    height="70px"
                    width="100px"
                    :src="
                      'https://localhost/blog/public/images/' + product.picture
                    "
                    alt="Italian Trulli"
                  />
                </router-link>
                <div>
                  <p><span>Name </span>{{ product.title }}</p>
                  <p v-text="product.category"></p>
                </div>
                <div>
                  <h3>price {{ product.price }}</h3>
                </div>
              </div>
            </div>
          </div>
          <div class="text-center">
      <nav aria-label="Page navigation example">
        <ul class="pagination text-center">
          <li class="page-item" v-if="currentPage > 1">
            <a class="page-link" href="#" @click.prevent="currentPage--"
              >Previous</a
            >
          </li>
          <li class="page-item" v-for="page in totalPage" :key="page">
            <a class="page-link" href="#" @click.prevent="currentPage = page">{{
              page
            }}</a>
          </li>
          <li class="page-item" v-if="currentPage < totalPage">
            <a class="page-link" href="#" @click.prevent="currentPage++"
              >Next</a
            >
          </li>
        </ul>
      </nav>
    </div>
        </div>
      </div>
    </div>
    
    <!-- Messenger Plugin chat Code -->
    <div id="fb-root"></div>

    <!-- Your Plugin chat code -->
    <div id="fb-customer-chat" class="fb-customerchat"></div>
  </section>
</template>
<script>
const axios = require("axios");

import Nav from "./nav_header";
import baseRequest from "../core/baseRequest";
export default {
  data() {
    return {
      posts: [],
      currentPage: 1,
      totalPage: 0,
      categories: [],
      publishers: [],
      prices:[
        {
          
          price:"less than 50"
        },
        {
          
          price:"50 -> 100"
        },
        {
          
          price:"more than 100"
        },
      ],
      selected: {
        prices: [],
        categories: [],
        publishers: [],
      },
    };
  },
  mounted: function () {
    this.loadProducts();
    this.loadCategories();
    //this.getPublisers();
  },
  methods: {
    getPosts: function () {
      this.loading = true;
      baseRequest.get("shoe?page=" + this.currentPage).then((response) => {
        console.log(response.data.data);
        this.posts = response.data.data;
        this.totalPage = response.data.last_page;
        this.loading = false;
      });
    },
    filterMedia: function (e) {
      this.activeCategories = e.target.value;
      let data = new FormData();
      data.append("category", this.activeCategories);
      baseRequest
        .post("shoe/advanceSearch", data)
        .then((response) => {
          this.posts = response.data.data;
          this.totalPage = response.data.last_page;
          //this.getPosts();
          console.log(response.data.data);
        })
        .catch((error) => {
          console.log(error);
        });
    },
    getCategories: function () {
      this.loading = true;
      baseRequest.get("category").then((response) => {
        this.categories = response.data;
        //console.log(this.categories);
      });
    },
    /*
    getPublisers: function () {
      //this.loading = true;
      baseRequest.get("publisher").then((response) => {
        this.publishers = response.data;
        //console.log(response.data);
      });
    },
    */
    loadProducts: function () {
      let data = new FormData();
      data.append("categories", this.selected.categories);
      data.append("prices", this.selected.prices);
      data.append("publishers", this.selected.publishers);
      axios
        .get("http://localhost/blog/public/api/shoe", {
          params: {
            categories: this.selected.categories,
            prices: this.selected.prices,
            //publishers: this.selected.publishers,
          },
        })
        .then((response) => {
          this.posts = response.data.data;
          this.totalPage = response.data.last_page;
          //this.loading = false;
        })
        .catch(function (error) {
          console.log(error);
        });
    },
    loadCategories: function () {
      axios
        .get("http://localhost/blog/public/api/category", {
          params: {
            categories: this.selected.categories,
          },
        })
        .then((response) => {
          this.categories = response.data;
        })
        .catch(function (error) {
          console.log(error);
        });
    },
  },
  watch: {
    currentPage() {
      this.getPosts();
    },
    selected: {
      handler: function () {
        this.loadProducts();
        this.loadCategories();
        //console.log(this.selected);
      },
      deep: true,
    },
  },
  computed: {
    /*
        products(){
            return this.$store.state.products;
        },
        
        totalPage(){
            return this.$store.state.pagination.totalPage;
        },
        */
  },
  components: {
    Nav,
  },
};
</script>
