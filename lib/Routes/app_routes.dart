import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:woye_user/presentation/common/login/login_binding.dart';
import 'package:woye_user/presentation/common/login/login_screen.dart';
import 'package:woye_user/presentation/common/otp_verification/otp_verificaiton_screen.dart';
import 'package:woye_user/presentation/common/otp_verification/otp_verification_binding.dart';
import 'package:woye_user/presentation/common/splash/splash_screen.dart';
import 'package:woye_user/presentation/common/welcome/welcome_binding.dart';
import 'package:woye_user/presentation/common/welcome/welcome_screen.dart';

class AppRoutes {
  static const String initalRoute = "/inital_route";
  static const String welcomeScreen = "/welcome_screen";
  static const String login = "/login_screen";
  static const String otpVerification = "/otp_verification";

  // static const String signUp = "/signUp_page";
  // static const String navbar = "/nav_bar";
  // static const String homeScreen = "/home_screen";
  // static const String customerSupport = "/customer_support";
  // static const String profilePage = "/profile_page";
  // static const String myAccount = "/my_account";
  // static const String termsAndConditions = "/term_and_conditions";
  // static const String privacyPolicy = "/privacy_policy";

  static List<GetPage> pages = [
    GetPage(
      name: initalRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
        name: welcomeScreen,
        page: () => const WelcomeScreen(),
        binding: WelcomeBinding()),
    GetPage(
        name: login, page: () => const LoginScreen(), binding: LoginBinding()),
    GetPage(
        name: otpVerification,
        page: () => const OtpVerificaitonScreen(),
        binding: OtpVerificationBinding()),
  ];
}
