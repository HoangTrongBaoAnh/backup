<template>
  <div id="main">
    <div class="row row-full">
      <v-carousel height="600px">
        <v-carousel-item
          v-for="(item, i) in items"
          :key="i"
          :src="item.src"
        ></v-carousel-item>
      </v-carousel>
    </div>
    <div>
      <div class="text-center">
        <p>Best Sale Product</p>
      </div>
      <div>
        <div class="row">
          <div class="col-3" v-for="item in products" :key="item.id">
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
                <v-img
                  height="250"
                  :src="'http://localhost/blog/public/images/' + item.picture"
                ></v-img>
              </nuxt-link>

              <v-card-title>{{ item.title }}</v-card-title>

              <v-card-text>
                <v-row align="center" class="mx-0">
                  <v-rating
                    :value="4.5"
                    color="amber"
                    dense
                    half-increments
                    readonly
                    size="14"
                  ></v-rating>

                  <div class="grey--text ms-4">4.5 (413)</div>
                </v-row>

                <div class="my-4 text-subtitle-1">$ • Italian, Cafe</div>

                <div>
                  Small plates, salads & sandwiches - an intimate setting with
                  12 indoor seats plus patio seating.
                </div>
              </v-card-text>

              <v-divider class="mx-4"></v-divider>

              <v-card-actions>
                <v-btn
                  color="deep-purple lighten-2"
                  text
                  @click="$store.commit('addToCart', item)"
                >
                  Reserve
                </v-btn>
              </v-card-actions>
            </v-card>
          </div>
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
              <div class="col-4" v-for="n in 3" :key="n">
                <v-card class="mx-auto" max-width="336">
                  <v-card-title>Card title</v-card-title>

                  <v-card-text>
                    Phasellus magna. Quisque rutrum. Nunc egestas, augue at
                    pellentesque laoreet, felis eros vehicula leo, at malesuada
                    velit leo quis pede. Aliquam lobortis. Quisque libero metus,
                    condimentum nec, tempor a, commodo mollis, magna. In turpis.
                    In dui magna, posuere eget, vestibulum et, tempor auctor,
                    justo. In turpis. Pellentesque dapibus hendrerit tortor. Ut
                    varius tincidunt libero.
                  </v-card-text>
                </v-card>
              </div>
            </div>
          </v-lazy>
        </div>
        <div class="mx-auto m-4">
          <v-tabs
            v-model="tab"
            background-color="transparent"
            color="basil"
            grow
          >
            <v-tab
              v-for="item in categories"
              :key="item.id"
              @click="changeTab(item.id)"
            >
              {{ item.title }}
            </v-tab>
          </v-tabs>

          <v-tabs-items v-model="tab">
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
                      <v-img
                        height="200"
                        :src="
                          'http://localhost/blog/public/images/' + n.picture
                        "
                      ></v-img>
                    </nuxt-link>

                    <v-card-title>{{ n.title }}</v-card-title>

                    <v-card-text>
                      <v-row align="center" class="mx-0">
                        <v-rating
                          :value="4.5"
                          color="amber"
                          dense
                          half-increments
                          readonly
                          size="14"
                        ></v-rating>

                        <div class="grey--text ms-4">4.5 (413)</div>
                      </v-row>

                      <div class="my-4 text-subtitle-1">$ • Italian, Cafe</div>

                      <div>
                        Small plates, salads & sandwiches - an intimate setting
                        with 12 indoor seats plus patio seating.
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

        <v-slide-group class="pa-4" show-arrows>
          <v-slide-item v-for="n in 15" :key="n">
            <v-img
              lazy-src="https://picsum.photos/id/11/10/6"
              height="100"
              width="100"
              class="ma-4"
              src="https://picsum.photos/id/11/500/300"
            ></v-img>
          </v-slide-item>
        </v-slide-group>
      </div>
    </div>
    <v-snackbar color="green" v-model="snackbar">
        {{ snackbarText }}
        <v-icon green>mdi-checkbox-marked-circle</v-icon>
        <template v-slot:action="{ attrs }">
          <v-btn text v-bind="attrs" @click="snackbar = false"> Close </v-btn>
        </template>
      </v-snackbar>
  </div>
</template>
<script>
import baseRequest from "~/store/baseRequest";
export default {
  data() {
    return {
      tab: null,
      snackbar: false,
      snackbarText: "",
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
    };
  },
  async asyncData({ $axios, route }) {
    //const { id } = route.params;
    //console.log(id);
    const categories_pa = await $axios.$get(
      "http://localhost/blog/public/api/category"
    );
    const categories = await $axios.$get(
      "http://localhost/blog/public/api/childcategory/" + categories_pa[0].id
    );
    return { categories, categories_pa };
  },
  mounted() {
    this.getProducts();
    // this.getPosts();

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
* {
  text-decoration: none !important;
}
.mySlider{
  background-color:#B9B8B1;
}
.row-full {
  width: 100vw;
  position: relative;
  margin-left: -50vw;
  height: 100px;
  margin-bottom: 50%;
  left: 49%;
}
</style>