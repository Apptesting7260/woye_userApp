import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:woye_user/Presentation/Common/Home/home_screen.dart';
import 'package:woye_user/Presentation/Common/Otp/controller/otp_binding.dart';
import 'package:woye_user/Presentation/Common/Otp/view/otp_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Categories_details/restaurant_category_details.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_categories/View/restaurant_categories_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Filter/restaurant_home_filter.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_home/Sub_screens/More_Products/more_products.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_reviews/product_reviews.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_wishlist/Sub_screens/Filter/restaurant_wishlist_filter.dart';
import 'package:woye_user/Presentation/Restaurants/Restaurants_navbar/Controller/restaurant_navbar_binding.dart';
import 'package:woye_user/Presentation/Restaurants/Restaurants_navbar/View/restaurant_navbar.dart';
import 'package:woye_user/presentation/Common/login/login_screen.dart';
import 'package:woye_user/presentation/Common/sign_up/sign_up_screen.dart';
import 'package:woye_user/presentation/Common/splash/splash_screen.dart';
import 'package:woye_user/presentation/Common/welcome/welcome_binding.dart';
import 'package:woye_user/presentation/Common/welcome/welcome_screen.dart';
import 'package:woye_user/presentation/Grocery/Grocery_navbar/view/grocery_navbar.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/Filter/grocery_home_filter.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/More_Products/grocery_more_products.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/Most_popular/grocery_most_popular.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/Checkout/pharmacy_checkout_screen.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_categories/Sub_screens/Categories_details/pharmacy_category_details.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_categories/Sub_screens/Filter/pharmacy_categories_filter.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Filter/pharmacy_home_filter.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/More_Products/pharmacy_more_products.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Most_popular/pharmacy_most_popular.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Product_reviews/pharmacy_product_reviews.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Rate_vendor/pharmacy_rate_vendor_screen.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Vendor_review/pharmacy_vendor_review_screen.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_wishlist/sub_screens/Filter/pharmacy_wishlist_filter.dart';
import 'package:woye_user/presentation/Pharmacy/Pharmacy_navbar/view/pharmacy_navbar.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/Checkout/checkout_screen.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Filter/view/restaurant_categories_filter.dart';
import 'package:woye_user/presentation/common/Home/home_binding.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Delivery_address/Sub_screens/Add_address/add_address_screen.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Delivery_address/Sub_screens/Edit_address/edit_address_screen.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Delivery_address/view/delivery_address_screen.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Edit_profile/edit_profile_screen.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Invite_friends/invite_friends_screen.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/My_wallet/Sub_screens/Filter/my_wallet_filter.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/My_wallet/Sub_screens/Transaction_history/transaction_history_screen.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/My_wallet/View/my_wallet_screen.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Notifications/notifications_screen.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/Sub_screens/Order_confirm/order_confirm_screen.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/Sub_screens/Order_details/order_details_screen.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/Sub_screens/Order_otp/order_otp_screen.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/Sub_screens/Order_received/order_reveived_screen.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/Sub_screens/Rate_and_review_product/rate_and_review_product_screen.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/Sub_screens/Review_driver/review_driver_screen.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/Sub_screens/Track_order/track_order_screen.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/view/orders_screen.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Payment_method/Add_card/add_card_screen.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Payment_method/View/payment_method_screen.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Promo_codes/promo_codes.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Settings/Sub_screens/Notifications_settings/notifications_settings_screen.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Settings/view/settings_screen.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/help/sub_screens/faq/faq_screen.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/help/sub_screens/privacy_policy/privay_policy_screen.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/help/sub_screens/support/support_screen.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/help/sub_screens/term_and_conditions/term_and_conditions_screen.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/help/view/help_screen.dart';
import 'package:woye_user/presentation/common/Sign_up_form_editProfile/controller/Sign_up_form_binding.dart';
import 'package:woye_user/presentation/common/Sign_up_form_editProfile/view/sign_up_form_screen.dart';
import 'package:woye_user/presentation/common/guest%20login/guest_binding.dart';

class AppRoutes {
  ///`common=====================================================>`

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

  ///`restaurant=====================================================>`

