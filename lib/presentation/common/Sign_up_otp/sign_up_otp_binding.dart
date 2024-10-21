import 'package:get/get.dart';
import 'package:woye_user/presentation/Common/sign_up/sign_up_controller.dart';

class SignUpOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController());
  }
}
