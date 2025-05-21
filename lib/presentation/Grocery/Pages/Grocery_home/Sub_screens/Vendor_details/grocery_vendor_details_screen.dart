import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Utils/image_cache_height.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/Vendor_details/GroceryDetailsController.dart';
import 'package:woye_user/shared/widgets/custom_banner_grocery.dart';

import '../../../../../../Core/Constant/app_urls.dart';
import '../../../../../../Shared/theme/font_family.dart';
import '../../../../../../shared/widgets/shimmer.dart';
import '../../../../../Restaurants/Pages/Restaurant_home/Sub_screens/Reviews/controller/more_products_controller.dart';

class GroceryVendorDetailsScreen extends StatefulWidget {
  final String groceryId;

  GroceryVendorDetailsScreen({super.key, required this.groceryId});

  @override
  State<GroceryVendorDetailsScreen> createState() => _GroceryVendorDetailsScreenState();
}

class _GroceryVendorDetailsScreenState extends State<GroceryVendorDetailsScreen> {
  final GroceryDetailsController controller =  Get.put(GroceryDetailsController());

  final SeeAllProductReviewController seeAllProductReviewController =   Get.put(SeeAllProductReviewController());

  @override
  void initState() {
    controller.restaurant_Details_Api(id: widget.groceryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: deliveryAndCollectionsCard(),
        actions: [
          // deliveryAndCollectionsCard(),
          // wBox(5.w),
          GestureDetector(
            onTap: () {
              Share.share(
                  '${AppUrls.hostUrl}/grocery?id=${widget.groceryId}',
                  subject:
                  controller.pharma_Data.value.pharmaShop?.shopName ??
                      'Share Grocery Shop');
            },
            child: Container(
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
          // GestureDetector(
          //   onTap: () {
          //     Get.toNamed(AppRoutes.notifications);
          //   },
          //   child: Container(
          //     padding: REdgeInsets.all(9),
          //     height: 44.h,
          //     width: 44.h,
          //     decoration: BoxDecoration(
          //         color: AppColors.greyBackground,
          //         borderRadius: BorderRadius.circular(12.r)),
          //     child: SvgPicture.asset(
          //       ImageConstants.notification,
          //     ),
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
                  controller.restaurant_Details_Api(id: widget.groceryId);
                },
              );
            } else {
              return GeneralExceptionWidget(
                onPress: () {
                  controller.restaurant_Details_Api(id: widget.groceryId);
                },
              );
            }
          case Status.COMPLETED:
            return Scaffold(
              body: RefreshIndicator(
                  onRefresh: () async {
                    controller.restaurant_Details_Api(id: widget.groceryId);
                  },
                  child: SingleChildScrollView(
                    padding: REdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mainBanner(),
                        // hBox(30),
                        // openHours(),
                        // hBox(30),
                        // description(),
                        // reviews(),
                        if (controller.pharma_Data.value.moreProducts!.isNotEmpty)
                          moreProducts(),
                        hBox(30),
                      ],
                    ),
                  )),
            );
        }
      }),
    );
  }

  Widget mainBanner() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: CachedNetworkImage(
              memCacheHeight: memCacheHeight,
              width: Get.width,
              imageUrl:controller.pharma_Data.value.pharmaShop!.shopimage.toString(),
              placeholder: (context, url) =>const ShimmerWidget(),
              errorWidget: (context, url, error) => Container(
                height: 220.h,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.textFieldBorder),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child:  Icon(Icons.broken_image_rounded,color: AppColors.textFieldBorder)),
              fit: BoxFit.cover,
            )),
        hBox(15.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                controller.pharma_Data.value.pharmaShop?.shopName.toString().capitalize.toString() ?? "",
                style: AppFontStyle.text_22_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
                maxLines: 2,
              ),
            ),
            wBox(5.w),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.groceryShopInformation,
                    arguments: {
                      "groceryId" : widget.groceryId,
                    }
                );
              },
              child: Icon(Icons.info_outline,color: AppColors.black,size: 22,),
            )
          ],
        ),
        hBox(10.h),
        Row(
          children: [
            // Text(
            //   "${controller.distance.toStringAsFixed(2)} KM",
            //   style: AppFontStyle.text_14_400(AppColors.lightText),
            // ),
            // wBox(4),
            // Text(
            //   "•",
            //   style: AppFontStyle.text_14_400(AppColors.lightText),
            // ),
            // wBox(4),
            // Text(
            //   "${controller.travelTime.toStringAsFixed(0)} Min",
            //   style: AppFontStyle.text_14_400(AppColors.lightText),
            // ),
            // wBox(4),
            // Text(
            //   "•",
            //   style: AppFontStyle.text_14_400(AppColors.lightText),
            // ),
            // wBox(4),
            SvgPicture.asset("assets/svg/star-yellow.svg",height: 18),
            wBox(4.w),
            Text(
              "${controller.pharma_Data.value.averageRating}/5",
              style: AppFontStyle.text_15_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
            ),
            wBox(5.w),
            GestureDetector(
              onTap: () {
                if(controller.pharma_Data.value.review?.isNotEmpty ?? false){
                  Get.toNamed(
                    AppRoutes.productReviews,
                    arguments: {
                      'product_id': widget.groceryId.toString(),
                      'product_review':controller.pharma_Data.value.averageRating,
                      'review_count': controller.pharma_Data.value.totalReviews.toString(),
                      "type": "grocery",
                    },
                  );
                  seeAllProductReviewController.seeAllProductReviewApi(vendorId: widget.groceryId.toString(), type: "grocery");
                }
              },
              child: Text(
                "(${controller.pharma_Data.value.review?.length} Reviews)",
                style:TextStyle(fontSize: 15.sp,fontFamily: AppFontFamily.gilroyRegular,decoration: TextDecoration.underline,color: AppColors.lightText,decorationColor: AppColors.lightText),
              ),
            ),
          ],
        ),
        hBox(8.h),
        Row(
          children: [
            SvgPicture.asset(ImageConstants.scooterImage,height: 18,width: 18,colorFilter: ColorFilter.mode(AppColors.darkText.withOpacity(0.8), BlendMode.srcIn),),
            wBox(6.w),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                "\$5 Delivery",
                style: AppFontStyle.text_15_400(AppColors.darkText,family: AppFontFamily.gilroyRegular),
              ),
            ),
            Text(
              "  •  ",
              textAlign: TextAlign.left,
              style: AppFontStyle.text_16_300(AppColors.lightText,family: AppFontFamily.gilroyRegular),
            ),
            SvgPicture.asset(ImageConstants.cartIconImage,height: 18,colorFilter: ColorFilter.mode(AppColors.darkText, BlendMode.srcIn),),
            wBox(6.w),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                "No min. order",
                style: AppFontStyle.text_15_400(AppColors.darkText,family: AppFontFamily.gilroyRegular),
              ),
            ),
          ],
        ),
        hBox(15.h),
        Container(
          decoration: BoxDecoration(color: AppColors.primary,borderRadius: BorderRadius.circular(54.r)),
          padding: REdgeInsets.symmetric(vertical: 7,horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(ImageConstants.scooterImage,height: 18,colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),),
              wBox(8.w),
              Padding(
                padding: REdgeInsets.only(top: 3.0),
                child: Text("Free delivery when you spend over \$1009",
                  style: AppFontStyle.text_14_400(AppColors.white,family: AppFontFamily.gilroyMedium),
                ),
              ),
            ],
          ),
        ),
        // hBox(20),
        // Row(
        //   children: [
        //     const Icon(Icons.person_outline_rounded),
        //     wBox(8),
        //     Flexible(
        //       child: Text(
        //         "${controller.pharma_Data.value.pharmaShop!.firstName ?? ""} ${controller.pharma_Data.value.pharmaShop!.lastName ?? ""}",
        //         style: TextStyle(
        //           fontSize: 14.sp,
        //           color: AppColors.darkText,
        //           fontWeight: FontWeight.w400,
        //         ),
        //       ),
        //     )
        //   ],
        // ),
        // hBox(10),
        // Row(
        //   children: [
        //     const Icon(Icons.mail_outline_rounded),
        //     wBox(8),
        //     Flexible(
        //       child: Text(
        //         controller.pharma_Data.value.pharmaShop!.email.toString(),
        //         overflow: TextOverflow.ellipsis,
        //         style: AppFontStyle.text_14_400(AppColors.darkText),
        //       ),
        //     )
        //   ],
        // ),
        // hBox(10),
        // Row(
        //   children: [
        //     const Icon(Icons.location_on_outlined),
        //     wBox(8),
        //     Flexible(
        //       child: Text(
        //         controller.pharma_Data.value.pharmaShop!.shopAddress.toString(),
        //         maxLines: 2,
        //         overflow: TextOverflow.ellipsis,
        //         style: AppFontStyle.text_14_400(
        //           AppColors.darkText,
        //         ),
        //       ),
        //     )
        //   ],
        // ),
      ],
    );
  }

  Widget openHours() {
    var openingHours = controller.pharma_Data.value.pharmaShop!.openingHours;

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
              // width: Get.width * 0.7,
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
          controller.pharma_Data.value.pharmaShop!.shopDes.toString(),
          style: AppFontStyle.text_16_400(AppColors.lightText),
          maxLines: 30,
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
                itemCount: controller.pharma_Data.value.review!.length,
                itemBuilder: (context, index) {
                  return controller.pharma_Data.value.review![index].user !=
                      null
                      ? Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.r),
                            child: CachedNetworkImage(
                              imageUrl: controller.pharma_Data.value
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
                                          controller.pharma_Data.value
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
                                              .pharma_Data
                                              .value
                                              .review![index]
                                              .rating!
                                              .toString()),
                                          maxRating: 5,
                                          size: 20.h,
                                        ),
                                        hBox(10),
                                        Text(
                                          controller.pharma_Data.value
                                              .review![index].message
                                              .toString(),
                                          style: AppFontStyle.text_16_400(
                                              AppColors.darkText),
                                          maxLines: 2,
                                        ),
                                        hBox(10),
                                        Text(
                                          controller.formatDate(controller
                                              .pharma_Data
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

                                if (controller.pharma_Data.value.review![index].reply != null)
                                  Padding(
                                    padding:  EdgeInsets.only(top: 10.h),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.reply,
                                          color: AppColors.primary,
                                        ),
                                        Flexible(
                                          child: Text(
                                            controller.pharma_Data.value
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
          controller.pharma_Data.value.totalReviews!.toInt() > 0
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
                      'product_id': controller.pharma_Data.value.pharmaShop?.id,
                      'product_review':
                      controller.pharma_Data.value.averageRating,
                      'review_count': controller
                          .pharma_Data.value.totalReviews
                          .toString(),
                      "type": "grocery",
                    },
                  );
                  seeAllProductReviewController.seeAllProductReviewApi(
                      vendorId: controller.pharma_Data.value.pharmaShop!.id.toString(), type: "grocery");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "See All (${controller.pharma_Data.value.totalReviews.toString()})",
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

  Widget moreProducts() {
    final products = controller.pharma_Data.value.moreProducts;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hBox(30.h),
        Text(
          "All Products",
          style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
        ),
        hBox(10.h),
        GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: products?.length ?? 0,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6.w,
              crossAxisSpacing: 14.w,
              mainAxisSpacing: 5.h,
            ),
            itemBuilder: (context, index) {
              return CustomBannerGrocery(
                image: products![index].urlImage.toString(),
                sale_price: products[index].salePrice.toString(),
                regular_price: products[index].regularPrice.toString(),
                title: products[index].title.toString(),
                quantity: products[index].packagingValue.toString(),
                categoryId: products[index].categoryId.toString(),
                product_id: products[index].id.toString(),
                shop_name: products[index].shopName.toString(),
                is_in_wishlist: products[index].isInWishlist,
                isLoading: products[index].isLoading,
                categoryName: products[index].categoryName.toString(),
              );
            }),
        hBox(20.h),
      ],
    );
  }


  Widget deliveryAndCollectionsCard() {
    return Center(
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 5),
        child: Container(
          height: 54.h,
          decoration: BoxDecoration(color: AppColors.ultraLightPrimary.withOpacity(0.06),borderRadius: BorderRadius.circular(100)),
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 5.0,vertical: 5),
            child: Row(
              children: [
                Container(
                  padding: REdgeInsets.only(left: 10,right: 3),
                  height: 50.h,width: 112.w,decoration: BoxDecoration(color: AppColors.primary,borderRadius: BorderRadius.circular(100)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: REdgeInsets.only(bottom: 3.0),
                        child: SvgPicture.asset(ImageConstants.scooterImage,height: 20,colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),),
                      ),
                      wBox(5.h),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Delivery",style: AppFontStyle.text_12_400(AppColors.white,family: AppFontFamily.gilroyBold),),
                          Text("30-50 mins",style: AppFontStyle.text_12_400(AppColors.white,family: AppFontFamily.gilroyRegular),),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: REdgeInsets.only(left: 10),
                  height: 50.h,width: 110.w,decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  child: Row(
                    children: [
                      SvgPicture.asset(ImageConstants.collections,height: 20,colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),),
                      wBox(5.h),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Collection",style: AppFontStyle.text_12_400(AppColors.darkText,family: AppFontFamily.gilroyBold),),
                          Text("15 mins",style: AppFontStyle.text_12_400(AppColors.darkText,family: AppFontFamily.gilroyRegular),),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
