<template>
  <div class="container">
    <ProductZoomer :base-images="images" :base-zoomer-options="zoomerOptions"></ProductZoomer>
  </div>
</template>

<script>

export default {
  data() {
    return {
      images: {
        thumbs: [
         {
            id: 1,
            url:
              "https://yoohooworld.com/assets/images/vue_product_zoomer/normal_size/1.jpeg"
          },
          {
            id: 2,
            url:
              "https://yoohooworld.com/assets/images/vue_product_zoomer/normal_size/2.jpeg"
          },
          {
            id: 3,
            url:
              "https://yoohooworld.com/assets/images/vue_product_zoomer/normal_size/3.jpeg"
          },
          {
            id: 4,
            url:
              "https://yoohooworld.com/assets/images/vue_product_zoomer/normal_size/4.jpeg"
          },
          
        ],
        normal_size: [
          {
            id: 1,
            url:
              "https://yoohooworld.com/assets/images/vue_product_zoomer/normal_size/1.jpeg"
          },
          {
            id: 2,
            url:
              "https://yoohooworld.com/assets/images/vue_product_zoomer/normal_size/2.jpeg"
          },
          {
            id: 3,
            url:
              "https://yoohooworld.com/assets/images/vue_product_zoomer/normal_size/3.jpeg"
          },
          {
            id: 4,
            url:
              "https://yoohooworld.com/assets/images/vue_product_zoomer/normal_size/4.jpeg"
          },
          
        ],
        
      },
      zoomerOptions: {
        zoomFactor: 3,
      pane: "pane",
      hoverDelay: 300,
      namespace: "zoomer-bottom",
      move_by_click: false,
      scroll_items: 4,
      choosed_thumb_border_color: "#dd2c00",
      scroller_position: "bottom",
      zoomer_pane_position: "right"
      }
    };
  }
};
</script>

<style>

</style>