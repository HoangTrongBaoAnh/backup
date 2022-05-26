<template>
    <div>
        <v-data-table
        
        :headers="headers"
        :items="img"
        :items-per-page="5"
        class="elevation-1 mb-5"
        
        loading-text="Loading... Please wait"
        >
        <template v-slot:top>
            <v-toolbar flat>
            <v-toolbar-title>Img</v-toolbar-title>
            <v-divider class="mx-4" inset vertical></v-divider>
            <v-spacer></v-spacer>
            
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
                        <v-file-input
                            :rules="rules"
                            multiple
                            accept="image/png, image/jpeg, image/bmp"
                            placeholder="Pick an Image"
                            prepend-icon="mdi-camera"
                            v-on:change="handles"
                            v-model="editedItem.img"
                            label="Image"
                        ></v-file-input>
                        <div v-for="(image, key) in images" :key="key">
                            <div>
                                <img class="imagePreviewWrapper" :ref="'image'" />
                                {{ image.name }}
                            </div>
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
        <template v-slot:item="img">
            <tr class="mb-5">
            <td>{{ img.item.id }}</td>
            <td>
                <img
                  height="40px"
                  width="100px"
                  v-bind:src="img.item.picture"
                  alt="Italian Trulli"
                />
            </td>
            <td>
                <v-btn
                class="mr-4"
                tile
                color="success"
                @click="editItem(img)"
                >
                <v-icon left> mdi-pencil </v-icon>
                Edit
                </v-btn>

                <v-btn tile color="red" @click="deletePosts(img.item.id)">
                <v-icon left> mdi-delete </v-icon>
                Delete
                </v-btn>
            </td>
            </tr>
        </template>
        </v-data-table>
        
    </div>
</template>
<script>
const axios = require("axios");
import baseRequest from "../../../store/baseRequest";
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
                { text: "Content", value: "picture" },
                { text: "Actions", value: "id" },
            ],
            rules: [
                //value => !value || value.size < 200000000 || 'Avatar size should be less than 2 MB!',
            ],
            editedItem: [
                {
                    img:""
                }
            ],
            dialog: false,
            editedIndex: -1,
            previewImage: null,
            img: [],
            images: [],
        }
    },
    mounted() {
        this.getPosts();
        //console.log(this.$route.params.id);
    },
    methods: {
        handles: function (e) {
            this.images = e;
            console.log(this.images);
            //let input = this.$refs.fileInput
            for (let i = 0; i < this.images.length; i++) {
                let reader = new FileReader();
                reader.onload = e => {
                    this.$refs.image[i].src = e.target.result
                }
                reader.readAsDataURL(this.images[i]);
            }
        
        },
        selectImage () {
            this.$refs.fileInput.click()
        },
        close () {
            this.dialog = false
            this.editedIndex = -1
            this.previewImage = null
            this.editedItem.img = null
            this.images = null
            this.$emit('input', null)
        },
        editItem (item) {
            this.editedIndex = this.img.indexOf(item.item)
            this.editedItem = Object.assign({}, item)
            this.dialog = true
            this.editedItem = item.item;
            console.log(this.editedItem);
        },
        getPosts: function () {
            this.loading = true;
            baseRequest.get("image/"+this.$route.params.id)
            .then((response) => {
                this.img = JSON.parse(JSON.stringify(response.data));
                console.log(this.img);
            });
        },
        deletePosts: function (id) {
        if (confirm("are you sure?"))
            baseRequest
            .post("image/delete/" + id)
            .then((response) => {
                this.getPosts();
                console.log(response);
            })
            .catch((error) => {
                console.log(error);
            });
        },
        submit: function () {
            if(this.editedIndex == -1){
                let data = new FormData();

                for( var i = 0; i < this.images.length; i++ ){
                    let file = this.images[i];
                    data.append('files[' + i + ']', file);
                    //console.log(this.images[i]);
                }
                data.append('id', this.$route.params.id);
                axios.post(`https://peaceful-journey-07506.herokuapp.com/api/image/create`, data,
                {
                    headers:{
                    'Content-Type': `multipart/form-data` 
                },    
                }).then((res) => {
                    this.getPosts();
                    this.editedIndex = -1
                    console.log(res.data)
                }).catch((error) => {
                    console.log(error)
                })
            }
            else{
                let data = new FormData();
                data.append("picture", this.images[0]);
                console.log(this.editedItem.picture);
                baseRequest
                    .post("image/edit/" + this.editedItem.id, data)
                    .then((response) => {
                        console.log(response);
                        this.getPosts();
                        this.editedIndex = -1
                    })
                    .catch((error) => {
                        console.log(error);
                    });
                } 
                this.previewImage = null
        },
        
    },
    computed: {
      formTitle () {
        return this.editedIndex === -1 ? 'New Item' : 'Edit Item'
      },
    },
}
</script>
<style scoped lang="scss">
.imagePreviewWrapper {
    width: 250px;
    height: 250px;
    display: block;
    cursor: pointer;
    margin: 0 auto 30px;
    background-size: cover;
    background-position: center center;
}
</style>