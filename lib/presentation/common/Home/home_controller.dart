import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Grocery/Grocery_navbar/view/grocery_navbar.dart';
import 'package:woye_user/presentation/Pharmacy/Pharmacy_navbar/view/pharmacy_navbar.dart';

class HomeController extends GetxController {
  RxInt mainButtonIndex = 0.obs;

  @override
  void onInit() {
    loadLocationData();
    // TODO: implement onInit
    super.onInit();
  }

  List<Widget> homeWidgets = [
    RestaurantNavbar(),
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
        update();
    }
    update();
  }

  void getIndex(index) {
    mainButtonIndex.value = index;
    update();
  }

  var location = ''.obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;

  void loadLocationData() async {
    var storage = GetStorage();
    location.value = storage.read('location') ?? '';
    latitude.value = storage.read('latitude') ?? 0.0;
    longitude.value = storage.read('longitude') ?? 0.0;
    print('Stored Location: ${location.value}');
    print('Stored Latitude: ${latitude.value}');
    print('Stored Longitude: ${longitude.value}');
  }
}
