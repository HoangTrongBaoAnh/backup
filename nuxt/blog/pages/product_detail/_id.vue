<template>
  <div class="productDetail">
    <form @submit.prevent="submit()">
      <section class="mb-5">
        <div class="row">
          <div class="col-lg-6">
            <div
              class="zoomer"
              style="display: flex; justify-content: center"
              v-if="images.normal_size.length"
            >
              <ProductZoomer
                :base-images="images"
                :base-zoomer-options="zoomerOptions"
              ></ProductZoomer>
            </div>
          </div>
          <div class="col-lg-6">
            <div>
              <div class="float-left">
                <h5>{{ posts.title }}</h5>
              </div>
              <div class="ml-4">
                <v-menu offset-y>
                  <template v-slot:activator="{ on, attrs }">
                    <v-btn color="primary" dark v-bind="attrs" v-on="on">
                      <v-icon>mdi-minus</v-icon>
                    </v-btn>
                  </template>
                  <v-list>
                    <v-list-item>
                      <v-rating
                        v-model.number="rating"
                        color="yellow darken-3"
                        background-color="grey darken-1"
                        empty-icon="$ratingFull"
                        half-increments
                        @change="rate()"
                        hover
                        large
                      ></v-rating>
                    </v-list-item>
                  </v-list>
                </v-menu>
              </div>
            </div>
            <div class="mt-2 text-muted text-uppercase small">
              {{ posts.category.content }}
            </div>

            <p>
              <span class="mr-1"
                ><strong>${{ posts.price }}</strong></span
              >
            </p>
            <p class="pt-1">
              Lorem ipsum dolor sit amet consectetur adipisicing elit. Numquam,
              sapiente illo. Sit error voluptas repellat rerum quidem, soluta
              enim perferendis voluptates laboriosam. Distinctio, officia quis
              dolore quos sapiente tempore alias.
            </p>
            <div class="table-responsive">
              <table class="table table-sm table-borderless mb-0">
                <tbody>
                  <tr>
                    <th class="pl-0 w-25" scope="row">
                      <strong>Model</strong>
                    </th>
                    <td>Shirt 5407X</td>
                  </tr>
                  <tr>
                    <th class="pl-0 w-25" scope="row">
                      <strong>Color</strong>
                    </th>
                    <td>Black</td>
                  </tr>
                  <tr>
                    <th class="pl-0 w-25" scope="row">
                      <strong>Delivery</strong>
                    </th>
                    <td>USA, Europe</td>
                  </tr>
                </tbody>
              </table>
            </div>
            <hr />
            <div class="table-responsive mb-2">
              <v-rating
                :value="productRating"
                color="yellow darken-3"
                background-color="grey darken-1"
                empty-icon="$ratingFull"
                half-increments
                readonly
                hover
                large
              ></v-rating>
              <table class="table table-sm table-borderless">
                <tbody>
                  <tr>
                    <td class="pl-0 pb-0">Quantity</td>
                  </tr>
                  <tr>
                    <td class="pl-0">
                      <b-input-group class="pt-2" style="width: 50%">
                        <b-input-group-prepend>
                          <b-btn variant="info" @click="decrement()">-</b-btn>
                        </b-input-group-prepend>

                        <b-form-input
                          type="number"
                          min="0.00"
                          :value="number"
                        ></b-form-input>

                        <b-input-group-append>
                          <b-btn variant="info" @click="increment()">+</b-btn>
                        </b-input-group-append>
                      </b-input-group>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
            <button type="submit" class="btn btn-primary btn-md mr-1 mb-2">
              <v-icon color="#fff">mdi-cart</v-icon>
              <div>Add to cart</div>
            </button>
          </div>
        </div>
      </section>
    </form>
    <div id="fb-root"></div>
    <div
      class="fb-share-button"
      v-bind:data-href="url"
      data-layout="button_count"
    >
      <a
        target="_blank"
        :href="
          'https://www.facebook.com/sharer/sharer.php?u=' +
          url +
          '&amp;src=sdkpreparse'
        "
        class="fb-xfbml-parse-ignore"
      >
        Chia sẻ
      </a>
    </div>
    <div class="productCategory">
      <h2>You may also interested in</h2>
      <v-slide-group show-arrows>
        <v-slide-item v-for="item in products" :key="item.id">
          <v-card width="300" class="ma-4">
            <v-card-title>
              {{ item.title }}
            </v-card-title>
            <nuxt-link
              :to="{ name: 'product_detail-id', params: { id: item.id } }"
            >
              <v-img
                lazy-src="https://picsum.photos/id/11/10/6"
                height="200"
                width="250"
                class="ma-4"
                :src="item.picture"
              ></v-img>
            </nuxt-link>

            <v-card-text>
              <b>{{ item.price }}€</b>
            </v-card-text>
          </v-card>
        </v-slide-item>
      </v-slide-group>
    </div>
  </div>
</template>

