import 'package:get/get.dart';
import 'package:woye_user/presentation/common/otp_verification/otp_verification_controller.dart';

class OtpVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtpVerificationController());
  }
}
