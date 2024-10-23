import 'package:country_code_picker/country_code_picker.dart';
import 'package:woye_user/Routes/app_routes.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Common/sign_up/sign_up_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
        init: SignUpController(),
        builder: (signUpController) {
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
                    "Create your\nAccount",
                    style: AppFontStyle.text_40_600(AppColors.darkText),
                  ),
                  hBox(24),
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    style: AppFontStyle.text_16_400(AppColors.lightText),
                  ),
                  hBox(50),
                  CustomTextFormField(
                    prefix: CountryCodePicker(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 9),
                        onChanged: (CountryCode countryCode) {
                          signUpController.updateCountryCode(countryCode);
                          signUpController.showError.value = false;
                          int? countrylength = signUpController
                              .countryPhoneDigits[countryCode.code.toString()];
                          signUpController.chackCountryLength = countrylength!;
                        },
                        initialSelection: "IN"),
                    hintText: "Phone Number",
                    textInputType: TextInputType.phone,
                  ),
                  hBox(20),
                  CustomElevatedButton(
                    text: "Sign Up",
                    onPressed: () {
                      // Get.toNamed(AppRoutes.loginOtp);
                    },
                  ),
                  const Spacer(),
                  InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      Get.toNamed(AppRoutes.login);
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
                              text: "Already have an account? ",
                              style: AppFontStyle.text_16_400(
                                  AppColors.lightText)),
                          TextSpan(
                              text: "Sign In",
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
}
