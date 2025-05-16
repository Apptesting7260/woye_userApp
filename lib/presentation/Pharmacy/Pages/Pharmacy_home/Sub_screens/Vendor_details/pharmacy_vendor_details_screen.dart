import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Vendor_details/PharmacyDetailsController.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Reviews/controller/more_products_controller.dart';
import 'package:woye_user/shared/widgets/shimmer.dart';

import '../../../../../../Core/Constant/app_urls.dart';
import '../../../../../../Core/Utils/image_cache_height.dart';
import '../../../../../../Shared/theme/font_family.dart';

class PharmacyVendorDetailsScreen extends StatefulWidget {
  final String pharmacyId;

  PharmacyVendorDetailsScreen({super.key, required this.pharmacyId});

  @override
  State<PharmacyVendorDetailsScreen> createState() => _PharmacyVendorDetailsScreenState();
}

class _PharmacyVendorDetailsScreenState extends State<PharmacyVendorDetailsScreen> {
  final PharmacyDetailsController controller = Get.put(PharmacyDetailsController());

  final SeeAllProductReviewController seeAllProductReviewController =
      Get.put(SeeAllProductReviewController());

  @override
  void initState() {
    print("Pharma ID >> ${widget.pharmacyId}");
   controller.restaurant_Details_Api(id: widget.pharmacyId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        actions: [
          GestureDetector(
            onTap: () {
              Share.share(
                  '${AppUrls.hostUrl}/pharmacy?id=${widget.pharmacyId}',
                  subject: controller.pharma_Data.value.pharmaShop?.shopName ?? 'Share Pharmacy Shop',
              );
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
          wBox(8),
          GestureDetector(
            onTap: (){
              Get.toNamed(AppRoutes.notifications);
            },
            child: Container(
              padding: REdgeInsets.all(9),
              height: 44.h,
              width: 44.h,
              decoration: BoxDecoration(
                  color: AppColors.greyBackground,
                  borderRadius: BorderRadius.circular(12.r)),
              child: SvgPicture.asset(
                ImageConstants.notification,
              ),
            ),
          ),
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
                  controller.restaurant_Details_Api(id: widget.pharmacyId);
                },
              );
            } else {
              return GeneralExceptionWidget(
                onPress: () {
                  controller.restaurant_Details_Api(id: widget.pharmacyId);
                },
              );
            }
          case Status.COMPLETED:
            return Scaffold(
              body: RefreshIndicator(
                  onRefresh: () async {
                    controller.restaurant_Details_Api(id: widget.pharmacyId);
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
                        reviews(),
                        if (controller.pharma_Data.value.moreProducts?.isNotEmpty ?? true)
                          hBox(30),
                        if (controller.pharma_Data.value.moreProducts?.isNotEmpty ?? true)
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
              imageUrl: controller.pharma_Data.value.pharmaShop?.shopimage.toString() ?? "",
              placeholder: (context, url) => const ShimmerWidget(),
              errorWidget: (context, url, error) =>Container(
              clipBehavior: Clip.antiAlias,
              width: double.maxFinite,
              height: 220.h,
              decoration: BoxDecoration(
              border: Border.all(color: AppColors.textFieldBorder),
              borderRadius: BorderRadius.circular(20.r),
              ),
              child:  Icon(Icons.broken_image_rounded,color: AppColors.textFieldBorder)),
              fit: BoxFit.cover,
            )),
        hBox(15),
        Text(
          controller.pharma_Data.value.pharmaShop?.shopName.toString().capitalize.toString() ?? "",
          style: AppFontStyle.text_22_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
          maxLines: 2,
        ),
        hBox(15),
        Row(
          children: [
            Text(
              "${controller.distance.toStringAsFixed(2)} KM",
              style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
            ),
            wBox(4),
            Text(
              "•",
              style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
            ),
            wBox(4),
            Text(
              "${controller.travelTime.toStringAsFixed(0)} Min",
              style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
            ),
            wBox(4),
            Text(
              "•",
              style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
            ),
            wBox(4),
            SvgPicture.asset("assets/svg/star-yellow.svg"),
            wBox(4),
            Text(
              "${controller.pharma_Data.value.averageRating}/5",
              style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
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
                "${controller.pharma_Data.value.pharmaShop?.firstName ?? ""} ${controller.pharma_Data.value.pharmaShop?.lastName ?? ""}",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.darkText,
                  fontFamily: AppFontFamily.gilroyMedium,
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
                controller.pharma_Data.value.pharmaShop?.email.toString() ?? "",
                overflow: TextOverflow.ellipsis,
                style: AppFontStyle.text_14_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
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
                controller.pharma_Data.value.pharmaShop?.shopAddress.toString() ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppFontStyle.text_14_400(
                  AppColors.darkText,family: AppFontFamily.gilroyMedium,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget openHours() {
    var openingHours = controller.pharma_Data.value.pharmaShop?.openingHours;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Open Hours",
          style: AppFontStyle.text_18_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
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
                    style: AppFontStyle.text_16_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    openingHour.status == null
                        ? 'Closed'
                        : "${openingHour.open} - ${openingHour.close}",
                    style: AppFontStyle.text_16_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
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
          style: AppFontStyle.text_18_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
        ),
        hBox(10),
        Text(
          controller.pharma_Data.value.pharmaShop?.shopDes.toString() ?? "",
          style: AppFontStyle.text_16_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
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
                itemCount: 1,
                itemBuilder: (context, index) {
                  return controller.pharma_Data.value.review?[index].user != null
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
                                                    AppColors.darkText,family: AppFontFamily.gilroyMedium),
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
                                                    AppColors.darkText,family: AppFontFamily.gilroyMedium),
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
                                                style: AppFontStyle.text_15_400(
                                                    AppColors.lightText,family: AppFontFamily.gilroyMedium),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      if (controller.pharma_Data.value
                                              .review![index].reply !=
                                          null)
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
                                                      AppColors.lightText,family: AppFontFamily.gilroyMedium),
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
                            'product_id': widget.pharmacyId.toString(),
                            'product_review':
                                controller.pharma_Data.value.averageRating,
                            'review_count': controller
                                .pharma_Data.value.totalReviews
                                .toString(),
                            "type": "pharmacy",
                          },
                        );
                        seeAllProductReviewController.seeAllProductReviewApi(
                            vendorId: widget.pharmacyId.toString(), type: "pharmacy");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "See All (${controller.pharma_Data.value.totalReviews.toString()})",
                            style: AppFontStyle.text_14_600(AppColors.primary,family: AppFontFamily.gilroyRegular),
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
        Text(
          "Products",
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
              return CustomBanner(
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
}
