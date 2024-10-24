import 'package:firebase_auth/firebase_auth.dart';
import 'package:woye_user/core/utils/app_export.dart';

class OtpController extends GetxController {
  final Rx<TextEditingController> otpPin = TextEditingController().obs;
  var otpVerify = false.obs;

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

  final FirebaseAuth auth = FirebaseAuth.instance;

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
