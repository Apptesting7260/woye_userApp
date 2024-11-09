import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:woye_user/Core/Constant/app_urls.dart';
import 'package:woye_user/Data/Model/usermodel.dart';
import 'package:woye_user/Data/network/base_api_services.dart';
import 'package:woye_user/Data/network/network_api_services.dart';
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
  final _api = Repository();
  final apiService = NetworkApiServices();

  final rxRequestStatus = Status.COMPLETED.obs;
  final registerData = RegisterModel().obs;
  RxString error = ''.obs;
  UserModel userModel = UserModel();

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void signUpSet(RegisterModel _value) => registerData.value = _value;
  void setError(String _value) => error.value = _value;

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
      SnackBarUtils.showToastCenter('Otp Verify Successfully');
      return credential.user == null ? false : true;
    } on FirebaseAuthException catch (e) {
      print('otp error == ${e.code}');
      otpVerify.value = false;
      if (e.code == 'invalid-verification-code') {
        SnackBarUtils.showToastCenter('Invalid otp.');
      } else {
        SnackBarUtils.showToastCenter('Please check your otp and try again.');
      }
      return false;
    }
  }

  Future<bool> registerApi({
    required String countryCode,
    required String mob,
  }) async {
    String? tokenFcm = await FirebaseMessaging.instance.getToken();

    final data = {
      "mob_no": mob,
      "fcm_token": tokenFcm,
      "country_code": countryCode,
    };

    try {
      otpVerify.value = true;
      var response = await apiService.postApi(data, AppUrls.register, "");

      if (response != null && response is Map<String, dynamic>) {
        // Parse the response into the RegisterModel
        RegisterModel registerModel = RegisterModel.fromJson(response);

        log("Response: ${registerModel.message}");

        // Check if the status is true
        if (registerModel.status == true) {
          UserModel userModel = UserModel();
          userModel.step = registerModel.step;
          userModel.token = registerModel.token;
          userModel.islogin = true;
          userModel.loginType = registerModel.loginType;
          return true;
        }else{
          otpVerify.value = false;
          SnackBarUtils.showToastCenter('The mob no has already been taken.');
          return false;
        }
      }

      // If the status is not true or the response is not as expected, return false
      return false;
    } catch (e) {
      otpVerify.value = false;
      log("Error: $e");
      return false;
    }
  }

  Future<bool> loginApi({
    required String countryCode,
    required String mob,
  }) async {
    String? tokenFcm = await FirebaseMessaging.instance.getToken();
    log("mobile ==>> ${mob}");

    final data = {
      "mob_no": mob,
      "fcm_token": tokenFcm,
      "country_code": countryCode,
    };

    try {
      otpVerify.value = true;
      var response = await apiService.postApi(data, AppUrls.login, "");
      print(response);

      if (response != null && response is Map<String, dynamic>) {
        // Parse the response into the RegisterModel
        LoginModel loginModel = LoginModel.fromJson(response);

        log("Response: ${loginModel.message}");

        // Check if the status is true
        if (loginModel.status == true) {
          userModel.step = loginModel.step;
          log("Response Step: ${userModel.step}");
          userModel.token = loginModel.token;
          log("Response token: ${userModel.token}");
          userModel.islogin = true;
          log("Response islogin: ${userModel.islogin}");
          userModel.loginType = loginModel.loginType;
          log("Response loginType: ${userModel.loginType}");
          otpVerify.value = false;
          return true;
        }else{
          otpVerify.value = false;
          SnackBarUtils.showToastCenter('${loginModel.message}');
          return false;
        }
      }else{
        otpVerify.value = false;
        SnackBarUtils.showToastCenter('User not found. Register first.');
        return false;
      }

      // If the status is not true or the response is not as expected, return false
      return false;
    } catch (e) {
      otpVerify.value = false;
      SnackBarUtils.showToastCenter('User not found.');
      log("Errors: $e");
      return false;
    }
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
