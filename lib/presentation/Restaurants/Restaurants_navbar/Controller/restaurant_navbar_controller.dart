import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_cart/View/restaurant_cart_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_categories/View/restaurant_categories_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_wishlist/View/restaurant_wishlist_screen.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/view/grocery_cart_screen.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_categories/view/grocery_categories_screen.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/view/grocery_home_screen.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_wishlist/view/grocery_wishlist_screen.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_categories/view/pharmacy_categories_screen.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/view/pharmacy_home_screen.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/View/restaurant_single_cart_screen.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/View/restaurant_home_screen.dart';
import 'package:woye_user/presentation/common/Profile/View/profile_screen.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';

import '../../../Pharmacy/Pages/Pharmacy_cart/view/pharmacy_cart_screen.dart';
import '../../../Pharmacy/Pages/Pharmacy_wishlist/view/pharmacy_wishlist_screen.dart';

class RestaurantNavbarController extends GetxController {
  int navbarCurrentIndex;
  RxInt mainButtonIndex = 0.obs;


  void getIndexMainButton(index) {
    mainButtonIndex.value = index;
    update();
  }

  var storage = GetStorage();

  RestaurantNavbarController({this.navbarCurrentIndex = 0});

  void navigateBackToMainNavbar({required int index}) {
    Get.until((route) => Get.currentRoute == AppRoutes.restaurantNavbar);
    getIndex(index);
  }


  NetworkController networkController = Get.find<NetworkController>();

  PrefUtils prefUtils = PrefUtils();
  File? profileImage;

  List<Widget> widgets0 = [
    const RestaurantHomeScreen(),
    RestaurantCategoriesScreen(),
    RestaurantCartScreen(),
    ProfileScreen(profileScreenType: "restaurantProfileScreen",)
  ];

  List<Widget> widgets1 = [
    PharmacyHomeScreen(),
    PharmacyCategoriesScreen(),
    PharmacyCartScreen(),
    ProfileScreen(profileScreenType: "pharmacyProfileScreen")
  ];

  List<Widget> widgets2 = [
    GroceryHomeScreen(),
    GroceryCategoriesScreen(),
    GroceryCartScreen(isBack: false,),
    ProfileScreen(profileScreenType: 'groceryProfileScreen',)
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
