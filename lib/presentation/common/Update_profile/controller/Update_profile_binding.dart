import 'package:get/get.dart';
import 'package:woye_user/presentation/common/Update_profile/controller/Update_profile_controller.dart';

class SignUpFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpForm_editProfileController());
  }
}
