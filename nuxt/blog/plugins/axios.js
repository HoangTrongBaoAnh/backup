import Vue from "vue";
import axios from "axios";

axios.interceptors.request.use(
  config => {
    // Do something before request is sent
    return config;
  },
  function(error) {
    const { status, data } = error.response;
    if (status === 404 || status === 403) {
      router.push("/not-found");
    }
    return Promise.reject(error);
  }
);

Vue.use(axios);
