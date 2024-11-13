import 'package:get/get.dart';
import 'package:woye_user/presentation/common/Sign_up_form/controller/sign_up_form_controller.dart';

class SignUpFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpFormController());
  }
}
