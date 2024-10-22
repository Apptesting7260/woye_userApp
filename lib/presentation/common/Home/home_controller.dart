import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Presentation/Grocery/Grocery_navbar/grocery_navbar.dart';
import 'package:woye_user/Presentation/Pharmacy/Pharmacy_navbar/pharmacy_navbar.dart';
import 'package:woye_user/Presentation/Restaurants/Restaurants_navbar/restaurant_navbar.dart';

class HomeController extends GetxController {
  int mainButtonIndex = 0;

  List<Widget> homeWidgets = [
    const RestaurantNavbar(),
    const PharmacyNavbar(),
    const GroceryNavbar()
  ];

  void navigate(index) {
    switch (index) {
      case 0:
        Get.to(
          const RestaurantNavbar(),
        );
      case 1:
        Get.to(const PharmacyNavbar());
      case 2:
        Get.to(const GroceryNavbar());
    }
  }

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
