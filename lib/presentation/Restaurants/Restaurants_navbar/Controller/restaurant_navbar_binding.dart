import 'package:get/get.dart';
import 'package:woye_user/Presentation/Restaurants/Restaurants_navbar/Controller/restaurant_navbar_controller.dart';

class RestaurantNavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RestaurantNavbarController());
  }
}
