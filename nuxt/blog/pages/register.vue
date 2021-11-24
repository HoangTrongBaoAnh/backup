<template>
  <div>
    <form @submit.prevent="CreatePost()">
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
    </form>
  </div>
</template>
<script>
import baseRequest from "../store/baseRequest";
export default {
  data() {
    return {
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
<style></style>
