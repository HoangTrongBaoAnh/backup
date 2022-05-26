<template>
  <div class="row">
    <div class="col-lg-7 ">
      <div class="checkout__left">
        <div class="checkout__title"><h2>Cart</h2></div>

        <div class="checkout__listitems">
          <div
            v-for="(item, index) in cart"
            :key="index"
            class="checkout__item"
          >
            <div class="checkout__item__header">
              <button
                style="margintop: 5px"
                @click="$store.commit('removeFromCart', index)"
              >
                <span>Remove<v-icon>mdi-delete</v-icon></span>
              </button>
            </div>
            <div class="checkout__item__content">
              <div class="checkout__item__img">
                <nuxt-link
                  :to="{
                    name: 'product_detail-id',
                    params: { id: item.id },
                  }"
                >
                  <img :src="item.picture" alt="" />
                </nuxt-link>
              </div>
              <div class="checkout__item__title" v-text="item.title"></div>
              <div class="checkout__item__price">
                <div class="checkout__item__quantity__header">Price</div>
                <div v-text="item.price + ' $'"></div>
              </div>
              <div class="checkout__item__quantity">
                <div class="checkout__item__quantity__header">Quantity</div>
                <div class="checkout__item__quantity__groupinput">
                  <div class="checkout__item__quantity__button">
                    <button @click="AdjustQuantity(item, item.quantity - 1)">
                      <v-icon>mdi-minus</v-icon>
                    </button>
                  </div>
                  <!-- <b-input-group-prepend>
                    <b-btn
                      variant="info"
                      @click="AdjustQuantity(item, item.quantity - 1)"
                      >-</b-btn
                    >
                  </b-input-group-prepend> -->
                  <div
                    class="checkout__item__quantity__groupinput__text"
                    v-text="item.quantity"
                  ></div>
                  <!-- <b-form-input
                    type="number"
                    min="0"
                    :value="item.quantity"
                    @change="AdjustQuantity(item, $event)"
                  ></b-form-input> -->

                  <div class="checkout__item__quantity__button">
                    <button @click="AdjustQuantity(item, item.quantity + 1)">
                      <v-icon>mdi-plus</v-icon>
                    </button>
                  </div>
                </div>
              </div>
            </div>
            <div class="checkout__item__total">
              <div>
                <span style="fontweight: 600; fontsize: 20px">Amount: </span>
                <span v-text="item.price * item.quantity"></span>
                $
              </div>
            </div>
          </div>
        </div>
        <div class="checkout__redirect">
          <nuxt-link to="/Category"
            ><div>
              <span><v-icon>mdi-arrow-left</v-icon></span> Continue Shopping
            </div>
          </nuxt-link>
        </div>
      </div>
    </div>
    <div class="col-lg-1"></div>
    <div class="col-lg-4 checkout__right">
      <h2>Order Info</h2>
      <div>
        <div class="checkout__right__item">
          <div>Total Amount:</div>
          <div v-text="cartQuantity"></div>
        </div>
        <div class="checkout__right__item">
          <div>Total:</div>
          <div v-text="cartTotal + ' $'"></div>
        </div>

        <div class="checkout__right__button">
          <button @click="purchase()">Buy</button>
        </div>
        <div class="separator">or</div>
        <div>
          <div class="text-center" ref="paypal"></div>
          <div class="checkout__right__button">
            <button @click="thanhtoan()">Payment with MoMo</button>
          </div>
        </div>
      </div>
    </div>
  </div>

