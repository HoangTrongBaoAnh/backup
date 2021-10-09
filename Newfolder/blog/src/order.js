const axios = require("axios");
var endpoint = "https://test-payment.momo.vn/gw_payment/transactionProcessor";
//var hostname = "https://test-payment.momo.vn";
//var path = "/gw_payment/transactionProcessor";
var partnerCode = "MOMOFPH620210629";
var accessKey = "pLRg9mp9Vumw0XCF";
var serectkey = "tvwRBXnU21wGA7y0nitUhkMXlFFToLVh";
var orderInfo = "pay with MoMo";
var returnUrl = "http://localhost:8080/checkout";
var notifyurl = "https://momo.vn/notify";
var amount = "50000";
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
console.log("--------------------RAW SIGNATURE----------------");
console.log(rawSignature);
const crypto = require("crypto");
var signature = crypto
  .createHmac("sha256", serectkey)
  .update(rawSignature)
  .digest("hex");
console.log("--------------------SIGNATURE----------------");
console.log(signature);
console.log("--------------------PAYURL----------------");
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

export function returnTodaysWeather() {
  return axios
    .post(endpoint, body)
    .then(function(response) {
      console.log(response.data.payUrl);
      //return response.data.payUrl;
    })
    .catch(function(error) {
      console.log(error.message);
    });
}
