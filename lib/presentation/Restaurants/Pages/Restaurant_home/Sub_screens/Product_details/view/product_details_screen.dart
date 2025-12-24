import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Utils/login_required_pop_up.dart';
import 'package:woye_user/Data/app_exceptions.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_cart/View/restaurant_cart_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Categories_details/controller/RestaurantCategoriesDetailsController.dart';
import 'package:woye_user/Shared/Widgets/custom_radio_button_reverse.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/Add_to_Cart/addtocartcontroller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/Controller/restaurant_cart_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/View/restaurant_single_cart_screen.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/More_Products/controller/more_products_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/controller/specific_product_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/controller/RestaurantDetailsController.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/view/restaurant_details_screen.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/banners_screens/banner_details_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_wishlist/Controller/aad_product_wishlist_Controller/add_product_wishlist.dart';
import 'package:woye_user/presentation/common/get_user_data/get_user_data.dart';
import 'package:woye_user/shared/widgets/CircularProgressIndicator.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';
import 'package:woye_user/shared/widgets/error_widget.dart';
import 'package:woye_user/shared/widgets/radio_button.dart';
import '../../../../../../../Core/Utils/image_cache_height.dart';
import '../../../../../../../Shared/theme/font_family.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;
  final String categoryId;
  final String categoryName;
  final String? restaurantId;
  final String? bannerId;
  final String? cuisineType;
  final String? priceSort;
  var quickFilter;
  final String? priceRange;
  bool? fromCart;
  String? cartId;

  ProductDetailsScreen({
    super.key,
    required this.productId,
    required this.categoryId,
    required this.categoryName,
    this.restaurantId,
    this.fromCart,
    this.bannerId,
    this.cuisineType,
    this.priceSort,
    this.quickFilter,
    this.priceRange,
    this.cartId,
  });

  // final RestaurantHomeController restaurantHomeController = Get.put(RestaurantHomeController());

  final AddProductWishlistController addWishlistController = Get.put(AddProductWishlistController());
  final specific_Product_Controller controller = Get.put(specific_Product_Controller());
  final AddToCartController addToCartController = Get.put(AddToCartController());
  final seeAll_Product_Controller seeAllProductController = Get.put(seeAll_Product_Controller());
  final GetUserDataController getUserDataController = Get.put(GetUserDataController());
  final RestaurantDetailsController restaurantDetailsController = Get.put(RestaurantDetailsController());
  final RestaurantCartController restaurantCartController = Get.put(RestaurantCartController());
  final BannerDetailsController bannerController = Get.put(BannerDetailsController());
  final RestaurantCategoriesDetailsController restaurantCategoriesDetailsController = Get.put(RestaurantCategoriesDetailsController());
  // final SeeAllProductReviewController seeAllProductReviewController = Get.put(SeeAllProductReviewController());

  @override
  Widget build(BuildContext context) {
    pt("restaurant>>>>>>>>>>>> 11  $restaurantId :: catid>>> $categoryId :: productId $productId  ::   catName >> $categoryName");
    // restaurantCartController.isCartScreen.value;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        isLeading: true,
        actions: [
          GestureDetector(
            onTap: () {
              if (fromCart != null && fromCart == true) {
                Get.back();
              } else {
                Get.off(() => const RestaurantBaseScaffold(child: RestaurantCartScreen(isBack: true)));
              }

              controller.goToCart.value = false;
              controller.cartCount.value = 1;
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: REdgeInsets.all(9),
                  height: 44.h,
                  width: 44.h,
                  decoration: BoxDecoration(
                      color: AppColors.greyBackground,
                      borderRadius: BorderRadius.circular(12.r)),
                  child: SvgPicture.asset(
                    ImageConstants.cart,
                  ),
                ),
                Obx(
                  () {
                    return restaurantCartController.allResCartData.value.carts?.length == null ||
                            restaurantCartController.allResCartData.value.carts!.isEmpty
                        ? const SizedBox.shrink()
                        : Positioned(
                            right: -3,
                            top: -8,
                            child: Container(
                              padding: REdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppColors.black.withOpacity(0.75),
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 1.5),
                                child: Center(
                                  child: Text(
                                    restaurantCartController.allResCartData.value.carts?.length.toString() ?? "",
                                    style: TextStyle(fontSize: 9, color: AppColors.white),
                                  ),
                                ),
                              ),
                            ),
                        );
                  },
                ),
              ],
            ),
          ),
          /*Obx(() {
            return GestureDetector(
              onTap: () async {
                if (getUserDataController.userData.value.user?.userType =="guestUser") {
                  showLoginRequired(context);
                }else{
                controller.isLoading.value = true;
                controller.productData.value.product?.isInWishlist = !controller.productData.value.product!.isInWishlist!;
                await addWishlistController.restaurant_add_product_wishlist(
                  restaurantId: restaurantId.toString(),
                  categoryId: categoryId,
                  product_id: controller.productData.value.product?.id.toString() ?? productId.toString(),
                  cuisineType: cuisineType,
                  priceRange: priceRange,
                  priceSort: priceSort,
                  quickFilter: quickFilter,
                ).then((value) {
                  if(bannerId != "" && bannerId != null){
                    bannerController.refreshBannerDataApi(bannerId: bannerId.toString());
                   }
                  },
                );
                // Utils.showToast("restaurant>> $restaurantId :: catid>>> $categoryId :: productId 1>> :: $productId");

                pt("productId 1>> :: $productId");
                pt("restaurant>> $restaurantId :: catid>>> $categoryId :: productId 1>> :: $productId");
                controller.isLoading.value = false;
                }
              },
              child: Container(
                padding: REdgeInsets.all(9),
                height: 44.h,
                width: 44.h,
                decoration: BoxDecoration(
                  color: AppColors.greyBackground,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: controller.isLoading.value
                    ? circularProgressIndicator(size: 18)
                    : Icon(
                        controller.productData.value.product?.isInWishlist !=
                                true
                            ? Icons.favorite_outline_sharp
                            : Icons.favorite_outlined,
                        size: 24.w,
                      ),
              ),
            );
          }),*/
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
                  controller.specific_Product_Api(
                      productId: productId, categoryId: categoryId.toString());
                },
              );
            } else {
              return GeneralExceptionWidget(
                onPress: () {
                  controller.specific_Product_Api(
                      productId: productId, categoryId: categoryId.toString());
                },
              );
            }
          case Status.COMPLETED:
            return Stack(
              children: [
                RefreshIndicator(
                    onRefresh: () async {
                      controller.specific_Product_Api(
                          productId: productId, categoryId: categoryId.toString());
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          mainContainer(),
                          /*hBox(30),
                          description(),
                          hBox(30),
                          extra(context: context),
                          hBox(30),
                          addOn(),
                          // hBox(30),
                          // if (controller.productData.value.product!.extra != null)
                          //   extra(context: context),
                          // if (controller.productData.value.product!.extra != null)
                          //   hBox(10.h),
                          // if (controller
                          //     .productData.value.product!.addOn!.isNotEmpty)
                          //   addOn(
                          //     context: context,
                          //     checkBoxGroupValues: true.obs,
                          //   ),
                          if (controller.productData.value.product!.addOns != null)
                            hBox(25.h),
                          // Obx(
                          //   () => controller.goToCart.value == true
                          //       ? CustomElevatedButton(
                          //       fontFamily: AppFontFamily.gilroyMedium,
                          //       width: Get.width,
                          //           color: AppColors.primary,
                          //           isLoading:
                          //               addToCartController.rxRequestStatus.value ==
                          //                   (Status.LOADING),
                          //           text: "Go to Cart",
                          //           onPressed: () {
                          //             // restaurantCartController.isCartScreen.value ?
                          //             // Get.toNamed(AppRoutes.restaurantNavbar) :
                          //             if (fromCart != null && fromCart == true) {
                          //               Get.back();
                          //             } else {
                          //               Get.to(() => const RestaurantCartScreen(isBack: true));
                          //             }
                          //
                          //             controller.goToCart.value = false;
                          //             controller.cartCount.value = 1;
                          //           })
                          //       : CustomElevatedButton(
                          //       fontFamily: AppFontFamily.gilroyMedium,
                          //       width: Get.width,
                          //           color: AppColors.darkText,
                          //           isLoading: addToCartController.rxRequestStatus.value == (Status.LOADING),
                          //           text: "Add to Cart",
                          //           onPressed: () {
                          //             if (getUserDataController.userData.value.user?.userType =="guestUser") {
                          //               showLoginRequired(context);
                          //             } else {
                          //               // ---------- add to cart api -----------
                          //               // controller.productPriceFun();
                          //               addToCartController.addToCartApi(
                          //                 cartId: cartId,
                          //                 productId: controller.productData.value.product!.id.toString(),
                          //                 productPrice: controller.productData.value.product!.salePrice != null
                          //                     ? controller.productData.value.product!.salePrice.toString()
                          //                     : controller.productData.value.product!.regularPrice.toString(),
                          //                 productQuantity: controller.cartCount.toString(),
                          //                 restaurantId: controller.productData.value.product!.restaurantId.toString(),
                          //                 addons: controller.selectedAddOn.toList(),
                          //                 extrasIds: controller.extrasTitlesIdsId,
                          //                 extrasItemIds: controller.extrasItemIdsId.toList(),
                          //                 extrasItemNames: controller.extrasItemIdsName.toList(),
                          //                 extrasItemPrices: controller.extrasItemIdsPrice.toList(),
                          //               );
                          //               pt("object ${controller.extrasItemIdsName}");
                          //             }
                          //           },
                          //   ),
                          // ),
                          // hBox(30),

                          //------------------------
                          // productReviews(),
                          // hBox(8),
                          // const Divider(),
                          // if (controller
                          //     .productData.value.product!.productreview!.isNotEmpty)
                          //   hBox(30),
                          // if (controller
                          //     .productData.value.product!.productreview!.isNotEmpty)
                          //   reviews(),
                          if (controller.productData.value.moreProducts!.isNotEmpty)...[
                            // hBox(20.h),
                            moreProducts(),
                          ],
                          hBox(60.h),*/
                        ],
                      ),
                    )),
                Positioned(
                  bottom: 2,
                  right: 0,
                  left: 2,
                  child: Row(
                    children: [
                      Obx(
                            () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                if (controller.cartCount.value > 1) {
                                  controller.cartCount.value--;
                                  if (controller.goToCart.value == true) {
                                    controller.goToCart.value = false;
                                  }
                                }
                              },
                              icon: Container(
                                height: 30.h,
                                width: 30.h,
                                decoration: BoxDecoration(
                                  color: controller.cartCount.value > 1
                                      ? AppColors.black
                                      : AppColors.textFieldBorder,
                                ),
                                child: Icon(
                                  Icons.remove,
                                  size: 18.w,
                                  color: controller.cartCount.value > 1
                                      ? AppColors.primary
                                      : AppColors.lightText,
                                ),
                              ),
                            ),
                            Text(
                              "${controller.cartCount.value}",
                              style: AppFontStyle.text_16_600(
                                AppColors.darkText,
                                family: AppFontFamily.gilroyMedium,
                              ),
                            ),
                            IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                controller.cartCount.value++;
                                if (controller.goToCart.value == true) {
                                  controller.goToCart.value = false;
                                }
                              },
                              icon: Container(
                                height: 30.h,
                                width: 30.h,
                                decoration: BoxDecoration(
                                  color: AppColors.black,
                                ),
                                child: Icon(
                                  Icons.add,
                                  size: 18.w,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      wBox(8),
                      Container(
                        width: Get.width * 0.6,
                        decoration: BoxDecoration(
                          color: AppColors.transparent,
                        ),
                        child: Padding(
                          padding: REdgeInsets.fromLTRB(22,2,22,Platform.isIOS ? 15 : 0),
                          child: Obx(
                                () => controller.goToCart.value == true
                                ? CustomElevatedButton(
                                fontFamily: AppFontFamily.gilroyMedium,
                                width: Get.width,
                                color: AppColors.primary,
                                isLoading:
                                addToCartController.rxRequestStatus.value ==
                                    (Status.LOADING),
                                text: "Go to Cart",
                                onPressed: () {
                                  // restaurantCartController.isCartScreen.value ?
                                  // Get.toNamed(AppRoutes.restaurantNavbar) :
                                  if (fromCart != null && fromCart == true) {
                                    Get.back();
                                  } else {
                                    addToCartController.clearSelected();
                                    Get.to(() => const RestaurantBaseScaffold(child: RestaurantCartScreen(isBack: true)));
                                  }
                                  controller.goToCart.value = false;
                                  controller.cartCount.value = 1;
                                })
                                : CustomElevatedButton(
                              fontFamily: AppFontFamily.gilroyMedium,
                              width: Get.width,
                              color: AppColors.darkText,
                              isLoading: addToCartController.rxRequestStatus.value == (Status.LOADING),
                              text: "Add to Cart",
                              onPressed: () {

                                if (getUserDataController.userData.value.user?.userType =="guestUser") {
                                  showLoginRequired(context);
                                }
                                else {
                                  // ---------- add to cart api -----------
                                  // controller.productPriceFun();

                                  if ((controller.productData.value.product?.options?.isNotEmpty ?? false) ||
                                      (controller.productData.value.product?.addOns?.isNotEmpty ?? false)) {
                                    addToCartPopUp(context);
                                  }else{
                                  addToCartController.addToCartApi(
                                    isPopUp: false,
                                    cartId: cartId,
                                    productId: controller.productData.value.product!.id.toString(),
                                    productPrice: controller.productData.value.product!.salePrice != null
                                        ? controller.productData.value.product!.salePrice.toString()
                                        : controller.productData.value.product!.regularPrice.toString(),
                                    productQuantity: controller.cartCount.toString(),
                                    restaurantId: controller.productData.value.product!.vendorId.toString(),
                                    addons: controller.selectedAddOn.toList(),
                                    extrasIds: controller.extrasTitlesIdsId,
                                    extrasItemIds: controller.extrasItemIdsId.toList(),
                                    extrasItemNames: controller.extrasItemIdsName.toList(),
                                    extrasItemPrices: controller.extrasItemIdsPrice.toList(),
                                  );
                                  pt("object ${controller.extrasItemIdsName}");
                                }
                                  }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
        }
      },
    ),
   );
  }

  Future<dynamic> addToCartPopUp(BuildContext context) {
    return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return PopScope(
        canPop:  true,
        child: AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: EdgeInsets.zero,
          backgroundColor: AppColors.white,
          content: SizedBox(
            width: Get.width * 0.95,
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    hBox(40.h),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0, right: 16, left: 16, bottom: 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (controller.productData.value.product?.options != null)
                                extra(context: context),
                              if (controller.productData.value.product?.options != null)
                                hBox(10.h),
                              if (controller.productData.value.product?.addOns?.isNotEmpty ?? false)
                                addOn(
                                  context: context,
                                  checkBoxGroupValues: true.obs,
                                ),
                              // hBox(20.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(
                            () => controller.goToCart.value == true
                            ? CustomElevatedButton(
                            fontFamily: AppFontFamily.gilroyMedium,
                            width: Get.width,
                            color: AppColors.primary,
                            isLoading:
                            addToCartController.rxRequestStatusPopUp.value == (Status.LOADING),
                            text: "Go to Cart",
                            onPressed: () {
                              // restaurantCartController.isCartScreen.value ?
                              // Get.toNamed(AppRoutes.restaurantNavbar) :
                              addToCartController.clearSelected();
                              if (fromCart != null && fromCart == true) {
                                Get.back();
                                Get.back();
                              } else {
                                Get.back();
                                Get.to(() => const RestaurantBaseScaffold(child: RestaurantCartScreen(isBack: true)));
                              }

                              controller.goToCart.value = false;
                              controller.cartCount.value = 1;
                            })
                            : CustomElevatedButton(
                              fontFamily: AppFontFamily.gilroyMedium,
                              width: Get.width,
                              color: AppColors.darkText,
                              isLoading:  addToCartController.rxRequestStatusPopUp.value == (Status.LOADING),
                              text: "Add to Cart",
                              onPressed: () {
                            addToCartController.addToCartApi(
                              isPopUp: true,
                              cartId: cartId,
                              productId: controller.productData.value.product!.id.toString(),
                              productPrice: controller.productData.value.product!.salePrice != null
                                  ? controller.productData.value.product!.salePrice.toString()
                                  : controller.productData.value.product!.regularPrice.toString(),
                              productQuantity: controller.cartCount.toString(),
                              restaurantId: controller.productData.value.product!.vendorId.toString(),
                              addons: controller.selectedAddOn.toList(),
                              extrasIds: controller.extrasTitlesIdsId,
                              extrasItemIds: controller.extrasItemIdsId.toList(),
                              extrasItemNames: controller.extrasItemIdsName.toList(),
                              extrasItemPrices: controller.extrasItemIdsPrice.toList(),
                            );
                            pt("object ${controller.extrasItemIdsName}");
                            },
                        ),
                      ),
                    ),
                  ],
                ),
                // Close Icon
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                      addToCartController.clearSelected();
                    },
                    icon: Icon(Icons.cancel, color: AppColors.primary, size: 26),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
    );
  }

