import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:woye_user/Core/Constant/app_urls.dart';
import 'package:woye_user/Data/Model/usermodel.dart';
import 'package:http/http.dart' as http;
import 'package:woye_user/Data/userPrefrenceController.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_home/controller/restaurant_home_controller.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/common/Update_profile/Model/getprofile_model.dart';
import 'package:woye_user/presentation/common/Update_profile/Model/updateprofile_model.dart';

class SignUpForm_editProfileController extends GetxController {
  String typeFrom = "";

  @override
  void onInit() async {
    getprofileApi();
    fisrtNameController = TextEditingController();
    mobileController = TextEditingController();
    emailController = TextEditingController();
    genderController = TextEditingController();
    var arguments = Get.arguments;
    typeFrom = arguments?['typefrom'];
    print("objectyyyyyyyyyyyyyyyy$typeFrom");
    super.onInit();
  }

  final api = Repository();

  final rxRequestStatus = Status.LOADING.obs;
  final profileData = ProfileModel().obs;
  final updateprofileData = UpdateprofileModel().obs;
  RxString error = ''.obs;
  UserModel userModel = UserModel();
  Location location = Location();
  var pref = UserPreference();

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void profileSet(ProfileModel value) => profileData.value = value;

  void upprofileSet(UpdateprofileModel value) =>
      updateprofileData.value = value;

  void setError(String value) => error.value = value;

  var profileImageFromAPI = "".obs;

