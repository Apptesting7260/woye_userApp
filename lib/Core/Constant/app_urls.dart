class AppUrls {
  // static const String hostUrl = "https://nbttech.xyz";
  // static const String baseUrl = "https://nbttech.xyz/woy/api";

  static const String hostUrl = "https://nbturls.in";
  static const String baseUrl = "https://nbturls.in/woy/api";
  static const String baseUrlPrivacyPolicy = "https://nbturls.in/woy";

  // static const String baseUrl = "https://urlsdemo.online/woy/api";
  // static const String baseUrl = "https://urlsdemo.online/woy/api";

  /* ---------------- Authentication -----------------------------------------  */

  static const String register = "$baseUrl/register";
  static const String login = "$baseUrl/login";
  static const String guestUser = "$baseUrl/guest-user";
  static const String checkUser = "$baseUrl/check-user";
  static const String socialLogin = "$baseUrl/social-login";

  /* ------------------------------ maintenance and app version ---------------------------------  */
  static const String maintenance = "$baseUrl/maintenance";
  static const String appVersion = "$baseUrl/app-version";

  /* ------------------------------ Profile ---------------------------------  */

  static const String getProfile = "$baseUrl/get-profile";
  static const String updateProfile = "$baseUrl/update-profile";
  static const String getUserData = "$baseUrl/user-profile";
  static const String sendVerificationOtp = "$baseUrl/send-verification-otp";
  static const String verifyOtp = "$baseUrl/verify-email-otp";

  // static const String updateStatus = "$baseUrl/update-status";

  /* ------------------------------ privacy-policy----------------------------  */

  static const String privacyPolicy = '$baseUrlPrivacyPolicy/privacy-policy';
  static const String termsConditions = '$baseUrlPrivacyPolicy/terms-conditions';

  /* ------------------------------ Notification----------------------------  */

  static const String userNotification = "$baseUrl/user-notification";

  /* ------------------------------ invite friends ----------------------------  */

  static const String inviteFriends = "$baseUrl/invite-friends";

  /* ------------------------------ Faq ----------------------------  */

  static const String faq = "$baseUrl/faq-user";

  /* ------------------------------ Address Section ----------------------------  */

  static const String getAddress = "$baseUrl/get-address";
  static const String addAddress = "$baseUrl/add-address";
  static const String editAddress = "$baseUrl/edit-address";
  static const String deleteAddress = "$baseUrl/delete-address";

  /* ------------------------------------------------ User Wallet ----------------------------------------------------  */

  static const String userWallet = "$baseUrl/transaction-history";
  static const String userTransaction = "$baseUrl/user-transaction";
  // static const String userWallet = "$baseUrl/user-wallet";

  /* ------------------------------------------------ Show Orders  ----------------------------------------------------  */

  static const String getOrdersList = "$baseUrl/list-order";
  static const String ordersDetails = "$baseUrl/detail-order";
  static const String cancelOrder = "$baseUrl/cancel-order";
  static const String postVendorReview = "$baseUrl/post-review";

  /* ------------------------------ Restaurant ---------------------------------*/

  static const String homeApi = "$baseUrl/home-api";
  static const String restaurantCategories = "$baseUrl/all-category";
  static const String allRestaurant = "$baseUrl/all-restaurant";
  static const String restaurantCategoryDetails = "$baseUrl/category-product";
  static const String specificRestaurant = "$baseUrl/specific-restaurant";
  static const String restaurantBannersData = "$baseUrl/banners-data";
  static const String specificProduct = "$baseUrl/specific-product";
  static const String addProductWishlist = "$baseUrl/product-wishlist";
  static const String restaurantProductWishlist = "$baseUrl/all-product-wishlist";
  static const String getCategoriesFilter = "$baseUrl/inner-search-data";
  static const String seeAllProducts = "$baseUrl/seeAll-specific-product";
  static const String seeAllReview = "$baseUrl/review-all";
  static const String homeSearch = "$baseUrl/home-search";
  static const String addToCart = "$baseUrl/make-cart";
  static const String updateCart = "$baseUrl/update-cart";
  static const String getCartData = "$baseUrl/get-cart";
  static const String updateQuantity = "$baseUrl/update-product-quantity";
  static const String deleteProduct = "$baseUrl/delete-product";
  static const String applyCoupons = "$baseUrl/apply-coupons";
  static const String checkedUnchecked = "$baseUrl/checked-unchecked";
  static const String createOrder = "$baseUrl/create-order";
  static const String trackOrderRestaurant = "$baseUrl/track-order";
  static const String rAllCartsRestaurant = "$baseUrl/rall-carts";
  static const String checkoutAllRestaurant = "$baseUrl/checkout-all";
  static const String deleteVendorRestaurant = "$baseUrl/delete-vendor";
  static const String orderTypeResUrl = "$baseUrl/order-type";

  /* ------------------------------------------------ Pharmacy  ----------------------------------------------------  */

  static const String pharmacyHomeApi = "$baseUrl/pharamacy-home-api";
  static const String pharmacyCategories = "$baseUrl/all-pcategory";
  static const String pharmacyCategoriesDetails = "$baseUrl/pcategory-product";
  static const String pharmacyProductWishlist = "$baseUrl/all-pharma-wishlist";
  static const String addPharmaProductWishlist = "$baseUrl/pharma-wishlist";
  static const String pharmaSpecificProduct = "$baseUrl/pspecific-product";
  static const String allShops = "$baseUrl/pall-shops";
  static const String pharmaBannersData = "$baseUrl/pbanners-data";
  static const String specificPharmaShop = "$baseUrl/specific-pharmacy";
  static const String pharmaHomeSearch = "$baseUrl/phome-search";
  static const String getPharmaCategoriesFilter = "$baseUrl/pinner-search-data";
  static const String pharmaAddToCart = "$baseUrl/pmake-cart";
  static const String pharmaUpdateCart = "$baseUrl/pupdate-cart";
  // static const String getPharmaCartData = "$baseUrl/pall-carts";
  static const String getPharmaCartData = "$baseUrl/pget-cart";
  static const String getAllPharmaCartData = "$baseUrl/pall-carts";
  static const String deletePharmaProduct = "$baseUrl/pdelete-product";
  static const String updatePharmaQuantity = "$baseUrl/pupdate-product-quantity";
  static const String pharmaCheckedUnchecked = "$baseUrl/pchecked-unchecked";

  static const String applyPharmaCoupons = "$baseUrl/papply-coupons";
  static const String pharmacyCheckoutAll = "$baseUrl/pcheckout-all";
  static const String pharmacyDeleteVendor = "$baseUrl/pdelete-vendor";
  static const String pharmacyCreateOrder = "$baseUrl/pcreate-order";
  static const String orderTypePharmacyUrls = "$baseUrl/porder-type";

/* ------------------------------------------------ Grocery  ----------------------------------------------------  */
  static const String groceryHomeApi = "$baseUrl/grocery-home-api";
  static const String groceryCategories = "$baseUrl/all-gcategory";
  static const String groceryCategoriesDetails = "$baseUrl/gcategory-product";
  static const String addGroceryProductWishlist = "$baseUrl/grocery-wishlist";
  static const String groceryProductWishlist = "$baseUrl/all-grocery-wishlist";
  static const String allGrocery = "$baseUrl/gall-shops";
  static const String specificGroceryShop = "$baseUrl/specific-grocery";
  static const String grocerySpecificProduct = "$baseUrl/gspecific-product";
  static const String groceryHomeSearch = "$baseUrl/ghome-search";
  static const String getGroceryCategoriesFilter = "$baseUrl/ginner-search-data";
  static const String applyCouponsGrocery = "$baseUrl/gapply-coupons";

  static const String groceryBannersData = "$baseUrl/gbanners-data";
  static const String groceryAddToCart = "$baseUrl/gmake-cart";
  static const String groceryAllCart = "$baseUrl/gcheckout-all";
  static const String grocerySingleVendorCart = "$baseUrl/gget-cart";
  static const String groceryShowAllCart = "$baseUrl/all-carts";

  static const String deleteGroceryProduct = "$baseUrl/gdelete-product";
  static const String deleteGroceryVendor = "$baseUrl/gdelete-vendor";
  static const String updateGroceryQuantity = "$baseUrl/gupdate-product-quantity";
  static const String groceryCreateOrder = "$baseUrl/gcreate-order";
  static const String groceryCheckUncheck = "$baseUrl/gchecked-unchecked";
  static const String gOrderTypeUrl = "$baseUrl/gorder-type";

}
