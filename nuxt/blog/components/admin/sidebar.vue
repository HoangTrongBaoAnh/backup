<template>
  <v-navigation-drawer
    color="#09151E"
    permanent
    :key="drawerState"
    :expand-on-hover="!drawerState"
    app
    v-model="drawerState"
  >
    <v-list class="white--text">
      <v-list-item class="p-2">
        <v-list-item-avatar>
          <v-img src="https://randomuser.me/api/portraits/women/85.jpg"></v-img>
        </v-list-item-avatar>
        <v-list-item class="mt-4 white--text">
          <p>Welcome {{ user.name }}</p>
        </v-list-item>
      </v-list-item>
    </v-list>

    <v-divider></v-divider>

    <v-list nav dense>
      <v-list-item
        link
        v-for="(item, i) in items"
        :key="i"
        :to="item.to"
        class="white--text"
      >
        <v-list-item-icon>
          <v-icon color="white">{{ item.icon }}</v-icon>
        </v-list-item-icon>
        <v-list-item-title>{{ item.title }}</v-list-item-title>
      </v-list-item>
    </v-list>
  </v-navigation-drawer>
</template>
<script>
import baseRequest from "~/store/baseRequest";
export default {
  data() {
    return {
      items: [
        {
          icon: "mdi-format-list-bulleted",
          title: "Category",
          to: "/admin/datatable_category"
        },
        {
          icon: "mdi-view-dashboard",
          title: "Product",
          to: "/admin/product"
        }
      ],
      user: {}
    };
  },
  mounted() {
    this.CheckedLogin();
    
  },
  created() {},
  methods: {
    CheckedLogin: function () {
      baseRequest
        .post("user")
        .then((response) => {
          this.user = response.data;
          //console.log(this.user);
        })
        .catch(() => {
          this.$router.push({ name: "login" });
        });
    },
    
  },
  computed: {
    drawerState: {
      get() {
        return this.$store.getters.drawerState;
      },
      set() {
        return this.$store.getters.drawerState;
      }
    }
  }
};
</script>
