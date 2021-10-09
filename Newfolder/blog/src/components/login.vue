<template>
  <div class="container">
    <div class="row">
      <form class="col-4 mx-auto" @submit.prevent="Login()">
        <h2>Login</h2>
        <div class="input-group has-validation form-group">
          <label for="exampleInputEmail1">Email address</label>
          <input
            type="email"
            class="form-control"
            id="exampleInputEmail1"
            v-model="user.email"
            placeholder="Enter email"
            :class="{ 'is-invalid': errors.email }"
          />
          <div v-if="errors.email" class="invalid-feedback">
            {{ errors.email[0] }}
          </div>
        </div>
        <div class="form-group">
          <label for="exampleInputPassword1">Password</label>
          <input
            type="password"
            class="form-control"
            id="exampleInputPassword1"
            v-model="user.password"
            placeholder="Password"
          />
        </div>
        <button type="submit" class="btn btn-primary">
          <span v-if="loading" class="spinner-border"></span>
          Submit
        </button>
      </form>
    </div>
  </div>
</template>

<script>
import baseRequest from "../core/baseRequest";

export default {
  data() {
    return {
      user: {
        email: "",
        password: "",
      },
      errors: {},
      loading: false,
    };
  },
  methods: {
    Login: function () {
      this.loading = true;
      baseRequest
        .post("login", this.user)
        .then((response) => {
          window.localStorage.setItem("token", response.data.token);
          console.log(response.data);
          this.$store.commit('updateUser', response.data)
          this.$router.push({ name: "admin" });
        })
        .catch((error) => {
          this.logloading = false;
          this.errors = error.response.data.errors;
        });
    },
  },
};
</script>
<style></style>
