import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/Controller/restaurant_cart_controller.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Delivery_address/Sub_screens/Edit_address/edit_address_modal.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Delivery_address/controller/delivery_address_controller.dart';
import 'package:woye_user/shared/widgets/address_fromgoogle/modal/GoogleLocationModel.dart';
export 'package:country_code_picker/country_code_picker.dart';

class EditAdressController extends GetxController {
  final Rx<TextEditingController> nameController = TextEditingController().obs;
  final Rx<TextEditingController> mobNoController = TextEditingController().obs;
  final Rx<TextEditingController> houseNoController = TextEditingController().obs;
  final Rx<TextEditingController> deliveryInstructionController = TextEditingController().obs;
  var location = ''.obs;
  var addressType = "".obs;
  // var addressType = "Home".obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  final locationController = TextEditingController();
  RxBool defaultSet = true.obs;
  RxInt radioValue = 0.obs;
  String addressId = "";

  Rx<CountryCode> selectedCountryCode =
      CountryCode(dialCode: '+91', code: 'IN').obs;

  // ---------------------------------------- Place API ---------------------------------------------
  RxBool isValidAddress = true.obs;
  final List<Predictions> searchPlace = [];
  String? selectedLocation;
  String googleAPIKey = "${dotenv.env['googleAPIKey']}";

