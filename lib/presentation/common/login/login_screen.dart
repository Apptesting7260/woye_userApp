import 'package:country_code_picker/country_code_picker.dart';
import 'package:woye_user/Routes/app_routes.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Common/login/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  // final loginController = Get.lazyPut(() => LoginController());

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
                  hBox(100),
                  Text(
                    "Login to your\nAccount",
                    style: AppFontStyle.text_40_600(AppColors.darkText),
                  ),
                  hBox(24),
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    style: AppFontStyle.text_16_400(AppColors.lightText),
                  ),
                  hBox(50),
                  CustomTextFormField(
                    controller: loginController.mobNoCon,
                    contentPadding: REdgeInsets.all(30),
                    prefix: CountryCodePicker(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 9),
                        // onChanged: (CountryCode countryCode) {
                        //   countryCode.updateCountryCode(countryCode);
                        //   countryCode.showError.value = false;
                        //   int? countrylength = controller
                        //       .countryPhoneDigits[countryCode.code.toString()];
                        //   controller.chackCountryLength = countrylength!;
                        // },
                        initialSelection: "ZA"),
                    hintText: "Phone Number",
                    textInputType: TextInputType.phone,
                  ),
                  hBox(20),
                  CustomElevatedButton(
                    text: "Sign In",
                    onPressed: () {
                      loginController.sendOtp();

                      // Get.toNamed(AppRoutes.loginOtp);
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
                        style: AppFontStyle.text_16_400(AppColors.lightText),
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
                  InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      Get.toNamed(AppRoutes.signUp);
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: REdgeInsets.only(
                          bottom: 30,
                        ),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Don't have an account? ",
                              style: AppFontStyle.text_16_400(
                                  AppColors.lightText)),
                          TextSpan(
                              text: "Sign Up",
                              style: AppFontStyle.text_16_600(
                                AppColors.darkText,
                              )),
                        ])),
                      ),
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
