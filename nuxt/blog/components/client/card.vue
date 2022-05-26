<template>
  <div class="card__container">
    <div class="card__top__section">
      <img :src="product.picture" />
      <div class="card__top__section__icons">
        <div>
          <i><v-icon dark>mdi-heart</v-icon></i>
        </div>
        <div @click="addToCart(product)">
          <i><v-icon dark>mdi-shopping</v-icon></i>
        </div>
        <div>
          <i><v-icon dark>mdi-share</v-icon></i>
        </div>
      </div>
    </div>
    <div class="card__body__section">
      <nuxt-link
        :to="{ name: 'product_detail-id', params: { id: product.id } }"
        class="image"
      >
        <p>{{ product.title }}</p>
      </nuxt-link>
      <span>A nice blue shirt for men. One size fit all.</span>
    </div>
    <div>
      <div class="rating-section">
        <div class="stars-rating">
          <span>{{ product.rating }}</span>
          <v-rating
            v-model="product.rating"
            background-color="#777"
            size="18"
            color="#f7bc3d"
          ></v-rating>
        </div>
        <div class="c-price">
          <span>$ {{ product.price }}</span>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "card",
  props: ["product"],
};
</script>
<style lang="scss">
.card__container {
  width: 260px;
  background-color: #fff;
  -webkit-box-shadow: 0 2.5rem 2rem -2rem hsl(200 50% 20% / 40%);
  box-shadow: 0 2.5rem 2rem -2rem hsl(200 50% 20% / 40%);
  margin: 0 auto;
  border-radius: 8px;
  border: 2px;
  /* position: relative; */
  top: 30px;
  margin-bottom: 60px;
  height: 90%;
}

.card__top__section {
  background: -webkit-gradient(
    linear,
    left top,
    right top,
    from(#64c1ff),
    to(#0064b7)
  );
  background: -o-linear-gradient(left, #64c1ff, #0064b7);
  background: linear-gradient(to right, #64c1ff, #0064b7);
  background-repeat: no-repeat;
  background-size: cover;
  background-position: 0 0;
  height: 220px;
  width: 100%;
  padding: 10px 0px 0px 0px;
  border-top-left-radius: 8px;
  border-top-right-radius: 8px;
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  
  &__icons > div {
    width: 38px;
    height: 38px;
    background-color: rgb(83, 64, 64);
    border-radius: 50%;
    /* z-index: 100; */
    position: relative;
    left: -22px;
    margin-bottom: 10px;
    display: table;
  }
}

.card__top__section__icons > div:hover {
  background-color: rgb(169, 197, 46);
  transform: scale(1.5);
}

.card__top__section__icons > div > i {
  vertical-align: middle;
  text-align: center;
  display: table-cell;
  color: #454545;
  font-size: 16px;
}

.card__body__section {
  text-align: center;
  padding: 8px 5px;
}

.card__body__section > p {
  font-weight: 700;
}

.rating-section {
  border-top: 1px solid #eee;
  padding: 8px 12px;
  margin-top: 5px;
  display: table;
  margin-bottom: 20px;
  clear: both;
  width: 100%;
}

.rating-with-color {
  color: #ffa500;
}

.stars-rating {
  float: left;
}

.stars-rating > span {
  font-size: small;
}

.c-price {
  padding-top: 5px;
  float: right;
}
</style>
