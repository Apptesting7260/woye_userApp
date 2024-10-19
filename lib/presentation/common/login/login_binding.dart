import 'package:get/get.dart';
import 'package:woye_user/presentation/common/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
