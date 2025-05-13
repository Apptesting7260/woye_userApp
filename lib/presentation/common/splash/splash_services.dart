import 'dart:async';
import 'package:get/get.dart';
import 'package:woye_user/main.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/Vendor_details/grocery_vendor_details_screen.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Vendor_details/pharmacy_vendor_details_screen.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/controller/RestaurantDetailsController.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/view/restaurant_details_screen.dart';
import 'package:woye_user/presentation/common/app_link/deeplinkingController.dart';
import '../../../Data/userPrefrenceController.dart';
import '../../../Routes/app_routes.dart';

class SplashServices {
  UserPreference userPreference = UserPreference();
  final deepLinkController = Get.put(DeepLinkController());


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
      } else
      // {
      //   print("object out ${deepLinkController.deepLinkType.value}");
      //   if (deepLinkController.deepLinkType.value != "") {
      //     print("object ss ${deepLinkController.deepLinkType.value}");
      //     Get.offAllNamed(AppRoutes.restaurantNavbar)?.then(
      //       (value) {
      //         Get.to(RestaurantDetailsScreen(
      //           Restaurantid: deepLinkController.deepLinkRestaurantsId.value,
      //         ));
      //         restaurantDeatilsController.restaurant_Details_Api(
      //           id: deepLinkController.deepLinkRestaurantsId.value,
      //         );
      //       },
      //     );
      //   }
      //   else
      {
        if (value.loginType == "Guest") {
          print("Splash service 1111111111");
          Timer(const Duration(seconds: 2), () {
            Get.offAllNamed(AppRoutes.restaurantNavbar);
            inSplash.value = false;
          });
        } else {
          if (value.step == 1) {
            print("Splash service 222222");

            Timer(const Duration(seconds: 2), () {
              Get.offAllNamed(AppRoutes.signUpFom);
              inSplash.value = false;
            });
          } else if (value.step == 2) {
            print("Splash service 333333333");
            Timer(const Duration(seconds: 2), () {
              print("Splash service 444");
              Get.offAllNamed(AppRoutes.restaurantNavbar);
              print("Splash service ${deepLinkController.deepLinkType.value}");
              if (deepLinkController.deepLinkType.value == "") {
                Get.offAllNamed(AppRoutes.restaurantNavbar);
              } else {
                if (deepLinkController.deepLinkType.value == 'restaurants') {
                  Get.offAllNamed(AppRoutes.restaurantNavbar);
                  Get.to(()=>RestaurantDetailsScreen(
                    Restaurantid: deepLinkController.deepLinkRestaurantsId.value,
                  ));
                } else if (deepLinkController.deepLinkType.value == 'pharmacy') {
                  Get.offAllNamed(AppRoutes.pharmacyNavbar);
                  Get.to(()=>PharmacyVendorDetailsScreen(
                    pharmacyId: deepLinkController.deepLinkRestaurantsId.value.toString(),
                  ));
                } else if (deepLinkController.deepLinkType.value == 'grocery') {
                  Get.offAllNamed(AppRoutes.pharmacyNavbar);
                  Get.to(GroceryVendorDetailsScreen(
                    groceryId: deepLinkController.deepLinkRestaurantsId.value,
                  ));
                }
              }
              inSplash.value = false;
            });
          }
        }
      }
      // }
    });
  }
}
