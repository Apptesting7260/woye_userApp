import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Common/sign_up/sign_up_controller.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final LoginController loginController = Get.put(LoginController());
  final SignUpController signUpController = Get.put(SignUpController());
  final OtpController otpController = Get.find<OtpController>();

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final from = arguments['type'];
    final mob = arguments['mob'];
    print("ttttttttt${from}");
    print("ttttttttt${mob}");
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
            hBox(30),
            Pinput(
              length: 6,
              controller: otpController.otpPin.value,
              defaultPinTheme: otpController.defaultPinTheme,
              focusedPinTheme: otpController.focusedPinTheme,
              submittedPinTheme: otpController.submittedPinTheme,
            ),
            hBox(20),
            Obx(
              () => CustomElevatedButton(
                isLoading: otpController.otpVerify.value,
                onPressed: () async {
                  if (otpController.otpPin.value.text.length < 6) {
                    SnackBarUtils.showToastCenter(
                        'Please enter a valid 6-digit OTP.');
                    return;
                  } else {
                    final verify = await otpController.verifyOtp(
                        verificationId: from == 'login'
                            ? loginController.verificationID.value
                            : signUpController.verificationID.value,
                        smsCode: otpController.otpPin.value.text);
                    if (from == 'login') {
                      if (verify) {
                        Get.offAllNamed(AppRoutes.restaurantNavbar);
                      }
                    } else {
                      if (verify) {
                        Get.offNamed(AppRoutes.signUpFom);
                      }
                    }
                  } // Get.toNamed(AppRoutes.signUp);
                },
                text: "Verify",
              ),
            ),
            hBox(20),
            from == 'login'
                ? Align(
                    alignment: Alignment.center,
                    child: OtpTimerButton(
                        buttonType: ButtonType.text_button,
                        controller: loginController.otpTimerButtonController,
                        loadingIndicatorColor: AppColors.primary,
                        onPressed: () {
                          print('resend otp');
                          loginController.resendOtp();
                        },
                        text: Text(
                          'Resend',
                          style: AppFontStyle.text_16_400(AppColors.lightText),
                        ),
                        duration: 60),
                  )
                : Align(
                    alignment: Alignment.center,
                    child: OtpTimerButton(
                        buttonType: ButtonType.text_button,
                        controller: signUpController.otpTimerButtonController,
                        loadingIndicatorColor: Colors.green,
                        onPressed: () {
                          print('resend otp');
                          signUpController.resendOtp();
                        },
                        text: Text(
                          'Resend',
                          style: AppFontStyle.text_16_400(AppColors.lightText),
                        ),
                        duration: 60),
                  ),
          ],
        ),
      ),
    );
  }
}
