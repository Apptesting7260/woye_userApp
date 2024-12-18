import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Filter/controller/CategoriesFilter_controller.dart';

class CategoriesFilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Categories_FilterController());
  }
}
