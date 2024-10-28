import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:woye_user/Presentation/Common/Home/home_screen.dart';
import 'package:woye_user/Presentation/Common/Sign_up_form/Sign_up_form_binding.dart';
import 'package:woye_user/Presentation/Common/Sign_up_form/sign_up_form_screen.dart';
import 'package:woye_user/Presentation/Common/otp/otp_binding.dart';
import 'package:woye_user/Presentation/Common/otp/otp_screen.dart';
import 'package:woye_user/Presentation/Grocery/Grocery_navbar/grocery_navbar.dart';
import 'package:woye_user/Presentation/Pharmacy/Pharmacy_navbar/pharmacy_navbar.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_categories/Restaurant_categories_screen/restaurant_categories_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Categories_details/restaurant_category_details.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Filter/restaurant_categories_filter.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Filter/restaurant_home_filter.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details_screen/Product_details_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details_screen/restaurant_details_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_wishlist/Sub_screens/Filter/restaurant_wishlist_filter.dart';
import 'package:woye_user/Presentation/Restaurants/Restaurants_navbar/Controller/restaurant_navbar_binding.dart';
import 'package:woye_user/Presentation/Restaurants/Restaurants_navbar/Restaurant_navbar_screen/restaurant_navbar.dart';
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
  static const String restaurantHomeFilter = "/restaurant_home_filter";
  static const String restaurantDetailsScreen = "/restaurant_details_screen";
  static const String productDetailsScreen = "/product_details_screen";
  static const String restaurantCategories = "/restaurant_categories";
  static const String restaurantCategoriesFilter =
      "/restaurant_categories_filter";
  static const String restaurantCategoriesDetails =
      "/restaurant_categories_details";
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
      name: pharmacyNavbar,
      page: () => const PharmacyNavbar(),
    ),
    GetPage(
      name: groceryNavbar,
      page: () => const GroceryNavbar(),
    ),
    GetPage(name: restaurantHomeFilter, page: () => RestaurantHomeFilter()),
    GetPage(
        name: restaurantDetailsScreen,
        page: () => const RestaurantDetailsScreen()),
    GetPage(
        name: productDetailsScreen, page: () => const ProductDetailsScreen()),
    GetPage(
        name: restaurantCategories,
        page: () => const RestaurantCategoriesScreen()),
    GetPage(
        name: restaurantCategoriesFilter,
        page: () => RestaurantCategoriesFilter()),
    GetPage(
        name: restaurantCategoriesFilter,
        page: () => RestaurantCategoriesFilter()),
    GetPage(
        name: restaurantCategoriesDetails,
        page: () => const RestaurantCategoryDetails()),
    GetPage(
        name: restaurantWishlistFilter,
        page: () => const RestaurantWishlistFilter()),
  ];
}
