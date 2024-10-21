import 'dart:io';

import 'package:woye_user/core/Utils/pref_utils.dart';
import 'package:woye_user/core/utils/app_export.dart';

class RestaurantNavbarController extends GetxController {
  int navbarCurrentIndex;

  RestaurantNavbarController({this.navbarCurrentIndex = 0});
  NetworkController networkController = Get.find<NetworkController>(); 

  PrefUtils prefUtils = PrefUtils();
  File? profileImage;
  // int navbarCurrentIndex = 0;

  List<Widget> widgets = [
    // const HomeScreen(),
    // const CustomerSupport(),
    // const ProfilePage()
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
