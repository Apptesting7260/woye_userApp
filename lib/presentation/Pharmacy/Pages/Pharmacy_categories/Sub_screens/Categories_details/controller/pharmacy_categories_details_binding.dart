import 'package:get/get.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_categories/Sub_screens/Categories_details/controller/PharmacyCategoriesDetailsController.dart';

class RestaurantCategoriesBindingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PharmacyCategoriesDetailsController());
  }
}
