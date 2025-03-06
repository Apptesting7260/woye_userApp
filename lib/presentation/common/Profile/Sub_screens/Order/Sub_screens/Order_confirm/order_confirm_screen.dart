import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Presentation/Common/Home/home_controller.dart';
import 'package:woye_user/Presentation/Restaurants/Restaurants_navbar/Controller/restaurant_navbar_controller.dart';

class OrderConfirmScreen extends StatelessWidget {
  OrderConfirmScreen({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments;
    String cartType = arguments['type'];
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: CustomAppBar(
          isLeading: false,
          title: Text(
            "",
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
                  if (cartType == "restaurant") {
                    // await Get.offAllNamed(AppRoutes.restaurantNavbar);
                    homeController.getIndex(0);
                    homeController.navigate(0);
                  } else if (cartType == "pharmacy") {
                    homeController.getIndex(1);
                    homeController.navigate(1);
                    // await Get.offAllNamed(AppRoutes.pharmacyNavbar);
                  }
                },
                child: const Text("Continue Shopping"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