  static const String restaurantHomeFilter = "/restaurant_home_filter";
  static const String restaurantDetailsScreen = "/restaurant_details_screen";
  static const String productDetailsScreen = "/product_details_screen";
  static const String restaurantCategories = "/restaurant_categories";
  static const String restaurantCategoriesFilter =
      "/restaurant_categories_filter";
  static String restaurantCategoriesDetails = "/restaurant_categories_details";
  static const String restaurantWishlistFilter = "/restaurant_Wishlist_filter";
  static const String productReviews = "/product_reviews";
  static const String moreProducts = "/more_products";
  static const String checkoutScreen = "/checkout_screen";
  static const String deliveryAddressScreen = "/delivery_ddress_screen";
  static const String addAddressScreen = "/add_address";
  static const String editAddressScreen = "/edit_address";
  static const String promoCode = "/promo_code";
  static const String paymentMethod = "/payment_method";
  static const String addCard = "/add_card";
  static const String oderConfirm = "/order_confirm";
  static const String trackOrder = "/track_order";
  static const String orderReveived = "/order_reveived";
  static const String reviewDriver = "/review_driver";
  static const String orderOtp = "/order_otp";
  static const String editProfile = "/edit_profile";
  static const String orders = "/orders";
  static const String orderDetails = "/order_details";
  static const String myWallet = "/my_wallet";
  static const String transactionHistory = "/transaction_history";
  static const String myWalletFilter = "/my_wallet_filter";
  static const String inviteFriends = "/invite_friends";
  static const String notifications = "/notifications";
  static const String settings = "/settings";
  static const String notificationsSettings = "/notifications_settings";
  static const String help = "/help";
  static const String faq = "/faq";
  static const String support = "/support";
  static const String privayPolicy = "/privacyPolicy";
  static const String termsAndConditions = "/termAndConditions";
  static const String rateAndReviewProductScreen =
      "/rateAndReviewProductScreen";

  ///`pharmacy=====================================================>`
  static const String pharmcayHomeFilter = "/pharmcayHomeFilter";
  static const String pharmacyCategoryDetails = "/pharmacyCategoryDetails";
  static const String pharmacyCategoryFilter = "/pharmacyCategoryFilter";
  static const String pharmacyWishlistFilter = "/pharmacyWishlistFilter";
  static const String pharmacyMoreProduct = "/pharmacyMoreProduct";
  static const String pharmacyMostPopular = "/pharmacyMostPopular";
  static const String pharmacyProductDetailsScreen =
      "/pharmacyProductDetailsScreen";
  static const String pharmacyProductReviews = "/pharmacyProductReviews";
  static const String pharmacyVendorDetails = "/pharmacyVendorDetails";
  static const String pharmacyVendorReview = "/pharmacyVendorReview";
  static const String pharmacyRateVendor = "/pharmacyRateVendor";
  static const String pharmacyCheckout = "/pharmacyCheckout";

  ///`grocery=====================================================>`
  static const String groceryHomeFilter = "/groceryHomeFilter";
  static const String groceryMostPopular = "/groceryMostPopular";
  static const String groceryMoreProducts = "/groceryMoreProducts";
  static const String groceryProductDetails = "/groceryProductDetails";
  static const String groceryVendorDetails = "/groceryVendorDetails";