</template>
<script>
const axios = require("axios");
import baseRequest from "~/store/baseRequest";
export default {
  data() {
    return {
      user: [],
      item: [],
      urlaaa: [],
      notifyurl: "",
      cart1: [],
      loaded: false,
      paidFor: false,
      product: {
        price: 777.77,
        description: "leg lamp from that one movie",
        img: "./assets/lamp.jpg",
      },
    };
  },
  // watch: function(){
  //   this.$route.query.status;
  // },
  mounted: function () {
    this.CheckedLogin();
    //this.thanhtoan();
    //console.log(this.usersss);
    this.notifyurl = this.$route.query.errorCode;
    if (this.notifyurl == 0) {
      this.$store.commit("updateCart", []);
      let data = new FormData();
      data.append("user_id", this.usersss.id);
      data.append("total", this.orderTotal);
      data.append("cart", JSON.stringify(this.order));
      baseRequest
        .post("order/create", data)
        .then((response) => {
          console.log(response);
          this.$store.commit("updateOrder", []);
          this.$router.push(this.$route.path);
          //this.loading = false;
          //this.getPosts();
        })
        .catch((error) => {
          console.log(error);
        });
      console.log(this.order);
    }
    const script = document.createElement("script");
    script.src =
      "https://www.paypal.com/sdk/js?client-id=ATqr2hBpKcK-1HGCAK9RUT-jeTegvDMsNIgZI5jR7f1p_9gC2nBo5jHePa4P_rBHh3PCipqLk6eTwmzA";
    script.addEventListener("load", this.setLoaded);
    document.body.appendChild(script);

    this.save();
  },
  methods: {
    AdjustQuantity(item, quantity) {
      //console.log(quantity)
      this.$store.commit("AdjustQuantity", {
        ...item,
        quantity: parseInt(quantity),
      });
    },
    thanhtoan: function () {
      var endpoint =
        "https://test-payment.momo.vn/gw_payment/transactionProcessor";
      //var hostname = "https://test-payment.momo.vn";
      //var path = "/gw_payment/transactionProcessor";
      var partnerCode = "MOMOFPH620210629";
      var accessKey = "pLRg9mp9Vumw0XCF";
      var serectkey = "tvwRBXnU21wGA7y0nitUhkMXlFFToLVh";
      var orderInfo = "pay with MoMo";
      var returnUrl = "http://localhost:3000/checkout";
      var notifyurl = "http://localhost:3000/checkout";
      var amount = String(this.cartTotal);
      var requestId = partnerCode + new Date().getTime();
      var orderId = requestId;
      var requestType = "captureMoMoWallet";
      var extraData =
        "merchantName=[autosalingmachine01];merchantId=[MOMOMFJP20200425]"; //pass empty value if your merchant does not have stores else merchantName=[storeName]; merchantId=[storeId] to identify a transaction map with a physical store

      //before sign HMAC SHA256 with format
      //partnerCode=$partnerCode&accessKey=$accessKey&requestId=$requestId&amount=$amount&orderId=$oderId&orderInfo=$orderInfo&returnUrl=$returnUrl&notifyUrl=$notifyUrl&extraData=$extraData
      var rawSignature =
        "partnerCode=" +
        partnerCode +
        "&accessKey=" +
        accessKey +
        "&requestId=" +
        requestId +
        "&amount=" +
        amount +
        "&orderId=" +
        orderId +
        "&orderInfo=" +
        orderInfo +
        "&returnUrl=" +
        returnUrl +
        "&notifyUrl=" +
        notifyurl +
        "&extraData=" +
        extraData;
      //puts raw signature
      // console.log("--------------------RAW SIGNATURE----------------");
      // console.log(rawSignature);
      const crypto = require("crypto");
      var signature = crypto
        .createHmac("sha256", serectkey)
        .update(rawSignature)
        .digest("hex");
      // console.log("--------------------SIGNATURE----------------");
      // console.log(signature);
      // console.log("--------------------PAYURL----------------");
      var body = JSON.stringify({
        partnerCode: partnerCode,
        accessKey: accessKey,
        requestId: requestId,
        amount: amount,
        orderId: orderId,
        orderInfo: orderInfo,
        returnUrl: returnUrl,
        notifyUrl: notifyurl,
        extraData: extraData,
        requestType: requestType,
        signature: signature,
      });
      axios
        .post(endpoint, body)
        .then((response) => {
          window.location.href = response.data.payUrl;
          console.log(response);
          //this.urlaaa = response.data.payUrl;
          this.$store.commit("updateOrder", this.cart);

          //console.log(this.order);
          // axios
          //   .post(notifyurl, body)
          //   .then(function (response) {
          //     //console.log(response);
          //   })
          //   .catch(function (error) {
          //     console.log(error.message);
          //   });
        })
        .catch(function (error) {
          console.log(error.message);
        });
    },
    setLoaded: function () {
      this.loaded = true;
      window.paypal
        .Buttons({
          createOrder: (data, actions) => {
            return actions.order.create({
              purchase_units: [
                {
                  description: "test",
                  amount: {
                    currency_code: "USD",
                    value: this.cartTotal,
                  },
                },
              ],
            });
          },
          onApprove: async (data, actions) => {
            const order = await actions.order.capture();
            this.data;
            this.paidFor = true;
            this.purchase();
            console.log(order);
          },
          onError: (err) => {
            console.log(err);
          },
        })
        .render(this.$refs.paypal);
    },
    CheckedLogin: function () {
      baseRequest
        .get("user")
        .then((response) => {
          this.user = response.data;
          //console.log(this.user);
        })
        .catch(() => {
          this.$router.push({ name: "login" });
        });
    },
    purchase: function () {
      //console.log( this.user.name + " Mua " + this.cartQuantity + " sản phẩm với giá " + this.cartTotal);
      let data = new FormData();
      data.append("user_id", this.user.id);
      data.append("total", this.cartTotal);
      data.append("cart", JSON.stringify(this.cart));
      baseRequest
        .post("order/create", data)
        .then((response) => {
          console.log(response);
          this.$store.commit("removeFromCart");
          //this.loading = false;
          //this.getPosts();
        })
        .catch((error) => {
          console.log(error);
        });
    },
    save: function () {
      this.cart.forEach((i) => {
        console.log(
          "{name:'" + i.title + "',description :'" + i.content + "',},"
        );
      });
    },
  },
  computed: {
    cart() {
      return this.$store.state.cart;
    },
    usersss() {
      return this.$store.state.user;
    },
    order() {
      return this.$store.state.order;
    },
    cartQuantity() {
      return this.$store.state.cart.reduce(
        (acc, item) => acc + item.quantity,
        0
      );
    },
    cartTotal() {
      let price = this.cart.reduce(
        (acc, item) => acc + item.price * item.quantity,
        0
      );
      //price = price/100;
      return price;
    },
    orderTotal() {
      let price = this.order.reduce(
        (acc, item) => acc + item.price * item.quantity,
        0
      );
      //price = price/100;
      return price;
    },
  },
};
</script>

<style>
@import '~/assets/scss/style/checkout.css';

</style>
