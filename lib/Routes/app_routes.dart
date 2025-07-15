import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:flutter/material.dart';
import 'package:woye_user/Presentation/Common/Home/home_screen.dart';
import 'package:woye_user/Presentation/Common/Otp/controller/otp_binding.dart';
import 'package:woye_user/Presentation/Common/Otp/view/otp_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_cart/View/restaurant_cart_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Categories_details/restaurant_category_details.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_categories/View/restaurant_categories_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_home/Sub_screens/More_Products/more_products.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_wishlist/Sub_screens/Filter/restaurant_wishlist_filter.dart';
import 'package:woye_user/Presentation/Restaurants/Restaurants_navbar/Controller/restaurant_navbar_binding.dart';
import 'package:woye_user/Presentation/Restaurants/Restaurants_navbar/View/restaurant_navbar.dart';
import 'package:woye_user/presentation/Common/login/login_screen.dart';
import 'package:woye_user/presentation/Common/sign_up/sign_up_screen.dart';
import 'package:woye_user/presentation/Common/splash/splash_screen.dart';
import 'package:woye_user/presentation/Common/welcome/welcome_binding.dart';
import 'package:woye_user/presentation/Common/welcome/welcome_screen.dart';
import 'package:woye_user/presentation/Grocery/Grocery_navbar/view/grocery_navbar.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_categories/Sub_screens/Categories_details/grocery_category_details.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_categories/Sub_screens/Filter/grocery_categories_filter.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/Filter/grocery_home_filter.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/More_Products/grocery_more_products.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/Most_popular/grocery_most_popular.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/Checkout/pharmacy_checkout_screen.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/prescription/prescription_details_screen.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/prescription/prescription_upload_screen.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_categories/Sub_screens/Categories_details/view/pharmacy_category_details.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_categories/Sub_screens/Filter/pharmacy_categories_filter.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Filter/pharmacy_home_filter.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/More_Products/pharmacy_more_products.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Most_popular/pharmacy_most_popular.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Product_reviews/pharmacy_product_reviews.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Rate_vendor/pharmacy_rate_vendor_screen.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Vendor_review/pharmacy_vendor_review_screen.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_wishlist/sub_screens/Filter/pharmacy_wishlist_filter.dart';
import 'package:woye_user/presentation/Pharmacy/Pharmacy_navbar/view/pharmacy_navbar.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/View/restaurant_single_cart_screen.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Filter/controller/categoriesfilter_binding.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Filter/view/restaurant_categories_filter.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/view/restaurant_details_screen.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/search/view/restaurant_home_filter.dart';
import 'package:woye_user/presentation/common/Checkout_create-order/checkout_screen.dart';
import 'package:woye_user/presentation/common/Home/home_binding.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Delivery_address/Sub_screens/Add_address/add_address_screen.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Delivery_address/Sub_screens/Edit_address/edit_address_screen.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Delivery_address/view/delivery_address_screen.dart';
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
import 'package:woye_user/presentation/common/Update_profile/controller/Update_profile_binding.dart';
import 'package:woye_user/presentation/common/Update_profile/view/Update_profile_Screen.dart';
import 'package:woye_user/presentation/common/guest%20login/guest_binding.dart';

