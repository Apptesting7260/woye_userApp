import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:woye_user/Presentation/Common/Otp/model/register_model.dart';
import 'package:woye_user/Presentation/Common/Otp/view/otp_screen.dart';
import 'package:woye_user/core/utils/app_export.dart';

class OtpController extends GetxController {
  final Rx<TextEditingController> otpPin = TextEditingController().obs;
  var otpVerify = false.obs;
  final OtpScreen _otpScreen = OtpScreen();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _api = Repository();

  final rxRequestStatus = Status.COMPLETED.obs;
  final registerData = RegisterModel().obs;
  RxString error = ''.obs;
  String mobNumber = "";

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void signUpSet(RegisterModel _value) => registerData.value = _value;
  void setError(String _value) => error.value = _value;

  @override
  void onInit() {
    mobNumber = _otpScreen.mobileNumber ?? "";
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

  void registerApi() async {
    String? tokenFcm = await FirebaseMessaging.instance.getToken();

    Map data = {"mob_no": ""};
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
