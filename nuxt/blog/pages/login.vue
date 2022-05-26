<template>
  <div class="login">
    <div class="row">
      <div class="login__left col-lg-5">
        <div class="polygon2"></div>
        <div class="polygon1"></div>
        <div class="ellipse2"></div>
        <div class="rectangle2"></div>
        <div class="login__left__signContent">
          <div>
            <h2>Welcome Back!</h2>
            <p>To keep connected with us plase login with your personal info</p>
          </div>
          <div>
            <button>
              <nuxt-link class="nav-link" :to="{ name: 'register' }">
                Register
            </nuxt-link>
            </button>
          </div>
        </div>
      </div>
      <div class="login__right col-lg-7">
        <form @submit.prevent="Login()">
          <h2>Sign In</h2>
          <div class="form-group">
            <v-text-field
              v-model="user.email"
              outlined
              :rules="[rules.required, rules.email]"
              label="E-mail"
              :error="errors.email ? true : false"
            ></v-text-field>
            <div v-if="errors.email" class="invalid-feedback">
              {{ errors.email[0] }}
            </div>
          </div>
          <div class="form-group">
            <v-text-field
              v-model="user.password"
              outlined
              :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
              :type="show1 ? 'text' : 'password'"
              :rules="[rules.required, rules.counter]"
              @click:append="show1 = !show1"
              label="Password"
              :error="errors.email ? true : false"
              :class="{ 'is-invalid': errors.password }"
            ></v-text-field>
            <div
              style="display: block"
              v-if="errors.password"
              class="invalid-feedback"
            >
              {{ errors.password[0] }}
            </div>
          </div>

          <button type="submit" class="formButton">
            <div>
              <span v-if="loading" class="spinner-border"></span>
              <div>Submit</div>
            </div>
          </button>
        </form>
      </div>
    </div>
    <div class="ellipse"></div>
    <div class="rectangle"></div>
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
      show1: false,
      errors: {},
      loading: false,
      rules: {
        required: (value) => !!value || "Required.",
        counter: (value) => value.length <= 20 || "Max 20 characters",
        email: (value) => {
          const pattern =
            /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
          return pattern.test(value) || "Invalid e-mail.";
        },
      },
    };
  },
  methods: {
    async Login() {
      this.loading = true;
      await baseRequest
        .post("login", this.user)
        .then((response) => {
          window.localStorage.setItem("token", response.data.token);
          //console.log(response.data);
          this.$store.dispatch("updateUser", response.data);
          //this.$store.commit("updateUser", response.data);
          this.$router.push({ path: "/", params: { snackbar: "true" } });
        })
        .catch((error) => {
          // if (error.response.status === 401) {
          //   app.nuxt.error = () => {};
          // }
          this.loading = false;
          console.log(error.response.data);
          this.errors = error.response.data.errors;
        });
    },
  },
};
</script>
<style lang="scss">
@import '~/assets/scss/style/login.scss';
</style>
