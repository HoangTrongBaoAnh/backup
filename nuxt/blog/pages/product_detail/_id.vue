<template>
  <div>
    <form @submit.prevent="submit()">
      <div class="container p-2" v-if="posts">
        <img
          height="70px"
          width="100px"
          :src="'https://localhost/blog/public/images/' + posts.picture"
          alt="Italian Trulli"
        />
        <p v-text="posts.title"></p>
        <p v-text="posts.category"></p>
        <p v-text="posts.price"></p>
        <b-input type="number" min="1" v-model.number=number />
        <div class="quantity">
    <b-input-group>
      <b-input-group-prepend>
        <b-btn variant="info" @click="decrement()">-</b-btn>
      </b-input-group-prepend>

      <b-form-input type="number" min="0.00" :value="number"></b-form-input>

      <b-input-group-append>
        <b-btn variant="info" @click="increment()">+</b-btn>
      </b-input-group-append>
    </b-input-group>
  </div>
        <button type="submit">Add to Cart</button>
      </div>
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
  </div>
</template>
<script>
export default {
  data() {
    return {
      //posts: [],
      number: 1,
      cart:[],
      url:
        "http://2ac0-2405-4802-b2b6-f4e0-388b-b096-4db6-b2cc.ngrok.io" +
        this.$route.path
    };
  },
  async asyncData({ $axios, route }) {
    const { id } = route.params;
    //console.log(id);
    const posts = await $axios.$post(
      "http://localhost/blog/public/api/shoe/show/" + id
    );
    return { posts };
  },
  methods: {
    decrement: function(){
      this.number--;
    },
    increment:function(){
      this.number++;
    },
    submit: function(){
      this.cart = this.posts;
      this.cart.quantity = this.number;
      console.log(this.cart)
      this.$store.commit('addToCart', this.cart)
    }
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
          content: this.url
        },
        {
          property: "og:image",
          content:
            "https://static.wixstatic.com/media/56a444_9273e80a60684dc8b38e56025059f356%7Emv2_d_3200_1800_s_2.png"
        },

        {
          property: "og:image:type",
          content: "image/jpeg"
        },
        {
          property: "og:image:width",
          content: "400"
        },
        {
          property: "og:image:height",
          content: "300"
        }
      ]
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
    /*
        products(){
            return this.$store.state.products;
        },
        product(){
            return this.products.find(product => product.id === this.$route.params.id)
        }
        */
  }
  //   components: {
  //     Nav,
  //   },
};
</script>
