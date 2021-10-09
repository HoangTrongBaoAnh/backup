<template>
  <div>
    <Nav class="pd-2" />
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
      <button @click="$store.commit('addToCart', posts)">Add to Cart</button>
    </div>
    <div id="fb-root"></div>
    <div
      class="fb-share-button"
      v-bind:data-href="url"
      data-layout="button_count"
    >
      <a
        target="_blank"
        :href="'https://www.facebook.com/sharer/sharer.php?u='+url+'&amp;src=sdkpreparse'"
        class="fb-xfbml-parse-ignore"
      >
        Chia sẻ
      </a>
    </div>
  </div>
</template>
<script>
import Nav from "./nav_header";
import baseRequest from "../core/baseRequest";
export default {
  data() {
    return {
      posts: [],
      url: "http://2ac0-2405-4802-b2b6-f4e0-388b-b096-4db6-b2cc.ngrok.io" + this.$route.path,
    };
  },
  metaInfo() {
    return {
      title: `${this.posts.title}`,
      htmlAttrs: {
        lang: "en",
        amp: true,
      },
      meta: [
        { name: "description", content: "Connect and follow " },
        { property: "og:title", content: this.posts.title },
        //{ property: 'og:site_name', content: 'Epiloge'},
        //{ property: 'og:description', content: 'Connect and follow ' + this.userData.name + ' on Epiloge - ' + this.userData.tagline},
        { property: "og:type", content: "article" },
        {
          property: "og:url",
          content: this.url,
        },
        {
          property: "og:image",
          content: "https://localhost/blog/public/images/" + this.posts.picture,
        },
      ],
    };
  },
  mounted() {
    console.log(this.url);
    this.getPosts(this.$route.params.id);
  },
  methods: {
    getPosts: function(id) {
      this.loading = true;
      baseRequest.post("shoe/show/" + id).then((response) => {
        this.posts = response.data;
        console.log(this.posts);
      });
    },
  },
  computed: {
    /*
        products(){
            return this.$store.state.products;
        },
        product(){
            return this.products.find(product => product.id === this.$route.params.id)
        }
        */
  },
  components: {
    Nav,
  },
};
</script>