import '../Presentation/Restaurants/Restaurants_navbar/Controller/restaurant_navbar_controller.dart';
import '../presentation/Grocery/Pages/Grocery_cart/Checkout/grocery_checkout_screen.dart';
import '../presentation/Grocery/Pages/Grocery_home/Sub_screens/Vendor_details/grocery_shop_information.dart';
import '../presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Vendor_details/pharmacy_vendor_information_screen.dart';
import '../presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/view/restaurant_information_screen.dart';
import '../presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Reviews/product_reviews.dart';

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
  static const String restaurantCategoriesFilter = "/restaurant_categories_filter";
  static String restaurantCategoriesDetails = "/restaurant_categories_details";
  // static const String restaurantWishlistFilter = "/restaurant_Wishlist_filter";
  static const String productReviews = "/product_reviews";
  static const String moreProducts = "/more_products";
  static const String checkoutScreen = "/checkout_screen";
  static const String prescriptionScreen = "/Prescription_screen";
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
  static const String restaurantSingleCartScreen = "/restaurantSingleCartScreen";
  static const String restaurantCartScreen = "/restaurantCartScreen";

  // static const String editProfile = "/edit_profile";
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
  static const String rateAndReviewProductScreen ="/rateAndReviewProductScreen";
  static const String prescriptionsScreen ="/prescriptionsScreen";
  static const String restaurantInformationScreen ="/restaurantInformationScreen";

  ///`pharmacy=====================================================>`
  static const String pharmcayHomeFilter = "/pharmcayHomeFilter";
  static const String pharmacyCategoryDetails = "/pharmacyCategoryDetails";
  static const String pharmacyCategoryFilter = "/pharmacyCategoryFilter";
  static const String pharmacyWishlistFilter = "/pharmacyWishlistFilter";
  static const String pharmacyMoreProduct = "/pharmacyMoreProduct";
  static const String pharmacyMostPopular = "/pharmacyMostPopular";
  static const String pharmacyProductDetailsScreen = "/pharmacyProductDetailsScreen";
  static const String pharmacyProductReviews = "/pharmacyProductReviews";
  static const String pharmacyVendorDetails = "/pharmacyVendorDetails";
  static const String pharmacyVendorReview = "/pharmacyVendorReview";
  static const String pharmacyRateVendor = "/pharmacyRateVendor";
  // static const String pharmacyCheckout = "/pharmacyCheckout";
  static const String pharmacyVendorInformationScreen = "/pharmacyVendorInformationScreen";

  ///`grocery=====================================================>`
  static const String groceryHomeFilter = "/groceryHomeFilter";
  static const String groceryMostPopular = "/groceryMostPopular";
  static const String groceryMoreProducts = "/groceryMoreProducts";
  static const String groceryProductDetails = "/groceryProductDetails";
  static const String groceryVendorDetails = "/groceryVendorDetails";
  static const String groceryCategoryDetails = "/groceryCategoryDetails";
  static const String groceryCategoryFilter = "/groceryCategoryFilter";
  // static const String groceryCheckoutScreen = "/groceryCheckoutScreen";
  static const String groceryShopInformation = "/groceryShopInformation";

  static List<GetPage> pages = [
    GetPage(name: initalRoute, page: () => const SplashScreen(),),
    GetPage(name: restaurantCartScreen, page: () => const RestaurantBaseScaffold(child: RestaurantCartScreen()),),
    GetPage(name: welcomeScreen, page: () => WelcomeScreen(), binding: WelcomeBinding()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: login, page: () => LoginScreen(), binding: GuestBinding()),
    GetPage(name: otp, page: () => OtpScreen(), binding: OtpBinding()),
    GetPage(name: signUp, page: () => SignUpScreen()),
    GetPage(name: signUpFom, page: () => SignUpFormScreen(), binding: SignUpFormBinding()),
    GetPage(name: homeScreen, page: () => HomeScreen(), /*binding: RestaurantNavbarBinding()*/),
    GetPage(name: restaurantNavbar, page: () => RestaurantNavbar(navbarInitialIndex: 0,), bindings: [RestaurantNavbarBinding(), HomeBinding()]),
    GetPage(name: pharmacyNavbar, page: () => PharmacyNavbar(),),
    GetPage(name: groceryNavbar, page: () => GroceryNavbar(),),
    GetPage(name: restaurantHomeFilter, page: () => RestaurantHomeFilter()),
    GetPage(name: productReviews, page: () => RestaurantBaseScaffold(child: ProductReviews())),
    GetPage(name: moreProducts, page: () => RestaurantBaseScaffold(child: MoreProducts())),
    GetPage(name: checkoutScreen, page: () => CheckoutScreen()),
    GetPage(name: prescriptionScreen, page: () => RestaurantBaseScaffold(child: PrescriptionUploadScreen())),
    GetPage(name: addAddressScreen, page: () => RestaurantBaseScaffold(child: AddAddressScreen())),
    GetPage(name: editAddressScreen, page: () => RestaurantBaseScaffold(child: EditAddressScreen())),
    GetPage(name: promoCode, page: () => const PromoCodes()),
    GetPage(name: paymentMethod, page: () => PaymentMethodScreen()),
    GetPage(name: addCard, page: () => const RestaurantBaseScaffold(child: AddCardScreen())),
    GetPage(name: oderConfirm, page: () =>  RestaurantBaseScaffold(child: OrderConfirmScreen())),
    GetPage(name: trackOrder, page: () => RestaurantBaseScaffold(child: TrackOrderScreen())),
    GetPage(name: orderReveived, page: () => OrderReveivedScreen()),
    GetPage(name: reviewDriver, page: () => ReviewDriverScreen()),
    GetPage(name: orderOtp, page: () => const OrderOtpScreen()),
    // GetPage(name: editProfile, page: () => const EditProfileScreen()),
    GetPage(name: orders, page: () => RestaurantBaseScaffold(child: OrdersScreen())),
    GetPage(name: orderDetails, page: () =>  RestaurantBaseScaffold(child: OrderDetailsScreen())),
    GetPage(name: myWallet, page: () => RestaurantBaseScaffold(child: MyWalletScreen())),
    GetPage(name: inviteFriends, page: () => RestaurantBaseScaffold(child: InviteFriendsScreen())),
    GetPage(name: notifications, page: () => RestaurantBaseScaffold(child: NotificationsScreen())),
    GetPage(name: settings, page: () => const RestaurantBaseScaffold(child: SettingsScreen())),
    GetPage(name: help, page: () => const RestaurantBaseScaffold(child: HelpScreen())),
    GetPage(name: support, page: () => const RestaurantBaseScaffold(child: SupportScreen())),
    GetPage(name: faq, page: () => RestaurantBaseScaffold(child: FaqScreen())),
    GetPage(name: privayPolicy, page: () => const RestaurantBaseScaffold(child: PrivayPolicyScreen())),
    GetPage(name: termsAndConditions, page: () => const RestaurantBaseScaffold(child: TermAndConditionsScreen())),
    GetPage(name: notificationsSettings, page: () =>  const RestaurantBaseScaffold(child: NotificationsSettingsScreen())),
    GetPage(name: transactionHistory, page: () => const RestaurantBaseScaffold(child: TransactionHistoryScreen())),
    GetPage(name: myWalletFilter, page: () => const MyWalletFilter()),
    GetPage(name: deliveryAddressScreen, page: () => RestaurantBaseScaffold(child: DeliveryAddressScreen())),
    GetPage(name: restaurantCategories, page: () => RestaurantBaseScaffold(child: RestaurantCategoriesScreen())),
    // GetPage(name: restaurantCategoriesFilter,page: () => RestaurantCategoriesFilter()),
    GetPage(name: restaurantCategoriesFilter, page: () => const RestaurantCategoriesFilter(), binding: CategoriesFilterBinding()),
    GetPage(name: restaurantCategoriesDetails, page: () => RestaurantBaseScaffold(child: RestaurantCategoryDetails())),
    // GetPage( name: restaurantWishlistFilter, page: () => const RestaurantWishlistFilter()),
    GetPage(name: rateAndReviewProductScreen, page: () => RestaurantBaseScaffold(child: RateAndReviewProductScreen())),
    GetPage(name: prescriptionsScreen, page: () => const PrescriptionsScreen()),
    GetPage(name: restaurantInformationScreen, page: () => const RestaurantBaseScaffold(child: RestaurantInformationScreen())),
    // GetPage(name: restaurantSingleCartScreen, page: () => RestaurantSingleCartScreen()),

    ///`pharmacy=====================================================>`
    GetPage(name: pharmcayHomeFilter, page: () => PharmacyHomeFilter()),
    GetPage(name: pharmacyCategoryDetails, page: () => RestaurantBaseScaffold(child: PharmacyCategoryDetails())),
    GetPage(name: pharmacyCategoryFilter, page: () => const PharmacyCategoriesFilter()),
    GetPage(name: pharmacyWishlistFilter, page: () => PharmacyWishlistFilter()),
    GetPage(name: pharmacyMoreProduct, page: () => const RestaurantBaseScaffold(child: PharmacyMoreProducts())),
    GetPage(name: pharmacyMostPopular, page: () => const RestaurantBaseScaffold(child: PharmacyMostPopular())),
    GetPage(name: pharmacyProductReviews, page: () => const RestaurantBaseScaffold(child: PharmacyProductReviews())),
    GetPage(name: pharmacyVendorReview, page: () => const RestaurantBaseScaffold(child: PharmacyVendorReviewScreen())),
    GetPage(name: pharmacyRateVendor, page: () => const RestaurantBaseScaffold(child: PharmacyRateVendorScreen())),
    GetPage(name: pharmacyVendorInformationScreen, page: () => const RestaurantBaseScaffold(child: PharmacyVendorInformationScreen())),
    // GetPage(name: pharmacyCheckout, page: () => const PharmacyCheckoutScreen()),
    // GetPage(name: pharmacyVendorDetails, page: () => PharmacyVendorDetailsScreen()),
    // GetPage( name: pharmacyProductDetailsScreen, page: () => PharmacyProductDetailsScreen()),

    ///`pharmacy=====================================================>`
    GetPage(name: groceryHomeFilter, page: () => GroceryHomeFilter()),
    GetPage(name: groceryMostPopular, page: () => const RestaurantBaseScaffold(child: GroceryMostPopular())),
    GetPage(name: groceryMoreProducts, page: () => const RestaurantBaseScaffold(child: GroceryMoreProducts())),
    GetPage(name: groceryCategoryDetails, page: () => RestaurantBaseScaffold(child: GroceryCategoryDetails())),
    // GetPage(name: groceryProductDetails, page: () => GroceryProductDetailsScreen()),
    GetPage(name: groceryCategoryFilter,page: () =>  const RestaurantBaseScaffold(child: GroceryCategoriesFilter())),
    // GetPage(name: groceryCheckoutScreen,page: () =>  GroceryCheckoutScreen()),
    GetPage(name: groceryShopInformation,page: () =>  RestaurantBaseScaffold(child: GroceryShopInformation())),
    GetPage(name: groceryShopInformation,page: () =>  RestaurantBaseScaffold(child: GroceryShopInformation())),

  ];
}

class RestaurantBaseScaffold extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  const RestaurantBaseScaffold({
    super.key,
    required this.child,
    this.currentIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    final RestaurantNavbarController navbarController =
    Get.find<RestaurantNavbarController>();

    return Scaffold(
      body: Stack(
        children: [
          child,
          if (MediaQuery.of(context).viewInsets.bottom == 0.0)
            Align(
              alignment: Alignment.bottomCenter,
              child: RestaurantNavbar().navbar(navbarController),
            ),
        ],
      ),
    );
  }
}


