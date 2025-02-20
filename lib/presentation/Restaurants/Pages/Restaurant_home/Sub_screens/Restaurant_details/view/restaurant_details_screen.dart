import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/More_Products/controller/more_products_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/controller/specific_product_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/view/product_details_screen.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/controller/RestaurantDetailsController.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Reviews/controller/more_products_controller.dart';
import 'package:woye_user/shared/widgets/CircularProgressIndicator.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final String Restaurantid;

  final RestaurantDetailsController controller =
      Get.put(RestaurantDetailsController());

  final specific_Product_Controller specific_product_controllerontroller =
      Get.put(specific_Product_Controller());

  final seeAll_Product_Controller seeallproductcontroller =
      Get.put(seeAll_Product_Controller());

  final SeeAllProductReviewController seeAllProductReviewController =
      Get.put(SeeAllProductReviewController());

  RestaurantDetailsScreen({super.key, required this.Restaurantid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          isLeading: true,
          actions: [
            Container(
              padding: REdgeInsets.all(9),
              height: 44.h,
              width: 44.h,
              decoration: BoxDecoration(
                  color: AppColors.greyBackground,
                  borderRadius: BorderRadius.circular(12.r)),
              child: Icon(
                Icons.share_outlined,
                size: 24.w,
              ),
            ),
            // wBox(8),
            // Container(
            //     padding: REdgeInsets.all(9),
            //     height: 44.h,
            //     width: 44.h,
            //     decoration: BoxDecoration(
            //         color: AppColors.greyBackground,
            //         borderRadius: BorderRadius.circular(12.r)),
            //     child: Icon(
            //       Icons.favorite_outline_sharp,
            //       size: 24.w,
            //     )),
            // wBox(8),
            // Container(
            //   padding: REdgeInsets.all(9),
            //   height: 44.h,
            //   width: 44.h,
            //   decoration: BoxDecoration(
            //       color: AppColors.greyBackground,
            //       borderRadius: BorderRadius.circular(12.r)),
            //   child: SvgPicture.asset(
            //     ImageConstants.notification,
            //   ),
            // ),
          ],
        ),
        body: Obx(() {
          switch (controller.rxRequestStatus.value) {
            case Status.LOADING:
              return Center(child: circularProgressIndicator());
            case Status.ERROR:
              if (controller.error.value == 'No internet') {
                return InternetExceptionWidget(
                  onPress: () {
                    controller.restaurant_Details_Api(id: Restaurantid);
                  },
                );
              } else {
                return GeneralExceptionWidget(
                  onPress: () {
                    controller.restaurant_Details_Api(id: Restaurantid);
                  },
                );
              }
            case Status.COMPLETED:
              return Scaffold(
                body: RefreshIndicator(
                    onRefresh: () async {
                      controller.restaurant_Details_Api(id: Restaurantid);
                    },
                    child: SingleChildScrollView(
                      padding: REdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          mainBanner(),
                          hBox(30),
                          openHours(),
                          hBox(30),
                          description(),
                          if (controller
                              .restaurant_Data.value.review!.isNotEmpty)
                            reviews(),
                          if (controller
                              .restaurant_Data.value.moreProducts!.isNotEmpty)
                            hBox(30),
                          if (controller
                              .restaurant_Data.value.moreProducts!.isNotEmpty)
                            moreProducts(context),
                          hBox(30),
                        ],
                      ),
                    )),
              );
          }
        }));
  }

  Widget mainBanner() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: CachedNetworkImage(
              imageUrl: controller.restaurant_Data.value.restaurant!.shopimage
                  .toString(),
              placeholder: (context, url) => circularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(
                Icons.error,
                size: 60.h,
                color: AppColors.lightText.withOpacity(0.5),
              ),
              fit: BoxFit.cover,
            )),
        hBox(15),
        Text(
          controller.restaurant_Data.value.restaurant!.shopName
              .toString()
              .capitalize!,
          style: AppFontStyle.text_24_400(AppColors.darkText),
          maxLines: 2,
        ),
        hBox(15),
        Row(
          children: [
            Text(
              "${controller.travelTime.toStringAsFixed(0)} Min",
              // "32min",
              style: AppFontStyle.text_14_400(AppColors.lightText),
            ),
            wBox(4),
            Text(
              "•",
              style: AppFontStyle.text_14_400(AppColors.lightText),
            ),
            wBox(4),
            Text(
              // "2km",
              "${controller.distance.toStringAsFixed(2)} KM",
              style: AppFontStyle.text_14_400(AppColors.lightText),
            ),
            wBox(4),
            Text(
              "•",
              style: AppFontStyle.text_14_400(AppColors.lightText),
            ),
            wBox(4),
            SvgPicture.asset("assets/svg/star-yellow.svg"),
            wBox(4),
            Text(
              "${controller.restaurant_Data.value.averageRating}/5",
              style: AppFontStyle.text_14_400(AppColors.lightText),
            ),
          ],
        ),
        hBox(20),
        Row(
          children: [
            const Icon(Icons.person_outline_rounded),
            wBox(8),
            Flexible(
              child: Text(
                "${controller.restaurant_Data.value.restaurant!.firstName ?? ""} ${controller.restaurant_Data.value.restaurant!.lastName ?? ""}",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.darkText,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
        hBox(10),
        Row(
          children: [
            const Icon(Icons.mail_outline_rounded),
            wBox(8),
            Flexible(
              child: Text(
                controller.restaurant_Data.value.restaurant!.email.toString(),
                overflow: TextOverflow.ellipsis,
                style: AppFontStyle.text_14_400(AppColors.darkText),
              ),
            )
          ],
        ),
        hBox(10),
        Row(
          children: [
            const Icon(Icons.location_on_outlined),
            wBox(8),
            Flexible(
              child: Text(
                controller.restaurant_Data.value.restaurant!.shopAddress
                    .toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppFontStyle.text_14_400(
                  AppColors.darkText,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget openHours() {
    var openingHours =
        controller.restaurant_Data.value.restaurant!.openingHours;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Open Hours",
          style: AppFontStyle.text_20_600(AppColors.darkText),
        ),
        hBox(14),
        for (var openingHour in openingHours!)
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: SizedBox(
              width: Get.width * 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    openingHour.day ?? "",
                    style: AppFontStyle.text_16_400(AppColors.lightText),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    openingHour.status == null
                        ? 'Closed'
                        : "${openingHour.open} - ${openingHour.close}",
                    style: AppFontStyle.text_16_400(AppColors.lightText),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Descriptions",
          style: AppFontStyle.text_20_600(AppColors.darkText),
        ),
        hBox(10),
        Text(
          controller.restaurant_Data.value.restaurant!.shopDes.toString(),
          maxLines: 100,
          style: AppFontStyle.text_16_400(AppColors.lightText),
        ),
      ],
    );
  }

  Widget reviews() {
    return Padding(
      padding: EdgeInsets.only(top: 30.h),
      child: Column(
        children: [
          Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.restaurant_Data.value.review!.length,
                itemBuilder: (context, index) {
                  return controller.restaurant_Data.value.review![index].user !=
                          null
                      ? Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50.r),
                                  child: CachedNetworkImage(
                                    imageUrl: controller.restaurant_Data.value
                                        .review![index].user!.imageUrl
                                        .toString(),
                                    fit: BoxFit.cover,
                                    height: 50.h,
                                    width: 50.h,
                                    errorWidget: (context, url, error) =>
                                        Center(
                                            child: Container(
                                      height: 50.h,
                                      width: 50.h,
                                      color: AppColors.gray.withOpacity(.2),
                                      child: Icon(
                                        Icons.person,
                                        color: AppColors.gray,
                                      ),
                                    )),
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                      baseColor: AppColors.gray,
                                      highlightColor: AppColors.lightText,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.gray,
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                wBox(15),
                                Flexible(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                     Container(
                                       decoration: BoxDecoration(
                                         color: AppColors.bgColor,
                                         borderRadius: BorderRadius.circular(20),
                                       ),
                                       child: Padding(
                                         padding:  EdgeInsets.all(10.h),
                                         child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           children: [
                                             Text(
                                               controller.restaurant_Data.value
                                                   .review![index].user!.firstName
                                                   .toString(),
                                               style: AppFontStyle.text_16_400(
                                                   AppColors.darkText),
                                             ),
                                             hBox(5),
                                             RatingBar.readOnly(
                                               filledIcon: Icons.star,
                                               emptyIcon: Icons.star,
                                               filledColor: AppColors.goldStar,
                                               emptyColor: AppColors.normalStar,
                                               initialRating: double.parse(controller
                                                   .restaurant_Data
                                                   .value
                                                   .review![index]
                                                   .rating!
                                                   .toString()),
                                               maxRating: 5,
                                               size: 20.h,
                                             ),
                                             hBox(10),
                                             Text(
                                               controller.restaurant_Data.value
                                                   .review![index].message
                                                   .toString(),
                                               style: AppFontStyle.text_16_400(
                                                   AppColors.darkText),
                                               maxLines: 3,
                                             ),
                                             hBox(10),
                                             Text(
                                               controller.formatDate(controller
                                                   .restaurant_Data
                                                   .value
                                                   .review![index]
                                                   .updatedAt
                                                   .toString()),
                                               style: AppFontStyle.text_16_400(
                                                   AppColors.lightText),
                                             ),
                                           ],
                                         ),
                                       ),
                                     ),
                                      if (controller.restaurant_Data.value
                                              .review![index].reply !=
                                          null)
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.h),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Icon(
                                                Icons.reply,
                                                color: AppColors.primary,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  controller.restaurant_Data.value
                                                      .review![index].reply
                                                      .toString()
                                                      .trim(),
                                                  style: AppFontStyle.text_16_400(
                                                      AppColors.lightText),
                                                  maxLines: 100,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
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
                        )
                      : const SizedBox();
                },
              ),
            ],
          ),
          controller.restaurant_Data.value.totalReviews!.toInt() > 0
              ? Column(
                  children: [
                    hBox(10),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.productReviews,
                          arguments: {
                            'product_id': Restaurantid.toString(),
                            'product_review':
                                controller.restaurant_Data.value.averageRating,
                            'review_count': controller
                                .restaurant_Data.value.totalReviews
                                .toString(),
                            "type": "restaurant",
                          },
                        );
                        seeAllProductReviewController.seeAllProductReviewApi(
                            vendorId: Restaurantid.toString(),
                            type: "restaurant");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "See All (${controller.restaurant_Data.value.totalReviews.toString()})",
                            style: AppFontStyle.text_14_600(AppColors.primary),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: AppColors.primary,
                            size: 20.h,
                          )
                        ],
                      ),
                    ),
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget moreProducts(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "More Products",
              style: AppFontStyle.text_22_600(AppColors.darkText),
            ),
            InkWell(
              onTap: () {
                seeallproductcontroller.seeAll_Product_Api(
                    restaurant_id: Restaurantid.toString(), category_id: "");
                Get.toNamed(AppRoutes.moreProducts, arguments: {
                  'restaurant_id': Restaurantid.toString(),
                  'category_id': '',
                });
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "See All",
                    style: AppFontStyle.text_16_600(AppColors.primary),
                  ),
                  wBox(4),
                  Icon(
                    Icons.arrow_forward_sharp,
                    color: AppColors.primary,
                    size: 18,
                  )
                ],
              ),
            ),
          ],
        ),
        hBox(15),
        GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.restaurant_Data.value.moreProducts!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6.w,
              crossAxisSpacing: 14.w,
              mainAxisSpacing: 5.h,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    specific_product_controllerontroller.specific_Product_Api(
                      productId: controller
                          .restaurant_Data.value.moreProducts![index].id
                          .toString(),
                      categoryId: controller
                          .restaurant_Data.value.moreProducts![index].categoryId
                          .toString(),
                    );
                    Get.to(ProductDetailsScreen(
                      productId: controller
                          .restaurant_Data.value.moreProducts![index].id
                          .toString(),
                      categoryId: controller
                          .restaurant_Data.value.moreProducts![index].categoryId
                          .toString(),
                      categoryName: controller.restaurant_Data.value
                          .moreProducts![index].categoryName
                          .toString(),
                    ));
                  },
                  child: CustomItemBanner(
                    index: index,
                    product_id: controller
                        .restaurant_Data.value.moreProducts![index].id
                        .toString(),
                    categoryId: controller
                        .restaurant_Data.value.moreProducts![index].categoryId
                        .toString(),
                    image: controller
                        .restaurant_Data.value.moreProducts![index].urlImage,
                    title: controller
                        .restaurant_Data.value.moreProducts![index].title,
                    // rating: controller
                    //     .restaurant_Data.value.moreProducts![index].rating
                    //     .toString(),
                    is_in_wishlist: controller.restaurant_Data.value
                        .moreProducts![index].isInWishlist,
                    isLoading: controller
                        .restaurant_Data.value.moreProducts![index].isLoading,
                    sale_price: controller
                        .restaurant_Data.value.moreProducts![index].salePrice
                        .toString(),
                    regular_price: controller
                        .restaurant_Data.value.moreProducts![index].regularPrice
                        .toString(),
                    resto_name: controller
                        .restaurant_Data.value.moreProducts![index].restoName
                        .toString(),
                  ));
            })
      ],
    );
  }
}
