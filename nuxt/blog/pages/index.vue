<template>
  <div id="main">
    <div class="">
      <v-img
        :src="'https://static.vecteezy.com/system/resources/previews/000/669/988/non_2x/vector-shopping-online-banner.jpg'"
      ></v-img>
      <!-- <v-carousel height="600px">
        <v-carousel-item
          v-for="(item, i) in items"
          :key="i"
          :src="item.src"
        ></v-carousel-item>
      </v-carousel> -->
    </div>
    <div>
      <div class="text-center pt-4">
        <h2 class="ntitle">Best Sale Product</h2>
      </div>
      <div>
        <div class="row">
          <div
            class="col-lg-3 col-md-6"
            v-for="item in products"
            :key="item.id"
          >
            <v-card class="mx-auto my-12" max-width="374">
              <template slot="progress">
                <v-progress-linear
                  color="deep-purple"
                  height="10"
                  indeterminate
                ></v-progress-linear>
              </template>
              <nuxt-link
                :to="{ name: 'product_detail-id', params: { id: item.id } }"
              >
                <v-img height="250" :src="item.picture"></v-img>
              </nuxt-link>

              <v-card-title>{{ item.title }}</v-card-title>

              <v-card-text>
                <v-row align="center" class="mx-0">
                  <v-rating
                    :value="item.rating"
                    color="amber"
                    dense
                    half-increments
                    readonly
                    size="14"
                  ></v-rating>

                  <div class="grey--text ms-4">{{ item.rating }} (413)</div>
                </v-row>

                <div class="my-4 text-subtitle-1">$ • {{ item.price }}</div>

                <div>
                  {{ item.content }}
                </div>
              </v-card-text>

              <v-divider class="mx-4"></v-divider>

              <v-card-actions>
                <v-btn
                  color="deep-purple lighten-2"
                  text
                  @click="$store.commit('addToCart', item)"
                >
                  Buy
                </v-btn>
              </v-card-actions>
            </v-card>
          </div>
        </div>
        <div class="text-center m-4">
          <h2 class="ntitle">New Product</h2>
        </div>
        <div class="mx-auto">
          <v-lazy
            v-model="isActive"
            :options="{
              threshold: 0.8,
            }"
            min-height="200"
            transition="scroll-y-transition"
          >
            <div class="row">
              <div class="col-4" v-for="item in newproduct" :key="item.id">
                <v-card class="mx-auto" max-width="336">
                  <v-card-title>{{ item.title }}</v-card-title>
                  <nuxt-link
                    :to="{ name: 'product_detail-id', params: { id: item.id } }"
                  >
                    <v-img
                      max-height="200"
                      :src="item.picture"
                      style="margin: 16px"
                    ></v-img>
                  </nuxt-link>
                  <v-card-text>
                    {{ item.content }}
                  </v-card-text>
                </v-card>
              </div>
            </div>
          </v-lazy>
        </div>
        <div class="mx-auto m-4 tabslide">
          <v-tabs
            v-model="tab"
            centered
            background-color="transparent"
            color="basil"
          >
            <v-tab
              v-for="item in categories"
              :key="item.id"
              @click="changeTab(item.id)"
            >
              {{ item.title }}
            </v-tab>
          </v-tabs>

          <v-tabs-items v-model="tab" class="m-4">
            <v-tab-item v-for="item in categories" :key="item.id">
              <v-slide-group class="mySlider pa-4" show-arrows color="dark">
                <v-slide-item v-for="n in products_ca" :key="n.id">
                  <v-card class="ma-4" width="250">
                    <nuxt-link
                      :to="{
                        name: 'product_detail-id',
                        params: { id: n.id },
                      }"
                    >
                      <v-img height="250" :src="n.picture"></v-img>
                    </nuxt-link>

                    <v-card-title>{{ n.title }}</v-card-title>

                    <v-card-text>
                      <v-row align="center" class="mx-0">
                        <v-rating
                          :value="parseFloat(n.rating)"
                          color="amber"
                          dense
                          half-increments
                          readonly
                          size="14"
                        ></v-rating>

                        <div class="grey--text ms-4">{{ n.rating }} (413)</div>
                      </v-row>

                      <div class="my-4 text-subtitle-1">$ • {{ n.price }}</div>

                      <div>
                        {{ n.content }}
                      </div>
                    </v-card-text>

                    <v-divider class="mx-4"></v-divider>

                    <v-card-actions>
                      <v-btn
                        color="deep-purple lighten-2"
                        text
                        @click="$store.commit('addToCart', n)"
                      >
                        BUY
                      </v-btn>
                    </v-card-actions>
                  </v-card>
                </v-slide-item>
              </v-slide-group>
            </v-tab-item>
          </v-tabs-items>
        </div>

        <!-- <v-slide-group class="pa-4" show-arrows>
          <v-slide-item v-for="n in 15" :key="n">
            <v-img
              lazy-src="https://picsum.photos/id/11/10/6"
              height="100"
              width="100"
              class="ma-4"
              src="https://picsum.photos/id/11/500/300"
            ></v-img>
          </v-slide-item>
        </v-slide-group> -->

        <div class="brands">
          <div>
            <div class="row">
              <div class="col-2">
                <img
                  src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/97/Godrej_Logo.svg/2560px-Godrej_Logo.svg.png"
                  alt="logo"
                />
              </div>
              <div class="col-2">
                <img
                  src="https://cdn.tgdd.vn/Files/2019/03/12/1154295/oppo-logo-old_600x277.jpg"
                  alt="logo"
                />
              </div>
              <div class="col-2">
                <img
                  src="https://haitrieu.com/wp-content/uploads/2022/01/Logo-Cocacola-Re.png"
                  alt="logo"
                />
              </div>
              <div class="col-2">
                <img
                  src="https://cdn.pixabay.com/photo/2015/05/26/09/37/paypal-784404__480.png"
                  alt="logo"
                />
              </div>
              <div class="col-2">
                <img
                  src="https://shojiki.vn/template/uploads/2021/04/philips-logo.jpg"
                  alt="logo"
                />
              </div>
              <div class="col-2">
                <img
                  src="https://cdn0.fahasa.com/media/wysiwyg/NXB/Logo-IPM.jpg"
                  alt="logo"
                />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import baseRequest from "~/store/baseRequest";
