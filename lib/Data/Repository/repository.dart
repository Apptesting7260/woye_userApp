import 'package:woye_user/Core/Constant/app_urls.dart';
import 'package:woye_user/Data/Model/usermodel.dart';
import 'package:woye_user/Data/network/network_api_services.dart';
import 'package:woye_user/Data/userPrefrenceController.dart';
import 'package:woye_user/Presentation/Common/Otp/model/register_model.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Categories_details/Modal/RestaurantCategoryDetailsModal.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_categories/Modal/restaurant_categories_modal.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Filter/modal/CategoriesFilter_modal.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/All_Restaurant/modal/all_restaurant_modal.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/More_Products/modal/see_all_products_modal.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/modal/specific_product_modal.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/modal/singal_restaurant_modal.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Model/home_model.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_wishlist/Controller/Modal.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_wishlist/Controller/aad_product_wishlist_Controller/Modal.dart';
import 'package:woye_user/presentation/common/Otp/model/login_model.dart';
import 'package:woye_user/presentation/common/Social_login/social_model.dart';
import 'package:woye_user/presentation/common/Update_profile/Model/getprofile_model.dart';

class Repository {
  final _apiService = NetworkApiServices();

  String token = "";
  UserModel userModel = UserModel();
  var pref = UserPreference();

  Future<void> initializeUser() async {
    userModel = await pref.getUser();
    token = userModel.token!;
  }

  /* ------------------------------------------------ Authentication ----------------------------------------------------*/

  Future<dynamic> registerApi(data) async {
    dynamic response = await _apiService.postApi(data, AppUrls.register, "");
    return RegisterModel.fromJson(response);
  }

  Future<dynamic> loginApi(data) async {
    dynamic response = await _apiService.postApi(data, AppUrls.login, "");
    return LoginModel.fromJson(response);
  }

  Future<dynamic> guestUserApi(data) async {
    dynamic response = await _apiService.postApi(data, AppUrls.guestUser, "");
    return RegisterModel.fromJson(response);
  }

  Future<dynamic> SocialLoginApi(data) async {
    dynamic response = await _apiService.postApi(data, AppUrls.socialLogin, "");
    return SocialModel.fromJson(response);
  }

  /* ------------------------------------------------ Profile ----------------------------------------------------*/

  Future<dynamic> getprofileApi() async {
    await initializeUser();
    dynamic response = await _apiService.getApi(AppUrls.getProfile, token);
    return ProfileModel.fromJson(response);
  }

  // Future<dynamic> updateprofileApi(data) async {
  //   await initializeUser();
  //   dynamic response =
  //       await _apiService.postApi(data, AppUrls.updateProfile, token);
  //   return UpdateprofileModel.fromJson(response);
  // }

  /* ------------------------------------------------ Restaurant ----------------------------------------------------*/

  Future<dynamic> homeApi({required int page, required int perPage}) async {
    await initializeUser();
    final String url = '${AppUrls.homeApi}?page=$page&per_page=$perPage';

    dynamic response = await _apiService.getApi(url, token);
    return HomeModel.fromJson(response);
  }

  Future<dynamic> all_Restaurant_Api() async {
    await initializeUser();
    dynamic response = await _apiService.getApi(AppUrls.all_Restaurant, token);
    return all_restaurant_modal.fromJson(response);
  }

  Future<dynamic> restaurant_Categories_Api() async {
    await initializeUser();
    dynamic response =
        await _apiService.getApi(AppUrls.restaurant_Categories, token);
    return restaurant_Categories_Modal.fromJson(response);
  }

  Future<dynamic> Restaurant_Category_Details_Api(var data) async {
    await initializeUser();
    dynamic response = await _apiService.postApi(
        data, AppUrls.restaurant_category_Details, token);
    return RestaurantCategoryDetailsModal.fromJson(response);
  }

  Future<dynamic> specific_Restaurant_Api(var data) async {
    await initializeUser();
    dynamic response =
        await _apiService.postApi(data, AppUrls.specific_restaurant, token);
    return SpecificRestaurantModal.fromJson(response);
  }

  Future<dynamic> specific_Product_Api(var data) async {
    await initializeUser();
    dynamic response =
        await _apiService.postApi(data, AppUrls.specific_product, token);
    return specificProduct.fromJson(response);
  }

  Future<dynamic> add_Product_Wishlist(
    var data,
  ) async {
    await initializeUser();
    dynamic response = await _apiService.postApi(
        data, AppUrls.restaurant_aad_product_wishlist, token);
    return restaurant_add_product_wishlist_modal.fromJson(response);
  }

  Future<dynamic> Restaurant_All_product_wishlist_Api() async {
    await initializeUser();
    dynamic response =
        await _apiService.getApi(AppUrls.restaurant_product_wishlist, token);
    return restaurant_product_wishlist_modal.fromJson(response);
  }

  Future<dynamic> get_CategoriesFilter_Api() async {
    await initializeUser();
    dynamic response =
        await _apiService.getApi(AppUrls.get_CategoriesFilter, token);
    return CategoriesFilter_modal.fromJson(response);
  }

  Future<dynamic> seeAllProductApi(var data) async {
    await initializeUser();
    dynamic response =
        await _apiService.postApi(data, AppUrls.seeAllProducts, token);
    return seeAllProductsModal.fromJson(response);
  }
}
