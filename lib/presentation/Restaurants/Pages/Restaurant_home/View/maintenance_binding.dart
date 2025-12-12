import 'package:get/get.dart';

import 'maintenance_mode_controller.dart';


class MaintenanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MaintenanceModeController>(() => MaintenanceModeController());
  }
}
