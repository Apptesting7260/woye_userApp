import 'dart:io';

import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/view/pharmacy_cart_screen.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_categories/view/pharmacy_categories_screen.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/view/pharmacy_home_screen.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_wishlist/view/pharmacy_wishlist_screen.dart';
import 'package:woye_user/presentation/common/Profile/View/profile_screen.dart';

class PharmacyNavbarController extends GetxController {
  int navbarCurrentIndex;

  PharmacyNavbarController({this.navbarCurrentIndex = 0});
  NetworkController networkController = Get.find<NetworkController>();

  PrefUtils prefUtils = PrefUtils();
  File? profileImage;

  List<Widget> widgets = [
     PharmacyHomeScreen(),
     PharmacyCategoriesScreen(),
     PharmacyWishlistScreen(),
     PharmacyCartScreen(),
    ProfileScreen(profileScreenType: "pharmacyProfileScreen")
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
