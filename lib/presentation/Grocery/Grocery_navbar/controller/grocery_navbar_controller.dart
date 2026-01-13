import 'dart:io';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/view/grocery_cart_screen.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_categories/view/grocery_categories_screen.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/view/grocery_home_screen.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_wishlist/view/grocery_wishlist_screen.dart';
import 'package:woye_user/presentation/common/Profile/View/profile_screen.dart';

class GroceryNavbarController extends GetxController {
  int navbarCurrentIndex;

  GroceryNavbarController({this.navbarCurrentIndex = 0});

  NetworkController networkController = Get.find<NetworkController>();

  PrefUtils prefUtils = PrefUtils();
  File? profileImage;

  List<Widget> widgets = [
    GroceryHomeScreen(),
    GroceryCategoriesScreen(),
    GroceryWishlistScreen(),
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
    update();
  }
}
