import 'package:get/get.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Delivery_address/controller/delivery_address_controller.dart';

class DeliveryAddressBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => DeliveryAddressController());
  }

}