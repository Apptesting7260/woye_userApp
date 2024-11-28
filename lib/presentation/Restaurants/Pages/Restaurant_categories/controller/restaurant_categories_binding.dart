import 'package:get/get.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_categories/controller/restaurant_categories_controller.dart';

class RestaurantCategoriesBindingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RestaurantCategoriesController());
  }
}
