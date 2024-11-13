import 'package:get/get.dart';
import 'package:woye_user/presentation/common/guest%20login/guest_controller.dart';

class GuestBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => GuestController(),);
  }
}