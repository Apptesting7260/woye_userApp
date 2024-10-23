import 'package:get/get.dart';

import 'login_otp_controller.dart';

class LoginOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginOtpController());
  }
}