<script>
import img from "~/store/img";
import baseRequest from "~/store/baseRequest";
export default {
  data() {
    return {
      imgURL: null,
      //posts: [],
      current: null,
      imgs: [],
      images: {
        thumbs: [],
        normal_size: [],
      },
      products: [],
      number: 1,
      cart: [],
      img: [],

      rating: null,
      url: "https://shopping-app-d.herokuapp.com" + this.$route.path,
      zoomerOptions: {
        zoomFactor: 3,
        pane: "pane",
        hoverDelay: 300,
        namespace: "zoomer-bottom",
        move_by_click: false,
        scroll_items: 4,
        choosed_thumb_border_color: "#dd2c00",
        scroller_position: "bottom",
        zoomer_pane_position: "right",
      },
    };
  },
  async asyncData({ $axios, route }) {
    const { id } = route.params;

    const posts = await $axios.$post(
      "https://peaceful-journey-07506.herokuapp.com/api/shoe/show/" + id
    );
    const productRating = parseFloat(posts.rating);
    //posts.rating = parseInt(posts.rating);
    //console.log(posts.rating);

    // const posts = await $axios.$post(
    //       "http://peaceful-lowlands-39014.herokuapp.com/api/shoe/show/" + 5
    //     );
    return { posts, productRating };
  },
  beforeMount() {
    this.imgURL = img.get();
    this.getPosts();
  },
  mounted() {
    this.getProductwith();
    this.userRating();
    //console.log(this.posts);
  },
  watch: {
    rating() {
      this.rate();
    },
  },
  methods: {
    getProductwith: function () {
      const { id } = this.$route.params;
      baseRequest
        .get("shoe/sameCategory/" + id)
        .then((response) => {
          this.products = response.data;

          console.log(this.products);
        })
        .catch((errors) => {
          console.log(errors);
        });
    },
    changeSource: function (src) {
      console.log(src);
      this.current = src;
      //Your source-changing code here
    },
    userRating: function () {
      let data = new FormData();
      data.append("id", this.usersss.id);
      data.append("shoes_id", this.$route.params.id);
      baseRequest
        .post("rating/show", data)
        .then((response) => {
          //console.log(response.data);
          this.rating = parseFloat(response.data.rating);
          //this.loading = false;
        })
        .catch(function (error) {
          console.log(error);
        });
    },
    rate: function () {
      let data = new FormData();
      data.append("user_id", this.usersss.id);
      console.log(this.rating);
      data.append("shoes_id", this.$route.params.id);
      data.append("rating", this.rating);
      //console.log(this.$route.params.id);
      baseRequest
        .post("rating", data)
        .then((response) => {
          console.log(response.data);
          this.productRating = parseFloat(response.data.rating);
          //this.loading = false;
        })
        .catch(function (error) {
          console.log(error);
        });
    },
    decrement: function () {
      this.number--;
    },
    increment: function () {
      this.number++;
    },
    getPosts: function () {
      this.loading = true;
      baseRequest.get("image/" + this.$route.params.id).then((response) => {
        this.img = JSON.parse(JSON.stringify(response.data));
        let int = 0;
        this.images.thumbs.push({
          id: int,
          url: this.posts.picture,
        });
        this.images.normal_size.push({
          id: int,
          url: this.posts.picture,
        });
        // this.current = this.posts.picture;
        // this.imgs.push(this.posts.picture);
        for (const item in this.img) {
          this.imgs.push(this.img[item].picture);
          int++;
          this.images.thumbs.push({
            id: int,
            url: this.img[item].picture,
          });
          this.images.normal_size.push({
            id: int,
            url: this.img[item].picture,
          });
          //console.log(this.images);
        }
        console.log(this.images);
      });
    },
    submit: function () {
      this.cart = this.posts;
      this.cart.quantity = this.number;
      console.log(this.cart);
      this.$store.dispatch("addToCart", this.cart);
    },
  },
  head() {
    return {
      title: this.posts.title,
      meta: [
        { name: "description", content: "Connect and follow " },
        { property: "og:title", content: this.posts.title },
        //{ property: 'og:site_name', content: 'Epiloge'},
        { property: "og:description", content: "Connect and follow " },
        { property: "og:type", content: "article" },
        { property: "fb:app_id", content: "1449621782097242" },
        {
          property: "og:url",
          content: this.url,
        },
        {
          property: "og:image",
          content: this.posts.picture,
        },

        {
          property: "og:image:type",
          content: "image/jpeg",
        },
        {
          property: "og:image:width",
          content: "400",
        },
        {
          property: "og:image:height",
          content: "300",
        },
      ],
    };
  },
  //   mounted() {
  //     //console.log(this.url);
  //     this.getPosts(this.$route.params.id);
  //   },
  //   methods: {
  //       async getPosts(id) {
  //       const ip = (await this.$axios.$post(
  //         "http://localhost/blog/public/api/shoe/show/"+id
  //       ));
  //       this.posts = ip;
  //       console.log(this.posts);
  //     }
  //   },
  computed: {
    usersss() {
      return this.$store.state.user;
    },
    /*
        products(){
            return this.$store.state.products;
        },
        product(){
            return this.products.find(product => product.id === this.$route.params.id)
        }
        */
  },
  //   components: {
  //     Nav,
  //   },
};
</script>
<style>
/*****************globals*************/
body {
  font-family: "open sans";
  overflow-x: hidden;
}
.img-hover-zoom {
  height: auto; /* Modify this according to your need */
  overflow: hidden; /* Removing this will break the effects */
  /* box-shadow: 8px 8px white;
  border-radius: 10px;
  text-shadow: 2px 2px; */
}

.responsive-image {
  box-shadow: 3px 3px whitesmoke;
  border-radius: 10% !important;
  width: 500px;
  /* height: 400px; */
  margin-bottom: 10px;
}

.thumb-list {
  width: 500px !important;
}

.pane-container {
  left: 500px !important;
  border-radius: 10%;
}

.img-hover-zoom img {
  transition: transform 0.5s ease;
}

/* [3] Finally, transforming the image when container gets hovered */
.img-hover-zoom:hover img {
  transform: scale(1.5);
}

.zoomer-bottom-base-container {
  width: 400px !important;
}

.zoomer-bottom-base-container img {
  width: auto;
}

.zoomer-bottom-base-container .thumb-list {
  width: auto !important;
  /* width: fit-content !important; */
}

.productDetail .row {
  margin-top: 4rem;
}

.zoomer {
  /* display: flex;
  justify-content: center; */
}

button {
  border-radius: 5px !important;
}

.productCategory {
  margin-top: 5%;
}
</style>
