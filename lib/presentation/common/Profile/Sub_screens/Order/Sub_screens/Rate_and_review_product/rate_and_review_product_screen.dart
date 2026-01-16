import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/Sub_screens/Rate_and_review_product/post_review_controller.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';

import '../../../../../../../Shared/theme/font_family.dart';

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
    final reply = arguments['reply'];
    final raring = arguments['raring'];
    final from = arguments['from'];

    double? rating = double.tryParse(raring ?? '');

    pt('Order ID: $orderId');
    pt('Vendor ID: $vendorId');
    pt('Type: $type');
    pt('reply: $reply');
    pt('arguments: $arguments');
    if (reply != "null") {
      controller.reviewController.value.text = reply;
    }

    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Reviews",
          style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.onestRegular),
        ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // hBox(25.h),
            giveRating(rating),
            hBox(30),
            giveReview(),
            hBox(20),
            Obx(
              () => CustomElevatedButton(
                fontFamily: AppFontFamily.onestMedium,
                isLoading: (controller.rxRequestStatus.value == Status.LOADING),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    String reviewText =
                        controller.reviewController.value.text.trim();

                    if (reviewText.isEmpty) {
                      Utils.showToast("Review cannot be empty or just spaces");
                    } else {
                      controller.postOrderReviewApi(
                          orderId: orderId,
                          vendorId: vendorId,
                          type: type,
                          rating: controller.rating.value,
                          review: reviewText,
                          from: from);
                    }
                  }
                },
                // onPressed: () {
                //   if (formKey.currentState!.validate()) {
                //     controller.cancelOrderApi(
                //       orderId: orderId,
                //       vendorId: vendorId,
                //       type: type,
                //       rating: controller.rating.value,
                //       review: controller.reviewController.value.text.trim(),
                //     );
                //   }
                // },
                text: "Submit",
              ),
            ),
            hBox(50),
          ],
        ),
      ),
    );
  }

  Widget giveRating(rating) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What is your rate?",
          style: AppFontStyle.text_18_600(AppColors.darkText,family: AppFontFamily.onestRegular),
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
          initialRating: rating,
          allowHalfRating: false,
          ratingWidget: RatingWidget(
            full: Icon(Icons.star, color: AppColors.goldStar),
            half: Icon(Icons.star_half, color: AppColors.goldStar),
            empty: Icon(Icons.star_border, color: AppColors.normalStar),
          ),
          onRatingUpdate: (rating) {
            print('Rating updated: $rating');
            controller.rating.value = rating;
          },
        ),
      ],
    );
  }

  Widget giveReview() {
    return Form(
      key: formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "What is your rate?",
          style: AppFontStyle.text_18_600(AppColors.darkText,family: AppFontFamily.onestRegular),
        ),
        hBox(20),
        CustomTextFormField(
          maxLines: 7,
          minLines: 7,
          controller: controller.reviewController.value,
          hintText: "Write your review...",
          hintStyle: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.onestRegular),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please write a review';
            }
            return null;
          },
        )
      ]),
    );
  }
}
