import 'package:flutter/services.dart';
import 'package:woye_user/Core/Utils/app_export.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: loginController.loginFormKey,
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hBox(100),
              //
              header(),
              hBox(40),
              //
              formField(),
              hBox(20),
              //
              signInButton(),
              hBox(20),
              //
              continueText(),
              hBox(20),
              //
              socialButtons(),
              const Spacer(),
              //
              signUpButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Login to your\nAccount",
        style: AppFontStyle.text_36_600(AppColors.darkText),
      ),
      hBox(20),
      Text(
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.lightText),
      ),
    ]);
  }

  Widget formField() {
    return CustomTextFormField(
      controller: loginController.mobNoCon.value,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      prefix: CountryCodePicker(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 9),
          onChanged: (CountryCode countryCode) {
            loginController.updateCountryCode(countryCode);
            loginController.showError.value = false;
            int? countrylength =
                loginController.countryPhoneDigits[countryCode.code.toString()];
            loginController.chackCountryLength = countrylength!;
          },
          initialSelection: "IN"),
      hintText: "Phone Number",
      textInputType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your phone number';
        }
        if (value.length != loginController.chackCountryLength) {
          return 'Please enter a valid phone number (${loginController.chackCountryLength} digits required)';
        }
        return null;
      },
    );
  }

  Widget signInButton() {
    return Obx(() => CustomElevatedButton(
          text: "Sign In",
          isLoading: loginController.isLoding.value,
          onPressed: () {
            if (loginController.loginFormKey.currentState!.validate()) {
              loginController.sendOtp();
            }
          },
        ));
  }

  Widget continueText() {
    return Row(
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
    );
  }

  Widget socialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomRoundedButton(
          onPressed: () {},
          child: SvgPicture.asset(
            ImageConstants.fbLogo,
            height: 26.h,
            width: 26.h,
          ),
        ),
        wBox(15),
        CustomRoundedButton(
            onPressed: () {},
            child: SvgPicture.asset(
              ImageConstants.googleLogo,
              height: 26.h,
              width: 26.h,
            )),
        wBox(15),
        CustomRoundedButton(
          onPressed: () {},
          child: SvgPicture.asset(
            ImageConstants.appleLogo,
            height: 26.h,
            width: 26.h,
          ),
        ),
      ],
    );
  }

  Widget signUpButton() {
    return Column(
      children: [
        InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            Get.toNamed(AppRoutes.restaurantNavbar);
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
                    text: "Home",
                    style: AppFontStyle.text_16_400(AppColors.lightText)),
                TextSpan(
                    text: "screen",
                    style: AppFontStyle.text_16_600(
                      AppColors.darkText,
                    )),
              ])),
            ),
          ),
        ),
        InkWell(
          highlightColor: Colors.transparent,
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
                    style: AppFontStyle.text_16_400(AppColors.lightText)),
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
    );
  }
}
