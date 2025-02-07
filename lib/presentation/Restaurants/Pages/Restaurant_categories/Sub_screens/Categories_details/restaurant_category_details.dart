import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Shared/Widgets/custom_search_filter.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Filter/controller/CategoriesFilter_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/controller/specific_product_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/view/product_details_screen.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_wishlist/Controller/aad_product_wishlist_Controller/add_product_wishlist.dart';

import '../../../../../../Data/components/GeneralException.dart';
import '../../../../../../Data/components/InternetException.dart';
import '../../../../../../shared/widgets/CircularProgressIndicator.dart';
import 'controller/RestaurantCategoriesDetailsController.dart';

class RestaurantCategoryDetails extends StatelessWidget {
  RestaurantCategoryDetails({super.key});

  final RestaurantCategoriesDetailsController controller =
      Get.put(RestaurantCategoriesDetailsController());

  final AddProductWishlistController add_Wishlist_Controller =
      Get.put(AddProductWishlistController());

  final specific_Product_Controller specific_product_controllerontroller =
      Get.put(specific_Product_Controller());

  final Categories_FilterController categoriesFilterController =
      Get.put(Categories_FilterController());

  @override
  Widget build(BuildContext context) {
    var args = Get.arguments;
    String categoryTitle = args['name'];
    int categoryId = args['id'];
    return Container(
      color: AppColors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            title: Text(
              categoryTitle,
              style: AppFontStyle.text_22_600(
                AppColors.darkText,
              ),
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
                      controller.restaurant_Categories_Details_Api(
                          id: categoryId.toString());
                    },
                  );
                } else {
                  return GeneralExceptionWidget(
                    onPress: () {
                      controller.restaurant_Categories_Details_Api(
                          id: categoryId.toString());
                    },
                  );
                }
              case Status.COMPLETED:
                return RefreshIndicator(
                    onRefresh: () async {
                      controller.restaurant_Categories_Details_Api(
                          id: categoryId.toString());
                    },
                    child: Padding(
                      padding: REdgeInsets.symmetric(horizontal: 24),
                      child: CustomScrollView(
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
                                child: (CustomSearchFilter(
                                  controller: controller.searchController,
                                  onChanged: (value) {
                                    if (controller.categoriesDetailsData.value
                                        .filterProduct!.isEmpty) {
                                      controller.searchDataFun(value);
                                    } else {
                                      controller.filterSearchDataFun(value);
                                    }
                                  },
                                  onFilterTap: () {
                                    Get.toNamed(
                                      AppRoutes.restaurantCategoriesFilter,
                                      arguments: {
                                        'categoryId': categoryId.toString()
                                      },
                                    );
                                    categoriesFilterController
                                        .restaurant_get_CategoriesFilter_Api();
                                  },
                                )),
                              ),
                              centerTitle: true,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: hBox(10.h),
                          ),
                          if (controller.categoriesDetailsData.value
                                  .filterProduct!.isEmpty &&
                              controller.categoriesDetailsData.value
                                  .categoryProduct!.isEmpty)
                            SliverToBoxAdapter(
                              child: Column(
                                children: [
                                  Center(
                                    child: SvgPicture.asset(
                                      ImageConstants.noData,
                                      height: 300.h,
                                      width: 200.h,
                                    ),
                                  ),
                                  Text(
                                    "We couldn't find any results",
                                    style: AppFontStyle.text_20_600(
                                        AppColors.darkText),
                                  ),
                                  hBox(5.h),
                                  Text(
                                    "Explore more and shortlist some items",
                                    style: AppFontStyle.text_16_400(
                                        AppColors.mediumText),
                                  ),
                                ],
                              ),
                            ),
                          if (controller.categoriesDetailsData.value
                              .filterProduct!.isEmpty)
                            SliverGrid(
                                delegate: SliverChildBuilderDelegate(
                                    childCount: controller.searchData.length,
                                    (context, index) {
                                  var product = controller.searchData[index];
                                  return GestureDetector(
                                      onTap: () {
                                        specific_product_controllerontroller
                                            .specific_Product_Api(
                                                productId:
                                                    product.id.toString(),
                                                categoryId:
                                                    categoryId.toString());
                                        Get.to(ProductDetailsScreen(
                                          productId: product.id.toString(),
                                          categoryId: categoryId.toString(),
                                          categoryName: categoryTitle,
                                        ));
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
                                                    width: double.maxFinite,
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
                                                    onTap: () async {
                                                      product.isInWishlist =
                                                          !product
                                                              .isInWishlist!;
                                                      product.isLoading.value =
                                                          true;
                                                      await add_Wishlist_Controller
                                                          .restaurant_add_product_wishlist(
                                                        categoryId: categoryId
                                                            .toString(),
                                                        product_id: product.id
                                                            .toString(),
                                                      );
                                                      product.isLoading.value =
                                                          false;
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
                                              product.salePrice != null
                                                  ? Text(
                                                      "\$${product.salePrice}",
                                                      textAlign: TextAlign.left,
                                                      style: AppFontStyle
                                                          .text_16_600(AppColors
                                                              .primary),
                                                    )
                                                  : Text(
                                                      "\$${product.regularPrice}",
                                                      textAlign: TextAlign.left,
                                                      style: AppFontStyle
                                                          .text_16_600(AppColors
                                                              .primary),
                                                    ),
                                              wBox(5.h),
                                              if (product.salePrice != null)
                                                Text(
                                                  "\$${product.regularPrice}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,

                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color:
                                                          AppColors.lightText,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      decorationColor:
                                                          AppColors.lightText),

                                                  //  AppFontStyle.text_14_300(AppColors.lightText),
                                                ),
                                            ],
                                          ),
                                          // hBox(10),
                                          Text(
                                            product.title.toString(),
                                            textAlign: TextAlign.left,
                                            style: AppFontStyle.text_16_400(
                                                AppColors.darkText),
                                          ),
                                          // hBox(10),

                                          // hBox(10),
                                          // Row(
                                          //   children: [
                                          //     SvgPicture.asset(
                                          //         "assets/svg/star-yellow.svg"),
                                          //     wBox(4),
                                          //     Text(
                                          //       "${product.rating.toString()}/5",
                                          //       style: AppFontStyle.text_14_300(
                                          //           AppColors.lightText),
                                          //     ),
                                          //     wBox(4),
                                          //     Flexible(
                                          //       child: Text(
                                          //         product.restoName.toString(),
                                          //         overflow:
                                          //             TextOverflow.ellipsis,
                                          //         textAlign: TextAlign.left,
                                          //         style:
                                          //             AppFontStyle.text_14_300(
                                          //                 AppColors.lightText),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // )
                                        ],
                                      ));
                                  //  categoryItem(index);
                                }),
                                gridDelegate:
                                    (SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.7.w,
                                  crossAxisSpacing: 16.w,
                                  mainAxisSpacing: 5.h,
                                ))),
                          if (controller.categoriesDetailsData.value
                              .filterProduct!.isNotEmpty)
                            SliverGrid(
                                delegate: SliverChildBuilderDelegate(
                                    childCount: controller
                                        .filterProductSearchData
                                        .length, (context, index) {
                                  var product =
                                      controller.filterProductSearchData[index];
                                  return GestureDetector(
                                      onTap: () {
                                        specific_product_controllerontroller
                                            .specific_Product_Api(
                                                productId:
                                                    product.id.toString(),
                                                categoryId:
                                                    categoryId.toString());
                                        Get.to(ProductDetailsScreen(
                                          productId: product.id.toString(),
                                          categoryId: categoryId.toString(),
                                          categoryName: categoryTitle,
                                        ));
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
                                                    onTap: () async {
                                                      product.isInWishlist =
                                                          !product
                                                              .isInWishlist!;
                                                      product.isLoading.value =
                                                          true;
                                                      await add_Wishlist_Controller
                                                          .restaurant_add_product_wishlist(
                                                        categoryId: categoryId
                                                            .toString(),
                                                        product_id: product.id
                                                            .toString(),
                                                      );
                                                      product.isLoading.value =
                                                          false;
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
                                          hBox(10),
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
                                          // hBox(10),
                                          Text(
                                            product.title.toString(),
                                            textAlign: TextAlign.left,
                                            style: AppFontStyle.text_16_400(
                                                AppColors.darkText),
                                          ),
                                          // hBox(10),

                                          // hBox(10),
                                          // Row(
                                          //   children: [
                                          //     SvgPicture.asset(
                                          //         "assets/svg/star-yellow.svg"),
                                          //     wBox(4),
                                          //     Text(
                                          //       "${product.rating.toString()}/5",
                                          //       style: AppFontStyle.text_14_300(
                                          //           AppColors.lightText),
                                          //     ),
                                          //     wBox(4),
                                          //     Flexible(
                                          //       child: Text(
                                          //         product.restoName.toString(),
                                          //         overflow:
                                          //             TextOverflow.ellipsis,
                                          //         textAlign: TextAlign.left,
                                          //         style:
                                          //             AppFontStyle.text_14_300(
                                          //                 AppColors.lightText),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // )
                                        ],
                                      ));
                                  //  categoryItem(index);
                                }),
                                gridDelegate:
                                    (SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.6.w,
                                  crossAxisSpacing: 16.w,
                                  mainAxisSpacing: 5.h,
                                ))),
                          SliverToBoxAdapter(
                            child: hBox(0.h),
                          )
                        ],
                      ),
                    ));
            }
          }),
        ),
      ),
    );
  }
}
