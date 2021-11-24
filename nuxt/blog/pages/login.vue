<template>
  <div class="container">
    <div class="row">
      <form class="col-4 mx-auto" @submit.prevent="Login()">
        <h2>Login</h2>
        <div class="form-group">
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
            :class="{ 'is-invalid': errors.password }"
          />
        </div>
        <div
          style="display: block"
          v-if="errors.password"
          class="invalid-feedback"
        >
          {{ errors.password[0] }}
        </div>
        <button type="submit" class="btn btn-primary m-1">
          <span v-if="loading" class="spinner-border"></span>
          Submit
        </button>
      </form>
    </div>
  </div>
</template>

<script>
import baseRequest from "../store/baseRequest";

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
    async Login() {
      
        this.loading = true;
        await baseRequest
          .post("login", this.user)
          .then((response) => {
            window.localStorage.setItem("token", response.data.token);
            console.log(response.data);
            this.$store.commit("updateUser", response.data);
            this.$router.push({ name: "index", params: { snackbar: 'true' },  });
          })
          .catch((error) => {
            if (error.response.status === 401) {
              app.nuxt.error = () => {}
            }
            this.logloading = false;
            console.log(error.response.data);
            this.errors = error.response.data.errors;
          });
      
    },
  },
};
</script>
<style></style>