  Future<List<Predictions>> searchAutocomplete(String query) async {
    Uri uri =
        Uri.https("maps.googleapis.com", "maps/api/place/autocomplete/json", {
      "input": query,
      "key": googleAPIKey,
    });

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final parse = jsonDecode(response.body);
        if (parse['status'] == "OK") {
          SearchPlaceModel searchPlaceModel = SearchPlaceModel.fromJson(parse);
          return searchPlaceModel.predictions ?? [];
        }
      }
    } catch (err) {
      print("Error: $err");
    }
    return [];
  }

  Future<void> getLatLang(String address) async {
    List<Location> locations = await locationFromAddress(address);
    if (locations.isNotEmpty) {
      var first = locations.first;
      latitude.value = first.latitude;
      longitude.value = first.longitude;
      print("Latitude: ${latitude.value}, Longitude: ${longitude.value}");
    }
  }

  // ------------------------------------------- Add address API ------------------------------
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final editAddress = EditAddressModal().obs;
  RxString error = ''.obs;
  String token = "";

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setData(EditAddressModal value) => editAddress.value = value;

  final DeliveryAddressController deliveryAddressController =
      Get.put(DeliveryAddressController());

  setAddressData(int index,) async {
    addressType.value = deliveryAddressController.deliveryAddressData.value.data![index].addressType ?? "Home";
    print("Address Type value: ${addressType.value}");
    addressId = deliveryAddressController.deliveryAddressData.value.data![index].id.toString();
    print("Address ID: $addressId");

    nameController.value.text = deliveryAddressController.deliveryAddressData.value.data![index].fullName.toString().trim();
    print("Full Name: ${nameController.value.text}");

    String countryCodeFromAPI = deliveryAddressController.deliveryAddressData.value.data?[index].countryCode ??"";
    print("countryCodeFrom API: $countryCodeFromAPI");
    if (countryCodeFromAPI.isNotEmpty) {
      String dialCode = countryCodeFromAPI;
      String countryCode = countryCodeFromAPI;
      selectedCountryCode.value =
          CountryCode(dialCode: dialCode, code: countryCode);
      CountryCode country = CountryCode.fromDialCode(dialCode);
      String? countryCodename = country.code;
      chackCountryLength = countryPhoneDigits[countryCodename]!;
      print("chackCountryLength: ${chackCountryLength}");
    }

    mobNoController.value.text = deliveryAddressController
        .deliveryAddressData.value.data![index].phoneNumber
        .toString()
        .trim();
    print("Phone Number: ${mobNoController.value.text}");

    houseNoController.value.text = deliveryAddressController
        .deliveryAddressData.value.data![index].houseDetails
        .toString()
        .trim();
    print("House Details: ${houseNoController.value.text}");

    locationController.text = deliveryAddressController
        .deliveryAddressData.value.data![index].address
        .toString()
        .trim();
    print("Address: ${locationController.text}");

    latitude.value = double.parse(deliveryAddressController
        .deliveryAddressData.value.data![index].latitude);
    print("Latitude: ${latitude.value}");

    longitude.value = double.parse(deliveryAddressController
        .deliveryAddressData.value.data![index].longitude);
    print("Longitude: ${longitude.value}");

    deliveryInstructionController.value.text = deliveryAddressController
        .deliveryAddressData.value.data![index].deliveryInstruction ?? "";
    print("Delivery Instruction: ${deliveryInstructionController.value.text}");

    int isDefaultValue = deliveryAddressController
            .deliveryAddressData.value.data![index].isDefault ??
        0;
    defaultSet.value = isDefaultValue == 1;
    print("Is Default: $defaultSet");

    String addressTypeApi = deliveryAddressController
            .deliveryAddressData.value.data![index].addressType ??
        "";
    print("Address Type From API: $addressTypeApi");

    if (addressTypeApi == "Home" || addressTypeApi == "home") {
      radioValue.value = 0;
      print("Address Type: Home");
    } else if (addressTypeApi == "Office" ||addressTypeApi == "office") {
      radioValue.value = 1;
      print("Address Type: Office");
    } else if (addressTypeApi == "Other" || addressTypeApi == "other") {
      radioValue.value = 2;
      print("Address Type: Other");
    }
  }

  editAddressApi() async {
    setRxRequestStatus(Status.LOADING);
    var body = {
      'address_id': addressId,
      'full_name': nameController.value.text,
      'country_code': selectedCountryCode.value.toString(),
      'phone_number': mobNoController.value.text,
      'house_details': houseNoController.value.text,
      'address': locationController.text,
      'address_type': addressType.value,
      'latitude': latitude.value.toString(),
      'longitude': longitude.value.toString(),
      'delivery_instruction': deliveryInstructionController.value.text,
      'is_default': defaultSet.value == true ? "1" : "0",
    };
    print("default Set value ${defaultSet.value}");
    api.editAddressApi(body).then((value) {
      setData(value);
      deliveryAddressController.getDeliveryAddressApi();
      if (editAddress.value.status == true) {
        deliveryAddressController.getDeliveryAddressApi().then((value) {
          Utils.showToast(editAddress.value.message.toString());
          setRxRequestStatus(Status.COMPLETED);
          Get.back();
          nameController.value.clear();
          mobNoController.value.clear();
          houseNoController.value.clear();
          deliveryInstructionController.value.clear();
          locationController.clear();
          return;
        });
      } else {
        Utils.showToast(editAddress.value.message.toString());
      }
    }).onError((error, stackError) {
      print("Error: $error");
      setError(error.toString());
      print(stackError);
      setRxRequestStatus(Status.ERROR);
    });
  }


  final RestaurantCartController restaurantCartController =
  Get.put(RestaurantCartController());

  changeAddressApi({
    required String addressId,
    required String name,
    required String selectedCountryCode,
    required String mobNo,
    required String houseNo,
    required String location,
    required String addressTypeName,
    required String latitude,
    required String longitude,
    required String deliveryInstruction,
}) async {
    setRxRequestStatus(Status.LOADING);
    var body = {
      'address_id': addressId,
      'full_name': name,
      'country_code': selectedCountryCode,
      'phone_number': mobNo,
      'house_details': houseNo,
      'address': location,
      'address_type': addressTypeName,
      'latitude': latitude,
      'longitude': longitude,
      'delivery_instruction': deliveryInstruction,
      'is_default': "1",
    };
    api.editAddressApi(body).then((value) {
      setData(value);
      deliveryAddressController.getDeliveryAddressApi();
      if (editAddress.value.status == true) {
        restaurantCartController.getRestaurantCartApi().then((value) {
          Utils.showToast(editAddress.value.message.toString());
          setRxRequestStatus(Status.COMPLETED);
          Get.back();
          nameController.value.clear();
          mobNoController.value.clear();
          houseNoController.value.clear();
          deliveryInstructionController.value.clear();
          locationController.clear();
          return;
        });
      } else {
        Utils.showToast(editAddress.value.message.toString());
      }
    }).onError((error, stackError) {
      print("Error: $error");
      setError(error.toString());
      print(stackError);
      setRxRequestStatus(Status.ERROR);
    });
  }


  void setError(String value) => error.value = value;

