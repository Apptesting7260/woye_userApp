import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_home/controller/restaurant_home_controller.dart';
import 'package:woye_user/core/utils/app_export.dart';

class RestaurantHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RestaurantHomeController());
  }
}
