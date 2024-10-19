import 'package:woye_user/Routes/app_routes.dart';
import 'package:woye_user/core/app_export.dart';
import 'package:woye_user/presentation/common/welcome/welcome_controller.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WelcomeController>(
        init: WelcomeController(),
        builder: (welcomeController) {
          return Scaffold(
            body: Padding(
              padding: REdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "W",
                              style: AppFontStyle.text_56_800(AppColors.black)),
                          TextSpan(
                              text: "O",
                              style:
                                  AppFontStyle.text_56_800(AppColors.primary)),
                          TextSpan(
                              text: "Y",
                              style: AppFontStyle.text_56_800(AppColors.black)),
                          TextSpan(
                              text: "E",
                              style: AppFontStyle.text_56_800(AppColors.black)),
                        ])),
                        hBox(50),
                        Text(
                          "Let’s Get Started!",
                          style: AppFontStyle.text_36_600(AppColors.darkText),
                        ),
                        hBox(50),
                        CustomElevatedButton(
                          text: "Sign in with Phone Number",
                          onPressed: () {
                            Get.toNamed(AppRoutes.login);
                          },
                        ),
                        hBox(30),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 1.h,
                                color: AppColors.greyBackground,
                                endIndent: 16.w,
                              ),
                            ),
                            Text(
                              "or",
                              style:
                                  AppFontStyle.text_18_400(AppColors.lightText),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 1.h,
                                color: AppColors.greyBackground,
                                indent: 16.w,
                              ),
                            ),
                          ],
                        ),
                        hBox(30),
                        facebookButton(),
                        hBox(15),
                        googleButton(),
                        hBox(15),
                        appleButton(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: REdgeInsets.only(bottom: 30),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Don't have an account? ",
                          style: AppFontStyle.text_16_400(AppColors.lightText)),
                      TextSpan(
                          text: "Sign Up",
                          style: AppFontStyle.text_16_600(AppColors.darkText)),
                    ])),
                  ),
                ],
              ),
            ),
          );
        });
  }

  CustomOutlinedButton facebookButton() {
    return CustomOutlinedButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImageConstants.fbLogo,
              height: 26.h,
              width: 26.h,
            ),
            wBox(12),
            Text(
              "Continue with Facebook",
              style: AppFontStyle.text_18_400(AppColors.darkText),
            )
          ],
        ));
  }

  CustomOutlinedButton googleButton() {
    return CustomOutlinedButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImageConstants.googleLogo,
              height: 26.h,
              width: 26.h,
            ),
            wBox(12),
            Text(
              "Continue with Google",
              style: AppFontStyle.text_18_400(AppColors.darkText),
            )
          ],
        ));
  }

  CustomOutlinedButton appleButton() {
    return CustomOutlinedButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImageConstants.appleLogo,
              height: 26.h,
              width: 26.h,
            ),
            wBox(12),
            Text(
              "Continue with Apple",
              style: AppFontStyle.text_18_400(AppColors.darkText),
            )
          ],
        ));
  }
}
