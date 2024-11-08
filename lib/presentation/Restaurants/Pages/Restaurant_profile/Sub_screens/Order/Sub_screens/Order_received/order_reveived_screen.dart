import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Presentation/Restaurants/Restaurants_navbar/Controller/restaurant_navbar_controller.dart';

class OrderReveivedScreen extends StatelessWidget {
  const OrderReveivedScreen({super.key});

  static RestaurantNavbarController restaurantNavbarController =
      RestaurantNavbarController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Order Received",
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
              "Order Received",
              style: AppFontStyle.text_24_600(AppColors.darkText),
            ),
            hBox(20),
            Text(
              "Thank you for purchasing products from our store.Wishing you a nice day.",
              textAlign: TextAlign.center,
              style: AppFontStyle.text_14_400(AppColors.darkText),
            ),
            hBox(20),
            CustomElevatedButton(
                text: "Continue shopping",
                onPressed: () async {
                  await Get.offAllNamed(AppRoutes.restaurantNavbar);
                }),
            hBox(20),
            CustomOutlinedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.reviewDriver);
              },
              child: const Text("Review This Driver"),
            ),
          ],
        ),
      ),
    );
  }

  // Widget confirmPic(){
  //   return  ;
  // }
}
