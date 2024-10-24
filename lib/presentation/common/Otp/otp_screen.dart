import 'package:woye_user/Core/Utils/app_export.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final LoginController loginController = Get.put(LoginController());
  final OtpController otpController = Get.find<OtpController>();

  @override
  Widget build(BuildContext context) {
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
              "+91 12345678",
              style: AppFontStyle.text_16_400(AppColors.primary),
            ),
            hBox(30),
            Pinput(
              length: 6,
              controller: otpController.otpPin,
              defaultPinTheme: otpController.defaultPinTheme,
              focusedPinTheme: otpController.focusedPinTheme,
              submittedPinTheme: otpController.submittedPinTheme,
            ),
            hBox(20),
            CustomElevatedButton(
              onPressed: () {
                otpController.verifyOtp(
                    verificationId: loginController.verificationID.value,
                    smsCode: otpController.otpPin.text);
                // Get.toNamed(AppRoutes.signUp);
              },
              text: "Verify",
            ),
            hBox(20),
            Align(
                alignment: Alignment.center,
                child: otpController.duration != 0
                    ?
                    //     ? Text(
                    //         "${(otpVerificationController.duration ~/ 60).toString().padLeft(2, '0')}:${(otpVerificationController.duration % 60).toString().padLeft(2, '0')}",
                    //         // "00:${otpVerificationController.start.toString().padLeft(2, "0")}",
                    //         style: TextStyle(
                    //             color: const Color.fromARGB(255, 184, 30, 30),
                    //             fontSize: 15.sp,
                    //             fontWeight: FontWeight.w500),
                    //       )
                    //     : null
                    Text(
                        "Resend code in ${otpController.duration.toString()} s",
                        style: AppFontStyle.text_16_400(AppColors.darkText),
                      )
                    : GestureDetector(
                        onTap: () {
                          // loginOtpController.resendOtp();
                        },
                        child: Text(
                          "Resend Code",
                          style: AppFontStyle.text_16_400(AppColors.lightText),
                        ),
                      ))
          ],
        ),
      ),
    );
  }
}
