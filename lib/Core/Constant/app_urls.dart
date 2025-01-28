class AppUrls {
  static const String baseUrl = "https://nbttech.xyz/woy/api";

  // static const String baseUrl = "https://urlsdemo.online/woy/api";

  /* ---------------- Authentication -----------------------------------------  */

  static const String register = "$baseUrl/register";
  static const String login = "$baseUrl/login";
  static const String guestUser = "$baseUrl/guest-user";
  static const String socialLogin = "$baseUrl/social-login";

  /* ------------------------------ Profile ---------------------------------  */

  static const String getProfile = "$baseUrl/get-profile";
  static const String updateProfile = "$baseUrl/update-profile";
  static const String getUserData = "$baseUrl/user-profile";

  // static const String updateStatus = "$baseUrl/update-status";

  /* ------------------------------ Address Section ----------------------------  */

  static const String getAddress = "$baseUrl/get-address";
  static const String addAddress = "$baseUrl/add-address";
  static const String editAddress = "$baseUrl/edit-address";
  static const String deleteAddress = "$baseUrl/delete-address";

  /* ------------------------------------------------ User Wallet ----------------------------------------------------  */

  static const String userWallet = "$baseUrl/user-wallet";

  /* ------------------------------------------------ Show Orders  ----------------------------------------------------  */

  static const String getOrdersList = "$baseUrl/list-order";

  /* ------------------------------ Restaurant ---------------------------------*/

  static const String homeApi = "$baseUrl/home-api";
  static const String restaurantCategories = "$baseUrl/all-category";
  static const String allRestaurant = "$baseUrl/all-restaurant";
  static const String restaurantCategoryDetails = "$baseUrl/category-product";
  static const String specificRestaurant = "$baseUrl/specific-restaurant";
  static const String restaurantBannersData = "$baseUrl/banners-data";
  static const String specificProduct = "$baseUrl/specific-product";
  static const String addProductWishlist = "$baseUrl/product-wishlist";
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
  static const String createOrder = "$baseUrl/create-order";

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
  static const String getPharmaCartData = "$baseUrl/pget-cart";
  static const String deletePharmaProduct = "$baseUrl/pdelete-product";
  static const String updatePharmaQuantity =
      "$baseUrl/pupdate-product-quantity";
  static const String pharmaCheckedUnchecked = "$baseUrl/pchecked-unchecked";

}
