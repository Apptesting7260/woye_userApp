import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:woye_user/Routes/app_routes.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/controller/RestaurantDetailsController.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/view/restaurant_details_screen.dart';

class DeepLinkController extends GetxService {

  final RestaurantDetailsController restaurantDeatilsController =
  Get.put(RestaurantDetailsController());
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;
  var deepLinkRestaurantsId = "".obs;
  var deepLinkType = "".obs;

  @override
  void onInit() {
    super.onInit();
    initDeepLinks();
  }

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      print("uri from deeplink: ${uri}");
      if (uri.path.contains('restaurants')) {
        print("rrrrrrrrrrrrrrrrrrrrrrrrrr");
        deepLinkType.value = "restaurants";
        final groupId = uri.queryParameters['id'] ?? "";
        deepLinkRestaurantsId.value = groupId;
        print("object ${deepLinkType.value}");
        if (deepLinkType.value != "") {
          print("object ss ${deepLinkType.value}");
          // Get.offAllNamed(AppRoutes.restaurantNavbar)?.then(
          //       (value) {
          Get.to(RestaurantDetailsScreen(
                Restaurantid: deepLinkRestaurantsId.value,
              ));
              restaurantDeatilsController.restaurant_Details_Api(
                id: deepLinkRestaurantsId.value,
              );
            // },
          // );
        }
      }
      // else if (uri.path.contains('profile')) {
      //   deepLinkType.value = "profile";
      // }
      else {
        deepLinkType.value = "";
      }

      // final groupId = uri.queryParameters['id'] ?? "";
      // deepLinkGroupId.value = groupId;
    });
  }

  @override
  void onClose() {
    _linkSubscription?.cancel();
    super.onClose();
  }
}
