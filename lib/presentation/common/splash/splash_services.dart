import 'dart:async';
import 'package:get/get.dart';
import 'package:woye_user/main.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/controller/RestaurantDetailsController.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/view/restaurant_details_screen.dart';
import 'package:woye_user/presentation/common/app_link/deeplinkingController.dart';
import '../../../Data/userPrefrenceController.dart';
import '../../../Routes/app_routes.dart';

class SplashServices {
  UserPreference userPreference = UserPreference();
  final deepLinkController = Get.put(DeepLinkController());
  final RestaurantDetailsController restaurantDeatilsController =
  Get.put(RestaurantDetailsController());

  void isLogin() {
    userPreference.getUser().then((value) {
      print("value.token${value.token}");
      print("value.isLogin${value.isLogin}");
      print("value.step${value.step}");
      print("value.type${value.loginType}");
      if (value.isLogin == false || value.isLogin.toString() == 'null') {
        Timer(const Duration(seconds: 2), () {
          Get.offAllNamed(AppRoutes.welcomeScreen);
          inSplash.value = false;
        });
      } else {
        if (deepLinkController.deepLinkType.value != "") {
          Get.offAllNamed(AppRoutes.restaurantNavbar)?.then(
            (value) {
              Get.to(RestaurantDetailsScreen(
                Restaurantid: deepLinkController.deepLinkRestaurantsId.value,
              ));
              restaurantDeatilsController.restaurant_Details_Api(
                id: deepLinkController.deepLinkRestaurantsId.value,
              );
            },
          );
        } else {
          if (value.loginType == "Guest") {
            Timer(const Duration(seconds: 2), () {
              Get.offAllNamed(AppRoutes.restaurantNavbar);
              inSplash.value = false;
            });
          } else {
            if (value.step == 1) {
              Timer(const Duration(seconds: 2), () {
                Get.offAllNamed(AppRoutes.signUpFom);
                inSplash.value = false;
              });
            } else if (value.step == 2) {
              Timer(const Duration(seconds: 2), () {
                Get.offAllNamed(AppRoutes.restaurantNavbar);
                inSplash.value = false;
              });
            }
          }
        }
      }
    });
  }
}
