import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/common/guest%20login/guest_controller.dart';
import 'package:woye_user/presentation/common/Social_login/social_controller.dart';
import 'package:woye_user/shared/widgets/CustomPhoneNumberField/CustomPhoneNumberField.dart';
import 'package:woye_user/shared/widgets/CustomPhoneNumberField/PhoneNumberService.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  static final LoginController loginController = Get.put(LoginController());

  final GuestController guestController = Get.put(GuestController());

  final SocialLoginController socialLoginController =
      Get.put(SocialLoginController());

  // final PhoneNumberService phoneNumberService = Get.put(PhoneNumberService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: loginController.loginFormKey,
        child: SingleChildScrollView(
          child: SizedBox(
            height: Get.height,
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 24.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  hBox(100.h),
                  //
                  header(),
                  hBox(40.h),
                  //
                  phoneNumberField(),
                  hBox(20.h),
                  //
                  signInButton(),
                  // hBox(10),
                  //
                  // guestButton(),
                  hBox(20.h),
                  //
                  continueText(),
                  hBox(20.h),
                  //
                  socialButtons(context),
                  const Spacer(),
                  //
                  signUpButton()
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

  // Widget phoneNumberField() {
  //   return Obx(() {
  //     print("object${loginController.selectedCountryCode.value.dialCode}");
  //     return CustomPhoneNumberField(
  //       controller: loginController.mobNoCon.value,
  //       hintText: 'Phone Number',
  //       selectedCountryCode: loginController.selectedCountryCode.value,
  //     );
  //   });
  // }

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
    return Obx(
      () => CustomOutlinedButton(
          onPressed: () {
            guestController.guestUserApi();
          },
          child: guestController.rxRequestStatus.value == Status.LOADING
              ? LoadingAnimationWidget.inkDrop(
                  color: AppColors.primary,
                  size: 30.h,
                )
              : Row(
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
                )),
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