export default {
  data() {
    return {
      tab: null,

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
      products: [],
      isActive: false,
      img: [],
      products_ca: [],
      newproduct: [],
    };
  },
  async asyncData({ $axios, route }) {
    //const { id } = route.params;
    //console.log(id);
    const categories_pa = await $axios.$get(
      "https://peaceful-journey-07506.herokuapp.com/api/category"
    );
    const categories = await $axios.$get(
      "https://peaceful-journey-07506.herokuapp.com/api/childcategory/" +
        categories_pa[0].id
    );
    return { categories, categories_pa };
  },
  mounted() {
    this.getProducts();
    // this.getPosts();
    this.getNewProduct();
    this.changeTab(this.categories[0].id);
  },
  methods: {
    changeTab: function (id) {
      let data = new FormData();
      data.append("id", id);
      baseRequest
        .post("shoe/childCategory", data)
        .then((response) => {
          this.products_ca = response.data;
          //console.log(this.childcategories);
        })
        .catch((errors) => {
          console.log(errors);
        });
    },
    // getPosts: function () {
    //   this.loading = true;
    //   baseRequest.get("childcategory/" + 1).then((response) => {
    //     this.img = response.data;
    //     //console.log(this.img);
    //   });
    // },
    getProducts: function () {
      baseRequest
        .get("shoe/bestSaleProduct")
        .then((response) => {
          this.products = response.data;
          this.products.forEach(element => {
            let rating = element.rating;
            element.rating = parseFloat(rating);
          });
          //this.products.rating = parseFloat(response)
          //console.log(this.childcategories);
        })
        .catch((errors) => {
          console.log(errors);
        });
    },
    getNewProduct: function () {
      baseRequest
        .get("shoe/newproduct")
        .then((response) => {
          this.newproduct = response.data;
          // this.newproduct.forEach(element => {
          //   let rating = element.rating;
          //   element.rating = parseFloat(rating);
          // });
          //console.log(this.childcategories);
        })
        .catch((errors) => {
          console.log(errors);
        });
    },
  },
};
</script>
<style>
#main {
  padding-top: 20px;
}
* {
  text-decoration: none !important;
}
.mySlider {
  /* background-color: #b9b8b1; */
}
.row-full {
  width: 100vw;
  position: relative;
  margin-left: -50vw;
  height: 100px;
  margin-bottom: 50%;
  left: 49%;
}
.col-5 {
  width: 160px;
}

.col-2 img {
  width: 100%;
  cursor: pointer;
  filter: grayscale(100%);
}

.col-2 img:hover {
  filter: none;
}

.brands {
  margin-top: 15%;
}

.brands .row {
  align-items: center;
  margin-top: 15%;
}

.tabslide {
  margin-top: 15% !important;
}

.mySlider {
  border: 1px solid #495057;
  border-radius: 15px;
}

.v-slide-group__prev,
.v-slide-group__next {
  background-color: gray;
  border-radius: 10px;
}

.v-slide-group__prev i,
.v-slide-group__next i {
  color: aliceblue !important;
  font-size: 30px !important;
}

.v-slide-group__prev:hover,
.v-slide-group__next:hover {
  background-color: orange;
  border-radius: 10px;
}

.v-image {
  border-radius: 10px;
  border: 1px solid rgba(0, 0, 0, 0.05);
}

.ntitle {
  text-align: center;
  margin: 50px auto 80px;
  position: relative;
  line-height: 60px !important;
  color: #555;
  font-size: 2rem;
}

.ntitle::after {
  content: "";
  background: #ff523b;
  width: 80px;
  height: 5px;
  border-radius: 5px;
  position: absolute;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
}
</style>