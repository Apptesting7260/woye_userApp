import 'package:get/get.dart';
import 'package:woye_user/presentation/Common/login_otp/login_otp_controller.dart';

class LoginOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginOtpController());
  }
}
