import 'package:country_code_picker/country_code_picker.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

class LoginController extends GetxController {
  late TextEditingController mobNoCon;
  late TextEditingController countryCode;
  var resendToken = 0.obs;
  // var countryCode = "".obs;
  //
  // void onSelect(Country country) {
  //   selectedCountry = country;
  //   countryCode.value = selectedCountry!.phoneCode;
  //   print("country==================>${selectedCountry}");
  //   print("country==================>${countryCode.value}");
  //   update();
  // }

  @override
  void onInit() {
    mobNoCon = TextEditingController();
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    mobNoCon.dispose();
    // TODO: implement onClose
    super.onClose();
  }

  void updateCountryCode(CountryCode countryCode) {
    selectedCountryCode.value = countryCode;
  }

  Rx<CountryCode> selectedCountryCode =
      CountryCode(dialCode: '+91', code: 'IN').obs;


  FirebaseAuth auth = FirebaseAuth.instance;
  RxString verificationID = ''.obs;


  // final Rx<TextEditingController> mobNoCon = TextEditingController().obs;

  Future<bool> sendOtp() async {
    Completer<bool> completer = Completer<bool>();
    print('re == ${resendToken.value}');
    print(
        'no == ${"+"}${countryCode.value.toString()}${mobNoCon.value.text.trim().toString()}');
    try {
      await auth.verifyPhoneNumber(
        timeout: const Duration(seconds: 59),
        phoneNumber:
            '${countryCode.value.toString()}${mobNoCon.value.text.trim().toString()}',
        // forceResendingToken: !Platform.isIOS ? (resendToken.value != 0 ? resendToken.value : null) : null,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('${e.code}');
            // showTostMsg('The provided phone number is not valid.');
            Fluttertoast.showToast(
                msg: 'The provided phone number is not valid.',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            Fluttertoast.showToast(
                msg: 'Something went wrong',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
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
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      completer.complete(false);
      print('error == ${e.toString()}');
    }
    return completer.future;
  }
// var otpVerify = false.obs;
//
// Future<bool> verifyOtp(String verificationId,String smsCode) async{
//   otpVerify.value = true;
//   try{
//     var credential = await auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode));
//     otpVerify.value = false;
//     return credential.user == null ? false : true;
//   }on FirebaseAuthException catch (e){
//     print('otp error == ${e.code}');
//     if(e.code == 'invalid-verification-code'){
//       showTostMsg('Invalid otp.');
//     }else{
//       showTostMsg('Please check your otp and try again.');
//     }
//     otpVerify.value = false;
//     return false;
//   }
// }

//
// OtpTimerButtonController otpTimerButtonController =
// OtpTimerButtonController();

// Future<bool> resendOtp() async {
//   Completer<bool> completer = Completer<bool>();
//   otpTimerButtonController.loading();
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
