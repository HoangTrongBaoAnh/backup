window.fbAsyncInit = function() {
  window.FB.init({
    appId: "1449621782097242",
    autoLogAppEvents: true,
    xfbml: true,
    version: "v3.2"
  });

  //This function should be here, inside window.fbAsyncInit
  //  FB.getLoginStatus(function(response) {
  //    console.log(response);
  // });
};

(function(d, s, id) {
  var js,
    fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) {
    return;
  }
  js = d.createElement(s);
  js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js";
  fjs.parentNode.insertBefore(js, fjs);
})(document, "script", "facebook-jssdk");
