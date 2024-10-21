import 'package:get/get.dart';
import 'package:woye_user/presentation/Common/form_sign_up/form_sign_up_screen.dart';

class FormSignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => const FormSignUpScreen());
  }
}
