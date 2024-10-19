import 'package:woye_user/core/app_export.dart';
import 'package:woye_user/presentation/common/login/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (loginController) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: REdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  hBox(60),
                  Text(
                    "Login to your\nAccount",
                    style: AppFontStyle.text_40_600(AppColors.darkText),
                  ),
                  hBox(34),
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    style: AppFontStyle.text_18_400(AppColors.lightText),
                  ),
                  hBox(50),
                  CustomTextFormField(
                    prefix: Padding(
                      padding: REdgeInsets.only(left: 20),
                      child: GestureDetector(
                        onTap: () {
                          showCountryPicker(
                              showPhoneCode: true,
                              context: context,
                              onSelect: loginController.onSelect);
                        },
                        child: SizedBox(
                          width: 70.w,
                          child: Row(
                            children: [
                              if (loginController.selectedCountry != null)
                                Text(
                                  "+${loginController.selectedCountry!.phoneCode}",
                                  style: AppFontStyle.text_16_400(
                                      AppColors.darkText),
                                )
                              else
                                Text(
                                  "+91",
                                  style: AppFontStyle.text_16_400(
                                      AppColors.darkText),
                                ),
                              wBox(8),
                              SvgPicture.asset(
                                ImageConstants.arrowDown,
                                height: 7.h,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    hintText: "Phone Number",
                    textInputType: TextInputType.phone,
                  ),
                  hBox(20),
                  CustomElevatedButton(
                    text: "Sign In",
                    onPressed: () {
                      Get.toNamed("page");
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
                        "or continue with",
                        style: AppFontStyle.text_18_400(AppColors.lightText),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      facebookButton(),
                      wBox(15),
                      googleButton(),
                      wBox(15),
                      appleButton(),
                    ],
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: REdgeInsets.only(
                        bottom: 30,
                      ),
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "Don't have an account? ",
                            style:
                                AppFontStyle.text_16_400(AppColors.lightText)),
                        TextSpan(
                            text: "Sign Up",
                            style: AppFontStyle.text_16_600(
                              AppColors.darkText,
                            )),
                      ])),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  CustomRoundedButton facebookButton() {
    return CustomRoundedButton(
      onPressed: () {},
      child: SvgPicture.asset(
        ImageConstants.fbLogo,
        height: 26.h,
        width: 26.h,
      ),
    );
  }

  CustomRoundedButton googleButton() {
    return CustomRoundedButton(
        onPressed: () {},
        child: SvgPicture.asset(
          ImageConstants.googleLogo,
          height: 26.h,
          width: 26.h,
        ));
  }

  CustomRoundedButton appleButton() {
    return CustomRoundedButton(
      onPressed: () {},
      child: SvgPicture.asset(
        ImageConstants.appleLogo,
        height: 26.h,
        width: 26.h,
      ),
    );
  }
}
