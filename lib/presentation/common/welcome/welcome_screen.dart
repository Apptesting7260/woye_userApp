import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/common/Sign_up/sign_up_controller.dart';
import 'package:woye_user/presentation/common/Social_login/social_controller.dart';
import 'package:woye_user/presentation/common/guest%20login/guest_controller.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final SocialLoginController socialLoginController =
      Get.put(SocialLoginController());
  static final SignUpController signUpController = Get.put(SignUpController());
  final GuestController guestController = Get.put(GuestController());

  @override
  Widget build(BuildContext context) {
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
                  hBox(30),
                  header(),
                  hBox(20),
                  signInWithPhoneNumberButton(),
                  hBox(10),
                  guestButton(),
                  hBox(20),
                  divider(),
                  hBox(20),
                  facebookButton(context),
                  hBox(15),
                  googleButton(context),
                  hBox(15),
                  appleButton(context),
                  hBox(0),
                ],
              ),
            ),
            signUpButton(),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Column(
      children: [
        SvgPicture.asset(
          ImageConstants.welcomeLogo,
          height: 42.h,
        ),
        hBox(20),
        Text(
          "Let’s Get Started!",
          style: AppFontStyle.text_36_600(AppColors.darkText),
        ),
      ],
    );
  }

  Widget signInWithPhoneNumberButton() {
    return CustomElevatedButton(
      text: "Sign In With Phone Number",
      onPressed: () {
        Get.toNamed(AppRoutes.login);
      },
    );
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

  Widget divider() {
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
          "or",
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

  Widget facebookButton(context) {
    return CustomOutlinedButton(
        onPressed: () {
          socialLoginController.facebookLogin(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImageConstants.fbLogo,
              height: 26.h,
              width: 26.h,
            ),
            wBox(12),
            Text("Continue with Facebook",
                style: AppFontStyle.text_16_400(AppColors.darkText))
          ],
        ));
  }

  Widget googleButton(context) {
    return CustomOutlinedButton(
        onPressed: () {
          socialLoginController.signInWithGoogle(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImageConstants.googleLogo,
              height: 26.h,
              width: 26.h,
            ),
            wBox(12),
            Text("Continue with Google",
                style: AppFontStyle.text_16_400(AppColors.darkText)
                // AppFontStyle.text_16_800(AppColors.darkText),
                )
          ],
        ));
  }

  Widget appleButton(context) {

    return CustomOutlinedButton(
        onPressed: () {
          print("APPLE LOGIN");
          socialLoginController.appleLogin(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImageConstants.appleLogo,
              height: 26.h,
              width: 26.h,
            ),
            wBox(12),
            Text("Continue with Apple",
                style: AppFontStyle.text_16_400(AppColors.darkText))
          ],
        ));
  }

  Widget signUpButton() {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        Get.toNamed(AppRoutes.signUp);
      },
      child: Padding(
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
    );
  }
}
