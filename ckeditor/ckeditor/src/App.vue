<template>
  <div id="app">
    <Ckeditor
      v-model:modelValue="editorData"
     
    ></Ckeditor>
    <input v-model="editorData" />
  </div>
</template>

<script>
import Ckeditor from "./components/HelloWorld.vue";

export default {
  name: "app",
  components: {
    Ckeditor,
  },
  data() {
    return {
      editorData: "<p>parent value</p>",
    };
  },
};
</script>