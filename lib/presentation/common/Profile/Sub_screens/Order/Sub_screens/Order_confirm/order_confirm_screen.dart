import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Presentation/Restaurants/Restaurants_navbar/Controller/restaurant_navbar_controller.dart';

class OrderConfirmScreen extends StatelessWidget {
  const OrderConfirmScreen({super.key});

  static RestaurantNavbarController restaurantNavbarController =
      RestaurantNavbarController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Order Confirm",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/order-confirm.png",
              height: 250.h,
            ),
            hBox(30),
            Text(
              "Your order has been Placed",
              style: AppFontStyle.text_24_600(AppColors.darkText),
            ),
            hBox(20),
            Text(
              "Your items has been placcd and is on it's way to being processed",
              textAlign: TextAlign.center,
              style: AppFontStyle.text_14_400(AppColors.darkText),
            ),
            hBox(20),
            CustomElevatedButton(
                text: "Track Oder",
                onPressed: () {
                  Get.toNamed(AppRoutes.trackOrder);
                }),
            hBox(20),
            CustomOutlinedButton(
              onPressed: () async {
                await Get.offAllNamed(AppRoutes.restaurantNavbar);
              },
              child: const Text("Continue Shopping"),
            ),
          ],
        ),
      ),
    );
  }

  
}
