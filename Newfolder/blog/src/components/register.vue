<template>
  <div>
    <form @submit.prevent="CreatePost()">
      <div class="form-group">
        <label>Enter Name</label>
        <input type="text" class="form-control" v-model="user.name" />
      </div>
      <div class="form-group">
        <label>Enter Email</label>
        <input type="text" class="form-control" v-model="user.email" />
      </div>
      <div class="form-group">
        <label>Enter password</label>
        <input type="text" class="form-control" v-model="user.password" />
      </div>
      <br />
      <div align="center">
        <button type="submit" class="btn btn-primary">Submit</button>
      </div>
    </form>
  </div>
</template>
<script>
import baseRequest from "../core/baseRequest";
export default {
  data() {
    return {
      user: {
        name: "",
        password: "",
        email: "",
      },
    };
  },
  methods: {
    CreatePost: function () {
      baseRequest
        .post("register", this.user)
        .then((response) => {
          console.log(response);
          this.$router.push({ name: "Login" });
        })
        .catch((error) => {
          console.log(error);
        });
    },
  },
};
</script>
<style></style>
