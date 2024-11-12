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
              phoneNumberField(),
              hBox(20),
              //
              signInButton(),
              hBox(10),
              //
              guestButton(),
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

  Widget phoneNumberField() {
    return CustomTextFormField(
      controller: loginController.mobNoCon.value,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      // prefixConstraints: BoxConstraints(maxWidth: 70),
      prefix: CountryCodePicker(
          padding: const EdgeInsets.only(left: 10),
          onChanged: (CountryCode countryCode) {
            print("country code===========> ${countryCode.code}");
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

  Widget guestButton() {
    return CustomOutlinedButton(
        onPressed: () {
          loginController.guestUserApi();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/svg/person-primary.svg",
              height: 26.h,
              width: 26.h,
            ),
            wBox(12),
            Text("Continue As Guest",
                style: AppFontStyle.text_16_400(AppColors.darkText))
          ],
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
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        Get.offNamed(AppRoutes.signUp);
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
    );
  }
}
