import 'package:flutter/services.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/common/Sign_up/sign_up_controller.dart';
import 'package:woye_user/presentation/common/Social_login/social_controller.dart';
import 'package:woye_user/shared/widgets/CustomPhoneNumberField/CustomPhoneNumberField.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final SignUpController signUpController = Get.put(SignUpController());

  final SocialLoginController socialLoginController =
      Get.put(SocialLoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: signUpController.signUpFormKey,
        child: SingleChildScrollView(
          child: SizedBox(
            height: Get.height,
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
                  signUpButton(),

                  hBox(20),
                  //
                  continueText(),
                  hBox(20),
                  //
                  socialButtons(context),
                  hBox(20),
                  const Spacer(),
                  //
                  signInButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Create your\nAccount",
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
      controller: signUpController.mobNoCon.value,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      prefix: CountryCodePicker(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 9),
          onChanged: (CountryCode countryCode) {
            signUpController.updateCountryCode(countryCode);
            signUpController.showError.value = false;
            int? countrylength = signUpController
                .countryPhoneDigits[countryCode.code.toString()];
            signUpController.checkCountryLength = countrylength!;
          },
          initialSelection: "IN"),
      hintText: "Phone Number",
      textInputType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your phone number';
        }
        if (value.length != signUpController.checkCountryLength) {
          return 'Please enter a valid phone number (${signUpController.checkCountryLength} digits required)';
        }
        return null;
      },
    );
  }

  // Widget formField() {
  //   return Obx(
  //     () => CustomPhoneNumberField(
  //       controller: signUpController.mobNoCon.value,
  //       hintText: 'Phone Number',
  //     ),
  //   );
  // }

  Widget signUpButton() {
    return Obx(
      () => CustomElevatedButton(
        text: "Sign Up",
        isLoading: signUpController.isLoding.value,
        onPressed: () {
          if (signUpController.signUpFormKey.currentState!.validate()) {
            signUpController.sendOtp();
          }
        },
      ),
    );
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

  Widget socialButtons(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomRoundedButton(
          onPressed: () {
            socialLoginController.facebookLogin(context);
          },
          child: SvgPicture.asset(
            ImageConstants.fbLogo,
            height: 26.h,
            width: 26.h,
          ),
        ),
        wBox(15),
        CustomRoundedButton(
            onPressed: () {
              socialLoginController.signInWithGoogle(context);
            },
            child: SvgPicture.asset(
              ImageConstants.googleLogo,
              height: 26.h,
              width: 26.h,
            )),
        wBox(15),
        CustomRoundedButton(
          onPressed: () {
            socialLoginController.appleLogin(context);
          },
          child: SvgPicture.asset(
            ImageConstants.appleLogo,
            height: 26.h,
            width: 26.h,
          ),
        ),
      ],
    );
  }

  Widget signInButton() {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        Get.offNamed(AppRoutes.login);
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
                style: AppFontStyle.text_16_400(AppColors.lightText)),
            TextSpan(
                text: "Sign In",
                style: AppFontStyle.text_16_600(
                  AppColors.darkText,
                )),
          ])),
        ),
      ),
    );
  }
}
