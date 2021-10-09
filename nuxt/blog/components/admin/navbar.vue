<template>
  <v-app-bar app>
    <v-app-bar-nav-icon
      @click.stop="drawerState = !drawerState"
    ></v-app-bar-nav-icon>

    <v-toolbar-title>Dashboard</v-toolbar-title>

    <v-spacer></v-spacer>

    <v-btn icon>
      <v-icon>mdi-magnify</v-icon>
    </v-btn>

    <v-btn icon>
      <v-icon>mdi-heart</v-icon>
    </v-btn>
    <v-menu left bottom>
      <template v-slot:activator="{ on, attrs }">
        <v-btn icon v-bind="attrs" v-on="on">
          <v-icon>mdi-dots-vertical</v-icon>
        </v-btn>
      </template>
      <v-list>
        <v-list-item @click="profile()">
          <v-list-item-icon>
            <v-icon>mdi-face-profile</v-icon>
          </v-list-item-icon>
          <v-list-item-title class="pr-6">Profile</v-list-item-title>
        </v-list-item>
        <v-list-item @click="Logout()">
          <v-list-item-icon>
            <v-icon>mdi-logout</v-icon>
          </v-list-item-icon>
          <v-list-item-title class="pr-6">Logout</v-list-item-title>
        </v-list-item>
      </v-list>
    </v-menu>
  </v-app-bar>
</template>

<script>
import baseRequest from "~/store/baseRequest";
export default {
  methods: {
    Logout: function () {
      baseRequest
        .post("logout")
        .then((response) => {
          this.$router.push({ name: "Login" });
          console.log(response.data);
        })
        .catch(() => {});
    },
    profile: function () {
      this.$router.push({ name: "admin-profile" });
    },
  },
  computed: {
    drawerState: {
      get() {
        return this.$store.getters.drawerState;
      },
      set(v) {
        return this.$store.commit("sidebar", v);
      },
    },
  },
};
</script>
