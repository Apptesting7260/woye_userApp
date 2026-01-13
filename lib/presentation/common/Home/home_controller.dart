import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Grocery/Grocery_navbar/view/grocery_navbar.dart';
import 'package:woye_user/presentation/Pharmacy/Pharmacy_navbar/view/pharmacy_navbar.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/View/model/maintenance_mode_model.dart';
import 'package:woye_user/presentation/common/get_user_data/get_user_data.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';

class HomeController extends GetxController {


  final GetUserDataController getUserDataController =
      Get.put(GetUserDataController());

  @override
  void onInit() {
    loadLocationData();
    getUserDataController.getUserDataApi();
    // TODO: implement onInit
    super.onInit();
  }

  List<Widget> homeWidgets = [
    RestaurantNavbar(),
     PharmacyNavbar(),
     GroceryNavbar()
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

  // void navigate(index) {
  //   switch (index) {
  //     case 0:
  //       Get.toNamed(AppRoutes.restaurantNavbar);
  //       break;
  //     case 1:
  //       Get.toNamed(AppRoutes.pharmacyNavbar);
  //       break;
  //     case 2:
  //       Get.toNamed(AppRoutes.groceryNavbar);
  //       break;
  //   }
  //   update();
  // }

  //void getIndex(index) {
    // mainButtonIndex.value = index;
    // update();
 // }

  var location = ''.obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;

  void loadLocationData() async {
    var storage = GetStorage();
    location.value = storage.read('location') ?? '';
    latitude.value = storage.read('latitude') ?? 0.0;
    longitude.value = storage.read('longitude') ?? 0.0;
    print('Stored Location home controller: ${location.value}');
    print('Stored Latitude home controller: ${latitude.value}');
    print('Stored Longitude home controller: ${longitude.value}');
  }


  final api = Repository();


  final  apiData = MaintenanceModel().obs;

  void setApiData(MaintenanceModel value) => apiData.value = value;


  Future<void> appvesionCheckApi()async{
    api.maintenanceApi().then((value) {
      setApiData(value);
      if(apiData.value.status == true){
        // Utils.showToast(apiData.value.message ?? "");
        pt("maintenance data>>>>>>>>  ${apiData.value.message ?? ""}");
        if(apiData.value.maintenance.toString() == "1"){
          Get.offAllNamed(AppRoutes.maintenance);
        }
      }else{
        pt("maintenance data else >>>>>>>>  ${apiData.value.message ?? ""}");
      }
    },).onError((error, stackTrace) {
      pt('>>>>>>>>>>>>maintenance $error');
      pt('>>>>>>>>>>>>maintenance $stackTrace');
    },);
  }
}
