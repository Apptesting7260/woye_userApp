import 'package:woye_user/Routes/app_routes.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Common/login/login_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                              wBox(5),
                              SvgPicture.asset(
                                ImageConstants.arrowDown,
                                height: 6.h,
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
                    text: "Sign Up",
                    onPressed: () {
                      Get.toNamed(AppRoutes.signUpOtp);
                    },
                  ),
                  const Spacer(),
                  GestureDetector(
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
