import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/Sub_screens/Rate_and_review_product/post_review_controller.dart';

class RateAndReviewProductScreen extends StatelessWidget {
  RateAndReviewProductScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final PostReviewController controller = Get.put(PostReviewController());

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final orderId = arguments['order_id'];
    final vendorId = arguments['vendor_id'];
    final type = arguments['type'];
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
            hBox(40),
            giveRating(),
            hBox(30),
            giveReview(),
            hBox(20),
            Obx(
              () => CustomElevatedButton(
                isLoading: (controller.rxRequestStatus.value == Status.LOADING),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    controller.cancelOrderApi(
                      orderId: orderId,
                      vendorId: vendorId,
                      type: type,
                      rating: controller.rating.value.toString(),
                      review: controller.reviewController.value.text,
                    );
                  }
                },
                text: "Submit",
              ),
            ),
            hBox(50),
          ],
        ),
      ),
    );
  }

  Widget giveRating() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What is your rate?",
            style: AppFontStyle.text_18_600(AppColors.darkText),
          ),
          hBox(20),
          // RatingBar(
          //     itemPadding: REdgeInsets.only(right: 10),
          //     itemSize: 36.h,
          //     initialRating: 0,
          //     allowHalfRating: true,
          //     ratingWidget: RatingWidget(
          //         full: SvgPicture.asset("assets/svg/star-yellow.svg"),
          //         half: SvgPicture.asset("assets/svg/star-white.svg"),
          //         empty: SvgPicture.asset("assets/svg/star-white.svg")),
          //     onRatingUpdate: (v) {}),
          RatingBar(
            itemPadding: EdgeInsets.only(right: 10.w),
            itemSize: 36,
            initialRating: 0,
            allowHalfRating: true,
            ratingWidget: RatingWidget(
              full: Icon(Icons.star, color: AppColors.goldStar),
              half: Icon(Icons.star_half, color: AppColors.goldStar),
              empty: Icon(Icons.star_border, color: AppColors.normalStar),
            ),
            onRatingUpdate: (rating) {
              // Handle rating change
              print('Rating updated: $rating');
              controller.rating.value = rating;
            },
          ),
        ],
      ),
    );
  }

  Widget giveReview() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "What is your rate?",
        style: AppFontStyle.text_18_600(AppColors.darkText),
      ),
      hBox(20),
      CustomTextFormField(
        maxLines: 7,
        minLines: 7,
        controller: controller.reviewController.value,
        hintText: "Write your review...",
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please write a review';
          }
          return null;
        },
      )
    ]);
  }

// Widget submitButton() {
//   return CustomElevatedButton(
//     onPressed: () {
//       if (formKey.currentState!.validate()) {
//         controller.cancelOrderApi(
//           orderId: orderId,
//         );
//       }
//     },
//     text: "Submit",
//   );
// }
}
