import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:woye_user/Presentation/Common/Home/home_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Restaurants_navbar/restaurant_navbar.dart';
import 'package:woye_user/Presentation/Restaurants/Restaurants_navbar/restaurant_navbar_binding.dart';
import 'package:woye_user/presentation/Common/form_sign_up/form_sign_up_binding.dart';
import 'package:woye_user/presentation/Common/form_sign_up/form_sign_up_screen.dart';
import 'package:woye_user/presentation/Common/login/login_binding.dart';
import 'package:woye_user/presentation/Common/login/login_screen.dart';
import 'package:woye_user/presentation/Common/login_otp/login_otp_binding.dart';
import 'package:woye_user/presentation/Common/login_otp/login_otp_screen.dart';
import 'package:woye_user/presentation/Common/sign_up/sign_up_binding.dart';
import 'package:woye_user/presentation/Common/sign_up/sign_up_screen.dart';
import 'package:woye_user/presentation/Common/sign_up_otp/sign_up_otp_binding.dart';
import 'package:woye_user/presentation/Common/sign_up_otp/sign_up_otp_screen.dart';
import 'package:woye_user/presentation/Common/splash/splash_screen.dart';
import 'package:woye_user/presentation/Common/welcome/welcome_binding.dart';
import 'package:woye_user/presentation/Common/welcome/welcome_screen.dart';

class AppRoutes {
  static const String initalRoute = "/inital_route";
  static const String welcomeScreen = "/welcome_screen";
  static const String login = "/login_screen";
  static const String loginOtp = "/login_otp";
  static const String signUp = "/sign_up_screen";
  static const String signUpOtp = "/sign_up_otp_page";
  static const String formSignUp = "/form_sign_up";
  static const String restaurantNavbar = "/restaurant_navbar";

  static const String otpVerification = "/otp_verification";

  static const String homeScreen = "/home_screen";
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
        name: loginOtp,
        page: () => const LoginOtpScreen(),
        binding: LoginOtpBinding()),
    GetPage(
        name: signUp,
        page: () => const SignUpScreen(),
        binding: SignUpBinding()),
    GetPage(
        name: signUpOtp,
        page: () => const SignUpOtpScreen(),
        binding: SignUpOtpBinding()),
    GetPage(
        name: formSignUp,
        page: () => const FormSignUpScreen(),
        binding: FormSignUpBinding()),
    GetPage(
        name: restaurantNavbar,
        page: () => const RestaurantNavbar(),
        binding: RestaurantNavbarBinding()),
    GetPage(
        name: restaurantNavbar,
        page: () => const RestaurantNavbar(),
        binding: RestaurantNavbarBinding()),
    GetPage(
      name: homeScreen,
      page: () => const HomeScreen(),
      // binding: RestaurantNavbarBinding()
    ),
  ];
}
