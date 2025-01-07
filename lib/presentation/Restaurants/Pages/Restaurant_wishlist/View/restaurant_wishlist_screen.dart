import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Shared/Widgets/custom_search_filter.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/controller/specific_product_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/view/product_details_screen.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_wishlist/Controller/aad_product_wishlist_Controller/add_product_wishlist.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_wishlist/Controller/restaurant_wishlist_controller.dart';
import 'package:woye_user/shared/widgets/CircularProgressIndicator.dart';

class RestaurantWishlistScreen extends StatefulWidget {
  const RestaurantWishlistScreen({super.key});

  @override
  State<RestaurantWishlistScreen> createState() =>
      _RestaurantWishlistScreenState();
}

class _RestaurantWishlistScreenState extends State<RestaurantWishlistScreen> {
  @override
  void initState() {
    // TODO: implement initState
    print('thjjfrioey irt mt2');
    controller.restaurant_product_wishlist_api();
    super.initState();
  }

  final RestaurantWishlistController controller =
      Get.put(RestaurantWishlistController());

  final AddProductWishlistController add_Wishlist_Controller =
      Get.put(AddProductWishlistController());

  final specific_Product_Controller specific_product_controller =
      Get.put(specific_Product_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: false,
        isActions: true,
        title: Text(
          "Wishlist",
          style: AppFontStyle.text_24_600(AppColors.darkText),
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
                  controller.restaurantProductWishlistRefreshApi();
                },
              );
            } else {
              return GeneralExceptionWidget(
                onPress: () {
                  controller.restaurantProductWishlistRefreshApi();
                },
              );
            }
          case Status.COMPLETED:
            return RefreshIndicator(
              onRefresh: () async {
                controller.restaurantProductWishlistRefreshApi();
              },
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 24.w),
                child: controller.wishlistData.value.categoryProduct!.isEmpty
                    ? Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          hBox(Get.height / 3),
                          Center(
                            child: Image.asset(
                              ImageConstants.wishlistEmpty,
                              height: 70.h,
                              width: 100.h,
                            ),
                          ),
                          hBox(10.h),
                          Text(
                            "Your wishlist is empty!",
                            style: AppFontStyle.text_20_600(AppColors.darkText),
                          ),
                          hBox(5.h),
                          Text(
                            "Explore more and shortlist some items",
                            style:
                                AppFontStyle.text_16_400(AppColors.mediumText),
                          ),
                        ],
                      )
                    : CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            automaticallyImplyLeading: false,
                            pinned: false,
                            snap: true,
                            floating: true,
                            expandedHeight: 70.h,
                            surfaceTintColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            flexibleSpace: FlexibleSpaceBar(
                              titlePadding: REdgeInsets.only(bottom: 15),
                              title: SizedBox(
                                height: 35.h,
                                child: CustomSearchFilter(
                                  onChanged: (value) {
                                    controller.filterWishlistData(value);
                                  },
                                  controller: controller.searchController,
                                  showfilterIcon: false,
                                ),
                              ),
                              centerTitle: true,
                            ),
                          ),
                          if (controller
                              .wishlistData.value.categoryProduct!.isNotEmpty)
                            SliverGrid(
                                delegate: SliverChildBuilderDelegate(
                                    childCount: controller.filteredWishlistData
                                        .length, (context, index) {
                                  var product =
                                      controller.filteredWishlistData[index];
                                  return GestureDetector(
                                      onTap: () {
                                        Get.to(ProductDetailsScreen(
                                          categoryName:
                                              product.categoryName.toString(),
                                          productId: product.id.toString(),
                                          categoryId:
                                              product.categoryId.toString(),
                                        ));
                                        specific_product_controller
                                            .specific_Product_Api(
                                          productId: product.id.toString(),
                                          categoryId:
                                              product.categoryId.toString(),
                                        );
                           },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              Container(
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r),
                                                ),
                                                child: Center(
                                                  child: CachedNetworkImage(
                                                    imageUrl: product.urlImage
                                                        .toString(),
                                                    fit: BoxFit.cover,
                                                    height: 160.h,
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                    placeholder:
                                                        (context, url) =>
                                                            Shimmer.fromColors(
                                                      baseColor: AppColors.gray,
                                                      highlightColor:
                                                          AppColors.lightText,
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppColors.gray,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.r),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Obx(
                                                () => Container(
                                                  margin: REdgeInsets.only(
                                                      top: 10, right: 10),
                                                  padding: REdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                    color: AppColors
                                                        .greyBackground,
                                                  ),
                                                  child: InkWell(
                                                    highlightColor:
                                                        Colors.transparent,
                                                    splashColor:
                                                        Colors.transparent,
                                                    onTap: () {
                                                      product.isLoading.value =
                                                          true;
                                                      add_Wishlist_Controller
                                                          .restaurant_add_product_wishlist(
                                                        categoryId: "",
                                                        product_id: product.id
                                                            .toString(),
                                                      );
                                                      print(
                                                          "product_id ${product.id.toString()}");
                                                    },
                                                    child: product
                                                            .isLoading.value
                                                        ? circularProgressIndicator(
                                                            size: 18)
                                                        : Icon(
                                                            product.isInWishlist ==
                                                                    true
                                                                ? Icons.favorite
                                                                : Icons
                                                                    .favorite_border_outlined,
                                                            size: 22,
                                                          ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          hBox(10.h),
                                          Row(
                                            children: [
                                              Text(
                                                "\$${product.salePrice}",
                                                textAlign: TextAlign.left,
                                                style: AppFontStyle.text_16_600(
                                                    AppColors.primary),
                                              ),
                                              wBox(5),
                                              Text(
                                                "\$${product.regularPrice}",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,

                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w300,
                                                    color: AppColors.lightText,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    decorationColor:
                                                        AppColors.lightText),

                                                //  AppFontStyle.text_14_300(AppColors.lightText),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            product.title.toString(),
                                            textAlign: TextAlign.left,
                                            style: AppFontStyle.text_16_400(
                                                AppColors.darkText),
                                          ),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                  "assets/svg/star-yellow.svg"),
                                              wBox(4),
                                              Text(
                                                "${product.rating.toString()}/5",
                                                style: AppFontStyle.text_14_300(
                                                    AppColors.lightText),
                                              ),
                                              wBox(4),
                                              // Text(
                                              //   controller
                                              //       .wishlistData
                                              //       .value
                                              //       .categoryProduct![index].restoName
                                              //       .toString(),
                                              //   overflow: TextOverflow.ellipsis,
                                              //   textAlign: TextAlign.left,
                                              //   style: AppFontStyle.text_14_300(
                                              //       AppColors.lightText),
                                              // ),
                                            ],
                                          )
                                        ],
                                      ));
                                  //  categoryItem(index);
                                }),
                                gridDelegate:
                                    (SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.6.h,
                                  crossAxisSpacing: 16.w,
                                  mainAxisSpacing: 5.h,
                                ))),
                          SliverToBoxAdapter(
                            child: hBox(100),
                          )
                        ],
                      ),
              ),
            );
          // return RefreshIndicator(
          //   onRefresh: () async {
          //     controller.restaurantProductWishlistRefreshApi();
          //   },
          //   child: Padding(
          //     padding: REdgeInsets.symmetric(horizontal: 24.w),
          //     child: controller.wishlistData.value.categoryProduct!.isEmpty
          //         ? Column(
          //             // mainAxisAlignment: MainAxisAlignment.center,
          //             // crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //               hBox(Get.height / 3),
          //               Center(
          //                 child: Image.asset(
          //                   ImageConstants.wishlistEmpty,
          //                   height: 70.h,
          //                   width: 100.h,
          //                 ),
          //               ),
          //               hBox(10.h),
          //               Text(
          //                 "Your wishlist is empty!",
          //                 style: AppFontStyle.text_20_600(AppColors.darkText),
          //               ),
          //               hBox(5.h),
          //               Text(
          //                 "Explore more and shortlist some items",
          //                 style:
          //                     AppFontStyle.text_16_400(AppColors.mediumText),
          //               ),
          //             ],
          //           )
          //         : CustomScrollView(
          //             slivers: [
          //               SliverAppBar(
          //                 automaticallyImplyLeading: false,
          //                 pinned: false,
          //                 snap: true,
          //                 floating: true,
          //                 expandedHeight: 70.h,
          //                 surfaceTintColor: Colors.transparent,
          //                 backgroundColor: Colors.transparent,
          //                 shape: RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(15)),
          //                 flexibleSpace: FlexibleSpaceBar(
          //                   titlePadding: REdgeInsets.only(bottom: 15),
          //                   title: SizedBox(
          //                     height: 35.h,
          //                     child: CustomSearchFilter(
          //                       onChanged: (value) {
          //                         controller.filterWishlistData(value);
          //                       },
          //                       controller: controller.searchController,
          //                       showfilterIcon: false,
          //                     ),
          //                   ),
          //                   centerTitle: true,
          //                 ),
          //               ),
          //               if (controller
          //                   .wishlistData.value.categoryProduct!.isNotEmpty)
          //                 SliverGrid(
          //                     delegate: SliverChildBuilderDelegate(
          //                         childCount: controller.filteredWishlistData
          //                             .length, (context, index) {
          //                       var product =
          //                           controller.filteredWishlistData[index];
          //                       return GestureDetector(
          //                           onTap: () {
          //                             Get.to(ProductDetailsScreen(
          //                               product_id: controller.wishlistData
          //                                   .value.categoryProduct![index].id
          //                                   .toString(),
          //                               category_id: controller
          //                                   .wishlistData
          //                                   .value
          //                                   .categoryProduct![index]
          //                                   .categoryId
          //                                   .toString(),
          //                               category_name: controller
          //                                   .wishlistData
          //                                   .value
          //                                   .categoryProduct![index]
          //                                   .categoryName
          //                                   .toString(),
          //                             ));
          //                             specific_product_controller
          //                                 .specific_Product_Api(
          //                               product_id: controller.wishlistData
          //                                   .value.categoryProduct![index].id
          //                                   .toString(),
          //                               category_id: controller
          //                                   .wishlistData
          //                                   .value
          //                                   .categoryProduct![index]
          //                                   .categoryId
          //                                   .toString(),
          //                             );
          //                           },
          //                           child: Column(
          //                             crossAxisAlignment:
          //                                 CrossAxisAlignment.start,
          //                             children: [
          //                               Stack(
          //                                 alignment: Alignment.topRight,
          //                                 children: [
          //                                   Container(
          //                                     clipBehavior: Clip.antiAlias,
          //                                     decoration: BoxDecoration(
          //                                       borderRadius:
          //                                           BorderRadius.circular(
          //                                               20.r),
          //                                     ),
          //                                     child: Center(
          //                                       child: CachedNetworkImage(
          //                                         imageUrl: product.urlImage
          //                                             .toString(),
          //                                         fit: BoxFit.cover,
          //                                         height: 160.h,
          //                                         errorWidget: (context, url,
          //                                                 error) =>
          //                                             const Icon(Icons.error),
          //                                         placeholder:
          //                                             (context, url) =>
          //                                                 Shimmer.fromColors(
          //                                           baseColor: AppColors.gray,
          //                                           highlightColor:
          //                                               AppColors.lightText,
          //                                           child: Container(
          //                                             decoration:
          //                                                 BoxDecoration(
          //                                               color: AppColors.gray,
          //                                               borderRadius:
          //                                                   BorderRadius
          //                                                       .circular(
          //                                                           20.r),
          //                                             ),
          //                                           ),
          //                                         ),
          //                                       ),
          //                                     ),
          //                                   ),
          //                                   Obx(
          //                                     () => Container(
          //                                       margin: REdgeInsets.only(
          //                                           top: 10, right: 10),
          //                                       padding: REdgeInsets.all(6),
          //                                       decoration: BoxDecoration(
          //                                         borderRadius:
          //                                             BorderRadius.circular(
          //                                                 10.r),
          //                                         color: AppColors
          //                                             .greyBackground,
          //                                       ),
          //                                       child: InkWell(
          //                                         highlightColor:
          //                                             Colors.transparent,
          //                                         splashColor:
          //                                             Colors.transparent,
          //                                         onTap: () {
          //                                           product.isLoading.value =
          //                                               true;
          //                                           add_Wishlist_Controller
          //                                               .restaurant_add_product_wishlist(
          //                                             categoryId: "",
          //                                             product_id: product.id
          //                                                 .toString(),
          //                                           );
          //                                           print(
          //                                               "product_id ${product.id.toString()}");
          //                                         },
          //                                         child: product
          //                                                 .isLoading.value
          //                                             ? circularProgressIndicator(
          //                                                 size: 18)
          //                                             : Icon(
          //                                                 product.isInWishlist ==
          //                                                         true
          //                                                     ? Icons.favorite
          //                                                     : Icons
          //                                                         .favorite_border_outlined,
          //                                                 size: 22,
          //                                               ),
          //                                       ),
          //                                     ),
          //                                   )
          //                                 ],
          //                               ),
          //                               hBox(10.h),
          //                               Row(
          //                                 children: [
          //                                   Text(
          //                                     "\$${product.salePrice}",
          //                                     textAlign: TextAlign.left,
          //                                     style: AppFontStyle.text_16_600(
          //                                         AppColors.primary),
          //                                   ),
          //                                   wBox(5),
          //                                   Text(
          //                                     "\$${product.regularPrice}",
          //                                     overflow: TextOverflow.ellipsis,
          //                                     textAlign: TextAlign.left,
          //
          //                                     style: TextStyle(
          //                                         fontSize: 14.sp,
          //                                         fontWeight: FontWeight.w300,
          //                                         color: AppColors.lightText,
          //                                         decoration: TextDecoration
          //                                             .lineThrough,
          //                                         decorationColor:
          //                                             AppColors.lightText),
          //
          //                                     //  AppFontStyle.text_14_300(AppColors.lightText),
          //                                   ),
          //                                 ],
          //                               ),
          //                               Text(
          //                                 product.title.toString(),
          //                                 textAlign: TextAlign.left,
          //                                 style: AppFontStyle.text_16_400(
          //                                     AppColors.darkText),
          //                               ),
          //                               Row(
          //                                 children: [
          //                                   SvgPicture.asset(
          //                                       "assets/svg/star-yellow.svg"),
          //                                   wBox(4),
          //                                   Text(
          //                                     "${product.rating.toString()}/5",
          //                                     style: AppFontStyle.text_14_300(
          //                                         AppColors.lightText),
          //                                   ),
          //                                   wBox(4),
          //                                   // Text(
          //                                   //   controller
          //                                   //       .wishlistData
          //                                   //       .value
          //                                   //       .categoryProduct![index].restoName
          //                                   //       .toString(),
          //                                   //   overflow: TextOverflow.ellipsis,
          //                                   //   textAlign: TextAlign.left,
          //                                   //   style: AppFontStyle.text_14_300(
          //                                   //       AppColors.lightText),
          //                                   // ),
          //                                 ],
          //                               )
          //                             ],
          //                           ));
          //                       //  categoryItem(index);
          //                     }),
          //                     gridDelegate:
          //                         (SliverGridDelegateWithFixedCrossAxisCount(
          //                       crossAxisCount: 2,
          //                       childAspectRatio: 0.6.h,
          //                       crossAxisSpacing: 16.w,
          //                       mainAxisSpacing: 5.h,
          //                     ))),
          //               SliverToBoxAdapter(
          //                 child: hBox(100),
          //               )
          //             ],
          //           ),
          //   ),
          // );
        }
      }),
    );
  }
}
