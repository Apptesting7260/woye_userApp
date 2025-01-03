
import 'dart:io';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:woye_user/core/utils/app_export.dart';

class SignUpController extends GetxController {
  final Rx<TextEditingController> mobNoCon = TextEditingController().obs;
  final Rx<TextEditingController> passController = TextEditingController().obs;
  final rxRequestStatus = Status.COMPLETED.obs;
  final signUpFormKey = GlobalKey<FormState>();

  var isLoding = false.obs;

  var resendToken = 0.obs;
  RxBool showError = true.obs;

  Rx<CountryCode> selectedCountryCode =
      CountryCode(dialCode: '+91', code: 'IN').obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  RxString verificationID = ''.obs;

  @override
  void onClose() {
    mobNoCon.value.dispose();
    passController.value.dispose();
    super.onClose();
  }

  void updateCountryCode(CountryCode countryCode) {
    selectedCountryCode.value = countryCode;
  }

  Future<bool> sendOtp() async {
    isLoding.value = true;
    Completer<bool> completer = Completer<bool>();
    print('re == ${resendToken.value}');
    print(
        'no == ${selectedCountryCode.value.toString()}${mobNoCon.value.text.trim().toString()}');
    try {
      update();
      await auth.verifyPhoneNumber(
        timeout: const Duration(seconds: 59),
        phoneNumber:
            '${selectedCountryCode.value.toString()}${mobNoCon.value.text.trim().toString()}',
        forceResendingToken: !Platform.isIOS
            ? (resendToken.value != 0 ? resendToken.value : null)
            : null,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print(e.code);
            Utils.showToast(
                'The provided phone number is not valid.');
            isLoding.value = false;
          } else {
            Utils.showToast('Something went wrong');
            isLoding.value = false;
          }
          print(e.toString());
          completer.complete(false);
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          print('codesent');
          if (!Platform.isIOS) {
            print(forceResendingToken);
            resendToken.value = forceResendingToken!;
            Timer(
              const Duration(seconds: 59),
              () {
                resendToken.value = 0;
                print('token == ${resendToken.value}');
              },
            );
          }
          verificationID.value = verificationId;
          completer.complete(true);
          Get.toNamed(
            AppRoutes.otp,
            arguments: {
              'type': 'signup',
              'countryCode': selectedCountryCode.value.toString(),
              'mob':
                  mobNoCon.value.text.trim().toString(),
            },
          );
          isLoding.value = false;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      completer.complete(false);
      print('error == ${e.toString()}');
      isLoding.value = false;
    }
    return completer.future;
  }

  OtpTimerButtonController otpTimerButtonController =
      OtpTimerButtonController();

  Future<bool> resendOtp() async {
    Completer<bool> completer = Completer<bool>();
    otpTimerButtonController.loading();
    try {
      await auth.verifyPhoneNumber(
        timeout: const Duration(seconds: 59),
        phoneNumber:
            '${selectedCountryCode.value.toString()}${mobNoCon.value.text.trim().toString()}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print(e.code);
            Utils.showToast(
                'The provided phone number is not valid.');
          } else {
            Utils.showToast('Something went wrong');
          }
          otpTimerButtonController.enableButton();
          completer.complete(false);
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          print('codesent');
          Utils.showToast('otp has been send successfully.');
          verificationID.value = verificationId;
          otpTimerButtonController.startTimer();
          completer.complete(true);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      otpTimerButtonController.enableButton();
      completer.complete(false);
      print('error == ${e.toString()}');
    }
    return completer.future;
  }

  int checkCountryLength = 10;
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


  // final api = Repository();
  //
  // final guestData = RegisterModel().obs;
  // RxString error = ''.obs;
  // UserModel userModel = UserModel();
  //
  // var pref = UserPreference();
  //
  // void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  // void guestSet(RegisterModel _value) => guestData.value = _value;
  // void setError(String _value) => error.value = _value;
  //
  //  guestUserApi() async {
  //
  //   // String? tokenFCM = await FirebaseMessaging.instance.getToken();
  //
  //   final data = {
  //     "fcm_token": "tokenFCM.toString()",
  //   };
  //
  //   log(data.toString());
  //
  //   setRxRequestStatus(Status.LOADING);
  //
  //   api.guestUserApi(data, "").then((value) {
  //
  //     setRxRequestStatus(Status.COMPLETED);
  //     guestSet(value);
  //
  //     if (guestData.value.status == true) {
  //       userModel.step = guestData.value.step;
  //       log("Response Step: ${userModel.step}");
  //       userModel.token = guestData.value.token;
  //       log("Response token: ${userModel.token}");
  //       userModel.islogin = true;
  //       log("Response islogin: ${userModel.islogin}");
  //       userModel.loginType = guestData.value.loginType;
  //       log("Response loginType: ${userModel.loginType}");
  //       pref.saveUser(userModel);
  //       Get.offAllNamed(AppRoutes.restaurantNavbar);
  //     }
  //
  //   }).onError((error, stackError) {
  //     setError(error.toString());
  //     print('errrrrrrrrrrrr');
  //     // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
  //     print(error);
  //     setRxRequestStatus(Status.ERROR);
  //   });
  //
  // }

}