/*
  Widget mainContainer() {
    controller.selectedImageUrl.value =
        controller.productData.value.product!.imageUrl.toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Obx(
            () => ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: CachedNetworkImage(
                memCacheHeight: memCacheHeight,
                imageUrl: controller.selectedImageUrl.value,
                fit: BoxFit.cover,
                height: 340.h,
                errorWidget: (context, url, error) =>const ImageErrorWidget(),
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
        ),
        if (controller.productData.value.product!.addimgUrl!.isNotEmpty)...[
          hBox(10),
          SizedBox(
            height: 75.h,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: 1 +
                  (controller.productData.value.product!.addimgUrl!.length ??
                      0),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                String imageUrl;

                if (index == 0) {
                  imageUrl = controller.productData.value.product!.imageUrl.toString();
                } else {
                  imageUrl = controller.productData.value.product!.addimgUrl![index - 1];
                }

                controller.isSelected.value = 0;

                return Obx(
                  () => GestureDetector(
                    onTap: () {
                      controller.isSelected.value = index;

                      pt("object  ${controller.isSelected.value}");

                      controller.selectedImageUrl.value = imageUrl;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: controller.isSelected.value == index
                            ? Border.all(color: AppColors.primary, width: 2)
                            : null,
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: CachedNetworkImage(
                          memCacheHeight: 500,
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          width: 75.h,
                          errorWidget: (context, url, error) =>Container(
                            width: 75.h,
                            decoration: BoxDecoration(
                              border: controller.isSelected.value != index
                                  ? Border.all(color: AppColors.textFieldBorder)
                                  : null,
                              color: AppColors.textFieldBorder.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                            child: Icon(Icons.broken_image_rounded,color: AppColors.greyImageColor,size: 17),
                          ),
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: AppColors.gray,
                            highlightColor: AppColors.lightText,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.gray,
                                borderRadius: BorderRadius.circular(18.r),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, itemIndex) => wBox(10.w),
            ),
          ),
        ],
        // Obx(
        //   () => ClipRRect(
        //     borderRadius: BorderRadius.circular(20.r),
        //     child: CachedNetworkImage(
        //       imageUrl: controller.selectedImageUrl.value.isEmpty
        //           ? controller.productData.value.product!.urlImage.toString()
        //           : controller.selectedImageUrl.value,
        //       // Display selected image if available
        //       fit: BoxFit.cover,
        //       height: 340.h,
        //       errorWidget: (context, url, error) =>
        //           const Center(child: Icon(Icons.error)),
        //       placeholder: (context, url) => Shimmer.fromColors(
        //         baseColor: AppColors.gray,
        //         highlightColor: AppColors.lightText,
        //         child: Container(
        //           decoration: BoxDecoration(
        //             color: AppColors.gray,
        //             borderRadius: BorderRadius.circular(20.r),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        // if (controller.productData.value.product!.urlAddimg!.isNotEmpty)
        //   hBox(10),
        // if (controller.productData.value.product!.urlAddimg!.isNotEmpty)
        //   SizedBox(
        //     height: 75.h,
        //     child: ListView.separated(
        //       shrinkWrap: true,
        //       itemCount:
        //           controller.productData.value.product?.urlAddimg!.length ?? 0,
        //       scrollDirection: Axis.horizontal,
        //       itemBuilder: (context, index) {
        //         return Obx(
        //           () => GestureDetector(
        //             onTap: () {
        //               controller.isSelected.value = index;
        //
        //               controller.selectedImageUrl.value = controller
        //                   .productData.value.product!.urlAddimg![index];
        //             },
        //             child: Container(
        //               decoration: BoxDecoration(
        //                 border: controller.isSelected.value == index
        //                     ? Border.all(color: AppColors.primary, width: 2)
        //                     : null,
        //                 borderRadius: BorderRadius.circular(18.r),
        //               ),
        //               child: ClipRRect(
        //                 borderRadius: BorderRadius.circular(15.r),
        //                 child: CachedNetworkImage(
        //                   imageUrl: controller
        //                       .productData.value.product!.urlAddimg![index],
        //                   fit: BoxFit.cover,
        //                   width: 75.h,
        //                   errorWidget: (context, url, error) =>
        //                       const Center(child: Icon(Icons.error)),
        //                   placeholder: (context, url) => Shimmer.fromColors(
        //                     baseColor: AppColors.gray,
        //                     highlightColor: AppColors.lightText,
        //                     child: Container(
        //                       decoration: BoxDecoration(
        //                         color: AppColors.gray,
        //                         borderRadius: BorderRadius.circular(18.r),
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ),
        //         );
        //       },
        //       separatorBuilder: (context, itemIndex) => wBox(10.w),
        //     ),
        //   ),
        hBox(10),
        Text(
          categoryName,
          style: AppFontStyle.text_16_400(AppColors.primary,
              family: AppFontFamily.gilroyMedium),
        ),
        hBox(10),
        Text(
          controller.productData.value.product!.title.toString(),
          style: AppFontStyle.text_20_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
        ),
        hBox(10),
        // Row(
        //   children: [
        //     SvgPicture.asset("assets/svg/star-yellow.svg"),
        //     wBox(4),
        //     Text(
        //       "${controller.productData.value.product!.rating.toString()}/5",
        //       style: AppFontStyle.text_14_400(AppColors.lightText),
        //     ),
        //   ],
        // ),
        // hBox(10),

        GestureDetector(
          onTap: () {
            Get.to(RestaurantBaseScaffold(
              child: RestaurantDetailsScreen(
                Restaurantid:
                    controller.productData.value.product!.vendorId.toString(),
              ),
            ));
            restaurantDetailsController.restaurant_Details_Api(
              id: controller.productData.value.product!.vendorId.toString(),
            );
          },
          child: Row(
            children: [
              // Text(
              //   "Provided by",
              //   style: AppFontStyle.text_12_400(AppColors.lightText),
              // ),
              // wBox(5),
              ClipRRect(
                borderRadius: BorderRadius.circular(50.r),
                child: Image.network(
                  controller.productData.value.product!.restoImage.toString(),
                  height: 20.h,
                  width: 20.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 22.h,
                    width: 22.h,
                    decoration: BoxDecoration(
                      color: AppColors.textFieldBorder.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Icon(Icons.broken_image_rounded,color: AppColors.greyImageColor,size: 15,),
                  ),
                ),
              ),
              wBox(5),
              Flexible(
                child: Text(
                  controller.productData.value.product!.restoName
                      .toString()
                      .capitalize!,
                  style: AppFontStyle.text_14_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        hBox(10),
        Row(
          children: [
            controller.productData.value.product!.salePrice != null
                ? Text(
                    "\$${controller.productData.value.product!.salePrice.toString()}",
                    style: AppFontStyle.text_16_600(AppColors.primary,family: AppFontFamily.gilroyRegular),
                  )
                : Text(
                    "\$${controller.productData.value.product!.regularPrice.toString()}",
                    style: AppFontStyle.text_16_600(AppColors.primary,family: AppFontFamily.gilroyRegular),
                  ),
            wBox(8),
            if (controller.productData.value.product!.salePrice != null)
              Text(
                "\$${controller.productData.value.product!.regularPrice.toString()}",
                style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.mediumText,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFontFamily.gilroyRegular,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: AppColors.mediumText),
              ),
            const Spacer(),
            Container(
              height: 40.h,
              width: 115.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
                border: Border.all(width: 0.8.w, color: AppColors.primary),
              ),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // GestureDetector(
                    //   onTap: () {
                    //     if (controller.cartCount.value > 1) {
                    //       controller.cartCount.value--;
                    //       if(controller.goToCart.value == true){
                    //         controller.goToCart.value = false;
                    //       }
                    //     }
                    //   },
                    //   child: Icon(
                    //     Icons.remove,
                    //     size: 20.w,
                    //   ),
                    // ),
                    IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                      if (controller.cartCount.value > 1) {
                        controller.cartCount.value--;
                        if(controller.goToCart.value == true){
                          controller.goToCart.value = false;
                        }
                      }
                    }, icon: Icon(
                      Icons.remove,
                      size: 20.w,
                      ),
                    ),
                    Text(
                      "${controller.cartCount.value}",
                      style: AppFontStyle.text_14_400(AppColors.darkText),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     controller.cartCount.value++;
                    //     if(controller.goToCart.value == true){
                    //       controller.goToCart.value = false;
                    //     }
                    //   },
                    //   child: Icon(
                    //     Icons.add,
                    //     size: 20.w,
                    //   ),
                    // ),
                    IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                      controller.cartCount.value++;
                      if(controller.goToCart.value == true){
                        controller.goToCart.value = false;
                      }
                    }, icon:  Icon(
                      Icons.add,
                      size: 20.w,
                    ),)
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
*/
  Widget mainContainer() {
    controller.selectedImageUrl.value =
        controller.productData.value.product!.imageUrl.toString();

    List<String> allImages = [];

    // Add main image first
    if (controller.productData.value.product!.imageUrl != null &&
        controller.productData.value.product!.imageUrl!.isNotEmpty) {
      allImages.add(controller.productData.value.product!.imageUrl!);
    }

    // Add additional images
    if (controller.productData.value.product!.addimgUrl != null &&
        controller.productData.value.product!.addimgUrl!.isNotEmpty) {
      allImages.addAll(controller.productData.value.product!.addimgUrl!);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---------- Image Section with Indicators ----------
        SizedBox(
          height: 340.h,
          child: Stack(
            children: [
              // PageView for swipeable images
              PageView.builder(
                itemCount: allImages.length,
                controller: controller.pageController,
                onPageChanged: (index) {
                  controller.isSelected.value = index;
                  controller.selectedImageUrl.value = allImages[index];
                },
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    memCacheHeight: memCacheHeight,
                    imageUrl: allImages[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 340.h,
                    errorWidget: (context, url, error) => const ImageErrorWidget(),
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: AppColors.gray,
                      highlightColor: AppColors.lightText,
                      child: Container(
                        width: double.infinity,
                        height: 340.h,
                        color: AppColors.gray,
                      ),
                    ),
                  );
                },
              ),

              // Image Indicators (Dots)
              if (allImages.length > 1)
                Positioned(
                  bottom: 40.h,
                  left: 0,
                  right: 0,
                  child: Obx(() {
                    int currentIndex = controller.isSelected.value;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        allImages.length,
                            (index) {
                          bool isActive = currentIndex == index;
                          return GestureDetector(
                            onTap: () {
                              controller.pageController.animateToPage(
                                index,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              margin: EdgeInsets.symmetric(horizontal: 4.w),
                              width: isActive ? 20.w : 8.w,
                              height: 8.h,
                              decoration: BoxDecoration(
                                color: isActive
                                    ? AppColors.white
                                    : AppColors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ),
            ],
          ),
        ),

        // ---------- Curved Layout Container ----------
        Transform.translate(
          offset: Offset(0, -25.h),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 22, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---------- Category Name ----------
                  Row(
                    children: [
                      Text(
                        categoryName,
                        style: AppFontStyle.text_16_400(
                          AppColors.primary,
                          family: AppFontFamily.gilroyMedium,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Container(
                            padding: REdgeInsets.all(9),
                            height: 44.h,
                            width: 44.h,
                            decoration: BoxDecoration(
                              color: AppColors.greyBackground,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: controller.isLoading.value
                                ? circularProgressIndicator(size: 18)
                                : Icon(
                              Icons.share,
                              size: 24.w,
                            ),
                          ),
                          wBox(5),
                          Obx(() {
                            return GestureDetector(
                              onTap: () async {
                                if (getUserDataController.userData.value.user?.userType =="guestUser") {
                                  showLoginRequired(Get.context);
                                }else{
                                  controller.isLoading.value = true;
                                  controller.productData.value.product?.isInWishlist = !controller.productData.value.product!.isInWishlist!;
                                  await addWishlistController.restaurant_add_product_wishlist(
                                    restaurantId: restaurantId.toString(),
                                    categoryId: categoryId,
                                    product_id: controller.productData.value.product?.id.toString() ?? productId.toString(),
                                    cuisineType: cuisineType,
                                    priceRange: priceRange,
                                    priceSort: priceSort,
                                    quickFilter: quickFilter,
                                  ).then((value) {
                                    if(bannerId != "" && bannerId != null){
                                      bannerController.refreshBannerDataApi(bannerId: bannerId.toString());
                                    }
                                  },
                                  );
                                  // Utils.showToast("restaurant>> $restaurantId :: catid>>> $categoryId :: productId 1>> :: $productId");

                                  pt("productId 1>> :: $productId");
                                  pt("restaurant>> $restaurantId :: catid>>> $categoryId :: productId 1>> :: $productId");
                                  controller.isLoading.value = false;
                                }
                              },
                              child: Container(
                                padding: REdgeInsets.all(9),
                                height: 44.h,
                                width: 44.h,
                                decoration: BoxDecoration(
                                  color: AppColors.greyBackground,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: controller.isLoading.value
                                    ? circularProgressIndicator(size: 18)
                                    : Icon(
                                  controller.productData.value.product?.isInWishlist !=
                                      true
                                      ? Icons.favorite_outline_sharp
                                      : Icons.favorite_outlined,
                                  size: 24.w,
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                  // ---------- Product Title ----------
                  Text(
                    controller.productData.value.product!.title.toString(),
                    style: AppFontStyle.text_22_500(
                      AppColors.darkText,
                      family: AppFontFamily.gilroyMedium,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  hBox(6.h),

                  // ---------- Price and Rating Row ----------
                  Row(
                    children: [
                      // Price with discount
                      Row(
                        children: [
                          Text(
                            "\$${controller.productData.value.product!.salePrice ?? controller.productData.value.product!.regularPrice ?? "0.00"}",
                            style: AppFontStyle.text_18_600(
                              AppColors.primary,
                              family: AppFontFamily.gilroyMedium,
                            ),
                          ),
                          wBox(8.w),
                          if (controller.productData.value.product!.salePrice != null)
                            Text(
                              "\$${controller.productData.value.product!.regularPrice ?? "0.00"}",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.mediumText,
                                fontWeight: FontWeight.w400,
                                fontFamily: AppFontFamily.gilroyRegular,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: AppColors.mediumText,
                              ),
                            ),
                        ],
                      ),

                      const Spacer(),

                      // Rating
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColors.goldStar,
                            size: 16.w,
                          ),
                          wBox(4.w),
                          Text(
                            "4.5/5",
                            style: AppFontStyle.text_14_600(
                              AppColors.darkText,
                              family: AppFontFamily.gilroyMedium,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  hBox(20),
                  description(),
                  hBox(20),
                  extra(context: Get.context),
                  hBox(20),
                  addOn(),
                  hBox(20),
                ],
              ),
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
          style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroySemiBold),
        ),
        hBox(10),
        Text(
          controller.productData.value.product!.description.toString(),
          style: AppFontStyle.text_16_400(AppColors.lightText, height: 1.4,family: AppFontFamily.gilroyRegular),
          maxLines: 20,
        ),
      ],
    );
  }

  Widget extra({context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---------- Size Section ----------
        Text(
          "Size",
          style: AppFontStyle.text_20_600(AppColors.darkText, family: AppFontFamily.gilroyRegular),
        ),
        hBox(10),

        // Small Size (Selected)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Small",
              style: AppFontStyle.text_16_400(
                AppColors.black,
                family: AppFontFamily.gilroyRegular,
              ),
            ),
            RadioButton(
              title: '\$18.00',
              onChanged: (value) {
                controller.priceRadioValue.value = value!;
                controller.update();
              },
              value: 1.obs,
              groupValue: controller.priceRadioValue,
            )
          ],
        ),
        hBox(8),

        // Medium Size
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Medium",
              style: AppFontStyle.text_16_400(
                AppColors.darkText,
                family: AppFontFamily.gilroyRegular,
              ),
            ),
            RadioButton(
              title: '\$22.00',
              onChanged: (value) {
                controller.priceRadioValue.value = value!;
                controller.update();
              },
              value: 2.obs,
              groupValue: controller.priceRadioValue,
            )
          ],
        ),
        hBox(8),

        // Large Size
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Large",
              style: AppFontStyle.text_16_400(
                AppColors.darkText,
                family: AppFontFamily.gilroyRegular,
              ),
            ),
            RadioButton(
              title: '\$28.00',
              onChanged: (value) {
                controller.priceRadioValue.value = value!;
                controller.update();
              },
              value: 3.obs,
              groupValue: controller.priceRadioValue,
            )
          ],
        ),

        hBox(20.h),

        // ---------- Base Bread Section ----------
        Text(
          "Base Bread Section",
          style: AppFontStyle.text_20_600(AppColors.darkText, family: AppFontFamily.gilroyRegular),
        ),
        hBox(5),
        Row(
          children: [
            Text(
              "Required",
              style: AppFontStyle.text_12_200(AppColors.lightText, family: AppFontFamily.gilroyRegular),
            ),
            Text(
              "•",
              style: AppFontStyle.text_12_200(AppColors.lightText, family: AppFontFamily.gilroyRegular),
            ),
            wBox(4),
            Text(
              "Select any 1 option",
              style: AppFontStyle.text_12_200(AppColors.lightText, family: AppFontFamily.gilroyRegular),
            ),
          ],
        ),
        hBox(10),

        // White Base (Selected)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "White Base",
              style: AppFontStyle.text_16_400(
                AppColors.black,
                family: AppFontFamily.gilroyRegular,
              ),
            ),
            RadioButton(
              title: '\$5.00',
              onChanged: (value) {
                controller.priceRadioValue.value = value!;
                controller.update();
              },
              value: 4.obs,
              groupValue: controller.priceRadioValue,
            )
          ],
        ),
        hBox(8),

        // Cheese Burst
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Cheese Burst",
              style: AppFontStyle.text_16_400(
                AppColors.darkText,
                family: AppFontFamily.gilroyRegular,
              ),
            ),
            RadioButton(
              title: '\$7.00',
              onChanged: (value) {
                controller.priceRadioValue.value = value!;
                controller.update();
              },
              value: 5.obs,
              groupValue: controller.priceRadioValue,
            )
          ],
        ),
        hBox(8),

        // Wheat Base
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Wheat Base",
              style: AppFontStyle.text_16_400(
                AppColors.darkText,
                family: AppFontFamily.gilroyRegular,
              ),
            ),
            RadioButton(
              title: '\$8.00',
              onChanged: (value) {
                controller.priceRadioValue.value = value!;
                controller.update();
              },
              value: 6.obs,
              groupValue: controller.priceRadioValue,
            )
          ],
        ),
      ],
    );
  }

  Widget addOn({context, checkBoxGroupValues}) {
    RxBool showAll = false.obs;

    // Get addons from API
    int totalAddons = controller.productData.value.product?.addOns?.length ?? 0;

    // Show only first 6 items initially
    int initialShowCount = 6;
    int itemsToShow = showAll.value ? totalAddons : min(totalAddons, initialShowCount);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Add On",
          style: AppFontStyle.text_20_600(AppColors.darkText, family: AppFontFamily.gilroyRegular),
        ),
        hBox(5),
        Row(
          children: [
            Text(
              "Select up to 9 option",
              style: AppFontStyle.text_12_200(AppColors.lightText, family: AppFontFamily.gilroyRegular),
            ),
          ],
        ),
        hBox(10),

        // Check if addons are available
        if (controller.productData.value.product?.addOns == null || controller.productData.value.product!.addOns!.isEmpty)
          Container(
            padding: REdgeInsets.symmetric(vertical: 30),
            child: Center(
              child: Text(
                "No add-ons available",
                style: AppFontStyle.text_16_400(AppColors.lightText, family: AppFontFamily.gilroyRegular),
              ),
            ),
          )
        else
          Obx(() => Column(
            children: [
              // Show addons from API
              ...List.generate(
                itemsToShow,
                    (index) {
                  bool isSelected = controller.selectedAddOn.contains(controller.productData.value.product?.addOns?[index].id);

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Addon name
                          Text(
                            controller.productData.value.product?.addOns?[index].name ?? "Addon ${index + 1}",
                            style: AppFontStyle.text_16_400(
                              isSelected ? AppColors.primary : AppColors.darkText,
                              family: AppFontFamily.gilroyRegular,
                            ),
                          ),

                          // Price and checkbox
                          Row(
                            children: [
                              // Price - Assuming price field exists or use default
                              Text(
                                "\$${controller.productData.value.product?.addOns?[index].price ?? "0.00"}",
                                style: AppFontStyle.text_16_600(
                                  isSelected ? AppColors.primary : AppColors.darkText,
                                  family: AppFontFamily.gilroyRegular,
                                ),
                              ),
                              wBox(10),

                              // Checkbox
                              GestureDetector(
                                onTap: () {
                                  // Toggle selection
                                  if (isSelected) {
                                    controller.selectedAddOn.remove(controller.productData.value.product?.addOns?[index].id);
                                  } else {
                                    // Check max selection limit (9)
                                    if (controller.selectedAddOn.length < 9) {
                                      controller.selectedAddOn.add(controller.productData.value.product?.addOns?[index].id);
                                    } else {
                                      // Show message if limit reached
                                      Utils.showToast("Maximum 9 add-ons can be selected");
                                    }
                                  }
                                },
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: isSelected ? AppColors.primary : Colors.transparent,
                                    border: Border.all(
                                      color: isSelected ? AppColors.primary : AppColors.lightText,
                                      width: isSelected ? 6 : 1,
                                    ),
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (index < itemsToShow - 1) hBox(8),
                    ],
                  );
                },
              ),

              // Show More/Less button if more than initial items
              if (totalAddons > initialShowCount) ...[
                hBox(10),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    showAll.value = !showAll.value;
                  },
                  child: Container(
                    padding: REdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          showAll.value ?
                          "-${totalAddons - initialShowCount} Less" :
                          "+${totalAddons - initialShowCount} More",
                          style: AppFontStyle.text_14_600(AppColors.primary, family: AppFontFamily.gilroyRegular),
                        ),
                        wBox(4),
                        Icon(
                          showAll.value ? Icons.expand_less : Icons.expand_more,
                          color: AppColors.primary,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ],
          )),
      ],
    );
  }

  /*Widget productReviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Product Reviews",
          style: AppFontStyle.text_20_600(AppColors.darkText),
        ),
        hBox(10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RatingBar.readOnly(
              filledIcon: Icons.star,
              emptyIcon: Icons.star,
              filledColor: AppColors.goldStar,
              emptyColor: AppColors.normalStar,
              initialRating: controller.productData.value.product!.rating!,
              maxRating: 5,
              size: 20.h,
            ),
            wBox(8),
            Text(
              "${controller.productData.value.product!.rating.toString()}/5",
              style: AppFontStyle.text_16_400(AppColors.darkText),
            ),
            wBox(8),
            Text(
              "(${controller.productData.value.product!.productreview_count.toString()} reviews)",
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
              itemCount:
                  controller.productData.value.product!.productreview!.length,
              itemBuilder: (context, index) {
                return controller.productData.value.product!
                            .productreview![index].user !=
                        null
                    ? Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50.r),
                                child: CachedNetworkImage(
                                  imageUrl: controller
                                      .productData
                                      .value
                                      .product!
                                      .productreview![index]
                                      .user!
                                      .imageUrl
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.productData.value.product!
                                          .productreview![index].user!.firstName
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
                                      initialRating: controller
                                          .productData
                                          .value
                                          .product!
                                          .productreview![index]
                                          .rating!,
                                      maxRating: 5,
                                      size: 20.h,
                                    ),
                                    hBox(10),
                                    Text(
                                      controller.productData.value.product!
                                          .productreview![index].message
                                          .toString(),
                                      style: AppFontStyle.text_16_400(
                                          AppColors.darkText),
                                      maxLines: 2,
                                    ),
                                    hBox(10),
                                    Text(
                                      controller.formatDate(controller
                                          .productData
                                          .value
                                          .product!
                                          .productreview![index]
                                          .updatedAt
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
                      )
                    : const SizedBox();
              },
            ),
          ],
        ),
        controller.productData.value.product!.productreview_count!.toInt() > 0
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
                          'product_id': productId.toString(),
                          'product_review':
                              controller.productData.value.product!.rating,
                          'review_count': controller
                              .productData.value.product!.productreview_count
                              .toString(),
                        },
                      );
                      seeAllProductReviewController.seeAllProductReviewApi(
                          productId: productId.toString());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "See All (${controller.productData.value.product!.productreview_count.toString()})",
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
    );
  }*/

  Widget moreProducts() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "More Products",
              style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
            ),
            InkWell(
              onTap: () {
                seeAllProductController.seeAll_Product_Api(
                    restaurant_id: '', category_id: categoryId.toString());
                Get.toNamed(AppRoutes.moreProducts, arguments: {
                  'restaurant_id': '',
                  'category_id': categoryId.toString(),
                  'productId' : productId.toString(),
                });
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "See All",
                    style: AppFontStyle.text_15_600(AppColors.primary,family: AppFontFamily.gilroyRegular),
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
        hBox(15.h),
        GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.productData.value.moreProducts!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6.w,
              crossAxisSpacing: 14.w,
              mainAxisSpacing: 0.h,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    pt("object productId >>>> ${controller.productData.value.moreProducts![index].id}");
                    // Utils.showToast("restaurant>>>>>>>>>>>> $restaurantId :: catid>>> $categoryId :: productId $productId >> :: ${controller.productData.value.moreProducts![index].id}  catName >> $categoryName");
                    pt("restaurant>>>>>>>>>>>> $restaurantId :: catid>>> $categoryId :: productId $productId >> :: ${controller.productData.value.moreProducts![index].id}  catName >> $categoryName");

                    controller.specific_Product_Api(
                      productId: controller.productData.value.moreProducts![index].id.toString(),
                      categoryId: categoryId.toString(),
                    );

                    Get.to(()=>RestaurantBaseScaffold(
                      child: ProductDetailsScreen(
                        productId: controller.productData.value.moreProducts![index].id.toString(),
                        categoryId: categoryId,
                        categoryName: categoryName,
                        restaurantId: restaurantId,
                      ),
                    ));


                  },
                  child: CustomItemBanner(
                    index: index,
                    product_id: controller.productData.value.moreProducts![index].id.toString(),
                    categoryId: categoryId,
                    image: controller
                        .productData.value.moreProducts![index].urlImage,
                    title:
                        controller.productData.value.moreProducts![index].title,
                    // rating: controller
                    //     .productData.value.moreProducts![index].rating
                    //     .toString(),
                    is_in_wishlist: controller
                        .productData.value.moreProducts![index].isInWishlist,
                    isLoading: controller
                        .productData.value.moreProducts![index].isLoading,
                    sale_price: controller
                        .productData.value.moreProducts![index].salePrice
                        .toString(),
                    regular_price: controller
                        .productData.value.moreProducts![index].regularPrice
                        .toString(),
                    resto_name: controller
                        .productData.value.moreProducts![index].restoName
                        .toString(),
                  ),
              );
            })
      ],
    );
  }
}
