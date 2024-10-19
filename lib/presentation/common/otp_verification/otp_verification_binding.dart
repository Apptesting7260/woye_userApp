import 'package:get/get.dart';
import 'package:woye_user/presentation/common/otp_verification/otp_verifiction_controller.dart';

class OtpVerificatinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtpVerifictionController());
  }
}
