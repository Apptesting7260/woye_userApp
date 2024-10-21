import 'package:woye_user/Routes/app_routes.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Common/sign_up_otp/sign_up_otp_controller.dart';
import 'package:woye_user/shared/widgets/custom_app_bar.dart';

class SignUpOtpScreen extends StatelessWidget {
  const SignUpOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpOtpController>(
        init: SignUpOtpController(),
        builder: (signUpOtpController) {
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
                    defaultPinTheme: signUpOtpController.defaultPinTheme,
                    focusedPinTheme: signUpOtpController.focusedPinTheme,
                    submittedPinTheme: signUpOtpController.submittedPinTheme,
                  ),
                  hBox(20),
                  CustomElevatedButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.formSignUp);
                    },
                    text: "Verify",
                  ),
                  hBox(20),
                  Align(
                      alignment: Alignment.center,
                      child: signUpOtpController.duration != 0
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
                              "Resend code in ${signUpOtpController.duration.toString()} s",
                              style:
                                  AppFontStyle.text_16_400(AppColors.darkText),
                            )
                          : GestureDetector(
                              onTap: () {
                                signUpOtpController.resendOtp();
                              },
                              child: Text(
                                "Resend Code",
                                style: AppFontStyle.text_16_400(
                                    AppColors.lightText),
                              ),
                            ))
                ],
              ),
            ),
          );
        });
  }
}
