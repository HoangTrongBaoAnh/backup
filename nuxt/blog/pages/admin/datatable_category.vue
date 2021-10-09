<template>
  <v-app>
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
          <v-toolbar-title>Category</v-toolbar-title>
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
          <v-dialog
            v-model="dialog"
            persistent
            max-width="600px"
            >
            <template v-slot:activator="{ on, attrs }">
                <v-btn
                color="primary"
                dark
                v-bind="attrs"
                v-on="on"
                >
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
                    <v-col
                        cols="12"
                        sm="12"
                        md="12"
                    >
                        <div class="form-group">
                          <label>Enter content</label>
                          <input
                            type="text"
                            class="form-control"
                            v-model="editedItem.content"
                          />
                        </div>
                    </v-col>
                    
                    </v-row>
                </v-container>
                
                </v-card-text>
                <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn
                    color="blue darken-1"
                    text
                    @click="close()"
                >
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
          <td>{{ desserts.item.content }}</td>
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
import baseRequest from "~/store/baseRequest";
export default {
  layout: 'admin',
  data() {
    return {
      headers: [
        {
          text: "Id",
          align: "start",
          sortable: false,
          value: "id",
        },
        { text: "Content", value: "content" },
        { text: "Actions", value: "id" },
      ],
      search: "",
      desserts: [],
      dialog: false,
      editedIndex: -1,
      editedItem: [
        {
          content:""
        }
      ],
    };
  },
  methods: {
    close () {
      this.dialog = false
      this.editedIndex = -1
      this.editedItem.content = null
      this.getPosts()
    },
    editItem (item) {
      this.editedIndex = this.desserts.indexOf(item.item)
      this.editedItem = Object.assign({}, item)
      this.dialog = true
      this.editedItem = item.item;
      console.log(this.editedItem);
    },
    getPosts: function () {
      this.loading = true;
      this.$axios
        .$get("http://localhost/blog/public/api/category").then((response) => {
        this.desserts = response;
      });
    },
    submit: function () {
      if(this.editedIndex == -1){
        let data = new FormData();
        data.append("content", this.editedItem.content);
        baseRequest
        .post("category/create", data)
          .then((response) => {
            console.log(response);
            this.editedIndex = -1
            this.getPosts();
          })
          .catch((error) => {
            console.log(error);
          });
      }
      else{
        let data = new FormData();
        data.append("content", this.editedItem.content);
        baseRequest
        .post("category/edit/" + this.editedItem.id, data)
          .then((response) => {
            console.log(response);
            this.editedIndex = -1
            this.getPosts();
          })
          .catch((error) => {
            console.log(error);
          });     
      }       
      
    },
    deletePosts: function (id) {
      if (confirm("are you sure?"))
        baseRequest
        .post("category/delete/" + id)
          .then((response) => {
            this.getPosts();
            console.log(response);
          })
          .catch((error) => {
            console.log(error.response.status);
            if(error.response.status === 403){
              this.$router.push("/403");
            }
          });
    },
  },
  mounted() {
    this.getPosts();
  },
  computed: {
      formTitle () {
        return this.editedIndex === -1 ? 'New Item' : 'Edit Item'
      },
    },
};
</script>
