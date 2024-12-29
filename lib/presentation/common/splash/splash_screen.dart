import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/common/current_location/current_location.dart';
import 'package:woye_user/presentation/common/splash/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashScreen = SplashServices();
  final CurrentLocationController currentLocationController =
      Get.put(CurrentLocationController());

  @override
  void initState() {
    super.initState();
    currentLocationController.getCurrentPosition();
    splashScreen.isLogin();
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
