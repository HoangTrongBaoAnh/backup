<template>
  <v-app v-if="isloaded"> </v-app>
</template>
<script>
import baseRequest from "~/store/baseRequest";
export default {
  layout: "admin",
  data() {
    return {
      isloaded: false,
      user: {}
    };
  },
  // async asyncData({ $axios, store }) {
  //   const token = store.state.user.token;
  //   // // $axios.onRequest(config => {
  //   // //   if (store.state.user.token) {
  //   // //     config.headers.common["Authorization"] = "Bearer " + token;
  //   // //   }
  //   // // });
  //   // if (process.client) {
  //   //   this.$axios.setToken(token, 'Bearer');
  //   //   this.$axios.setHeader('Content-Type', 'application/json', [
  //   //   'post'
  //   // ])

  //   //}
  //   console.log(token);
  //   //$axios.setToken(token, 'Bearer');
  //   $axios.setHeader('Authorization', "Bearer " + token);
  //   const posts = await $axios.$post(
  //     "http://localhost/blog/public/api/user/role"
  //   );
  //   console.log(posts);

  //   return { posts };
  // },
  mounted() {
    this.Checkedrole();
  },
  methods: {
    Checkedrole: function() {
      baseRequest
        .post("user/role")
        .then(response => {
          let admin = response.data.roles.find(t => t.name == "admin");
          if (admin == null) {
            // this.$router.push({name:'error-name', params:{name: '403'}});
            return this.$nuxt.error({
              statusCode: 403,
              message: "You dont have access to this page"
            });
            //console.log("not admin");
          } else {
            this.isloaded = true;
            this.user = response.data;
            console.log(response.data);
          }
        })
        .catch(() => {
          this.$router.push({ name: "login" });
        });
    }
  }
};
</script>
