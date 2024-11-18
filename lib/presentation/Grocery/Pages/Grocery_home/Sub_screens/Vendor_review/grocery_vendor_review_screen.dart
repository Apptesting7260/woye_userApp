import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Product_reviews/pharmacy_product_reviews.dart';

class GroceryVendorReviewScreen extends StatefulWidget {
  const GroceryVendorReviewScreen({super.key});

  @override
  State<GroceryVendorReviewScreen> createState() =>
      _PharmacyVendorReviewScreenState();
}

class _PharmacyVendorReviewScreenState extends State<GroceryVendorReviewScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animationController.animateTo(0.5);
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Reviews",
          style: AppFontStyle.text_20_600(AppColors.darkText),
        ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            hBox(20),
            ratings(),
            hBox(20),
            reviewButton(),
            hBox(30),
            shopReviews(),
            hBox(50),
          ],
        ),
      ),
    );
  }

  Widget ratings() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              Text(
                "4.5",
                style:
                    AppFontStyle.text_40_600(AppColors.darkText, height: 1.0),
              ),
              Text(
                "Rating",
                style: AppFontStyle.text_14_400(AppColors.darkText),
              ),
            ],
          ),
        ),
        Expanded(
            flex: 7,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  IgnorePointer(
                    child: RatingBar(
                        itemSize: 14.h,
                        initialRating: 5,
                        allowHalfRating: false,
                        ratingWidget: RatingWidget(
                            full:
                                SvgPicture.asset("assets/svg/star-yellow.svg"),
                            half: SvgPicture.asset("assets/svg/star-white.svg"),
                            empty:
                                SvgPicture.asset("assets/svg/star-white.svg")),
                        onRatingUpdate: (v) {}),
                  ),
                  LinearPercentIndicator(
                    width: 120.0,
                    lineHeight: 4.0,
                    percent: 0.8,
                    backgroundColor: AppColors.greyBackground,
                    progressColor: Colors.yellow,
                  ),
                  Text(
                    "85.5%",
                    style: AppFontStyle.text_14_400(AppColors.darkText),
                  )
                ],
              ),
              hBox(5),
              Row(
                children: [
                  IgnorePointer(
                    child: RatingBar(
                        itemSize: 14.h,
                        initialRating: 4,
                        allowHalfRating: false,
                        ratingWidget: RatingWidget(
                            full:
                                SvgPicture.asset("assets/svg/star-yellow.svg"),
                            half: SvgPicture.asset("assets/svg/star-white.svg"),
                            empty:
                                SvgPicture.asset("assets/svg/star-white.svg")),
                        onRatingUpdate: (v) {}),
                  ),
                  LinearPercentIndicator(
                    width: 120.0.w,
                    lineHeight: 4.0.h,
                    percent: 0.75,
                    backgroundColor: AppColors.greyBackground,
                    progressColor: Colors.yellow,
                  ),
                  Text(
                    "7.5%",
                    style: AppFontStyle.text_14_400(AppColors.darkText),
                  )
                ],
              ),
              hBox(5),
              Row(
                children: [
                  IgnorePointer(
                    child: RatingBar(
                        itemSize: 14.h,
                        initialRating: 3,
                        allowHalfRating: false,
                        ratingWidget: RatingWidget(
                            full:
                                SvgPicture.asset("assets/svg/star-yellow.svg"),
                            half: SvgPicture.asset("assets/svg/star-white.svg"),
                            empty:
                                SvgPicture.asset("assets/svg/star-white.svg")),
                        onRatingUpdate: (v) {}),
                  ),
                  LinearPercentIndicator(
                    width: 120.0.w,
                    lineHeight: 4.0.h,
                    percent: 0.25,
                    backgroundColor: AppColors.greyBackground,
                    progressColor: Colors.yellow,
                  ),
                  Text(
                    "2.5%",
                    style: AppFontStyle.text_14_400(AppColors.darkText),
                  )
                ],
              ),
              hBox(5),
              Row(
                children: [
                  IgnorePointer(
                    child: RatingBar(
                        itemSize: 14.h,
                        initialRating: 2,
                        allowHalfRating: false,
                        ratingWidget: RatingWidget(
                            full:
                                SvgPicture.asset("assets/svg/star-yellow.svg"),
                            half: SvgPicture.asset("assets/svg/star-white.svg"),
                            empty:
                                SvgPicture.asset("assets/svg/star-white.svg")),
                        onRatingUpdate: (v) {}),
                  ),
                  LinearPercentIndicator(
                    width: 120.0.w,
                    lineHeight: 4.0.h,
                    percent: 0.15,
                    backgroundColor: AppColors.greyBackground,
                    progressColor: Colors.yellow,
                  ),
                  Text(
                    "1.5%",
                    style: AppFontStyle.text_14_400(AppColors.darkText),
                  )
                ],
              ),
              hBox(5),
              Row(
                children: [
                  IgnorePointer(
                    child: RatingBar(
                        itemSize: 14.h,
                        initialRating: 1,
                        allowHalfRating: false,
                        ratingWidget: RatingWidget(
                            full:
                                SvgPicture.asset("assets/svg/star-yellow.svg"),
                            half: SvgPicture.asset("assets/svg/star-white.svg"),
                            empty:
                                SvgPicture.asset("assets/svg/star-white.svg")),
                        onRatingUpdate: (v) {}),
                  ),
                  LinearPercentIndicator(
                    width: 120.0.w,
                    lineHeight: 4.0.h,
                    percent: 0.32,
                    backgroundColor: AppColors.greyBackground,
                    progressColor: Colors.yellow,
                  ),
                  Text(
                    "3.2%",
                    style: AppFontStyle.text_14_400(AppColors.darkText),
                  )
                ],
              ),
            ])),
      ],
    );
  }

  Widget reviewButton() {
    return CustomElevatedButton(
      onPressed: () {
        Get.toNamed(AppRoutes.groceryRateVendor);
      },
      text: "Write A Review",
    );
  }

  Widget shopReviews() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Shop Reviews",
              style: AppFontStyle.text_22_600(AppColors.darkText, height: 1.0),
            ),
            Text(
              "  (120 Reviews)",
              style: AppFontStyle.text_14_400(
                AppColors.darkText,
              ),
            ),
          ],
        ),
        hBox(20),
        const PharmacyProductReviews().reviews()
      ],
    );
  }
}
