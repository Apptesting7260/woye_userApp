class AppUrls {
  static const String baseUrl = "https://urlsdemo.online/woy/api";

  /* ---------------- Authentication -----------------------------------------*/

  static const String register = "$baseUrl/register";
  static const String login = "$baseUrl/login";
  static const String guestUser = "$baseUrl/guest-user";
  static const String socialLogin = "$baseUrl/social-login";


  /* ------------------------------ Profile ---------------------------------*/
  static const String getProfile = "$baseUrl/get-profile";
  static const String updateProfile = "$baseUrl/update-profile";
  // static const String updateStatus = "$baseUrl/update-status";


  /* ------------------------------ Restaurant ---------------------------------*/

  static const String homeApi = "$baseUrl/home-api";
  static const String restaurant_Categories = "$baseUrl/all-category";
  static const String all_Restaurant = "$baseUrl/all-restaurant";
  static const String restaurant_category_Details = "$baseUrl/category-product";
  static const String specific_restaurant = "$baseUrl/specific-restaurant";
  static const String specific_product = "$baseUrl/specific-product";
  static const String restaurant_aad_product_wishlist = "$baseUrl/product-wishlist";
  static const String restaurant_product_wishlist = "$baseUrl/all-product-wishlist";
  static const String get_CategoriesFilter = "$baseUrl/inner-search-data";
}