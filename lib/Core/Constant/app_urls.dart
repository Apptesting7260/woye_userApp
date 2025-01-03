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
  static const String restaurantCategories = "$baseUrl/all-category";
  static const String allRestaurant = "$baseUrl/all-restaurant";
  static const String restaurantCategoryDetails = "$baseUrl/category-product";
  static const String specificRestaurant = "$baseUrl/specific-restaurant";
  static const String specificProduct = "$baseUrl/specific-product";
  static const String addProductWishlist =
      "$baseUrl/product-wishlist";
  static const String restaurantProductWishlist =
      "$baseUrl/all-product-wishlist";
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
}