  static List<GetPage> pages = [
    GetPage(
      name: initalRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
        name: welcomeScreen,
        page: () => WelcomeScreen(),
        binding: WelcomeBinding()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: login, page: () => LoginScreen(), binding: GuestBinding()),
    GetPage(name: otp, page: () => OtpScreen(), binding: OtpBinding()),
    GetPage(name: signUp, page: () => SignUpScreen()),
    GetPage(
        name: signUpFom,
        page: () => const SignUpFormScreen(),
        binding: SignUpFormBinding()),
    GetPage(
      name: homeScreen,
      page: () => HomeScreen(),
      // binding: RestaurantNavbarBinding()
    ),
    GetPage(
        name: restaurantNavbar,
        page: () => RestaurantNavbar(
              navbarInitialIndex: 0,
            ),
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
    GetPage(name: productReviews, page: () => const ProductReviews()),
    GetPage(name: moreProducts, page: () => const MoreProducts()),
    GetPage(name: checkoutScreen, page: () => const CheckoutScreen()),
    GetPage(name: addAddressScreen, page: () => const AddAddressScreen()),
    GetPage(name: editAddressScreen, page: () => const EditAddressScreen()),
    GetPage(name: promoCode, page: () => const PromoCodes()),
    GetPage(name: paymentMethod, page: () => const PaymentMethodScreen()),
    GetPage(name: addCard, page: () => const AddCardScreen()),
    GetPage(name: oderConfirm, page: () => const OrderConfirmScreen()),
    GetPage(name: trackOrder, page: () => const TrackOrderScreen()),
    GetPage(name: orderReveived, page: () => const OrderReveivedScreen()),
    GetPage(name: reviewDriver, page: () => const ReviewDriverScreen()),
    GetPage(name: orderOtp, page: () => const OrderOtpScreen()),
    GetPage(name: editProfile, page: () => const EditProfileScreen()),
    GetPage(name: orders, page: () => const OrdersScreen()),
    GetPage(name: orderDetails, page: () => const OrderDetailsScreen()),
    GetPage(name: myWallet, page: () => const MyWalletScreen()),
    GetPage(name: inviteFriends, page: () => const InviteFriendsScreen()),
    GetPage(name: notifications, page: () => const NotificationsScreen()),
    GetPage(name: settings, page: () => const SettingsScreen()),
    GetPage(name: help, page: () => const HelpScreen()),
    GetPage(name: support, page: () => const SupportScreen()),
    GetPage(name: faq, page: () => const FaqScreen()),
    GetPage(name: privayPolicy, page: () => const PrivayPolicyScreen()),
    GetPage(
        name: termsAndConditions, page: () => const TermAndConditionsScreen()),
    GetPage(
        name: notificationsSettings,
        page: () => const NotificationsSettingsScreen()),
    GetPage(
        name: transactionHistory, page: () => const TransactionHistoryScreen()),
    GetPage(name: myWalletFilter, page: () => const MyWalletFilter()),
    GetPage(
        name: deliveryAddressScreen, page: () => const DeliveryAddressScreen()),
    GetPage(
        name: restaurantCategories, page: () => RestaurantCategoriesScreen()),
    // GetPage(
    //     name: restaurantCategoriesFilter,
    //     page: () => RestaurantCategoriesFilter()),
    GetPage(
        name: restaurantCategoriesFilter,
        page: () => RestaurantCategoriesFilter()),
    GetPage(
        name: restaurantCategoriesDetails,
        page: () => RestaurantCategoryDetails()),
    GetPage(
        name: restaurantWishlistFilter,
        page: () => const RestaurantWishlistFilter()),
    GetPage(
        name: rateAndReviewProductScreen,
        page: () => const RateAndReviewProductScreen()),

    ///`pharmacy=====================================================>`
    GetPage(name: pharmcayHomeFilter, page: () => PharmacyHomeFilter()),
    GetPage(
        name: pharmacyCategoryDetails, page: () => PharmacyCategoryDetails()),
    GetPage(
        name: pharmacyCategoryFilter, page: () => PharmacyCategoriesFilter()),
    GetPage(name: pharmacyWishlistFilter, page: () => PharmacyWishlistFilter()),
    GetPage(
        name: pharmacyMoreProduct, page: () => const PharmacyMoreProducts()),
    GetPage(name: pharmacyMostPopular, page: () => const PharmacyMostPopular()),
    GetPage(
        name: pharmacyProductReviews,
        page: () => const PharmacyProductReviews()),
    GetPage(
        name: pharmacyVendorReview,
        page: () => const PharmacyVendorReviewScreen()),
    GetPage(
        name: pharmacyRateVendor, page: () => const PharmacyRateVendorScreen()),
    GetPage(name: pharmacyCheckout, page: () => const PharmacyCheckoutScreen()),

    // GetPage(
    //     name: pharmacyVendorDetails, page: () => PharmacyVendorDetailsScreen()),
    // GetPage(
    //     name: pharmacyProductDetailsScreen,
    //     page: () => PharmacyProductDetailsScreen()),

    ///`pharmacy=====================================================>`
    GetPage(name: groceryHomeFilter, page: () => GroceryHomeFilter()),
    GetPage(name: groceryMostPopular, page: () => GroceryMostPopular()),
    GetPage(name: groceryMoreProducts, page: () => GroceryMoreProducts()),
    // GetPage(
    //     name: groceryVendorDetails, page: () => GroceryVendorDetailsScreen()),
    // GetPage(
    //     name: groceryProductDetails, page: () => GroceryProductDetailsScreen()),
  ];
}
