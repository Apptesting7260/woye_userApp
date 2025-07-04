import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_cart/View/restaurant_cart_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_categories/View/restaurant_categories_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_wishlist/View/restaurant_wishlist_screen.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/View/restaurant_single_cart_screen.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/View/restaurant_home_screen.dart';
import 'package:woye_user/presentation/common/Profile/View/profile_screen.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';

class RestaurantNavbarController extends GetxController {
  int navbarCurrentIndex;

  var storage = GetStorage();

  RestaurantNavbarController({this.navbarCurrentIndex = 0});

  NetworkController networkController = Get.find<NetworkController>();

  PrefUtils prefUtils = PrefUtils();
  File? profileImage;

  List<Widget> widgets = [
    const RestaurantHomeScreen(),
    RestaurantCategoriesScreen(),
    RestaurantWishlistScreen(),
    RestaurantCartScreen(),
    ProfileScreen(profileScreenType: "restaurantProfileScreen",)
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
    pt("Navigation to screen>>>>>>>>>>>>>>>>>>>>>>>>> $index  >>>>>>>>>$navbarCurrentIndex");
    update();
  }

}
