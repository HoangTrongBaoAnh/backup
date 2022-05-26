<template>
  <div>
    <v-card class="mx-auto" max-width="auto" tile>
      <v-img
        height="200"
        src="https://cdn.vuetifyjs.com/images/cards/server-room.jpg"
      ></v-img>
      <v-row style="margin: 2.5%; position: absolute; top: 130px">
        <v-list-item>
          <v-list-item-avatar size="100">
            <img
              :src="user.picture"
              alt="John"
            />
          </v-list-item-avatar>
          <v-list-item-content style="margin-top: 5%">
            <v-list-item-title class="title">{{ user.name }}</v-list-item-title>
            <v-list-item-subtitle
              >Software Engineer | dokanee</v-list-item-subtitle
            >
          </v-list-item-content>
        </v-list-item>
      </v-row>
    </v-card>
    <div style="margin-bottom: 400px; margin-top: 100px">
      <div class="row">
        <div class="col-3">
          <v-card class="mx-auto" max-width="auto" tile>
            <v-card-title>User Info</v-card-title>
            <v-card-text>
              <v-row align="center" class="mx-0 mb-2">
                <p>{{ user.name }}</p>
              </v-row>
            </v-card-text>
          </v-card>
        </div>
        <div class="col-9">
          <v-card class="mx-auto" max-width="auto" tile>
            <v-tabs vertical center-active color="light-green darken-1">
              <v-tab>History</v-tab>
              <v-tab>Settings</v-tab>

              <v-tab-item class="m-2">
                <v-data-table
                  :headers="headers"
                  :items="desserts"
                  :items-per-page="5"
                  show-expand
                  :single-expand="true"
                  :expanded.sync="expanded"
                  class="elevation-1"
                  :search="search"
                  loading-text="Loading... Please wait"
                >
                  <template v-slot:top>
                    <v-toolbar flat>
                      <v-toolbar-title>Order history</v-toolbar-title>
                      <v-divider class="mx-4" inset vertical></v-divider>
                      <v-spacer></v-spacer>
                      <v-text-field
                        v-model="search"
                        append-icon="mdi-magnify"
                        label="Search"
                        single-line
                        hide-details
                      ></v-text-field>
                    </v-toolbar>
                  </template>
                  <template
                    v-slot:[`item.data-table-expand`]="{
                      item,
                      isExpanded,
                      expand,
                    }"
                  >
                    <v-btn
                      @click="
                        expand(true);
                        getSamples(item.id);
                      "
                      v-if="!isExpanded"
                      >Expand</v-btn
                    >
                    <v-btn @click="expand(false)" v-if="isExpanded"
                      >close</v-btn
                    >
                  </template>
                  <template v-slot:expanded-item="{ headers }">
                    <td :colspan="headers.length">
                      <v-simple-table>
                        <template v-slot:default>
                          <thead>
                            <tr>
                              <th>Product name</th>
                              <th>Amount</th>
                              <th>Price</th>
                            </tr>
                          </thead>
                          <tbody>
                            <tr
                              v-for="(item, index) in order_detail"
                              :key="index"
                            >
                              <td>{{ item.title }}</td>
                              <td>{{ item.quantity }}</td>
                              <td>{{ item.price }}</td>
                            </tr>
                          </tbody>
                        </template>
                      </v-simple-table>
                    </td>
                  </template>
                </v-data-table>
              </v-tab-item>
              <v-tab-item class="m-2">
                <v-container>
                  <form @submit.prevent="UpdateProfile()">
                    <div class="row mb-2">
                      <div class="col-4">                        
                        <!-- <label for="picture">Hình</label>
                      <input type="file" id="picture" v-on:change="handle" /> -->
                        <dropzone
                          :options="dropzoneOptions"
                          id="foo"
                          ref="foo"
                          
                          :destroyDropzone="true"
                          @vdropzone-file-added="added()"
                          @vdropzone-removed-file="remove()"
                        ></dropzone>
                      </div>
                      <div class="form-group col-8">
                        <label for="name">Name</label>
                        <input
                          name="name"
                          id="name"
                          type="text"
                          class="form-control"
                          v-model="name"
                        />
                        <label for="name">Name</label>
                        <input
                          name="x"
                          id="x"
                          type="text"
                          class="form-control"
                          v-model="name"
                        />
                        <button type="submit" class="btn btn-primary mt-4">
                      Save changes
                    </button>
                      </div>
                    </div>

                    
                  </form>
                </v-container>
              </v-tab-item>
            </v-tabs>
          </v-card>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Dropzone from "nuxt-dropzone";
import "nuxt-dropzone/dropzone.css";
import baseRequest from "~/store/baseRequest";
export default {
  // layout: "admin",
  data() {
    return {
      headers: [
        {
          text: "Id",
          align: "start",
          sortable: false,
          value: "id",
        },
        { text: "Name", value: "name" },
        { text: "Total", value: "total" },
      ],
      dropzoneOptions: {
        url: "https://httpbin.org/post",
        uploadMultiple: false,
        maxFiles: 1,
        
        addRemoveLinks: true,
        dictDefaultMessage: "<i class='fa fa-cloud-upload'></i>UPLOAD ME",
      },
      currentFile: null,
      search: "",
      desserts: [],
      order_detail: [],
      picture: "",
      name: "",
      user: {},
      expanded: [],
    };
  },
  mounted() {
    this.CheckedLogin();
    this.buyingHistory();
  },
  components: {
    Dropzone,
  },
  methods: {
    added() {
      if (this.currentFile !== null) {
        this.$refs.foo.dropzone.removeFile(this.$refs.foo.dropzone.files[0]);
      }
      this.currentFile = this.$refs.foo.dropzone;
      //console.log(this.currentFile);
    },
    remove() {
      this.currentFile = null;
      //console.log(this.currentFile);
    },
    getSamples: function (id) {
      baseRequest
        .post("order/detail/" + id)
        .then((res) => {
          this.order_detail = res.data;
          console.log(res.data);
        })
        .catch((error) => {
          console.log(error);
        });
    },
    handle: function (e) {
      this.picture = e.target.files[0];
      console.log(this.picture);
    },

    UpdateProfile: function () {
      let token = window.localStorage.getItem("token");
      if (token == null) {
        return {};
      }
      let data = new FormData();
      if (this.$refs.foo.dropzone != "") {
        data.append("picture", this.$refs.foo.dropzone.files[0]);
      }

      //data.append("picture", this.$refs.foo.dropzone.files[0]);
      //console.log(this.$refs.foo.dropzone.files[0]);
      //console.log(this.$refs.foo.dropzone);
      data.append("name", this.name);
      baseRequest
        .post("user/edit/" + this.user.id, data)
        .then((res) => {
          this.CheckedLogin();
          //console.log(res.data);
        })
        .catch((error) => {
          console.log(error);
        });
    },
    CheckedLogin: function () {
      baseRequest
        .get("user")
        .then((response) => {
          this.user = response.data;
        })
        .catch(() => {
          this.$router.push({ name: "Login" });
        });
    },
    buyingHistory: function () {
      baseRequest
        .post("user/history")
        .then((response) => {
          this.desserts = response.data;
          //console.log(response.data);
        })
        .catch(() => {});
    },
  },
};
</script>
<style>

.dropzone .dz-preview {
display: inherit;
}
.vue-dropzone>.dz-preview .dz-remove{
  margin: 5px;
  padding-top: 0px;
}

.dropzone .dz-preview .dz-image img{
  width: 150px;
  height: 150px;
} 
</style>