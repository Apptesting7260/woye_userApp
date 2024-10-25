import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:woye_user/Presentation/Common/Home/home_screen.dart';
import 'package:woye_user/Presentation/Common/Sign_up_form/Sign_up_form_binding.dart';
import 'package:woye_user/Presentation/Common/Sign_up_form/sign_up_form_screen.dart';
import 'package:woye_user/Presentation/Common/otp/otp_binding.dart';
import 'package:woye_user/Presentation/Common/otp/otp_screen.dart';
import 'package:woye_user/Presentation/Grocery/Grocery_navbar/grocery_navbar.dart';
import 'package:woye_user/Presentation/Pharmacy/Pharmacy_navbar/pharmacy_navbar.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_categories/restaurant_categories_filter.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_wishlist/restaurant_wishlist_filter_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Restaurants_navbar/restaurant_navbar.dart';
import 'package:woye_user/Presentation/Restaurants/Restaurants_navbar/restaurant_navbar_binding.dart';
import 'package:woye_user/presentation/Common/login/login_binding.dart';
import 'package:woye_user/presentation/Common/login/login_screen.dart';
import 'package:woye_user/presentation/Common/sign_up/sign_up_binding.dart';
import 'package:woye_user/presentation/Common/sign_up/sign_up_screen.dart';
import 'package:woye_user/presentation/Common/splash/splash_screen.dart';
import 'package:woye_user/presentation/Common/welcome/welcome_binding.dart';
import 'package:woye_user/presentation/Common/welcome/welcome_screen.dart';
import 'package:woye_user/presentation/common/Home/home_binding.dart';

class AppRoutes {
  static const String initalRoute = "/inital_route";
  static const String welcomeScreen = "/welcome_screen";
  static const String login = "/login_screen";
  static const String otp = "/otp";
  static const String signUp = "/sign_up_screen";
  static const String signUpFom = "/sign_up_form";
  static const String restaurantNavbar = "/restaurant_navbar";
  static const String pharmacyNavbar = "/pharmacy_navbar";
  static const String groceryNavbar = "/grocery_navbar";
  static const String otpVerification = "/otp_verification";
  static const String homeScreen = "/home_screen";
  static const String restaurantCategoriesFilter =
      "/restaurant_categories_filter";
  static const String restaurantWishlistFilter = "/restaurant_Wishlist_filter";

  static List<GetPage> pages = [
    GetPage(
      name: initalRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
        name: welcomeScreen,
        page: () => WelcomeScreen(),
        binding: WelcomeBinding()),
    GetPage(
        name: login, page: () => const LoginScreen(), binding: LoginBinding()),
    GetPage(name: otp, page: () => OtpScreen(), binding: OtpBinding()),
    GetPage(name: signUp, page: () => SignUpScreen(), binding: SignUpBinding()),
    GetPage(
        name: signUpFom,
        page: () => const SignUpFormScreen(),
        binding: SignUpFormBinding()),
    GetPage(
      name: homeScreen,
      page: () => const HomeScreen(),
      // binding: RestaurantNavbarBinding()
    ),
    GetPage(
        name: restaurantNavbar,
        page: () => const RestaurantNavbar(),
        bindings: [RestaurantNavbarBinding(), HomeBinding()]),
    GetPage(
        name: restaurantNavbar,
        page: () => const RestaurantNavbar(),
        binding: RestaurantNavbarBinding()),
    GetPage(
      name: pharmacyNavbar,
      page: () => const PharmacyNavbar(),
    ),
    GetPage(
      name: groceryNavbar,
      page: () => const GroceryNavbar(),
    ),
    GetPage(
        name: restaurantCategoriesFilter,
        page: () => const RestaurantCategoriesFilter()),
    GetPage(
        name: restaurantWishlistFilter,
        page: () => const RestaurantWishlistFilter()),
  ];
}
