<template>
  <v-app>
    <div v-if="errors.message">
      <div v-for="(error, index) in errors.errors" :key="index">
        <v-alert type="error">
          {{ error[0] }}
        </v-alert>
      </div>
    </div>

    <v-alert v-if="success" type="success">{{ success }}</v-alert>
    <v-data-table
      :headers="headers"
      :items="desserts"
      :items-per-page="5"
      class="elevation-1"
      :search="search"
      loading-text="Loading... Please wait"
    >
      <template v-slot:top>
        <v-toolbar flat>
          <v-toolbar-title>Product</v-toolbar-title>
          <v-divider class="mx-4" inset vertical></v-divider>
          <v-spacer></v-spacer>
          <v-text-field
            v-model="search"
            append-icon="mdi-magnify"
            label="Search"
            single-line
            hide-details
          ></v-text-field>
          <v-spacer></v-spacer>
          <v-dialog v-model="dialog" persistent max-width="600px">
            <template v-slot:activator="{ on, attrs }">
              <v-btn color="primary" dark v-bind="attrs" v-on="on">
                New Item
              </v-btn>
            </template>
            <v-card>
              <form @submit.prevent="submit()">
                <v-card-title>
                  <span class="text-h5">{{ formTitle }}</span>
                </v-card-title>
                <v-card-text>
                  <v-container>
                    <v-row>
                      <v-col cols="12" sm="12" md="12">
                        <div class="form-group">
                          <label>Enter title</label>
                          <input
                            type="text"
                            class="form-control"
                            v-model="editedItem.title"
                          />
                        </div>
                        <div class="form-group">
                          <label>Enter content</label>
                          <input
                            type="text"
                            class="form-control"
                            v-model="editedItem.content"
                          />
                        </div>
                        <div class="form-group">
                          <label>Enter price</label>
                          <input
                            type="number"
                            min="10000"
                            class="form-control"
                            v-model="editedItem.price"
                          />
                        </div>
                        <div class="form-group">
                          <label for="category">Category</label>
                          <select
                            class="form-control"
                            id="category"
                            v-on:change="handle_category"
                          >
                            <option>Select</option>
                            <option
                              v-for="post in categories"
                              :key="post.id"
                              :value="post.id"
                              :selected="idCategory === post.id"
                            >
                              {{ post.content }}
                            </option>
                          </select>
                        </div>
                        <div class="form-group">
                          <label for="childcategory">Child Category</label>
                          <select
                            class="form-control"
                            id="childcategory"
                            v-model="editedItem.child_categories"
                          >
                            <option
                              v-for="post in child_categories"
                              :key="post.id"
                              :value="post.id"
                              :selected="idCategory === post.id"
                            >
                              {{ post.title }}
                            </option>
                          </select>
                        </div>
                        <div class="form-group">
                          <label for="picture">Hình</label>
                          <input
                            type="file"
                            id="picture"
                            v-on:change="handle"
                          />
                        </div>
                      </v-col>
                    </v-row>
                  </v-container>
                </v-card-text>
                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn color="blue darken-1" text @click="close()">
                    Close
                  </v-btn>
                  <v-btn
                    color="blue darken-1"
                    text
                    type="submit"
                    @click="dialog = false"
                  >
                    Save
                  </v-btn>
                </v-card-actions>
              </form>
            </v-card>
          </v-dialog>
        </v-toolbar>
      </template>
      <template v-slot:item="desserts">
        <tr>
          <td>{{ desserts.item.id }}</td>
          <td>{{ desserts.item.title }}</td>
          <td>{{ desserts.item.content }}</td>
          <td>{{ desserts.item.category.content }}</td>
          <td>
            <img
              height="70px"
              width="100px"
              v-bind:src="
                'http://localhost/blog/public/images/' + desserts.item.picture
              "
              alt="Italian Trulli"
            />
            <router-link
              :to="{
                name: 'admin-product_image-id',
                params: { id: desserts.item.id },
              }"
            >
              <button>More Image >></button>
            </router-link>
          </td>
          <td>
            <v-btn
              class="mr-4"
              tile
              color="success"
              @click="editItem(desserts)"
            >
              <v-icon left> mdi-pencil </v-icon>
              Edit
            </v-btn>

            <v-btn tile color="red" @click="deletePosts(desserts.item.id)">
              <v-icon left> mdi-delete </v-icon>
              Delete
            </v-btn>
          </td>
        </tr>
      </template>
    </v-data-table>
  </v-app>
