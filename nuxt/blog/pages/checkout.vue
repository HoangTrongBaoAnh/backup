<template>
  <div class="w-full">
    <table class="table">
      <thead>
        <tr>
          <th>Name</th>
          <th>Quantity</th>
          <th>Price</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(item, index) in cart" :key="item.id">
          <td v-text="item.title"></td>
          <td v-text="item.quantity"></td>
          <td v-text="item.price"></td>
          <td>
            <button @click="$store.commit('removeFromCart', index)">
              Remove
            </button>
          </td>
        </tr>
        <tr>
          <td>Total Amount</td>
          <td v-text="cartQuantity"></td>
          <td v-text="cartTotal"></td>
          <td><button @click="purchase()">Buy</button></td>
        </tr>
      </tbody>
    </table>
    <div class="text-center" ref="paypal"></div>
    <button @click="thanhtoan()">Buy</button>
  </div>
</template>
<script>
const axios = require("axios");

//import { returnTodaysWeather } from '../order.js'
import baseRequest from "../store/baseRequest";
export default {
  data() {
    return {
      user: [],
      item: [],
      urlaaa: [],
      notifyurl:"",
      cart1:[],
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
  mounted: function() {
    this.CheckedLogin();
    //this.thanhtoan();
    //console.log(this.usersss);
    this.notifyurl = this.$route.query.errorCode;
    if(this.notifyurl == 0){
      
      this.$store.commit('updateCart', [])
      let data = new FormData();
      data.append("user_id", this.usersss.id);
      data.append("total", this.orderTotal);
      data.append("cart", JSON.stringify(this.order));
      baseRequest
        .post("order/create", data)
        .then((response) => {
          console.log(response);
          this.$store.commit('updateOrder', [])
          this.$router.push(this.$route.path)
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
    thanhtoan: function() {
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
          console.log(response.data.payUrl);
          //this.urlaaa = response.data.payUrl;
          this.$store.commit('updateOrder', this.cart)
          
          console.log(this.order);
          axios.post(notifyurl, body)
          .then(function (response) {
            console.log(response);
            
          })
          .catch(function (error) {
            console.log(error.message);
          });
        })
        .catch(function(error) {
          console.log(error.message);
        });
    },
    setLoaded: function() {
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
    CheckedLogin: function() {
      baseRequest
        .get("user")
        .then((response) => {
          this.user = response.data;
          //console.log(this.user);
        })
        .catch(() => {
          this.$router.push({ name: "Login" });
        });
    },
    purchase: function() {
      //console.log( this.user.name + " Mua " + this.cartQuantity + " sản phẩm với giá " + this.cartTotal);
      let data = new FormData();
      data.append("user_id", this.user.id);
      data.append("total", this.cartTotal);
      data.append("cart", JSON.stringify(this.cart));
      baseRequest
        .post("order/create", data)
        .then((response) => {
          console.log(response);
          //this.loading = false;
          //this.getPosts();
        })
        .catch((error) => {
          console.log(error);
        });
    },
    save: function() {
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
