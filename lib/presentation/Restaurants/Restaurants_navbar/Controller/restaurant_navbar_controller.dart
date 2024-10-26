import 'dart:io';

import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_cart/restaurant_cart_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_categories/restaurant_categories_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_home/restaurant_home_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_profile/restaurant_profile_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_wishlist/restaurant_wishlist_screen.dart';
import 'package:woye_user/core/utils/app_export.dart';

class RestaurantNavbarController extends GetxController {
  int navbarCurrentIndex;

  RestaurantNavbarController({this.navbarCurrentIndex = 0});
  NetworkController networkController = Get.find<NetworkController>();

  PrefUtils prefUtils = PrefUtils();
  File? profileImage;

  List<Widget> widgets = [
    const RestaurantHomeScreen(),
    const RestaurantCategoriesScreen(),
    const RestaurantWishlistScreen(),
    const RestaurantCartScreen(),
    const RestaurantProfileScreen(),
  ];

  @override
  void onInit() async {
    networkController.onInit();
    token = await prefUtils.getToken();
    debugPrint("response token at profile page ====================>$token");

    super.onInit();
  }

  bool isloading = false;
  String? token;
  Map<String, dynamic>? profileDetails;

  void getIndex(int index) {
    navbarCurrentIndex = index;
    update();
  }
}
