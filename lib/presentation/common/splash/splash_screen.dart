import 'package:woye_user/Routes/app_routes.dart';
import 'package:woye_user/core/app_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // PrefUtils prefUtils = PrefUtils();
  @override
  void initState() {
    checkToken();

    super.initState();
  }

  void checkToken() async {
    // String? responseToken = await prefUtils.getToken();
    // bool? isRegister = await prefUtils.getRegistrationDetails();

    Future.delayed(const Duration(milliseconds: 3000), () {
      // if (responseToken == null) {
      //   Get.toNamed(AppRoutes.login);
      // }
      // if (responseToken != null && !isRegister!) {
      //   Get.toNamed(AppRoutes.login);
      // }
      // if (responseToken != null && isRegister!) {
      //   Get.toNamed(AppRoutes.navbar);
      // }
      Get.toNamed(AppRoutes.welcomeScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkText,
      body: Center(
        child: RichText(
            text: TextSpan(children: [
          TextSpan(text: "W", style: AppFontStyle.text_56_800(AppColors.white)),
          TextSpan(
              text: "O", style: AppFontStyle.text_56_800(AppColors.primary)),
          TextSpan(text: "Y", style: AppFontStyle.text_56_800(AppColors.white)),
          TextSpan(text: "E", style: AppFontStyle.text_56_800(AppColors.white)),
        ])),
      ),
    );
  }
}
