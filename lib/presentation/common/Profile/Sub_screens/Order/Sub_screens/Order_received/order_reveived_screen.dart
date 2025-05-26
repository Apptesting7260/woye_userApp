import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Presentation/Restaurants/Restaurants_navbar/Controller/restaurant_navbar_controller.dart';

import '../../../../../../../shared/theme/font_family.dart';
import '../../../../../Home/home_controller.dart';

class OrderReveivedScreen extends StatelessWidget {
  OrderReveivedScreen({super.key});

  static RestaurantNavbarController restaurantNavbarController =RestaurantNavbarController();

 final HomeController homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments ?? {};
    String cartType = arguments['type'] ?? "";
    String screenType = arguments['screenType'] ?? "";
    print("sdgf >> $cartType  >>  $screenType ");

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: CustomAppBar(
          // isLeading: false,
          leadingOnTap: () {},
          title: Text(
            "Order Received",
            style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
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
                style: AppFontStyle.text_24_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
              ),
              hBox(20),
              Text(
                "Thank you for purchasing products from our store. Wishing you a nice day.",
                maxLines: 4,
                textAlign: TextAlign.center,
                style: AppFontStyle.text_14_400(AppColors.darkText,family: AppFontFamily.gilroyRegular),
              ),
              hBox(20),
              CustomElevatedButton(
                  fontFamily: AppFontFamily.gilroyMedium,
                  text: "Continue shopping",
                  onPressed: () async {
                    if (cartType == "restaurant" || screenType == "restaurantProfileScreen") {
                      // await Get.offAllNamed(AppRoutes.restaurantNavbar);
                      homeController.getIndex(0);
                      homeController.navigate(0);
                    } else if (cartType == "pharmacy" || screenType == 'pharmacyProfileScreen') {
                      homeController.getIndex(1);
                      homeController.navigate(1);
                      //await Get.offAllNamed(AppRoutes.pharmacyNavbar);
                    }else if(cartType == "grocery" || screenType == "groceryProfileScreen"){
                      homeController.getIndex(2);
                      homeController.navigate(2);
                    } if(screenType == "notificationScreen") {
                      Get.back();
                    }
                    // await Get.offAllNamed(AppRoutes.restaurantNavbar);
                  }),
              hBox(20),
              CustomOutlinedButton(
                onPressed: () {
                  Get.offNamed(AppRoutes.reviewDriver,
                      arguments: {'type': cartType,'screenType':screenType}
                  );
                },
                child: Text("Review This Driver",style:  AppFontStyle.text_15_400(AppColors.primary,family: AppFontFamily.gilroyMedium),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget confirmPic(){
  //   return  ;
  // }
}
