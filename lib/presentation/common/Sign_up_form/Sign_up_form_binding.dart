import 'package:get/get.dart';
import 'package:woye_user/Presentation/Common/Sign_up_form/sign_up_form_controller.dart';

class SignUpFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpFormController());
  }
}
