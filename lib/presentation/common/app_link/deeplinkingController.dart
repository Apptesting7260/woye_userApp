import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:get/get.dart';
import 'package:woye_user/Routes/app_routes.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/controller/RestaurantDetailsController.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/view/restaurant_details_screen.dart';

import '../../../Core/Utils/app_export.dart';

class DeepLinkController extends GetxService {
  final RestaurantDetailsController restaurantDeatilsController = Get.put(RestaurantDetailsController());
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
    // print("Valuewwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww11");
    _appLinks = AppLinks();
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) async {
      print("uri from deeplink: $uri");
      if (uri.path.contains('restaurants')) {
        print("rrrrrrrrrrrrrrrrrrrrrrrrrr");
        deepLinkType.value = "restaurants";
        // final groupId = uri.queryParameters['id'] ?? "";
        // deepLinkRestaurantsId.value = groupId;
        // print("object ${deepLinkType.value}");
        // Get.offAllNamed(AppRoutes.restaurantNavbar);
        // if (deepLinkType.value == "restaurants") {
        //   print("object ss ${deepLinkType.value}");
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     Get.to(()=>RestaurantDetailsScreen(
        //       Restaurantid: deepLinkRestaurantsId.value,
        //     ));s
        //   });
        //  }
      } else if (uri.path.contains('pharmacy')) {
        print("pharmacyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
        deepLinkType.value = "pharmacy";
      }else if (uri.path.contains('grocery')) {
        print("groceryyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
        deepLinkType.value = "grocery";
      }
      // else if (uri.path.contains('profile')) {
      //   deepLinkType.value = "profile";
      // }
      else {
        deepLinkType.value = "";
        // print("Valuewwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww");
      }
      final groupId = uri.queryParameters['id'] ?? "";
      deepLinkRestaurantsId.value = groupId;
      print("object ${deepLinkType.value}");
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

