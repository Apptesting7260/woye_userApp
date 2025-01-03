import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_reviews/controller/more_products_controller.dart';

class ProductReviews extends StatelessWidget {
  ProductReviews({super.key});

  final SeeAllProductReviewController controller =
      Get.put(SeeAllProductReviewController());

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final String productId = args['product_id'];
    final String reviewcount = args['review_count'];
    final double ProductReview = args['product_review'];
    return Scaffold(
        appBar: CustomAppBar(
          isLeading: true,
          title: Text(
            "Product Reviews",
            style: AppFontStyle.text_22_600(AppColors.darkText),
          ),
        ),
        body: Obx(() {
          switch (controller.rxRequestStatus.value) {
            case Status.LOADING:
              return Center(child: circularProgressIndicator());
            case Status.ERROR:
              if (controller.error.value == 'No internet') {
                return InternetExceptionWidget(
                  onPress: () {
                    controller.seeAllProductReviewApi(productId: productId);
                  },
                );
              } else {
                return GeneralExceptionWidget(
                  onPress: () {
                    controller.seeAllProductReviewApi(productId: productId);
                  },
                );
              }
            case Status.COMPLETED:
              return RefreshIndicator(
                  onRefresh: () async {
                    controller.seeAllProductReviewApi(productId: productId);
                  },
                  child: SingleChildScrollView(
                    padding: REdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        productReviews(
                            rating: ProductReview, reviewcount: reviewcount),
                        hBox(30),
                        reviews(),
                        hBox(50)
                      ],
                    ),
                  ));
          }
        }));
  }

  Widget productReviews({
    required String reviewcount,
    required double rating,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Product Reviews",
          style: AppFontStyle.text_20_600(AppColors.darkText),
        ),
        hBox(10),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RatingBar.readOnly(
              filledIcon: Icons.star,
              emptyIcon: Icons.star,
              filledColor: AppColors.goldStar,
              emptyColor: AppColors.normalStar,
              initialRating: rating,
              maxRating: 5,
              size: 20.h,
            ),
            wBox(8),
            Text(
              "${rating.toString()}/5",
              style: AppFontStyle.text_16_400(AppColors.darkText),
            ),
            wBox(8),
            Text(
              "(${reviewcount} reviews)",
              style: AppFontStyle.text_14_400(AppColors.lightText),
            ),
          ],
        ),
      ],
    );
  }

  Widget reviews() {
    return Column(
      children: [
        Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.seeAllReview.value.reviewAll!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.r),
                            child: CachedNetworkImage(
                              imageUrl: controller.seeAllReview.value
                                  .reviewAll![index].user!.imageUrl
                                  .toString(),
                              fit: BoxFit.cover,
                              height: 50.h,
                              width: 50.h,
                              errorWidget: (context, url, error) => Center(
                                  child: Container(
                                height: 50.h,
                                width: 50.h,
                                color: AppColors.gray.withOpacity(.2),
                                child: Icon(
                                  Icons.person,
                                  color: AppColors.gray,
                                ),
                              )),
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: AppColors.gray,
                                highlightColor: AppColors.lightText,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.gray,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        wBox(15),
                        Flexible(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.seeAllReview.value.reviewAll![index]
                                    .user!.firstName
                                    .toString(),
                                style: AppFontStyle.text_16_400(
                                  AppColors.darkText,
                                ),
                              ),
                              hBox(5),
                              RatingBar.readOnly(
                                filledIcon: Icons.star,
                                emptyIcon: Icons.star,
                                filledColor: AppColors.goldStar,
                                emptyColor: AppColors.normalStar,
                                initialRating: controller.seeAllReview.value
                                    .reviewAll![index].rating!,
                                maxRating: 5,
                                size: 20.h,
                              ),
                              hBox(10),
                              Text(
                                controller.seeAllReview.value.reviewAll![index]
                                    .message
                                    .toString(),
                                style: AppFontStyle.text_16_400(
                                    AppColors.darkText),
                                maxLines: 50,
                              ),
                              hBox(10),
                              Text(
                                controller.formatDate(controller.seeAllReview
                                    .value.reviewAll![index].createdAt
                                    .toString()),
                                style: AppFontStyle.text_16_400(
                                    AppColors.lightText),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: REdgeInsets.symmetric(vertical: 10),
                      child: const Divider(),
                    ),
                  ],
                );
              },
              // separatorBuilder: (context, inxex) => Padding(
              //   padding: REdgeInsets.symmetric(vertical: 10),
              //   child: const Divider(),
              // ),
            ),
          ],
        ),
        hBox(10),
      ],
    );
  }
}
