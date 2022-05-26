<template>
  <div class="register">
    <div class="row">
      <div class="register__left col-lg-5">
        <div class="polygon2"></div>
        <div class="polygon1"></div>
        <div class="ellipse2"></div>
        <div class="rectangle2"></div>
        <div class="register__left__signContent">
          <div>
            <h2>Welcome Back!</h2>
            <p>To keep connected with us plase login with your personal info</p>
          </div>
          <div>
            <button>
              <nuxt-link class="nav-link" :to="{ name: 'login' }">
                Sign In
              </nuxt-link>
            </button>
          </div>
        </div>
      </div>
      <div class="register__right col-lg-7">
        <form @submit.prevent="CreatePost()">
          <h2>Register</h2>
          <div class="form-group">
            <v-text-field
              v-model="user.name"
              outlined
              :rules="[rules.required]"
              label="Name"
              :error="errors.name ? true : false"
            ></v-text-field>
            <div v-if="errors.name" class="invalid-feedback">
              {{ errors.name[0] }}
            </div>
          </div>
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
    <!-- <form @submit.prevent="CreatePost()">
      <div class="form-group">
        <label>Enter Name</label>
        <input
          type="text"
          class="form-control"
          :class="{ 'is-invalid': errors.name }"
          v-model="user.name"
        />
        <div v-if="errors.name" class="invalid-feedback">
          {{ errors.name[0] }}
        </div>
      </div>
      <div class="form-group">
        <label>Enter Email</label>
        <input
          type="text"
          class="form-control"
          :class="{ 'is-invalid': errors.email }"
          v-model="user.email"
        />
        <div v-if="errors.email" class="invalid-feedback">
          {{ errors.email[0] }}
        </div>
      </div>
      <div class="form-group">
        <label>Enter password</label>
        <input
          type="text"
          class="form-control"
          :class="{ 'is-invalid': errors.password }"
          v-model="user.password"
        />
        <div v-if="errors.password" class="invalid-feedback">
          {{ errors.password[0] }}
        </div>
      </div>
      <br />
      <div align="center">
        <button type="submit" class="btn btn-primary">Submit</button>
      </div>
    </form> -->
  </div>
</template>
<script>
import baseRequest from "../store/baseRequest";
export default {
  data() {
    return {
      rules: {
        required: (value) => !!value || "Required.",
        counter: (value) => value.length <= 20 || "Max 20 characters",
        email: (value) => {
          const pattern =
            /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
          return pattern.test(value) || "Invalid e-mail.";
        },
      },
      show1: false,
      user: {
        name: "",
        password: "",
        email: "",
      },

      errors: {},
    };
  },
  methods: {
    CreatePost: function () {
      baseRequest
        .post("register", this.user)
        .then((response) => {
          console.log(response);
          this.$router.push({ name: "login" });
        })
        .catch((error) => {
          this.errors = error.response.data.errors;
          console.log(error);
        });
    },
  },
};
</script>
<style lang="scss">
@import "~/assets/scss/style/register.scss";
</style>
