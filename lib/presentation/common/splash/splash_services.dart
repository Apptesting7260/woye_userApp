import 'dart:async';
import 'package:get/get.dart';
import '../../../Data/userPrefrenceController.dart';
import '../../../Routes/app_routes.dart';

class SplashServices {
  UserPreference userPreference = UserPreference();

  void isLogin() {
    userPreference.getUser().then((value) {
      print("value.token${value.token}");
      print("value.isLogin${value.isLogin}");
      print("value.step${value.step}");
      print("value.type${value.loginType}");

      if (value.isLogin == false || value.isLogin.toString() == 'null') {
        Timer(const Duration(seconds: 2),
            () => Get.offAllNamed(AppRoutes.welcomeScreen));
      } else {
        if (value.loginType == "Guest") {
          Timer(const Duration(seconds: 2),
              () => Get.offAllNamed(AppRoutes.restaurantNavbar));
        } else {
          if (value.step == 1) {
            Timer(const Duration(seconds: 2),
                () => Get.offAllNamed(AppRoutes.signUpFom));
          } else if (value.step == 2) {
            Timer(const Duration(seconds: 2),
                () => Get.offAllNamed(AppRoutes.restaurantNavbar));
          }
        }
      }
    });
  }
}
