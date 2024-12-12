import 'dart:developer';

import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Data/Model/usermodel.dart';
import 'package:woye_user/Presentation/Common/Otp/controller/otp_controller.dart';

// import 'package:woye_user/presentation/Common/sign_up/sign_up_controller.dart';
import 'package:woye_user/presentation/common/Sign_up/sign_up_controller.dart';

class OtpScreen extends StatelessWidget {
  // String? mobileNumber = Get.arguments["mob"];
  OtpScreen({
    super.key,
  });

  final LoginController loginController = Get.put(LoginController());
  final SignUpController signUpController = Get.put(SignUpController());

  // final SignUpController signUpController = Get.find<SignUpController>();
  final OtpController otpController = Get.find<OtpController>();

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final from = arguments['type'];
    final countryCode = arguments['countryCode'];
    final mob = arguments['mob'];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: REdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            hBox(20),
            header("$countryCode $mob"),
            hBox(30),
            otpField(),
            hBox(20),
            verifyButton(from, countryCode, mob),
            hBox(10),
            resendOtp(from)
          ],
        ),
      ),
    );
  }

  Widget header(mob) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Verification code",
        style: AppFontStyle.text_30_600(AppColors.darkText),
      ),
      hBox(20),
      Text(
        "Please enter the verification code sent to",
        style: AppFontStyle.text_16_400(AppColors.lightText),
      ),
      Text(
        mob,
        style: AppFontStyle.text_16_400(AppColors.primary),
      ),
    ]);
  }

  Widget otpField() {
    return Pinput(
      length: 6,
      controller: otpController.otpPin.value,
      defaultPinTheme: otpController.defaultPinTheme,
      focusedPinTheme: otpController.focusedPinTheme,
      submittedPinTheme: otpController.submittedPinTheme,
    );
  }

  Widget verifyButton(from, countryCode, mob) {
    return Obx(
      () => CustomElevatedButton(
        isLoading: otpController.rxRequestStatus.value == Status.LOADING,
        onPressed: () async {
          if (otpController.otpPin.value.text.length < 6) {
            SnackBarUtils.showToast('Please enter a valid 6-digit OTP.');
            return;
          } else {
            final verify = await otpController.verifyOtp(
                verificationId: from == 'login'
                    ? loginController.verificationID.value
                    : signUpController.verificationID.value,
                smsCode: otpController.otpPin.value.text,
                countryCode: countryCode,
                mob: mob);
            if (from == 'login') {
              if (verify) {
                otpController.loginApi(countryCode: countryCode, mob: mob);
              }
            } else {
              if (verify) {
                otpController.registerApi(countryCode: countryCode, mob: mob);
              }
            }
          } // Get.toNamed(AppRoutes.signUp);
        },
        text: "Verify",
      ),
    );
  }

  Widget resendOtp(from) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Didn\'t receive OTP?',
          style: AppFontStyle.text_16_400(AppColors.black),
        ),
        from == 'login'
            ? OtpTimerButton(
                buttonType: ButtonType.text_button,
                controller: loginController.otpTimerButtonController,
                loadingIndicatorColor: AppColors.primary,
                onPressed: () {
                  print('Resending OTP');
                  loginController.resendOtp();
                  otpController.otpPin.value.clear();
                },
                text: Text(
                  'Resend',
                  style: AppFontStyle.text_16_400(AppColors.lightText,
                      fontWeight: FontWeight.w500),
                ),
                duration: 60,
              )
            : OtpTimerButton(
                buttonType: ButtonType.text_button,
                controller: signUpController.otpTimerButtonController,
                loadingIndicatorColor: Colors.green,
                onPressed: () {
                  print('Resending OTP');
                  signUpController.resendOtp();
                  otpController.otpPin.value.clear();
                },
                text: Text(
                  'Resend',
                  style: AppFontStyle.text_16_400(AppColors.lightText,
                      fontWeight: FontWeight.w500),
                ),
                duration: 60,
              ),
      ],
    );
  }
}
