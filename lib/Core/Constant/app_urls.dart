class AppUrls {
  static const String baseUrl = "https://urlsdemo.online/woy/api";

  /* ---------------- Authentication -----------------------------------------  */

  static const String register = "$baseUrl/register";
  static const String login = "$baseUrl/login";
  static const String guestUser = "$baseUrl/guest-user";
  static const String socialLogin = "$baseUrl/social-login";

  /* ------------------------------ Profile ---------------------------------  */

  static const String getProfile = "$baseUrl/get-profile";
  static const String updateProfile = "$baseUrl/update-profile";

  // static const String updateStatus = "$baseUrl/update-status";

  /* ------------------------------ Address Section ----------------------------  */

  static const String getAddress = "$baseUrl/get-address";
  static const String addAddress = "$baseUrl/add-address";
  static const String editAddress = "$baseUrl/edit-address";
  static const String deleteAddress = "$baseUrl/delete-address";

  /* ------------------------------------------------ User Wallet ----------------------------------------------------  */

  static const String userWallet = "$baseUrl/user-wallet";

  /* ------------------------------ Restaurant ---------------------------------*/

  static const String homeApi = "$baseUrl/home-api";
  static const String restaurant_Categories = "$baseUrl/all-category";
  static const String all_Restaurant = "$baseUrl/all-restaurant";
  static const String restaurant_category_Details = "$baseUrl/category-product";
  static const String specific_restaurant = "$baseUrl/specific-restaurant";
  static const String specific_product = "$baseUrl/specific-product";
  static const String restaurant_aad_product_wishlist =
      "$baseUrl/product-wishlist";
  static const String restaurant_product_wishlist =
      "$baseUrl/all-product-wishlist";
  static const String get_CategoriesFilter = "$baseUrl/inner-search-data";
  static const String seeAllProducts = "$baseUrl/seeAll-specific-product";
  static const String seeAllReview = "$baseUrl/review-all";
  static const String homeSearch = "$baseUrl/home-search";
  static const String addToCart = "$baseUrl/make-cart";
  static const String updateCart = "$baseUrl/update-cart";
  static const String getCartData = "$baseUrl/get-cart";
  static const String updateQuantity = "$baseUrl/update-product-quantity";
  static const String deleteProduct = "$baseUrl/delete-product";
}
