<template>
  <v-app >
    <div id="errorpage" class="m-auto">
      <div id="error-box">
        <div class="text-center" v-if="error.statusCode === 404">
          <h1>
            {{error.statusCode}}
          </h1>
          <h2>
            <span>PAGE NOT</span>
            <span>FOUND</span>
          </h2>
          <p>
            <span>
              {{ pageNotFound }}
            </span>
          </p>
        </div>
        <div class="text-center" v-else>
          <h1>
            {{error.statusCode}}
          </h1>
          <h2>
            <span>An error</span>
            <span>occurred</span>
          </h2>
          <p>
            {{ error.message }}
          </p>
        </div>
        <b-button class="w-100" variant="primary">
        <NuxtLink to="/">
          <span>Home page</span>
        </NuxtLink>
      </b-button>
      </div>
      
    </div>
  </v-app>
</template>

<script>
export default {
  layout: 'error-layout',
  props: {
    error: {
      type: Object,
      default: null
    }
  },
  data() {
    return {
      pageNotFound:
        "The page you were looking for was not found. Please verify the link/URL or try starting back at our home page.",
      otherError: "An error occurred"
    };
  },
  head() {
    const title =
      this.error.statusCode === 404 ? "Page not found" : this.otherError;
    return {
      title
    };
  }
};
</script>

<style scoped>
.theme--light.v-application{
background-color:grey;
}

h1 {
  text-transform: uppercase;
  font-size: 80px;
  text-align: left;
  display: inline-block;
  border-right: 3px solid black;
  padding-right: 10px;
}

h2{
  text-transform: uppercase;
  word-wrap: break-word;
  margin-left: 10px;
  text-align: right;
  display: inline-block;
}

button a span{
  color:#fff
}
h2 span{
  display: block;
  text-align: left;
}

#error-box{
  overflow: hidden;
  position: relative;
  top: -40%
}

#errorpage{
  
  width: 30%;
  position: relative
}
</style>
