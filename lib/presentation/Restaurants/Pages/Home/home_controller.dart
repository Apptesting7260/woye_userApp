import 'package:woye_user/Core/Utils/app_export.dart';

class HomeController extends GetxController {
  int mainButtonIndex = 0;
  List<Map<String, dynamic>> mainButtonbar = [
    {
      "title": "Restaurants",
      "imageEnabled": ImageConstants.restaurantEnable,
      "imageDisabled": ImageConstants.restaurantDisable
    },
    {
      "title": "Pharmacy",
      "imageEnabled": ImageConstants.pharmacyEnable,
      "imageDisabled": ImageConstants.pharmacyDisable
    },
    {
      "title": "Grocery",
      "imageEnabled": ImageConstants.groceryEnable,
      "imageDisabled": ImageConstants.groceryDisable
    }
  ];

  void getIndex(index) {
    mainButtonIndex = index;
    update();
  }
}