</template>
<script>
import baseRequest from "../../store/baseRequest";
export default {
  layout: "admin",
  data() {
    return {
      headers: [
        {
          text: "Id",
          align: "start",
          sortable: false,
          value: "id",
        },
        { text: "Title", value: "title" },
        { text: "Content", value: "content" },
        { text: "Category", value: "category.id" },
        { text: "Image", value: "picture" },
        { text: "Actions", value: "id" },
      ],
      errors: {},
      success: null,
      search: "",
      desserts: [],
      categories: [],
      child_categories: [],
      dialog: false,
      editedIndex: -1,
      nameCategory: "",
      idCategory: "",
      editedItem: {
        picture: "",
        content: "",
        title: "",
        category_id: null,
        child_category: null,
        price: "",
      },
    };
  },
  methods: {
    close() {
      this.dialog = false;
      this.editedIndex = -1;
      this.editedItem = [];
      this.getPosts();
    },
    editItem(item) {
      this.editedIndex = this.desserts.indexOf(item.item);
      this.editedItem = Object.assign({}, item);
      this.dialog = true;
      this.editedItem = item.item;
      this.idCategory = this.editedItem.category_id;
      //this.getCategory();
      console.log(this.editedItem);
    },
    getPosts: function () {
      this.loading = true;
      baseRequest.get("shoe/showall").then((response) => {
        this.desserts = response.data;
        //console.log(this.desserts);
      });
    },
    getCategories: function () {
      this.loading = true;
      baseRequest.get("category").then((response) => {
        this.categories = response.data;
        this.nameCategory = this.categories[0].id;
      });
    },
    getCategory: function () {
      let data = new FormData();
      data.append("category", this.editedItem.category.id);
      baseRequest.post("category/show", data).then((response) => {
        this.nameCategory = response.data.id;
        this.idCategory = response.data.content;
        //console.log(response.data);
      });
    },
    handle_category: function (e) {
      this.nameCategory = e.target.value;
      baseRequest.get("childcategory/" + e.target.value).then((response) => {
        this.child_categories = response.data;
        console.log(response.data);
      });
      console.log(this.nameCategory);
    },
    handle: function (e) {
      this.picture = e.target.files[0];
      console.log(this.picture);
    },
    submit: function () {
      if (this.editedIndex == -1) {
        let data = new FormData();
        data.append("picture", this.picture);
        data.append("content", this.editedItem.content);
        data.append("title", this.editedItem.title);
        data.append("category_id", this.nameCategory);
        data.append("child_category", this.editedItem.child_categories);
        data.append("price", this.editedItem.price);
        baseRequest
          .post("shoe/create", data)
          .then(() => {
            this.editedIndex = -1;
            this.getPosts();
            this.success = "success";
            this.errors = [];
            this.editedItem = {
              picture: "",
              content: "",
              title: "",
              category_id: "",
              child_category: null,
              price: 10000,
            };
          })
          .catch((error) => {
            this.success = null;
            this.errors = error.response.data;
            //console.log(error.response.data.errors.category_id[0]);
          });
      } else {
        let data = new FormData();
        data.append("picture", this.picture);
        data.append("content", this.editedItem.content);
        data.append("title", this.editedItem.title);
        data.append("category_id", this.nameCategory);
        data.append("child_category", this.editedItem.child_categories);
        baseRequest
          .post("shoe/edit/" + this.editedItem.id, data)
          .then(() => {
            this.editedIndex = -1;
            this.getPosts();
            this.errors = [];
            this.success = "success";
            this.getPosts();
            this.editedItem = [];
          })
          .catch((error) => {
            this.success = null;
            this.errors = error.response.data;
          });
      }
    },
    deletePosts: function (id) {
      if (confirm("are you sure?"))
        baseRequest
          .post("shoe/delete/" + id)
          .then((response) => {
            this.getPosts();
            console.log(response);
          })
          .catch((error) => {
            console.log(error);
          });
    },
  },
  mounted() {
    this.getPosts();
    this.getCategories();
    this.editedItem.price = 10000;
  },
  computed: {
    formTitle() {
      return this.editedIndex === -1 ? "New Item" : "Edit Item";
    },
  },
};
</script>
