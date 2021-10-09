const axios = require("axios");
const apiUrl = "http://localhost/blog/public/api/";

axios.interceptors.response.use(
  function(response) {
    //console.log(response);
    // Any status code within the range of 2xx cause this function to trigger
    // Do something with response data
    return response;
  },
  function(error) {
    if (error.status === 404 || error.status === 403) {
      router.push("/not-found");
    }
    //console.log(error);
    // Any status codes outside the range of 2xx cause this function to trigger
    // Do something with response error
    return Promise.reject(error);
  }
);

export default {
  getHeaders() {
    let token = window.localStorage.getItem("token");
    if (token == null) {
      return {};
    }
    return { Authorization: "Bearer " + token };
  },
  get(url) {
    return axios.get(apiUrl + url, { headers: this.getHeaders() });
  },
  post(url, data) {
    return axios.post(apiUrl + url, data, { headers: this.getHeaders() });
  }
};
