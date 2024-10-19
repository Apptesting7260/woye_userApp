import 'package:woye_user/core/app_export.dart';
import 'package:woye_user/presentation/common/otp_verification/otp_verification_controller.dart';
import 'package:woye_user/shared/widgets/custom_app_bar.dart';

class OtpVerificaitonScreen extends StatelessWidget {
  const OtpVerificaitonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpVerificationController>(
        init: OtpVerificationController(),
        builder: (otpVerificationController) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: CustomAppBar(
              leading: Padding(
                padding: REdgeInsets.only(left: 24),
                child: CircleAvatar(
                  radius: 44.w,
                  backgroundColor: AppColors.greyBackground,
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.darkText,
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: REdgeInsets.symmetric(horizontal: 24, vertical: 20),
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
                    defaultPinTheme: otpVerificationController.defaultPinTheme,
                    focusedPinTheme: otpVerificationController.focusedPinTheme,
                    submittedPinTheme:
                        otpVerificationController.submittedPinTheme,
                  ),
                  hBox(20),
                  CustomElevatedButton(
                    onPressed: () {},
                    text: "Verify",
                  ),
                  hBox(20),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Resend code in ${otpVerificationController.duration} s",
                      style: AppFontStyle.text_16_400(AppColors.darkText),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