  getprofileApi() async {
    userModel = await pref.getUser();
    log("get header : ${userModel.token.toString()}");
    profileImageGetUrl.value = "";
    // setRxRequestStatus(Status.LOADING);
    api.getprofileApi().then((value) {
      profileSet(value);
      if (profileData.value.status == true) {
        userModel.step = profileData.value.step;
        String countryCodeFromAPI = profileData.value.data?.countryCode ?? "";
        if (countryCodeFromAPI.isNotEmpty) {
          String dialCode = countryCodeFromAPI;
          String countryCode = countryCodeFromAPI.substring(1);
          selectedCountryCode.value =
              CountryCode(dialCode: dialCode, code: countryCode);

          CountryCode country = CountryCode.fromDialCode(dialCode);
          String? countryCodename = country.code;
          chackCountryLength = countryPhoneDigits[countryCodename]!;
          print("chackCountryLength: ${chackCountryLength}");
        }
        mobileController.text = profileData.value.data?.phone ?? "";
        emailController.text = profileData.value.data?.email ?? "";
        fisrtNameController.text = profileData.value.data?.firstName ?? "";
        formattedCurrentDate.value = profileData.value.data?.dob ?? "";
        genderController.text = profileData.value.data?.gender ?? "";
        profileImageFromAPI.value = profileData.value.data?.imageUrl ?? "";
        update();

        setRxRequestStatus(Status.COMPLETED);
      }
    }).onError((error, stackError) {
      setError(error.toString());
      print('errrrrrrrrrrrr');
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }

  late DateTime selectedDate = DateTime.now();
  RxString formattedCurrentDate = "".obs;

  Future<void> selectDate(BuildContext context) async {
    final DateTime initialDate =
        (selectedDate != null && selectedDate!.isBefore(DateTime(2015, 12, 31)))
            ? selectedDate
            : DateTime(2015, 12, 31);

    final DateTime? picked = await showDatePicker(
      context: context,
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        child: child!,
      ),
      initialDate: initialDate,
      firstDate: DateTime(1990, 1, 1),
      lastDate: DateTime(2015, 12, 31),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      formattedCurrentDate.value =
          DateFormat('dd-MM-yyyy').format(selectedDate!);

      print("Formatted Selected Date: ${formattedCurrentDate.value}");
    }
  }

  late TextEditingController fisrtNameController,
      mobileController,
      emailController,
      genderController;

  RxBool showError = true.obs;

  void updateCountryCode(CountryCode countryCode) {
    selectedCountryCode.value = countryCode;
  }

  Rx<CountryCode> selectedCountryCode =
      CountryCode(dialCode: '+91', code: 'IN').obs;
  GlobalKey<FormState> formSignUpKey = GlobalKey<FormState>();
  bool isValid = false;

  String? validateFirstName(String? value) {
    if (value!.isEmpty) {
      return "Please enter a valid Name";
    }
    return null;
  }

  String? validateMobile(String? value) {
    if (value!.isEmpty) {
      return "Please enter your mobile number";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty ||
        !isValidEmail(value, isRequired: true) ||
        value == "") {
      return "Please enter a valid Email";
    }

    return null;
  }

  String? validateGender(String? value) {
    if (value!.isEmpty) {
      return "Please Select Gender";
    }
    return null;
  }

  final rxRequestStatus2 = Status.COMPLETED.obs;

  var profileImageGetUrl = "".obs;

  Rx<File> image = File("assets/appLogo.png").obs;

  Future<void> pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      File originalImage = File(pickedImage.path);
      int originalSize = await originalImage.length();
      print('Original image size: $originalSize bytes');

      image.value = originalImage;

      profileImageGetUrl.value = image.value.path;
      print("Path ---> ${image.value.path}");
      print("Path ---> ${profileImageGetUrl.value}");
      imageUploadApi();
    }
  }

  final RestaurantHomeController restaurantHomeController =
      Get.put(RestaurantHomeController());

  imageUploadApi() async {
    var uri = Uri.parse(AppUrls.updateProfile);
    print("URL: $uri");

    var request = http.MultipartRequest('POST', uri);

    request.headers['Authorization'] = 'Bearer ${userModel.token.toString()}';
    print("Authorization Header: Bearer ${userModel.token.toString()}");

    if (profileImageGetUrl.value != "") {
      var pic = await http.MultipartFile.fromPath("image", image.value.path);
      print("Adding image with path: ${image.value.path}");
      request.files.add(pic);
    }

    try {
      var response = await request.send();
      print("Response status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var responseData = json.decode(responseBody);
        UpdateprofileModel profileData =
            UpdateprofileModel.fromJson(responseData);
        upprofileSet(profileData);
        if (updateprofileData.value.status == true) {
          if (typeFrom == "back") {
            restaurantHomeController.homeApi(1);
          }
          Utils.showToast("Your profile image has been updated.");
        }
      } else {
        Utils.showToast("Failed to update profile image");
        log('Failed to update profile. Status code: ${response.statusCode}');
      }
    } catch (error) {
      log('Error occurred: $error');
      setError(error.toString());
    }
  }

  // profileupdateApi(String type) async {
  //   print("Path ---> ${"0"}");
  //   print("Path ---> ${profileImageGetUrl.value}");
  //   rxRequestStatus2(Status.LOADING);
  //
  //   // Create data map
  //   final data = {
  //     "first_name": fisrtNameController.text.toString(),
  //     "country_code": selectedCountryCode.value.toString(),
  //     "phone": mobileController.text.trim().toString(),
  //     "dob": formattedCurrentDate.value,
  //     "email": emailController.text.trim().toString(),
  //     "gender": genderController.text.toString(),
  //   };
  //
  //   // Print the data being sent
  //   print("Sending data: $data");
  //
  //   // Print the URL
  //   var uri = Uri.parse(AppUrls.updateProfile);
  //   print("URL: $uri");
  //
  //   var request = http.MultipartRequest('POST', uri);
  //
  //   // Add fields to the request
  //   data.forEach((key, value) {
  //     print("Adding field: $key = $value"); // Print each field being added
  //     request.fields[key] = value;
  //   });
  //
  //   // Set headers
  //   request.headers['Authorization'] = 'Bearer ${userModel.token.toString()}';
  //   print("Authorization Header: Bearer ${userModel.token.toString()}");
  //
  //   // If there's a profile image, add it to the request
  //   if (profileImageGetUrl.value != "") {
  //     var pic = await http.MultipartFile.fromPath("image", image.value.path);
  //     print("Adding image with path: ${image.value.path}");
  //     request.files.add(pic);
  //   }
  //
  //   try {
  //     var response = await request.send();
  //     print("Response status code: ${response.statusCode}");
  //     if (response.statusCode == 200) {
  //       var responseBody = await response.stream.bytesToString();
  //       var responseData = json.decode(responseBody);
  //       UpdateprofileModel profileData =
  //           UpdateprofileModel.fromJson(responseData);
  //       log('Profile update success: $profileData');
  //       upprofileSet(profileData);
  //       if (updateprofileData.value.status == true) {
  //         if (type == "back") {
  //           restaurantHomeController.homeApi(1);
  //           Utils.showToast("Your profile has been updated.");
  //           Get.back();
  //           getprofileApi();
  //           rxRequestStatus2(Status.COMPLETED);
  //         } else {
  //           userModel.step = updateprofileData.value.step;
  //           log("get Response Step: ${userModel.step}");
  //           pref.saveStep(userModel.step!);
  //           Get.offAllNamed(AppRoutes.restaurantNavbar);
  //           rxRequestStatus2(Status.COMPLETED);
  //           getprofileApi();
  //         }
  //       }
  //     } else {
  //       Utils.showToast("Failed to update profile");
  //       log('Failed to update profile. Status code: ${response.statusCode}');
  //       rxRequestStatus2(Status.ERROR);
  //     }
  //   } catch (error) {
  //     log('Error occurred: $error');
  //     setError(error.toString());
  //     rxRequestStatus2(Status.ERROR);
  //   }
  // }

  // profileupdateApi(String type) async {
  //   rxRequestStatus2(Status.LOADING);
  //   final data = {
  //     "first_name": fisrtNameController.text.toString(),
  //     "country_code": selectedCountryCode.value.toString(),
  //     "phone": mobileController.text.trim().toString(),
  //     "dob": formattedCurrentDate.value,
  //     "email": emailController.text.trim().toString(),
  //     "gender": genderController.text.toString(),
  //   };
  //
  //   print("Sending data: $data");
  //
  //   var uri = Uri.parse(AppUrls.updateProfile);
  //   print("URL: $uri");
  //
  //   var request = http.MultipartRequest('POST', uri);
  //
  //   data.forEach((key, value) {
  //     request.fields[key] = value;
  //   });
  //
  //   request.headers['Authorization'] = 'Bearer ${userModel.token.toString()}';
  //   try {
  //     var response = await request.send();
  //     print("Response status code: ${response.statusCode}");
  //     if (response.statusCode == 200) {
  //       var responseBody = await response.stream.bytesToString();
  //       var responseData = json.decode(responseBody);
  //       UpdateprofileModel profileData =
  //           UpdateprofileModel.fromJson(responseData);
  //       upprofileSet(profileData);
  //       if (updateprofileData.value.status == true) {
  //         if (type == "back") {
  //           restaurantHomeController.homeApi(1);
  //           Utils.showToast("Your profile has been updated.");
  //           Get.back();
  //           getprofileApi();
  //           rxRequestStatus2(Status.COMPLETED);
  //         } else {
  //           userModel.step = updateprofileData.value.step;
  //           log("get Response Step: ${userModel.step}");
  //           pref.saveStep(userModel.step!);
  //           Get.offAllNamed(AppRoutes.restaurantNavbar);
  //           rxRequestStatus2(Status.COMPLETED);
  //           getprofileApi();
  //         }
  //       }
  //     } else {
  //       Utils.showToast("Failed to update profile");
  //       log('Failed to update profile. Status code: ${response.statusCode}');
  //       rxRequestStatus2(Status.ERROR);
  //     }
  //   } catch (error) {
  //     log('Error occurred: $error');
  //     setError(error.toString());
  //     rxRequestStatus2(Status.ERROR);
  //   }
  // }

  profileupdateApi(String type) async {
    final data = {
      "first_name": fisrtNameController.text.toString(),
      "country_code": selectedCountryCode.value.toString(),
      "phone": mobileController.text.trim().toString(),
      "dob": formattedCurrentDate.value,
      "email": emailController.text.trim().toString(),
      "gender": genderController.text.toString(),
    };

    log(data.toString());

    log("update profile");

    userModel = await pref.getUser();

    log("get header : ${userModel.token.toString()}");

    setRxRequestStatus(Status.LOADING);

    api.updateprofileApi(data).then((value) {
      upprofileSet(value);
      if (updateprofileData.value.status == true) {
        if (type == "back") {
          restaurantHomeController.homeApi(1);
          Utils.showToast("Your profile has been updated.");
          Get.back();
          setRxRequestStatus(Status.COMPLETED);
          getprofileApi();
          rxRequestStatus2(Status.COMPLETED);
        } else {
          userModel.step = updateprofileData.value.step;
          log("get Response Step: ${userModel.step}");
          pref.saveStep(userModel.step!);
          Get.offAllNamed(AppRoutes.restaurantNavbar);
          rxRequestStatus2(Status.COMPLETED);
          setRxRequestStatus(Status.COMPLETED);
          getprofileApi();
        }
      } else {
        Utils.showToast(updateprofileData.value.message.toString());
        log('Failed to update profile. Status code: ${updateprofileData.value.message}');
        rxRequestStatus2(Status.ERROR);
      }
    }).onError((error, stackError) {
      setError(error.toString());
      Utils.showToast(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

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
