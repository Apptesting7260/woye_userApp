import 'package:woye_user/Core/Utils/app_export.dart';

class OrderScreenController extends GetxController {
  int pageIndex = 0;

  void getIndex(index) {
    pageIndex = index;
    update();
  }
}
