import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:woye_user/Core/Constant/app_urls.dart';
import 'package:woye_user/Data/Model/usermodel.dart';
import 'package:woye_user/Data/network/base_api_services.dart';
import 'package:woye_user/Data/network/network_api_services.dart';
import 'package:woye_user/Data/userPrefrenceController.dart';
import 'package:woye_user/Presentation/Common/Otp/model/register_model.dart';
import 'package:woye_user/Presentation/Common/Otp/view/otp_screen.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/common/Otp/model/login_model.dart';

class OtpController extends GetxController {
  final Rx<TextEditingController> otpPin = TextEditingController().obs;
  var otpVerify = false.obs;
  var regVerify = false.obs;
  var logVerify = false.obs;
  // final OtpScreen _otpScreen = OtpScreen();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final api = Repository();
  final apiService = NetworkApiServices();

  final rxRequestStatus = Status.COMPLETED.obs;
  final registerData = RegisterModel().obs;
  // Parse the response into the RegisterModel
  final loginData = LoginModel().obs;
  RxString error = ''.obs;
  UserModel userModel = UserModel();

  var pref = UserPreference();

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void signUpSet(RegisterModel value) => registerData.value = value;
  void signInSet(LoginModel value) => loginData.value = value;
  void setError(String value) => error.value = value;

  @override
  void onInit() {
    // mobNumber = _otpScreen.mobileNumber ?? "";
    super.onInit();
  }

  @override
  void onClose() {
    otpPin.value.dispose();
  }

  PinTheme defaultPinTheme = PinTheme(
      width: 54.w,
      height: 56.h,
      textStyle: AppFontStyle.text_18_600(AppColors.darkText),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: AppColors.textFieldBorder,
        ),
      ));

  PinTheme focusedPinTheme = PinTheme(
      width: 54.w,
      height: 56.h,
      textStyle: AppFontStyle.text_18_600(AppColors.darkText),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: AppColors.darkText,
        ),
      ));

  PinTheme submittedPinTheme = PinTheme(
      width: 54.w,
      height: 56.h,
      textStyle: AppFontStyle.text_18_600(AppColors.darkText),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: AppColors.darkText,
        ),
      ));

  Future<bool> verifyOtp({
    required String verificationId,
    required String smsCode,
    required String countryCode,
    required String mob,
  }) async {
    try {
      otpVerify.value = true;
      var credential = await auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode));
      Utils.showToast('Otp Verify Successfully');
      return credential.user == null ? false : true;
    } on FirebaseAuthException catch (e) {
      print('otp error == ${e.code}');
      otpVerify.value = false;
      if (e.code == 'invalid-verification-code') {
        Utils.showToast('Invalid otp.');
      } else {
        Utils.showToast('Please check your otp and try again.');
      }
      return false;
    }
  }

  registerApi({
    required String countryCode,
    required String mob,
   }) async {
    String? tokenFcm = await FirebaseMessaging.instance.getToken();

    final data = {
      "mob_no": mob,
      "fcm_token": tokenFcm,
      "country_code": countryCode,
    };
    setRxRequestStatus(Status.LOADING);

    api.registerApi(data,).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      signUpSet(value);

      if(registerData.value.status == true){
        userModel.step = registerData.value.step;
        log("Response Step: ${userModel.step}");
        userModel.token = registerData.value.token;
        log("Response token: ${userModel.token}");
        userModel.isLogin = true;
        log("Response islogin: ${userModel.isLogin}");
        userModel.loginType = registerData.value.loginType;
        log("Response loginType: ${userModel.loginType}");
        pref.saveUser(userModel);
        log('data for saveuser:  ${userModel.step}');
        log("Navigating with countryCode: $countryCode, mob: $mob");
        Get.offNamed(AppRoutes.signUpFom,arguments: {
          "countryCode": countryCode,
          "mob": mob
        });
      }else{
        Utils.showToast('The number is already registered.');
        setRxRequestStatus(Status.COMPLETED);
      }

    }).onError((error, stackError) {
      setError(error.toString());
      print('errrrrrrrrrrrr');
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      print(error);
      setRxRequestStatus(Status.COMPLETED);
    });
  }

  loginApi({
    required String countryCode,
    required String mob,
  }) async {
    String? tokenFcm = await FirebaseMessaging.instance.getToken();
    log("mobile ==>> $mob");

    final data = {
      "mob_no": mob,
      "fcm_token": tokenFcm,
      "country_code": countryCode,
    };

    setRxRequestStatus(Status.LOADING);

    api.loginApi(data,).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      signInSet(value);

      if(loginData.value.status == true){
        userModel.step = loginData.value.step;
        log("Response Step: ${userModel.step}");
        userModel.token = loginData.value.token;
        log("Response token: ${userModel.token}");
        userModel.isLogin = true;
        log("Response islogin: ${userModel.isLogin}");
        userModel.loginType = loginData.value.loginType;
        log("Response loginType: ${userModel.loginType}");
        pref.saveUser(userModel);
        log('data for loginuser:  ${userModel.step}');
        log("Navigating with countryCode: $countryCode, mob: $mob");
        userModel.step == 1
            ? Get.toNamed(AppRoutes.signUpFom,arguments: {
              "countryCode": countryCode,
              "mob": mob
            })
            : Get.offAllNamed(AppRoutes.restaurantNavbar);
      }else{
        setRxRequestStatus(Status.COMPLETED);
        Utils.showToast('User not found. Register first.');
      }

    }).onError((error, stackError) {
      setError(error.toString());
      print('errrrrrrrrrrrr');
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      print(error);
      setRxRequestStatus(Status.COMPLETED);
    });
  }

// OtpTimerButtonController otpTimerButtonController =
// OtpTimerButtonController();

// Future<bool> resendOtp() async {
//   Completer<bool> completer = Completer<bool>();
//   // otpTimerButtonController.loading();
//   try {
//     await auth.verifyPhoneNumber(
//       timeout: const Duration(seconds: 59),
//       phoneNumber: '${countryCode.value.toString()}${mobNoCon.value.text.trim().toString()}',
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         await auth.signInWithCredential(credential);
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         if (e.code == 'invalid-phone-number') {
//           print('${e.code}');
//           showTostMsg('The provided phone number is not valid.');
//         }else{
//           showTostMsg('Something went wrong');
//         }
//         otpTimerButtonController.enableButton();
//         completer.complete(false);
//       },
//       codeSent: (String verificationId, int? forceResendingToken) {
//         print('codesent');
//         showTostMsg('otp has been send successfully.');
//         verificationID.value = verificationId;
//         otpTimerButtonController.startTimer();
//         completer.complete(true);
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {},
//     );
//   } catch (e) {
//     otpTimerButtonController.enableButton();
//     completer.complete(false);
//     print('error == ${e.toString()}');
//   }
//   return completer.future;
//
// }
}
