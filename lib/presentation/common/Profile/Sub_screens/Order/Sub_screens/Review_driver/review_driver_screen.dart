import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/common/Home/home_controller.dart';

import '../../../../../../../shared/theme/font_family.dart';
import '../../../../../../Restaurants/Restaurants_navbar/Controller/restaurant_navbar_controller.dart';

class ReviewDriverScreen extends StatelessWidget {
  ReviewDriverScreen({super.key});

  final HomeController homeController = HomeController();
  final RestaurantNavbarController restaurantNavbarController =RestaurantNavbarController();
  var ratingg = 0.0.obs;

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments ?? {};
    String cartType = arguments['type'] ?? "";
    String screenType = arguments['screenType'] ?? "";
    print("sdgf >> $cartType  >>  $screenType ");
    return Scaffold(
      appBar: const CustomAppBar(
        isLeading: true,
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            profile(),
            hBox(30),
            ratings(),
            hBox(30),
            review(),
            hBox(15),
            submitButton(cartType,screenType)
          ],
        ),
      ),
    );
  }

  Widget profile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 50.r,
          child: Image.asset("assets/images/profile-image.png"),
        ),
        hBox(15),
        Text(
          "David Ronney",
          textAlign: TextAlign.center,
          style: AppFontStyle.text_20_400(AppColors.darkText,family: AppFontFamily.gilroySemiBold),
        ),
      ],
    );
  }

  Widget ratings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What is your rate?",
          textAlign: TextAlign.center,
          style: AppFontStyle.text_16_400(AppColors.darkText,family: AppFontFamily.gilroySemiBold),
        ),
        hBox(10),
        // Row(
        //   children: [
        //     SvgPicture.asset(
        //       "assets/svg/star-white.svg",
        //       height: 28.h,
        //     ),
        //     wBox(5),
        //     SvgPicture.asset(
        //       "assets/svg/star-white.svg",
        //       height: 28.h,
        //     ),
        //     wBox(5),
        //     SvgPicture.asset(
        //       "assets/svg/star-white.svg",
        //       height: 28.h,
        //     ),
        //     wBox(5),
        //     SvgPicture.asset(
        //       "assets/svg/star-white.svg",
        //       height: 28.h,
        //     ),
        //     wBox(5),
        //     SvgPicture.asset(
        //       "assets/svg/star-white.svg",
        //       height: 28.h,
        //     ),
        //   ],
        // ),
        RatingBar(
          itemPadding: EdgeInsets.only(right: 10.w),
          itemSize: 36,
          initialRating: ratingg.value,
          allowHalfRating: false,
          ratingWidget: RatingWidget(
            full: Icon(Icons.star, color: AppColors.goldStar),
            half: Icon(Icons.star_half, color: AppColors.goldStar),
            empty: Icon(Icons.star_border, color: AppColors.normalStar),
          ),
          onRatingUpdate: (rating) {
            print('Rating updated: $rating');
            ratingg.value = rating;
          },
        ),
      ],
    );
  }

  Widget review() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "How was your experience ?",
          textAlign: TextAlign.center,
          style: AppFontStyle.text_16_400(AppColors.darkText,family: AppFontFamily.gilroySemiBold),
        ),
        hBox(10),
        TextFormField(
          style: AppFontStyle.text_14_400(AppColors.darkText),
          // expands: true,
          maxLines: 10,
          minLines: 7,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(16.r),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.textFieldBorder),
                borderRadius: BorderRadius.circular(15.r)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.textFieldBorder),
                borderRadius: BorderRadius.circular(15.r)),
            hintText: "Write your review...",
            hintStyle: AppFontStyle.text_14_400(
              AppColors.lightText,family: AppFontFamily.gilroySemiBold,
            ),
          ),
        ),
      ],
    );
  }

  Widget submitButton(cartType,screenType) {
    return CustomElevatedButton(
    fontFamily: AppFontFamily.gilroySemiBold,
        text: "Submit",
        onPressed: () async {
          if (cartType == "restaurant" || screenType == 'restaurantProfileScreen') {
            // await Get.offAllNamed(AppRoutes.restaurantNavbar);
            restaurantNavbarController.getIndexMainButton(0);
            //homeController.navigate(0);
          } else if (cartType == "pharmacy" || screenType == "pharmacyProfileScreen") {
            restaurantNavbarController.getIndexMainButton(1);
            //homeController.navigate(1);
            //await Get.offAllNamed(AppRoutes.pharmacyNavbar);
          }else if(cartType == "grocery" || screenType == "groceryProfileScreen") {
            restaurantNavbarController.getIndexMainButton(2);
            //homeController.navigate(2);
            // homeController.mainButtonIndex.value = 0;
          }else if(screenType == "notificationScreen"|| screenType == "") {
           Get.back();
          }
        });
  }
}
