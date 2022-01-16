<template>
  <section class="text-gray-700 body-font">
    <Nav class="pd-2" />
    <div class="container">
      <div class="row">
        <div class="row text-center">
          <div class="col-4" v-for="product in posts" :key="product.id">
            <div>
              <router-link
                :to="{ name: 'product_detail', params: { id: product.Id } }"
              >
              </router-link>
              <div>
                <p>{{ product.Name }}</p>
                <p v-text="product.category"></p>
              </div>
              <div>
                <h3>price {{ product.price }}</h3>
              </div>
            </div>
          </div>
        </div>
        <div class="text-center"></div>
      </div>
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
  </section>
</template>
<script>
const axios = require("axios");

import Nav from "./nav_header";
export default {
  data() {
    return {
      posts: [],
      currentPage: 1,
      totalPage: 0,
      categories: [],
    };
  },
  mounted: function () {
    // this.loadProducts();
    // this.loadCategories();
    //this.getPublisers();
    this.getPosts();
  },
  methods: {
    getPosts: function () {
      this.loading = true;
      axios
        .get(
          "https://localhost:44346/api/category?itemsperpage=3" +
            "&Page=" +
            this.currentPage
        )
        .then((response) => {
          this.posts = response.data;
          this.totalPage = JSON.parse(
            response.headers["x-pagination"]
          ).TotalPages;
          console.log(JSON.parse(response.headers["x-pagination"]).TotalPages);
          this.loading = false;
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
