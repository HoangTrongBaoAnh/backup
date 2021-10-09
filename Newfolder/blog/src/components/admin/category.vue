<template>
  <div class="container p-2">
    <div class="card">
      <div class="card-header">
        <div class="row">
          <div class="col-md-6">
            <h3 class="panel-title">Danh sách thể loại</h3>
          </div>
          <div class="col-md-6" align="right">
            <button
              type="button"
              class="btn btn-xs btn-info"
              @click="openModal({ mode: 'create' })"
            >
              Create
            </button>
          </div>
        </div>
      </div>
      <div class="card-body">
        <div class="spinner-border" v-if="loading"></div>
        <div class="table table-bordered" id="table">
          <table class="table table-borderless text-center" id="table">
            <thead class="thead-dark">
              <tr>
                <th>Title</th>
                <th>Content</th>
                <th>Sửa</th>
                <th>Xóa</th>
              </tr>
            </thead>
            <tr v-for="post in posts" :key="post.id">
              <td>{{ post.id }}</td>
              <td>{{ post.content }}</td>
              <td>
                <button
                  type="button"
                  class="btn btn-success"
                  @click="openModal({ id: post.id, content: post.content })"
                >
                  Edit
                </button>
              </td>
              <td>
                <button
                  type="button"
                  class="btn btn-danger"
                  @click="deletePosts(post.id)"
                >
                  Xoa
                </button>
              </td>
            </tr>
          </table>
        </div>
      </div>
    </div>
    <br />
    <div>
      <nav aria-label="Page navigation example">
        <ul class="pagination text-center">
          <li class="page-item" v-if="currentPage > 1">
            <a class="page-link" href="#" @click.prevent="currentPage--"
              >Previous</a
            >
          </li>
          <li class="page-item" v-for="page in totalPage" :key="page">
            <a class="page-link" href="#" @click.prevent="currentPage = page">{{
              page
            }}</a>
          </li>
          <li class="page-item" v-if="currentPage < totalPage">
            <a class="page-link" href="#" @click.prevent="currentPage++"
              >Next</a
            >
          </li>
        </ul>
      </nav>
    </div>
    <div v-if="myModal">
      <transition name="modal">
        <div class="modal-mask">
          <div class="modal-wrapper">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <h4 class="modal-title">{{ dynamicTitle }}</h4>
                  <button type="button" class="close" @click="myModal = false">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
                <div class="modal-body">
                  <form v-if="mode == 'edit'" @submit.prevent="EditPost()">
                    <div class="form-group">
                      <label>Enter content</label>
                      <input
                        type="text"
                        class="form-control"
                        v-model="content"
                      />
                    </div>
                    <br />
                    <div align="center">
                      <input
                        v-if="mode == 'edit'"
                        type="hidden"
                        v-model="hiddenId"
                      />
                      <button class="btn btn-default" @click="myModal = false">
                        Cancel
                      </button>
                      <button type="submit" class="btn btn-primary">
                        Submit
                      </button>
                    </div>
                  </form>
                  <form v-if="mode == 'create'" @submit.prevent="CreatePost()">
                    <div class="form-group">
                      <label>Enter content</label>
                      <input
                        type="text"
                        class="form-control"
                        v-model="content"
                      />
                    </div>
                    <br />
                    <div align="center">
                      <button class="btn btn-default" @click="myModal = false">
                        Cancel
                      </button>
                      <button type="submit" class="btn btn-primary">
                        Submit
                      </button>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </transition>
    </div>
  </div>
</template>
<script>
//const axios = require("axios");
import baseRequest from "../../core/baseRequest";
export default {
  data() {
    return {
      posts: [],
      loading: false,
      currentPage: 1,
      totalPage: 0,
      myModal: false,
      mode: "create",
      dynamicTitle: "Add Data",
    };
  },
  mounted() {
    this.getPosts();
  },
  watch: {
    currentPage: function () {
      this.getPosts();
    },
  },
  methods: {
    openModal: function (post) {
      if (post.mode == "create") {
        this.myModal = true;
        this.dynamicTitle = "Create";
        this.mode = "create";
        this.title = "";
        this.content = "";
      } else {
        this.myModal = true;
        this.dynamicTitle = "Update";
        this.mode = "edit";
        this.title = post.title;
        this.content = post.content;
        this.hiddenId = post.id;
      }
    },
    getPosts: function () {
      this.loading = true;
      baseRequest.get("category").then((response) => {
        this.posts = response.data;
        this.loading = false;
      });
    },
    CreatePost: function () {
      let data = new FormData();
      data.append("content", this.content);
      baseRequest
        .post("category/create", data)
        .then((response) => {
          console.log(response);
          this.myModal = false;
          this.getPosts();
        })
        .catch((error) => {
          console.log(error);
        });
    },
    EditPost: function () {
      let data = new FormData();
      data.append("content", this.content);
      baseRequest
        .post("category/edit/" + this.hiddenId, data)
        .then((response) => {
          console.log(response);
          this.myModal = false;
          this.getPosts();
        })
        .catch((error) => {
          console.log(error);
        });
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
            console.log(error);
          });
    },
  },
};
</script>
<style>
.btn {
  margin: 1px;
}
.modal-mask {
  position: fixed;
  z-index: 9998;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: table;
  transition: opacity 0.3s ease;
}

.modal-wrapper {
  display: table-cell;
  vertical-align: middle;
}
</style>
