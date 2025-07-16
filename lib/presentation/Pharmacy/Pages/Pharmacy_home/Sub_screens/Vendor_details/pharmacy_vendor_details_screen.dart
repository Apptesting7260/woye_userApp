import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Utils/login_required_pop_up.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Product_details/controller/pharma_specific_product_controller.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Product_details/pharmacy_product_details_screen.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Vendor_details/PharmacyDetailsController.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Vendor_details/pharmacy_details_modal.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_wishlist/Controller/aad_product_wishlist_Controller/add_pharma_product_wishlist.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Reviews/controller/more_products_controller.dart';
import 'package:woye_user/presentation/common/get_user_data/get_user_data.dart';
import 'package:woye_user/shared/widgets/custom_no_data_found.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';
import 'package:woye_user/shared/widgets/shimmer.dart';
import 'package:woye_user/shared/widgets/sliverPinnedHeaderDelegate.dart';

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

  final SeeAllProductReviewController seeAllProductReviewController = Get.put(SeeAllProductReviewController());

  final PharmaSpecificProductController specificProductController = Get.put(PharmaSpecificProductController());

  final AddPharmaProductWishlistController addPharmaProductWishlistController = Get.put(AddPharmaProductWishlistController());
  final GetUserDataController getUserDataController = Get.put(GetUserDataController());

  @override
  void initState() {
    print("Pharma ID >> ${widget.pharmacyId}");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.restaurant_Details_Api(id: widget.pharmacyId);
    },);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  RestaurantBaseScaffold(
      child: Scaffold(
        appBar: CustomAppBar(
          isLeading: true,
          title:deliveryAndCollectionsCard(),
          actions: [
            // deliveryAndCollectionsCard(),
            // wBox(5.w),
            GestureDetector(
              onTap: () {
                final shop = controller.pharma_Data.value.pharmaShop;
                Share.share('Check out your trusted pharmacy: ${shop?.shopName ?? "Our Pharmacy"}\n'
                      '${AppUrls.hostUrl}/pharmacy?id=${widget.pharmacyId}',
                  subject: shop?.shopName ?? 'Share Pharmacy',
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
            // GestureDetector(
            //   onTap: (){
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
              if (controller.error.value == 'No internet' || controller.error.value == 'InternetExceptionWidget') {
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
              return RefreshIndicator(
                  onRefresh: () async {
                    controller.restaurant_Details_Api(id: widget.pharmacyId);
                  },
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(child: mainBanner()),
                      // SliverToBoxAdapter(child: hBox(30.h)),
                      if (controller.pharma_Data.value.highlights?.isNotEmpty ?? false)
                        SliverToBoxAdapter(child: highlights(widget.pharmacyId))
                      else SliverToBoxAdapter(child: hBox(20.h)),
      
                      SliverToBoxAdapter(child: hBox(8.h)),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: _PinnedHeaderDelegate(
                          height: 35.h,
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: REdgeInsets.only(bottom: 2),
                              child: categoriesList(),
                            ),
                          ),
                        ),
                      ),
      
                      if ((controller.pharma_Data.value.categories?.data.isNotEmpty ?? false) &&
                          controller.categoriesIndex.value != 0)
                        SliverToBoxAdapter(child: categoriesProducts(context, widget.pharmacyId)),
      
                      if (controller.categoriesIndex.value == 0)
                        SliverToBoxAdapter(child: allProducts()),
      
                      SliverToBoxAdapter(child: hBox(100.h)),
                    ],
                  ),
                );
          }
        }),
      ),
    );
  }

  Widget mainBanner() {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: CachedNetworkImage(
                  memCacheHeight: memCacheHeight,
                  imageUrl: controller.pharma_Data.value.pharmaShop?.shopimage.toString() ?? "",
                  placeholder: (context, url) => const ShimmerWidget(),
                  errorWidget: (context, url, error) => Container(
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
          ),
          hBox(15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  controller.pharma_Data.value.pharmaShop?.shopName.toString().capitalize.toString() ?? "",
                  style: AppFontStyle.text_20_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
                  maxLines: 2,
                ),
              ),
              wBox(5.w),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.pharmacyVendorInformationScreen,
                      arguments: {
                        "pharmacyId" : widget.pharmacyId,
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
              //   style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
              // ),
              // wBox(4),
              // Text(
              //   "•",
              //   style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
              // ),
              // wBox(4),
              // Text(
              //   "${controller.travelTime.toStringAsFixed(0)} Min",
              //   style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
              // ),
              // wBox(4),
              // Text(
              //   "•",
              //   style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
              // ),
              // wBox(4),
              SvgPicture.asset("assets/svg/star-yellow.svg"),
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
          // hBox(20),
          // Row(
          //   children: [
          //     const Icon(Icons.person_outline_rounded),
          //     wBox(8),
          //     Flexible(
          //       child: Text(
          //         "${controller.pharma_Data.value.pharmaShop?.firstName ?? ""} ${controller.pharma_Data.value.pharmaShop?.lastName ?? ""}",
          //         style: TextStyle(
          //           fontSize: 14.sp,
          //           color: AppColors.darkText,
          //           fontFamily: AppFontFamily.gilroyMedium,
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
          //         controller.pharma_Data.value.pharmaShop?.email.toString() ?? "",
          //         overflow: TextOverflow.ellipsis,
          //         style: AppFontStyle.text_14_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
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
          //         controller.pharma_Data.value.pharmaShop?.shopAddress.toString() ?? "",
          //         maxLines: 2,
          //         overflow: TextOverflow.ellipsis,
          //         style: AppFontStyle.text_14_400(
          //           AppColors.darkText,family: AppFontFamily.gilroyMedium,
          //         ),
          //       ),
          //     )
          //   ],
          // ),
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
        ],
      ),
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
                itemCount: (controller.pharma_Data.value.review?.isNotEmpty ?? false) ? 1 : 0,
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

  Widget allProducts() {
    final products = controller.pharma_Data.value.moreProducts;
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hBox(20.h),
          Text(
            "All Products",
            style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
          ),
          hBox(13.h),
          (products?.isEmpty ?? true)  ? CustomNoDataFound(heightBox: hBox(0.h),) : GridView.builder(
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
      ),
    );
  }

  Widget deliveryAndCollectionsCard() {
    return Obx(
          ()=> Center(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 5),
          child: Container(
            height: 45.h,
            decoration: BoxDecoration(
              color: AppColors.ultraLightPrimary.withOpacity(0.06),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 5.0, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap:() {
                        controller.isDelivery.value = true;
                      },
                      child: Container(
                        padding: REdgeInsets.only(left: 10, right: 3),
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: controller.isDelivery.value ?  AppColors.primary :AppColors.transparent,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: REdgeInsets.only(bottom: 3.0),
                              child: SvgPicture.asset(
                                ImageConstants.scooterImage,
                                height: 20,
                                colorFilter: ColorFilter.mode(
                                    controller.isDelivery.value ? AppColors.white : AppColors.black, BlendMode.srcIn),
                              ),
                            ),
                            wBox(5.h),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "  Delivery",
                                    style: AppFontStyle.text_12_400(
                                      controller.isDelivery.value ? AppColors.white : AppColors.darkText,
                                      family: AppFontFamily.gilroyBold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  Obx(() => Text(
                                    controller.rxRequestStatus.value ==
                                        Status.LOADING
                                        ? "0-0 mins"
                                        : "${controller.travelTime.value.round()}-${(controller.travelTime.value.round() + 2)} mins",
                                    style: AppFontStyle.text_12_400(
                                      controller.isDelivery.value ? AppColors.white : AppColors.darkText,
                                      family: AppFontFamily.gilroyRegular,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  wBox(5.w),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.isDelivery.value = false;
                      },
                      child: Container(
                        padding: REdgeInsets.only(left: 10),
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: controller.isDelivery.value ?  AppColors.transparent :AppColors.primary,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              ImageConstants.collections,
                              height: 20,
                              colorFilter: ColorFilter.mode(
                                  controller.isDelivery.value ?  AppColors.black: AppColors.white, BlendMode.srcIn),
                            ),
                            wBox(5.h),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Collection",
                                    style: AppFontStyle.text_12_400(
                                      controller.isDelivery.value ? AppColors.darkText : AppColors.white,
                                      family: AppFontFamily.gilroyBold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  Text(
                                    "15 mins",
                                    style: AppFontStyle.text_12_400(
                                      controller.isDelivery.value ? AppColors.darkText : AppColors.white,
                                      family: AppFontFamily.gilroyRegular,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget highlights(pharmacyId) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hBox(22.h),
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "Highlights",
            style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
          ),
        ),
        hBox(13.h),
        Obx(
              ()=> SizedBox(
            width: /*240.w*/ Get.width,
            height: 287.h,
            child: ListView.separated(
              padding: REdgeInsets.symmetric(horizontal: 23,vertical: 3),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: controller.pharma_Data.value.highlights?.length ?? 0,
              itemBuilder: (context, index) {
                controller.pharma_Data.value.highlights![index].isInWishlist.value = controller.pharma_Data.value.highlights![index].isWishlist == "true" ? true : false;
                final item = controller.pharma_Data.value.highlights?[index];
                final price = item?.salePrice ?? item?.regularPrice ?? 0;
                return GestureDetector(
                  onTap: (){
                    specificProductController.pharmaSpecificProductApi(
                      productId: controller.pharma_Data.value.highlights![index].id.toString(),
                      categoryId: controller.pharma_Data.value.highlights![index].categoryId.toString(),
                    );
                    Get.to(()=>PharmacyProductDetailsScreen(
                      productId: controller.pharma_Data.value.highlights?[index].id.toString() ?? "",
                      categoryId: controller.pharma_Data.value.highlights?[index].categoryId.toString() ?? "",
                      categoryName: controller.pharma_Data.value.highlights?[index].categoryName.toString() ?? "",
                    ));
                  },
                  child: Container(
                    width: 240.w,
                    height: 287.h,
                    decoration: BoxDecoration(color: AppColors.white,borderRadius: BorderRadius.circular(20.r)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            controller.pharma_Data.value.highlights![index].urlImage != null ?
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: CachedNetworkImage(
                                memCacheHeight: memCacheHeight,
                                imageUrl: controller.pharma_Data.value.highlights![index].urlImage.toString(),
                                fit: BoxFit.cover,
                                height: 182.h,
                                width: Get.width,
                                errorWidget: (context, url, error) =>Container(
                                  clipBehavior: Clip.antiAlias,
                                  width: double.maxFinite,
                                  height: 220.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.textFieldBorder),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Icon(Icons.broken_image_rounded,color:AppColors.textFieldBorder,),
                                ),
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
                            ) :
                            Container(
                              clipBehavior: Clip.antiAlias,
                              width: double.maxFinite,
                              height: 220.h,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.textFieldBorder),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Icon(Icons.broken_image_rounded,color:AppColors.textFieldBorder,),
                            ),
                            Container(
                              margin: REdgeInsets.only(top: 10, right: 10),
                              padding: REdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: AppColors.greyBackground),
                              child:  Obx(
                                    ()=> InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () async {
                                    if (getUserDataController.userData.value.user?.userType =="guestUser") {
                                      showLoginRequired(context);
                                    }else{
                                    controller.pharma_Data.value.highlights?[index].isInWishlist.value = !controller.pharma_Data.value.highlights![index].isInWishlist.value;
                                    controller.pharma_Data.value.highlights?[index].isLoading.value = true;
                                    await addPharmaProductWishlistController.pharmacy_add_product_wishlist(
                                      isRefresh: true,
                                      pharmacyId:pharmacyId.toString(),
                                      categoryId: controller.pharma_Data.value.highlights![index].categoryId.toString(),
                                      product_id:controller.pharma_Data.value.highlights![index].id.toString(),
                                    );
                                    }
                                  },
                                  child: controller.pharma_Data.value.highlights![index].isLoading.value
                                      ? circularProgressIndicator(size: 18)
                                      : Icon(
                                    controller.pharma_Data.value.highlights![index].isInWishlist.value ?
                                    Icons.favorite : Icons.favorite_border_outlined,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,right: 10,
                              child:/* Obx(
                      ()=>*/ InkWell(
                                onTap: () {
                                  // if (getUserDataController.userData.value.user?.userType == "guestUser") {
                                  //   showLoginRequired(context);
                                  // } else {
                                  //   controller.restaurant_Data.value.highlights![index].isAddToCart.value = true;
                                  // }
                                },
                                child: Container(
                                  height: 30.h,width: 30.w,
                                  decoration: BoxDecoration(color: AppColors.primary,
                                      // shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(10.r)
                                  ),
                                  child: Icon(/*controller.restaurant_Data.value.highlights![index].isAddToCart.value ? Icons.done :*/Icons.add,
                                    color: AppColors.white,size: 20,),
                                ),
                              ),
                              // ),
                            ),
                          ],
                        ),
                        hBox(14.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "\$$price",
                              textAlign: TextAlign.left,
                              style: AppFontStyle.text_15_600(AppColors.primary,family: AppFontFamily.gilroyRegular),
                            ),
                            wBox(5.h),
                            Text(
                              "\$${item?.regularPrice}",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.lightText,
                                  fontFamily: AppFontFamily.gilroyRegular,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: AppColors.lightText),
                              //  AppFontStyle.text_14_300(AppColors.lightText),
                            ),
                          ],
                        ),
                        // hBox(10),
                        Text(
                          item?.title.toString().capitalizeFirst.toString() ?? "",
                          // textAlign: TextAlign.left,
                          style: AppFontStyle.text_17_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
                        ),
                        // hBox(10),
                        Text(
                          item?.pharmaName.toString() ?? "",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppFontStyle.text_14_300(AppColors.lightText,family: AppFontFamily.gilroyRegular),
                        ),
                        hBox(18.h)
                      ],
                    ),
                  ),
                );
              }, separatorBuilder: (context, index) => wBox(15.w),),
          ),
        )
      ],
    );
  }

  Widget categoriesList() {
    // final categoryKeys = controller.restaurant_Data.value.categories?.data.keys.toList() ?? [];
    final categoryKeys = ["All", ...(controller.pharma_Data.value.categories?.data.keys.toList() ?? [])];

    return SizedBox(
      height: 35,
      child: ListView.separated(
        padding: REdgeInsets.symmetric(horizontal: 24),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: categoryKeys.length,
        itemBuilder: (context, index) {
          return Obx(
                ()=> GestureDetector(
              onTap: () {
                controller.categoriesIndex.value = index;
              },
              child: Container(
                padding: REdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    color:controller.categoriesIndex.value == index ? AppColors.darkText : AppColors.bgColor,
                    borderRadius: BorderRadius.circular(100.r)),
                child: Center(
                  child: Text(
                    categoryKeys[index],
                    style: AppFontStyle.text_15_400(controller.categoriesIndex.value == index  ? AppColors.white : AppColors.darkText,
                        family:controller.categoriesIndex.value == index ? AppFontFamily.gilroySemiBold : AppFontFamily.gilroyMedium),
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => wBox(8.w),
      ),
    );
  }

  Widget categoriesProducts(context,String? pharmacyId) {
    final categoryKeys = ["All", ...(controller.pharma_Data.value.categories?.data.keys.toList() ?? [])];

    final selectedKey = controller.categoriesIndex.value == 0 ? "All" : categoryKeys[controller.categoriesIndex.value];

    final List<AllProducts> catValue =/* controller.categoriesIndex.value == 0
         ? controller.restaurant_Data.value.categories?.data.values.expand((e) => e).toList() ?? [] :*/
    controller.pharma_Data.value.categories?.data[selectedKey] ?? [];

    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hBox(20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedKey,
                style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
              ),
              // InkWell(
              //   onTap: () {
              //     seeallproductcontroller.seeAll_Product_Api(
              //         restaurant_id: widget.Restaurantid.toString(),
              //         category_id: "");
              //     Get.toNamed(AppRoutes.moreProducts, arguments: {
              //       'restaurant_id': widget.Restaurantid.toString(),
              //       'category_id': '',
              //     });
              //   },
              //   splashColor: Colors.transparent,
              //   highlightColor: Colors.transparent,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text(
              //         "See All",
              //         style: AppFontStyle.text_14_600(AppColors.primary,family: AppFontFamily.gilroyRegular),
              //       ),
              //       wBox(4),
              //       Icon(
              //         Icons.arrow_forward_sharp,
              //         color: AppColors.primary,
              //         size: 18,
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
          hBox(13.h),
          catValue.isEmpty ? CustomNoDataFound(heightBox: hBox(0.h)) :
          GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: catValue.length ?? 0,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6.w,
                crossAxisSpacing: 14.w,
                mainAxisSpacing: 5.h,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      // specific_product_controllerontroller.specific_Product_Api(
                      //   productId: catValue[index].id.toString(),
                      //   categoryId: catValue[index].categoryId.toString(),
                      // );
                      // Get.to(ProductDetailsScreen(
                      //   restaurantId: restaurantId.toString(),
                      //   productId:  catValue[index].id.toString(),
                      //   categoryId: catValue[index].categoryId.toString(),
                      //   categoryName:  catValue[index].categoryName.toString(),
                      // ));
                    },
                    child: CustomBanner(
                      index: index,
                      product_id: catValue[index].id.toString(),
                      categoryId: catValue[index].categoryId.toString(),
                      image: catValue[index].urlImage,
                      title: catValue[index].title,
                      // rating: controller.restaurant_Data.value.moreProducts![index].rating.toString(),
                      is_in_wishlist:catValue[index].isInWishlist,
                      isLoading: catValue[index].isLoading,
                      sale_price: catValue[index].salePrice ?? catValue[index].regularPrice,
                      regular_price: catValue[index].regularPrice,
                      shop_name: catValue[index].restoName,
                      categoryName:  catValue[index].categoryName,
                    ));
              }),
          hBox(20.h),
        ],
      ),
    );
  }
}
class _PinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _PinnedHeaderDelegate({
    required this.child,
    required this.height,
  });

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: height,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant _PinnedHeaderDelegate oldDelegate) {
    return child != oldDelegate.child || height != oldDelegate.height;
  }
}
