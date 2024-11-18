import 'dart:io';

import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_cart/View/restaurant_cart_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_categories/View/restaurant_categories_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_wishlist/View/restaurant_wishlist_screen.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/View/restaurant_home_screen.dart';
import 'package:woye_user/presentation/common/Profile/View/profile_screen.dart';

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
    ProfileScreen()
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
