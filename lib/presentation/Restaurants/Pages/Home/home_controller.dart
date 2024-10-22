import 'package:woye_user/Core/Utils/app_export.dart';

class HomeController extends GetxController {
  Map mainButtonbar = {
    "restaurantButton": {
      "title": "Restaurants",
      "imageEnabled": ImageConstants.restaurantEnable,
      "imageDisabled": ImageConstants.restaurantDisable
    },
    "pharmacyButton": {
      "title": "Pharmacy",
      "imageEnabled": ImageConstants.pharmacyDisable,
      "imageDisabled": ImageConstants.pharmacyDisable
    },
    "groceryButton": {
      "title": "Grocery",
      "imageEnabled": ImageConstants.groceryEnable,
      "imageDisabled": ImageConstants.groceryDisable
    }
  };
}
