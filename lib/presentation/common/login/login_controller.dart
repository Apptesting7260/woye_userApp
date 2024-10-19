import 'package:woye_user/core/app_export.dart';

class LoginController extends GetxController {
  Country? selectedCountry;


  void onSelect(Country country) {
    selectedCountry = country;
    print("country==================>${selectedCountry}");
    update();
  }
}
