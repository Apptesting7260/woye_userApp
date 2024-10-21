import 'package:woye_user/Routes/app_routes.dart';
import 'package:woye_user/core/utils/app_export.dart';

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

    Future.delayed(const Duration(seconds: 2), () {
      // if (responseToken == null) {
      //   Get.toNamed(AppRoutes.login);
      // }
      // if (responseToken != null && !isRegister!) {
      //   Get.toNamed(AppRoutes.login);
      // }
      // if (responseToken != null && isRegister!) {
      //   Get.toNamed(AppRoutes.navbar);
      // }
      // Get.Of(AppRoutes.welcomeScreen);
      Get.offAllNamed(AppRoutes.welcomeScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkText,
      body: Center(
        child: SvgPicture.asset(
          ImageConstants.splashLogo,
          height: 42.h,
        ),
      ),
    );
  }
}
