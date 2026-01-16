import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Presentation/Common/Otp/controller/otp_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Filter/view/restaurant_categories_filter.dart';
import 'package:woye_user/presentation/common/Sign_up/sign_up_controller.dart';
import 'package:woye_user/shared/theme/font_family.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';

class OtpScreen extends StatelessWidget {
  // String? mobileNumber = Get.arguments["mob"];
  OtpScreen({
    super.key,
  });

  final LoginController loginController = Get.put(LoginController());
  final SignUpController signUpController = Get.put(SignUpController());
  final OtpController otpController = Get.find<OtpController>();

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic> ?? {};
    final from = arguments['type'] ?? "";
    final countryCode = arguments['countryCode'] ?? "";
    final mob = arguments['mob'] ?? "";

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
        style: AppFontStyle.text_28_600(AppColors.darkText,
            family: AppFontFamily.onestRegular),
      ),
      hBox(20),
      Text(
        "Please enter the verification code sent to",
        style: AppFontStyle.text_16_400(AppColors.lightText,
            family: AppFontFamily.onestMedium),
      ),
      Text(
        mob,
        style: AppFontStyle.text_16_400(AppColors.black,
            family: AppFontFamily.onestMedium),
      ),
    ]);
  }

  Widget otpField() {
    return Obx(
      ()=> Pinput(
        length: 6,
        controller: otpController.otpPin.value,
        defaultPinTheme: otpController.defaultPinTheme,
        focusedPinTheme: otpController.focusedPinTheme,
        submittedPinTheme: otpController.submittedPinTheme,
      ),
    );
  }

  Widget verifyButton(from, countryCode, mob) {
    return Obx(
      () => CustomElevatedButton(
        fontFamily: AppFontFamily.onestMedium,
        isLoading: otpController.rxRequestStatus.value == Status.LOADING,
        onPressed: () async {
          final otpText = otpController.otpPin.value.text.trim();
          if (otpText.length != 6) {
            Utils.showToast('Please enter a valid 6-digit OTP.');
            pt("Otp length ${otpText.length}  $otpText");
            return;
          } else {
            if (otpController.remainingTime.value != 0) {
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
                  loginController.mobNoCon.value.clear();
                }
              } else {
                if (verify) {
                  otpController.registerApi(countryCode: countryCode, mob: mob);
                }
              }
            } else {
              Utils.showToast("The OTP has expired. Please resend it.");
            }
            // Get.toNamed(AppRoutes.signUp);
          }
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
          style: AppFontStyle.text_16_400(AppColors.darkText,
              family: AppFontFamily.onestRegular),
        ),

        Obx(
          () => TextButton(
            style: const ButtonStyle(
                padding: WidgetStatePropertyAll(EdgeInsets.zero)),
            onPressed: () {
              if (otpController.remainingTime.value == 0) {
                if (from == 'login') {
                  print('login Resending OTP');
                  loginController.resendOtp().then(
                    (value) {
                      otpController.startTimer();
                    },
                  );
                  otpController.otpPin.value.clear();
                } else {
                  print('signUpController Resending OTP');
                  signUpController.resendOtp().then(
                    (value) {
                      otpController.startTimer();
                    },
                  );
                  otpController.otpPin.value.clear();
                }
              }
              // otpController.remainingTime.value == 0 ? otpController.startTimer() : null;
            },
            child: Text(
              " Resend code in ${otpController.remainingTime.value} Sec",
              style: AppFontStyle.text_16_400(
                  otpController.remainingTime.value == 0
                      ? AppColors.black
                      : AppColors.lightText,
                  fontWeight: FontWeight.w400,
                  family: AppFontFamily.onestRegular),
            ),
          ),
        ),
      ],
    );
  }
}