// ------------------------------------------------------------- ------------------------------

  void updateCountryCode(CountryCode countryCode) {
    selectedCountryCode.value = countryCode;
  }

  RxBool showError = true.obs;

  int chackCountryLength = 10;
  final Map<String, int> countryPhoneDigits = {
    'AF': 9, // Afghanistan
    'AL': 9, // Albania
    'DZ': 9, // Algeria
    'AD': 6, // Andorra
    'AO': 9, // Angola
    'AG': 10, // Antigua and Barbuda
    'AR': 10, // Argentina
    'AM': 8, // Armenia
    'AU': 9, // Australia
    'AT': 10, // Austria
    'AZ': 9, // Azerbaijan
    'BS': 10, // Bahamas
    'BH': 8, // Bahrain
    'BD': 10, // Bangladesh
    'BB': 10, // Barbados
    'BY': 9, // Belarus
    'BE': 9, // Belgium
    'BZ': 7, // Belize
    'BJ': 8, // Benin
    'BT': 8, // Bhutan
    'BO': 8, // Bolivia
    'BA': 8, // Bosnia and Herzegovina
    'BW': 7, // Botswana
    'BR': 11, // Brazil
    'BN': 7, // Brunei
    'BG': 9, // Bulgaria
    'BF': 8, // Burkina Faso
    'BI': 8, // Burundi
    'CV': 7, // Cape Verde
    'KH': 9, // Cambodia
    'CM': 9, // Cameroon
    'CA': 10, // Canada
    'CF': 8, // Central African Republic
    'TD': 8, // Chad
    'CL': 9, // Chile
    'CN': 11, // China
    'CO': 10, // Colombia
    'KM': 7, // Comoros
    'CG': 9, // Congo
    'CR': 8, // Costa Rica
    'HR': 9, // Croatia
    'CU': 8, // Cuba
    'CY': 8, // Cyprus
    'CZ': 9, // Czech Republic
    'DK': 8, // Denmark
    'DJ': 8, // Djibouti
    'DM': 10, // Dominica
    'DO': 10, // Dominican Republic
    'EC': 9, // Ecuador
    'EG': 10, // Egypt
    'SV': 8, // El Salvador
    'GQ': 9, // Equatorial Guinea
    'ER': 7, // Eritrea
    'EE': 7, // Estonia
    'ET': 9, // Ethiopia
    'FJ': 7, // Fiji
    'FI': 10, // Finland
    'FR': 9, // France
    'GA': 7, // Gabon
    'GM': 7, // Gambia
    'GE': 9, // Georgia
    'DE': 10, // Germany
    'GH': 9, // Ghana
    'GR': 10, // Greece
    'GD': 10, // Grenada
    'GT': 8, // Guatemala
    'GN': 9, // Guinea
    'GW': 7, // Guinea-Bissau
    'GY': 7, // Guyana
    'HT': 8, // Haiti
    'HN': 8, // Honduras
    'HU': 9, // Hungary
    'IS': 7, // Iceland
    'IN': 10, // India
    'ID': 10, // Indonesia
    'IR': 10, // Iran
    'IQ': 10, // Iraq
    'IE': 9, // Ireland
    'IL': 9, // Israel
    'IT': 10, // Italy
    'JM': 10, // Jamaica
    'JP': 10, // Japan
    'JO': 9, // Jordan
    'KZ': 10, // Kazakhstan
    'KE': 10, // Kenya
    'KI': 8, // Kiribati
    'KP': 10, // North Korea
    'KR': 10, // South Korea
    'KW': 8, // Kuwait
    'KG': 9, // Kyrgyzstan
    'LA': 9, // Laos
    'LV': 8, // Latvia
    'LB': 8, // Lebanon
    'LS': 8, // Lesotho
    'LR': 7, // Liberia
    'LY': 10, // Libya
    'LI': 7, // Liechtenstein
    'LT': 8, // Lithuania
    'LU': 9, // Luxembourg
    'MG': 9, // Madagascar
    'MW': 9, // Malawi
    'MY': 10, // Malaysia
    'MV': 7, // Maldives
    'ML': 8, // Mali
    'MT': 8, // Malta
    'MH': 7, // Marshall Islands
    'MR': 8, // Mauritania
    'MU': 8, // Mauritius
    'MX': 10, // Mexico
    'FM': 7, // Micronesia
    'MD': 8, // Moldova
    'MC': 8, // Monaco
    'MN': 8, // Mongolia
    'ME': 8, // Montenegro
    'MA': 9, // Morocco
    'MZ': 9, // Mozambique
    'MM': 9, // Myanmar
    'NA': 9, // Namibia
    'NR': 7, // Nauru
    'NP': 10, // Nepal
    'NL': 9, // Netherlands
    'NZ': 9, // New Zealand
    'NI': 8, // Nicaragua
    'NE': 8, // Niger
    'NG': 10, // Nigeria
    'MK': 8, // North Macedonia
    'NO': 8, // Norway
    'OM': 8, // Oman
    'PK': 10, // Pakistan
    'PW': 7, // Palau
    'PA': 8, // Panama
    'PG': 8, // Papua New Guinea
    'PY': 9, // Paraguay
    'PE': 9, // Peru
    'PH': 10, // Philippines
    'PL': 9, // Poland
    'PT': 9, // Portugal
    'QA': 8, // Qatar
    'RO': 10, // Romania
    'RU': 10, // Russia
    'RW': 9, // Rwanda
    'KN': 10, // Saint Kitts and Nevis
    'LC': 10, // Saint Lucia
    'VC': 10, // Saint Vincent and the Grenadines
    'WS': 7, // Samoa
    'SM': 8, // San Marino
    'ST': 7, // Sao Tome and Principe
    'SA': 9, // Saudi Arabia
    'SN': 9, // Senegal
    'RS': 9, // Serbia
    'SC': 7, // Seychelles
    'SL': 8, // Sierra Leone
    'SG': 8, // Singapore
    'SK': 9, // Slovakia
    'SI': 9, // Slovenia
    'SB': 7, // Solomon Islands
    'SO': 8, // Somalia
    'ZA': 9, // South Africa
    'ES': 9, // Spain
    'LK': 10, // Sri Lanka
    'SD': 9, // Sudan
    'SR': 7, // Suriname
    'SE': 9, // Sweden
    'CH': 9, // Switzerland
    'SY': 9, // Syria
    'TW': 9, // Taiwan
    'TJ': 9, // Tajikistan
    'TZ': 9, // Tanzania
    'TH': 9, // Thailand
    'TG': 8, // Togo
    'TO': 7, // Tonga
    'TT': 10, // Trinidad and Tobago
    'TN': 8, // Tunisia
    'TR': 10, // Turkey
    'TM': 8, // Turkmenistan
    'TV': 7, // Tuvalu
    'UG': 9, // Uganda
    'UA': 9, // Ukraine
    'AE': 9, // United Arab Emirates
    'GB': 10, // United Kingdom
    'US': 10, // United States
    'UY': 9, // Uruguay
    'UZ': 9, // Uzbekistan
    'VU': 7, // Vanuatu
    'VA': 8, // Vatican City
    'VE': 10, // Venezuela
    'VN': 10, // Vietnam
    'YE': 9, // Yemen
    'ZM': 9, // Zambia
    'ZW': 9,
  };
}
