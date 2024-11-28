import 'package:get/get.dart';
import 'RestaurantCategoriesDetailsController.dart';

class RestaurantCategoriesBindingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RestaurantCategoriesDetailsController());
  }
}
