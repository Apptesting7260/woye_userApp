import 'dart:io';

import 'package:woye_user/Presentation/Restaurants/Pages/Categories/categories_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Home_restaurant/home_restaurant_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/My_cart/my_cart_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/My_profile/my_profile_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Wishlist/wishlist_screen.dart';
import 'package:woye_user/core/Utils/pref_utils.dart';
import 'package:woye_user/core/utils/app_export.dart';

class RestaurantNavbarController extends GetxController {
  int navbarCurrentIndex;

  RestaurantNavbarController({this.navbarCurrentIndex = 0});
  NetworkController networkController = Get.find<NetworkController>();

  PrefUtils prefUtils = PrefUtils();
  File? profileImage;

  List<Widget> widgets = [
    const HomeRestaurantScreen(),
    const CategoriesScreen(),
    const MyCartScreen(),
    const MyProfileScreen(),
    const WishlistScreen()
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
