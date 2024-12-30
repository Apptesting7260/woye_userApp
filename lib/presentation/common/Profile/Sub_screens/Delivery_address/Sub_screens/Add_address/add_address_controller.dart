import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/Controller/restaurant_cart_controller.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Delivery_address/Sub_screens/Add_address/add_address_modal.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Delivery_address/controller/delivery_address_controller.dart';
import 'package:woye_user/shared/widgets/address_fromgoogle/modal/GoogleLocationModel.dart';

class AddAddressController extends GetxController {
  final Rx<TextEditingController> nameController = TextEditingController().obs;
  final Rx<TextEditingController> mobNoController = TextEditingController().obs;
  final Rx<TextEditingController> houseNoController =
      TextEditingController().obs;
  final Rx<TextEditingController> deliveryInstructionController =
      TextEditingController().obs;
  var storage = GetStorage();
  var location = ''.obs;
  var addressType = "Home".obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  final locationController = TextEditingController();
  RxBool defaultSet = true.obs;

  RxBool showError = true.obs;
  RxInt radioValue = 0.obs;
  String countryValue = " ";
  String stateValue = " ";
  String cityValue = " ";

  void loadLocationData() async {
    locationController.clear();
    var storage = GetStorage();
    location.value = storage.read('location') ?? '';
    latitude.value = storage.read('latitude') ?? 0.0;
    longitude.value = storage.read('longitude') ?? 0.0;
    print('Stored Location: ${location.value}');
    print('Stored Latitude: ${latitude.value}');
    print('Stored Longitude: ${longitude.value}');
    locationController.text = location.value;
  }

  Rx<CountryCode> selectedCountryCode =
      CountryCode(dialCode: '+91', code: 'IN').obs;

  @override
  void onInit() {
    loadLocationData();
    print("objectiiiii");
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    print("objectiiiii111115");
    loadLocationData();
  }

  @override
  void onClose() {
    mobNoController.value.dispose();
    locationController.clear();
    super.onClose();
  }

  void updateCountryCode(CountryCode countryCode) {
    selectedCountryCode.value = countryCode;
  }

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
  final addAddress = AddAddressModal().obs;
  RxString error = ''.obs;
  String token = "";

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setData(AddAddressModal value) => addAddress.value = value;

  final DeliveryAddressController deliveryAddressController =
      Get.put(DeliveryAddressController());

  final RestaurantCartController restaurantCartController =
      Get.put(RestaurantCartController());

  addAddressApi() async {
    var arguments = Get.arguments;
    String cart = arguments['cartKey'];
    print("cart--------------------------------$cart");
    setRxRequestStatus(Status.LOADING);
    var body = {
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
    api.addAddressApi(body).then((value) {
      setData(value);
      if (addAddress.value.status == true) {
        if (cart == "RestaurantCart") {
          restaurantCartController.getRestaurantCartApi().then((value) {
            Utils.showToast(addAddress.value.message.toString());
            setRxRequestStatus(Status.COMPLETED);
            Get.back();
            nameController.value.clear();
            mobNoController.value.clear();
            houseNoController.value.clear();
            deliveryInstructionController.value.clear();
            locationController.clear();
            radioValue.value = 0;
            return;
          });
        } else {
          deliveryAddressController.getDeliveryAddressApi().then((value) {
            Utils.showToast(addAddress.value.message.toString());
            setRxRequestStatus(Status.COMPLETED);
            Get.back();
            nameController.value.clear();
            mobNoController.value.clear();
            houseNoController.value.clear();
            deliveryInstructionController.value.clear();
            locationController.clear();
            radioValue.value = 0;
            return;
          });
        }
      } else {
        Utils.showToast(addAddress.value.message.toString());
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
    'AS': 10,
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

    'AI': 7, // Anguilla

    'AW': 7, // Aruba

    'BM': 7, // Bermuda

    'KY': 7, // Cayman Islands

    'CD': 9, // Democratic Republic of the Congo
    'CI': 9, // Ivory Coast (Côte d'Ivoire)
    'FK': 7, // Falkland Islands
    'FO': 7, // Faroe Islands
    'GF': 9, // French Guiana
    'PF': 9, // French Polynesia
    'GI': 7, // Gibraltar
    'GL': 7, // Greenland
    'GP': 9, // Guadeloupe
    'GU': 10, // Guam
    'HK': 8, // Hong Kong
    'MO': 8, // Macau
    'MQ': 9, // Martinique
    'YT': 9, // Mayotte
    'MS': 7, // Montserrat
    'NC': 7, // New Caledonia
    'NU': 7, // Niue
    'NF': 7, // Norfolk Island
    'PR': 10, // Puerto Rico
    'RE': 9, // Réunion
    'SZ': 9, // Eswatini (Swaziland)
    'TL': 9, // Timor-Leste
    'TK': 7, // Tokelau
    'TC': 7, // Turks and Caicos Islands
    'VG': 10, // British Virgin Islands
    'VI': 10, // United States Virgin Islands
    'WF': 7, // Wallis and Futuna
  };
}
