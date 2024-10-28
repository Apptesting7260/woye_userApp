import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Presentation/Grocery/Grocery_navbar/grocery_navbar.dart';
import 'package:woye_user/Presentation/Pharmacy/Pharmacy_navbar/pharmacy_navbar.dart';
import 'package:woye_user/Presentation/Restaurants/Restaurants_navbar/Restaurant_navbar_screen/restaurant_navbar.dart';
import 'package:woye_user/Routes/app_routes.dart';

class HomeController extends GetxController {
  RxInt mainButtonIndex = 0.obs;

  List<Widget> homeWidgets = [
    const RestaurantNavbar(),
    const PharmacyNavbar(),
    const GroceryNavbar()
  ];

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

  void navigate(index) {
    switch (index) {
      case 0:
        Get.toNamed(AppRoutes.restaurantNavbar);
      case 1:
        Get.toNamed(AppRoutes.pharmacyNavbar);
      case 2:
        Get.toNamed(AppRoutes.groceryNavbar);
    }
    update();
  }

  void getIndex(index) {
    mainButtonIndex.value = index;
    update();
  }
}
