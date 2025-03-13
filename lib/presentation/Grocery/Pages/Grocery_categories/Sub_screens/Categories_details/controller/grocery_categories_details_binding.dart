import 'package:get/get.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_categories/Sub_screens/Categories_details/controller/GroceryCategoriesDetailsController.dart';

class GroceryCategoriesBindingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Grocerycategoriesdetailscontroller());
  }
}
