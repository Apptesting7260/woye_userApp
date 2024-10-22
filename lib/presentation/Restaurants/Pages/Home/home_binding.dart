import 'package:woye_user/Presentation/Restaurants/Pages/Home/home_controller.dart';
import 'package:woye_user/core/utils/app_export.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
