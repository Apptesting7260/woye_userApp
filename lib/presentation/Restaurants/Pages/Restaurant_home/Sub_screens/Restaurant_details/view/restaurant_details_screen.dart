import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Constant/app_urls.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/main.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Product_details/pharmacy_product_details_screen.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/More_Products/controller/more_products_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/controller/specific_product_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/view/product_details_screen.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/controller/RestaurantDetailsController.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/modal/singal_restaurant_modal.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Reviews/controller/more_products_controller.dart';
import 'package:woye_user/shared/widgets/CircularProgressIndicator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:woye_user/shared/widgets/custom_no_data_found.dart';
import 'package:woye_user/shared/widgets/shimmer.dart';

import '../../../../../../../Core/Utils/image_cache_height.dart';
import '../../../../../../../Shared/theme/font_family.dart';
import '../../../../Restaurant_wishlist/Controller/aad_product_wishlist_Controller/add_product_wishlist.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  final String Restaurantid;

  RestaurantDetailsScreen({super.key, required this.Restaurantid});

  @override
  State<RestaurantDetailsScreen> createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  final RestaurantDetailsController controller = Get.put(RestaurantDetailsController());

  final specific_Product_Controller specific_product_controllerontroller = Get.put(specific_Product_Controller());

  final seeAll_Product_Controller seeallproductcontroller = Get.put(seeAll_Product_Controller());

  final SeeAllProductReviewController seeAllProductReviewController = Get.put(SeeAllProductReviewController());
  final AddProductWishlistController addWishlistController = Get.put(AddProductWishlistController());

  @override
  void initState() {
    controller.restaurant_Details_Api(id: widget.Restaurantid);
    // TODO: implement initState
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
            // const Spacer(),
            GestureDetector(
              onTap: () {
                Share.share(
                    '${AppUrls.hostUrl}/restaurants?id=${widget.Restaurantid}',
                    subject:
                        controller.restaurant_Data.value.restaurant?.shopName ?? 'Share Restaurant');
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
                    controller.restaurant_Details_Api(id: widget.Restaurantid);
                  },
                );
              } else {
                return GeneralExceptionWidget(
                  onPress: () {
                    controller.restaurant_Details_Api(id: widget.Restaurantid);
                  },
                );
              }
            case Status.COMPLETED:
              return Scaffold(
                body: RefreshIndicator(
                    onRefresh: () async {
                      controller.restaurant_Details_Api(id: widget.Restaurantid);
                    },
                    child: SingleChildScrollView(
                      // padding: REdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: REdgeInsets.symmetric(horizontal: 24),
                            child: mainBanner(),
                          ),
                          hBox(28.h),
                          // openHours(),
                          // hBox(30),
                          // description(),
                          // if (controller
                          //     .restaurant_Data.value.review!.isNotEmpty)
                          //   reviews(),
                          categoriesList(),
                          if(controller.restaurant_Data.value.highlights?.isNotEmpty ?? false)...[
                            highlights(widget.Restaurantid),
                          ],
                          if(controller.restaurant_Data.value.highlights?.isEmpty ?? true)...[
                            hBox(20.h),
                          ],
                            if((controller.restaurant_Data.value.categories?.data.isNotEmpty ?? false) && controller.categoriesIndex.value != 0)...[
                              categoriesProducts(context,widget.Restaurantid),
                            ],
                          if( /*(controller.restaurant_Data.value.moreProducts?.isNotEmpty ?? false) && */controller.categoriesIndex.value == 0)...[
                            moreProducts(context,widget.Restaurantid),
                          ],
                          hBox(30),
                        ],
                      ),
                    )),
              );
          }
        }));
  }

  Widget highlights(restaurantId) {
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
              itemCount: controller.restaurant_Data.value.highlights?.length ?? 0,
              itemBuilder: (context, index) {
              controller.restaurant_Data.value.highlights![index].isInWishlist.value = controller.restaurant_Data.value.highlights![index].isWishlist == "true" ? true : false;
              final item = controller.restaurant_Data.value.highlights?[index];
              final price = item?.salePrice ?? item?.regularPrice ?? 0;
              return GestureDetector(
                onTap: (){
                  specific_product_controllerontroller.specific_Product_Api(
                    productId: controller.restaurant_Data.value.highlights![index].id.toString(),
                    categoryId: controller.restaurant_Data.value.highlights![index].categoryId.toString(),
                  );
                  Get.to(ProductDetailsScreen(
                    productId: controller.restaurant_Data.value.highlights![index].id.toString(),
                    categoryId: controller.restaurant_Data.value.highlights![index].categoryId.toString(),
                    categoryName: controller.restaurant_Data.value.highlights![index].category?.name.toString() ?? "",
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
                          controller.restaurant_Data.value.highlights![index].urlImage != null ?
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.r),
                            child: CachedNetworkImage(
                              memCacheHeight: memCacheHeight,
                              imageUrl: controller.restaurant_Data.value.highlights![index].urlImage.toString(),
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
                          ) : Container(
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
                                    controller.restaurant_Data.value.highlights?[index].isInWishlist.value = !controller.restaurant_Data.value.highlights![index].isInWishlist.value;
                                    controller.restaurant_Data.value.highlights?[index].isLoading.value = true;
                                    await addWishlistController.restaurant_add_product_wishlist(
                                      categoryId: controller.restaurant_Data.value.highlights![index].categoryId.toString(),
                                      product_id:controller.restaurant_Data.value.highlights![index].id.toString(),
                                    );
                                  },
                                  child: controller.restaurant_Data.value.highlights![index].isLoading.value
                                  ? circularProgressIndicator(size: 18)
                                  : Icon(
                                    controller.restaurant_Data.value.highlights![index].isInWishlist.value ?
                                    Icons.favorite : Icons.favorite_border_outlined,
                                    size: 22,
                                  ),
                                ),
                            ),
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
                        item?.restoName.toString() ?? "",
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

  Widget mainBanner() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: CachedNetworkImage(
              memCacheHeight: memCacheHeight,
              width: Get.width,
              imageUrl: controller.restaurant_Data.value.restaurant!.shopimage.toString(),
              placeholder: (context, url) => const ShimmerWidget(),
              errorWidget: (context, url, error) => Container(
                  width: double.maxFinite,
                  height: 220.h,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
              border: Border.all(color: AppColors.textFieldBorder),
              borderRadius: BorderRadius.circular(20.r),
              ),
              child:  Icon(Icons.broken_image_rounded,color: AppColors.textFieldBorder)),
              fit: BoxFit.cover,
            )),
        hBox(15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                controller.restaurant_Data.value.restaurant!.shopName
                    .toString()
                    .capitalize!,
                style: AppFontStyle.text_22_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
                maxLines: 2,
              ),
            ),
            wBox(5.w),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.restaurantInformationScreen,
                  arguments: {
                  "restaurantId" : widget.Restaurantid,
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
            //   "${controller.travelTime.toStringAsFixed(0)} Min",
            //   // "32min",
            //   style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
            // ),
            // wBox(4),
            // Text(
            //   "•",
            //   style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
            // ),
            // wBox(4),
            // Text(
            //   // "2km",
            //   "${controller.distance.toStringAsFixed(2)} KM",
            //   style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
            // ),
            // wBox(4),
            // Text(
            //   "•",
            //   style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
            // ),
            // wBox(4),
            SvgPicture.asset("assets/svg/star-yellow.svg",height: 16,width: 17,),
            wBox(4),
            Text(
              "${controller.restaurant_Data.value.averageRating}/5",
              style: AppFontStyle.text_15_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
            ),
            wBox(5.w),
            GestureDetector(
              onTap: () {
                if(controller.restaurant_Data.value.review?.length != 0) {
                  Get.toNamed(
                    AppRoutes.productReviews,
                    arguments: {
                      'product_id': widget.Restaurantid.toString(),
                      'product_review': controller.restaurant_Data.value
                          .averageRating,
                      'review_count': controller.restaurant_Data.value
                          .totalReviews.toString(),
                      "type": "restaurant",
                    },
                  );
                  seeAllProductReviewController.seeAllProductReviewApi(
                      vendorId: widget.Restaurantid.toString(),
                      type: "restaurant");
                }
              },
              child: Text(
                "(${controller.restaurant_Data.value.review?.length} Reviews)",
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
        // hBox(18.h),
        // Row(
        //   children: [
        //     const Icon(Icons.person_outline_rounded),
        //     wBox(8),
        //     Flexible(
        //       child: Text(
        //         "${controller.restaurant_Data.value.restaurant!.firstName ?? ""} ${controller.restaurant_Data.value.restaurant!.lastName ?? ""}",
        //         style: TextStyle(
        //           fontSize: 14.sp,
        //           color: AppColors.darkText,
        //           fontWeight: FontWeight.w400,
        //             fontFamily: AppFontFamily.gilroyMedium
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
        //         controller.restaurant_Data.value.restaurant!.email.toString(),
        //         overflow: TextOverflow.ellipsis,
        //         style: AppFontStyle.text_15_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
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
        //         controller.restaurant_Data.value.restaurant!.shopAddress
        //             .toString(),
        //         maxLines: 2,
        //         overflow: TextOverflow.ellipsis,
        //         style: AppFontStyle.text_14_400(
        //           AppColors.darkText,family: AppFontFamily.gilroyMedium
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
    );
  }

  //
  // Widget openHours() {
  //   var openingHours = controller.restaurant_Data.value.restaurant!.openingHours;
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         "Open Hours",
  //         style: AppFontStyle.text_18_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
  //       ),
  //       hBox(14),
  //       for (var openingHour in openingHours!)
  //         Padding(
  //           padding: const EdgeInsets.only(bottom: 10.0),
  //           child: SizedBox(
  //             // width: Get.width * 0.7,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   openingHour.day ?? "",
  //                   style: AppFontStyle.text_16_400(AppColors.lightText,family: AppFontFamily.gilroyRegular),
  //                   overflow: TextOverflow.ellipsis,
  //                 ),
  //                 Text(
  //                   openingHour.status == null
  //                       ? 'Closed'
  //                       : "${openingHour.open} - ${openingHour.close}",
  //                   style: AppFontStyle.text_16_400(AppColors.lightText,family: AppFontFamily.gilroyRegular),
  //                   textAlign: TextAlign.start,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //     ],
  //   );
  // }
  //
  // Widget description() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         "Descriptions",
  //         style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
  //       ),
  //       hBox(10),
  //       Text(
  //         controller.restaurant_Data.value.restaurant!.shopDes.toString(),
  //         maxLines: 100,
  //         style: AppFontStyle.text_16_400(AppColors.lightText,family: AppFontFamily.gilroyRegular),
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget reviews() {
  //   return Padding(
  //     padding: EdgeInsets.only(top: 30.h),
  //     child: Column(
  //       children: [
  //         Column(
  //           children: [
  //             ListView.builder(
  //               shrinkWrap: true,
  //               physics: const NeverScrollableScrollPhysics(),
  //               itemCount: controller.restaurant_Data.value.review!.length,
  //               itemBuilder: (context, index) {
  //                 return controller.restaurant_Data.value.review![index].user !=
  //                         null
  //                     ? Column(
  //                         children: [
  //                           Row(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               ClipRRect(
  //                                 borderRadius: BorderRadius.circular(50.r),
  //                                 child: CachedNetworkImage(
  //                                   imageUrl: controller.restaurant_Data.value
  //                                       .review![index].user!.imageUrl
  //                                       .toString(),
  //                                   fit: BoxFit.cover,
  //                                   height: 50.h,
  //                                   width: 50.h,
  //                                   errorWidget: (context, url, error) =>
  //                                       Center(
  //                                           child: Container(
  //                                     height: 50.h,
  //                                     width: 50.h,
  //                                     color: AppColors.gray.withOpacity(.2),
  //                                     child: Icon(
  //                                       Icons.person,
  //                                       color: AppColors.gray,
  //                                     ),
  //                                   )),
  //                                   placeholder: (context, url) =>
  //                                       Shimmer.fromColors(
  //                                     baseColor: AppColors.gray,
  //                                     highlightColor: AppColors.lightText,
  //                                     child: Container(
  //                                       decoration: BoxDecoration(
  //                                         color: AppColors.gray,
  //                                         borderRadius:
  //                                             BorderRadius.circular(20.r),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                               wBox(15),
  //                               Flexible(
  //                                 flex: 4,
  //                                 child: Column(
  //                                   crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                   children: [
  //                                     Container(
  //                                       decoration: BoxDecoration(
  //                                         color: AppColors.bgColor,
  //                                         borderRadius:
  //                                             BorderRadius.circular(20),
  //                                       ),
  //                                       child: Padding(
  //                                         padding: EdgeInsets.all(10.h),
  //                                         child: Column(
  //                                           crossAxisAlignment:
  //                                               CrossAxisAlignment.start,
  //                                           mainAxisAlignment:
  //                                               MainAxisAlignment.start,
  //                                           children: [
  //                                             Text(
  //                                               controller
  //                                                   .restaurant_Data
  //                                                   .value
  //                                                   .review![index]
  //                                                   .user!
  //                                                   .firstName
  //                                                   .toString(),
  //                                               style: AppFontStyle.text_16_400(
  //                                                   AppColors.darkText,family: AppFontFamily.gilroyMedium),
  //                                             ),
  //                                             hBox(5),
  //                                             RatingBar.readOnly(
  //                                               filledIcon: Icons.star,
  //                                               emptyIcon: Icons.star,
  //                                               filledColor: AppColors.goldStar,
  //                                               emptyColor:
  //                                                   AppColors.normalStar,
  //                                               initialRating: double.parse(
  //                                                   controller
  //                                                       .restaurant_Data
  //                                                       .value
  //                                                       .review![index]
  //                                                       .rating!
  //                                                       .toString()),
  //                                               maxRating: 5,
  //                                               size: 20.h,
  //                                             ),
  //                                             hBox(10),
  //                                             Text(
  //                                               controller.restaurant_Data.value
  //                                                   .review![index].message
  //                                                   .toString(),
  //                                               style: AppFontStyle.text_16_400(
  //                                                   AppColors.darkText,family: AppFontFamily.gilroyMedium),
  //                                               maxLines: 3,
  //                                             ),
  //                                             hBox(10),
  //                                             Text(
  //                                               controller.formatDate(controller
  //                                                   .restaurant_Data
  //                                                   .value
  //                                                   .review![index]
  //                                                   .updatedAt
  //                                                   .toString()),
  //                                               style: AppFontStyle.text_16_400(
  //                                                   AppColors.lightText,family: AppFontFamily.gilroyRegular),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                     ),
  //                                     if (controller.restaurant_Data.value
  //                                             .review![index].reply !=
  //                                         null)
  //                                       Padding(
  //                                         padding: EdgeInsets.only(top: 10.h),
  //                                         child: Row(
  //                                           crossAxisAlignment:
  //                                               CrossAxisAlignment.start,
  //                                           mainAxisAlignment:
  //                                               MainAxisAlignment.end,
  //                                           children: [
  //                                             Icon(
  //                                               Icons.reply,
  //                                               color: AppColors.primary,
  //                                             ),
  //                                             Flexible(
  //                                               child: Text(
  //                                                 controller
  //                                                     .restaurant_Data
  //                                                     .value
  //                                                     .review![index]
  //                                                     .reply
  //                                                     .toString()
  //                                                     .trim(),
  //                                                 style:
  //                                                     AppFontStyle.text_16_400(
  //                                                         AppColors.lightText,family: AppFontFamily.gilroyMedium),
  //                                                 maxLines: 100,
  //                                                 overflow:
  //                                                     TextOverflow.ellipsis,
  //                                               ),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                   ],
  //                                 ),
  //                               )
  //                             ],
  //                           ),
  //                           Padding(
  //                             padding: REdgeInsets.symmetric(vertical: 10),
  //                             child: const Divider(),
  //                           ),
  //                         ],
  //                       )
  //                     : const SizedBox();
  //               },
  //             ),
  //           ],
  //         ),
  //         controller.restaurant_Data.value.totalReviews!.toInt() > 0
  //             ? Column(
  //                 children: [
  //                   hBox(10),
  //                   InkWell(
  //                     splashColor: Colors.transparent,
  //                     highlightColor: Colors.transparent,
  //                     onTap: () {
  //                       Get.toNamed(
  //                         AppRoutes.productReviews,
  //                         arguments: {
  //                           'product_id': widget.Restaurantid.toString(),
  //                           'product_review':
  //                               controller.restaurant_Data.value.averageRating,
  //                           'review_count': controller
  //                               .restaurant_Data.value.totalReviews
  //                               .toString(),
  //                           "type": "restaurant",
  //                         },
  //                       );
  //                       seeAllProductReviewController.seeAllProductReviewApi(
  //                           vendorId: widget.Restaurantid.toString(),
  //                           type: "restaurant");
  //                     },
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Text(
  //                           "See All (${controller.restaurant_Data.value.totalReviews.toString()})",
  //                           style: AppFontStyle.text_14_600(AppColors.primary,family: AppFontFamily.gilroyRegular),
  //                         ),
  //                         Icon(
  //                           Icons.arrow_forward,
  //                           color: AppColors.primary,
  //                           size: 20.h,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               )
  //             : const SizedBox(),
  //       ],
  //     ),
  //   );
  // }

  Widget moreProducts(context,String? Restaurantid) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hBox(10.h),
          Obx(
            ()=> Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "All Products",
                  style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
                ),
                if(controller.restaurant_Data.value.moreProducts?.isNotEmpty ?? false)
                InkWell(
                  onTap: () {
                    seeallproductcontroller.seeAll_Product_Api(
                        restaurant_id: widget.Restaurantid.toString(),
                        category_id: "");
                    Get.toNamed(AppRoutes.moreProducts, arguments: {
                      'restaurant_id': widget.Restaurantid.toString(),
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
                        style: AppFontStyle.text_14_600(AppColors.primary,family: AppFontFamily.gilroyRegular),
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
          ),
          hBox(15),
          controller.restaurant_Data.value.moreProducts!.isEmpty ? CustomNoDataFound(heightBox: hBox(0.h)) :
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
                        productId: controller.restaurant_Data.value.moreProducts![index].id.toString(),
                        categoryId: controller.restaurant_Data.value.moreProducts![index].categoryId.toString(),
                      );
                      Get.to(ProductDetailsScreen(
                        restaurantId: Restaurantid.toString(),
                        productId: controller.restaurant_Data.value.moreProducts![index].id.toString(),
                        categoryId: controller.restaurant_Data.value.moreProducts![index].categoryId.toString(),
                        categoryName: controller.restaurant_Data.value.moreProducts![index].categoryName.toString(),
                      ));
                    },
                    child: CustomItemBanner(
                      index: index,
                      product_id: controller.restaurant_Data.value.moreProducts![index].id.toString(),
                      categoryId: controller.restaurant_Data.value.moreProducts![index].categoryId.toString(),
                      image: controller.restaurant_Data.value.moreProducts![index].urlImage,
                      title: controller.restaurant_Data.value.moreProducts![index].title,
                      // rating: controller.restaurant_Data.value.moreProducts![index].rating.toString(),
                      is_in_wishlist: controller.restaurant_Data.value.moreProducts![index].isInWishlist,
                      isLoading: controller.restaurant_Data.value.moreProducts![index].isLoading,
                      sale_price: controller.restaurant_Data.value.moreProducts![index].salePrice.toString(),
                      regular_price: controller.restaurant_Data.value.moreProducts![index].regularPrice.toString(),
                      resto_name: controller.restaurant_Data.value.moreProducts![index].restoName.toString(),
                    ));
              })
        ],
      ),
    );
  }

  Widget categoriesList() {
    // final categoryKeys = controller.restaurant_Data.value.categories?.data.keys.toList() ?? [];
    final categoryKeys = ["All", ...(controller.restaurant_Data.value.categories?.data.keys.toList() ?? [])];

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

  Widget categoriesProducts(context,String? restaurantId) {
    final categoryKeys = ["All", ...(controller.restaurant_Data.value.categories?.data.keys.toList() ?? [])];

    final selectedKey = controller.categoriesIndex.value == 0 ? "All" : categoryKeys[controller.categoriesIndex.value];

    final List<AllProducts> catValue =
    // controller.categoriesIndex.value == 0
    //     ? controller.restaurant_Data.value.categories?.data.values.expand((e) => e).toList() ?? []
    //     :
    controller.restaurant_Data.value.categories?.data[selectedKey] ?? [];

    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hBox(10.h),
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
          hBox(15),
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
                      specific_product_controllerontroller.specific_Product_Api(
                        productId: catValue[index].id.toString(),
                        categoryId: catValue[index].categoryId.toString(),
                      );
                      Get.to(ProductDetailsScreen(
                        restaurantId: restaurantId.toString(),
                        productId:  catValue[index].id.toString(),
                        categoryId: catValue[index].categoryId.toString(),
                        categoryName:  catValue[index].categoryName.toString(),
                      ));
                    },
                    child: CustomItemBanner(
                      index: index,
                      product_id: catValue[index].id.toString(),
                      categoryId: catValue[index].categoryId.toString(),
                      image: catValue[index].urlImage,
                      title: catValue[index].title,
                      // rating: controller.restaurant_Data.value.moreProducts![index].rating.toString(),
                      is_in_wishlist:catValue[index].isInWishlist,
                      isLoading: catValue[index].isLoading,
                      sale_price: catValue[index].salePrice,
                      regular_price: catValue[index].regularPrice,
                      resto_name: catValue[index].restoName,
                    ));
              })
        ],
      ),
    );
  }
}
