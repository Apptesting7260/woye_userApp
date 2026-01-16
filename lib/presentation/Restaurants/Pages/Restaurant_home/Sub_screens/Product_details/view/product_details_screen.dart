import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Constant/app_urls.dart' show AppUrls;
import 'package:woye_user/Core/Utils/login_required_pop_up.dart';
import 'package:woye_user/Data/app_exceptions.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_cart/View/restaurant_cart_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Categories_details/controller/RestaurantCategoriesDetailsController.dart';
import 'package:woye_user/Presentation/Restaurants/Restaurants_navbar/Controller/restaurant_navbar_controller.dart';
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
import 'package:woye_user/shared/widgets/format_price.dart';
import 'package:woye_user/shared/widgets/radio_button.dart';
import '../../../../../../../Core/Utils/image_cache_height.dart';
import '../../../../../../../Shared/theme/font_family.dart';
import '../modal/specific_product_modal.dart';

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
    return Obx(
      ()=> Scaffold(
        backgroundColor:controller.rxRequestStatus.value != Status.COMPLETED ? AppColors.white :  AppColors.backgroundColor,
        extendBodyBehindAppBar: true,
        appBar: appbar(),
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
              return body(context);
          }
        },
      ),
        bottomNavigationBar:Obx(
          ()=> controller.rxRequestStatus.value != Status.COMPLETED ? const SizedBox.shrink() :  Container(
            padding: const EdgeInsets.only(left: 16,bottom: 4,top: 4,right: 18),
            color: AppColors.backgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: AppColors.black),
                            color: AppColors.white,
                            // controller.cartCount.value > 1
                            //     ? AppColors.black
                            //     : AppColors.textFieldBorder,
                          ),
                          child: Icon(
                            Icons.remove,
                            size: 18.w,
                            color: AppColors.black,
                            // controller.cartCount.value > 1
                            //     ? AppColors.primary
                            //     : AppColors.lightText,
                          ),
                        ),
                      ),
                      Text(
                        "${controller.cartCount.value}",
                        style: AppFontStyle.text_16_600(
                          AppColors.darkText,
                          family: AppFontFamily.onestMedium,
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
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: AppColors.black),
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
                // wBox(4),
                Container(
                  width: Get.width * 0.63,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.transparent,
                  ),
                  child: Obx(
                        () => controller.goToCart.value == true
                        ? CustomElevatedButton(
                        fontFamily: AppFontFamily.onestMedium,
                        width: Get.width,
                        color: AppColors.primary,
                        isLoading: addToCartController.rxRequestStatus.value == (Status.LOADING),
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
                      fontFamily: AppFontFamily.onestMedium,
                      width: Get.width,
                      color: AppColors.black,
                      isLoading: addToCartController.rxRequestStatus.value == (Status.LOADING),
                      text: "Add to Cart",
                      onPressed: () {
                        if (getUserDataController.userData.value.user?.userType =="guestUser") {
                          showLoginRequired(context);
                        }
                        else {
                          addToCartController.addToCartApi(
                            isPopUp: false,
                            cartId: cartId,
                            productId: controller.productData.value.product!.id.toString(),
                            productPrice: controller.productData.value.product!.salePrice != "null"
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
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
         ),
    );
  }

  Widget body(BuildContext context) {
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
                    // hBox(30)
                  ],
                ),
              )),
        ],
      );

  }

  CustomAppBar appbar() {
    return CustomAppBar(
      horizontalPadding: 10,
      isLeading: true,
      height: 14,
      width: 14,
      actions: [
        GestureDetector(
          onTap: () {
            // showLocationDialog();
            Get.toNamed(AppRoutes.notifications);
          },
          child: Container(
            padding: REdgeInsets.all(9),
            height: 44.h,
            width: 44.h,
            decoration: BoxDecoration(
                color: AppColors.transparent.withAlpha(20),
                borderRadius: BorderRadius.circular(12.r),
            ),
            child: Stack(
              children: [
                SvgPicture.asset(
                  ImageConstants.notification,
                  colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                ),
                Positioned(
                  right: 3,
                  top: 3,
                  child: Container(
                    height: 9,
                    width: 9,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.white),
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        // GestureDetector(
        //   onTap: () {
        //     if (fromCart != null && fromCart == true) {
        //       Get.back();
        //     } else {
        //       Get.off(() => const RestaurantBaseScaffold(child: RestaurantCartScreen(isBack: true)));
        //     }
        //
        //     controller.goToCart.value = false;
        //     controller.cartCount.value = 1;
        //   },
        //   child: Stack(
        //     clipBehavior: Clip.none,
        //     children: [
        //       Container(
        //         padding: REdgeInsets.all(9),
        //         height: 44.h,
        //         width: 44.h,
        //         decoration: BoxDecoration(
        //             color: AppColors.greyBackground,
        //             borderRadius: BorderRadius.circular(12.r)),
        //         child: SvgPicture.asset(
        //           ImageConstants.cart,
        //         ),
        //       ),
        //       Obx(
        //         () {
        //           return restaurantCartController.allResCartData.value.carts?.length == null ||
        //                   restaurantCartController.allResCartData.value.carts!.isEmpty
        //               ? const SizedBox.shrink()
        //               : Positioned(
        //                   right: -3,
        //                   top: -8,
        //                   child: Container(
        //                     padding: REdgeInsets.all(4),
        //                     decoration: BoxDecoration(
        //                       color: AppColors.black.withOpacity(0.75),
        //                       shape: BoxShape.circle,
        //                     ),
        //                     child: Padding(
        //                       padding: const EdgeInsets.only(bottom: 1.5),
        //                       child: Center(
        //                         child: Text(
        //                           restaurantCartController.allResCartData.value.carts?.length.toString() ?? "",
        //                           style: TextStyle(fontSize: 9, color: AppColors.white),
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //               );
        //         },
        //       ),
        //     ],
        //   ),
        // ),

      ],
    );
  }

  Future<dynamic> addToCartPopUp(BuildContext context, MoreProducts? product) {
    final tempController = specific_Product_Controller();

    // Set the product data for popup
    tempController.productData.value = specificProduct(
      product: Product(
        id: product?.id,
        title: product?.title,
        imageUrl: product?.imageUrl,
        addimgUrl: product?.addimgUrl,
        regularPrice: product?.regularPrice,
        salePrice: product?.salePrice,
        vendorId: product?.vendorId,
        addOns: product?.addOns,
        options: product?.options,
        productAttributes: product?.productAttributes,
        rating: product?.rating,
        restoName: product?.restoName,
      ),
      moreProducts: controller.productData.value.moreProducts,
    );

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: true,
          child: AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            contentPadding: EdgeInsets.zero,
            backgroundColor: AppColors.white,
            content: StatefulBuilder(
              builder: (context, setState) {
                // Check if all sections are empty
                final hasOptions = tempController.productData.value.product?.options != null &&
                    tempController.productData.value.product!.options!.isNotEmpty;

                final hasAddOns = tempController.productData.value.product?.addOns != null &&
                    tempController.productData.value.product!.addOns!.isNotEmpty;

                final hasAttributes = tempController.productData.value.product?.productAttributes != null &&
                    tempController.productData.value.product!.productAttributes!.isNotEmpty;

                final hasAnyContent = hasOptions || hasAddOns || hasAttributes;

                return SizedBox(
                  width: Get.width * 0.95,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          hBox(20.h),
                          Flexible(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0, right: 16, left: 16, bottom: 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Show message if no content
                                    if (!hasAnyContent)
                                      Container(
                                        padding: REdgeInsets.symmetric(vertical: 40),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.check_circle_outline,
                                                color: AppColors.primary,
                                                size: 40,
                                              ),
                                              hBox(10),
                                              Text(
                                                "No addons available",
                                                style: AppFontStyle.text_16_400(
                                                  AppColors.darkText,
                                                  family: AppFontFamily.onestMedium,
                                                ),
                                              ),
                                              hBox(5),
                                              Text(
                                                "You can add this product directly to cart",
                                                style: AppFontStyle.text_14_400(
                                                  AppColors.lightText,
                                                  family: AppFontFamily.onestRegular,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                    // Show content if available
                                    if (hasAnyContent) ...[
                                      // Use the reusable extra widget with tempController
                                      if (hasOptions)
                                        extra(tempController: tempController, setState: setState),
                                      if (hasOptions)
                                        hBox(10.h),

                                      // Use the reusable addOn widget with tempController
                                      if (hasAddOns)
                                        addOn(tempController: tempController, setState: setState),

                                      // Use the reusable productAttributes widget with tempController
                                      if (hasAttributes)
                                        Column(
                                          children: [
                                            hBox(10.h),
                                            productAttributes(tempController: tempController),
                                          ],
                                        ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(
                                  () => /*controller.goToCart.value == true || */addToCartController.goToCart.value == true
                                  ? CustomElevatedButton(
                                fontFamily: AppFontFamily.onestMedium,
                                width: Get.width,
                                color: AppColors.primary,
                                isLoading: addToCartController.rxRequestStatusPopUp.value == (Status.LOADING),
                                text: "Go to Cart",
                                onPressed: () {
                                  addToCartController.clearSelected();
                                  if (fromCart != null && fromCart == true) {
                                    Get.back();
                                    Get.back();
                                  } else {
                                    Get.back();
                                    addToCartController.goToCart.value = false;
                                  //   RestaurantNavbarController  restaurantNavbarController = Get.isRegistered<RestaurantNavbarController>() ?
                                  // Get.find<RestaurantNavbarController>() : Get.put(RestaurantNavbarController());
                                    Get.to(() => const RestaurantBaseScaffold(child: RestaurantCartScreen(isBack: true)));
                                    // restaurantNavbarController.getIndex(2);
                                  }
                                  addToCartController.goToCart.value = false;
                                  controller.goToCart.value = false;
                                  tempController.cartCount.value = 1;
                                },
                              )
                                  : CustomElevatedButton(
                                fontFamily: AppFontFamily.onestMedium,
                                width: Get.width,
                                color: AppColors.black,
                                isLoading: addToCartController.rxRequestStatusPopUp.value == (Status.LOADING),
                                text: "Add to Cart",
                                onPressed: () {
                                  if (getUserDataController.userData.value.user?.userType == "guestUser") {
                                    showLoginRequired(context);
                                    return;
                                  }

                                  addToCartController.addToCartApi_in_categoryProduct(
                                    isPopUp: true,
                                    isBack: false,
                                    cartId: cartId,
                                    productId: product?.id.toString() ?? '',
                                    productPrice: tempController.productData.value.product!.salePrice != "null"
                                        ? tempController.productData.value.product!.salePrice.toString()
                                        : tempController.productData.value.product!.regularPrice.toString(),
                                    productQuantity: tempController.cartCount.toString(),
                                    restaurantId: product?.vendorId.toString() ?? '',
                                    addons: tempController.selectedAddOn.toList(),
                                    extrasIds: tempController.extrasTitlesIdsId,
                                    extrasItemIds: tempController.extrasItemIdsId.toList(),
                                    extrasItemNames: tempController.extrasItemIdsName.toList(),
                                    extrasItemPrices: tempController.extrasItemIdsPrice.toList(),
                                  );
                                  pt("object ${tempController.extrasItemIdsName}");
                                },
                              ),
                            ),
                          ),
                          hBox(10.h),
                        ],
                      ),
                      // Close Icon
                      Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                            addToCartController.goToCart.value = false;
                            controller.goToCart.value = false;
                            addToCartController.clearSelected();
                          },
                          icon: Icon(Icons.cancel, color: AppColors.primary, size: 26),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget mainContainer() {
    controller.isSelected.value = 0;
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
                      baseColor: AppColors.gray.withAlpha(150),
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
                Positioned.fill(
                  bottom: 28.h,
                  child: Obx(() {
                    int currentIndex = controller.isSelected.value;
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.gray.withAlpha(160),
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 2),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            allImages.length,
                                (index) {
                              bool isActive = currentIndex == index;
                              return GestureDetector(
                                onTap: () {
                                  controller.pageController.animateToPage(
                                    index,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                                  width: 9.w,
                                  // width: isActive ? 20.w : 8.w,
                                  height: 9.h,
                                  decoration: BoxDecoration(
                                    color: isActive
                                        ? AppColors.black
                                        : AppColors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(100.r),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  }),
                ),
            ],
          ),
        ),

        // ---------- Curved Layout Container ----------
        Container(
          // height: Get.height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---------- Category Name ----------
                Row(
                  children: [
                    Text(
                      categoryName?.capitalize ?? "",
                      style: AppFontStyle.text_16_400(
                        AppColors.primary,
                        family: AppFontFamily.onestMedium,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            final restaurant = controller.productData.value.product;

                            Share.share(
                              'Check out this amazing restaurant: ${restaurant?.restoName ?? "Our Restaurant"}\n'
                                  '${AppUrls.hostUrl}/restaurants?id=${restaurant?.vendorId}',
                              subject: restaurant?.restoName ?? 'Share Restaurant',
                            );
                          },
                          child: Container(
                            padding: REdgeInsets.all(9),
                            height: 42.h,
                            width: 42.h,
                            decoration: BoxDecoration(
                              color: AppColors.transparent.withAlpha(20),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child:  Icon(
                              Icons.share_outlined,
                              color: AppColors.black.withAlpha(180),
                              size: 24.w,
                            ),
                          ),
                        ),
                        wBox(6.w),
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
                              height: 42.h,
                              width: 42.h,
                              decoration: BoxDecoration(
                                color: AppColors.transparent.withAlpha(20),
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
                                color: AppColors.black.withAlpha(180),
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
                  controller.productData.value.product?.title?.capitalize ?? "",
                  style: AppFontStyle.text_20_500(
                    AppColors.darkText,
                    family: AppFontFamily.onestMedium,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                hBox(4.h),
                // ---------- Price and Rating Row ----------
                Row(
                  children: [
                    // Price with discount
                    controller.productData.value.product?.salePrice != "null" ?
                    Row(
                      children: [
                        Text(
                          "\$${controller.productData.value.product?.salePrice ?? "0.00"}",
                          style: AppFontStyle.text_16_600(
                            AppColors.primary,
                            family: AppFontFamily.onestMedium,
                          ),
                        ),
                        wBox(8.w),
                        Text(
                          "\$${controller.productData.value.product?.regularPrice ?? "0.00"}",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.mediumText,
                            fontWeight: FontWeight.w400,
                            fontFamily: AppFontFamily.onestRegular,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: AppColors.mediumText,
                          ),
                        ),
                      ],
                    )
                        :
                    Text(
                      "\$${controller.productData.value.product?.regularPrice ?? controller.productData.value.product?.salePrice ?? "0.00"}",
                      style: AppFontStyle.text_18_600(
                        AppColors.primary,
                        family: AppFontFamily.onestMedium,
                      ),
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
                          "${double.tryParse(controller.productData.value.product?.rating ?? "0")?.toStringAsFixed(1) ?? "0"}/5",
                          style: AppFontStyle.text_14_600(
                            AppColors.darkText,
                            family: AppFontFamily.onestMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                hBox(20),
                description(),
                extra(tempController: controller),
                addOn(tempController: controller),
                productAttributes(tempController: controller),
                hBox(30),
                if(controller.productData.value.moreProducts?.isNotEmpty ?? false)
                  moreProducts()
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
          style: AppFontStyle.text_18_500(AppColors.darkText,family: AppFontFamily.onestSemiBold),
        ),
        hBox(10),
        Text(
          controller.productData.value.product?.description?.trim() ??"",
          style: AppFontStyle.text_16_400(AppColors.lightText, height: 1.4,family: AppFontFamily.onestRegular),
          maxLines: 20,
        ),
      ],
    );
  }

  Widget extra({specific_Product_Controller? tempController, StateSetter? setState}) {
    // Use tempController if provided, otherwise use main controller
    final controllerToUse = tempController ?? controller;

    // Check if options are available
    if (controllerToUse.productData.value.product?.options == null ||
        controllerToUse.productData.value.product!.options!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Loop through each option
        ...controllerToUse.productData.value.product!.options!.asMap().entries.map((entry) {
          final option = entry.value;
          final index = entry.key;

          // Check if choices are available
          if (option.choices == null || option.choices!.isEmpty) {
            return const SizedBox.shrink();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hBox(20),
              // Option Name (Heading)
              Text(
                option.optionName ?? "",
                style: AppFontStyle.text_18_500(
                    AppColors.darkText,
                    family: AppFontFamily.onestSemiBold
                ),
              ),

              // Required/Selection info (if needed)
              if (option.choices != null && option.choices!.isNotEmpty) ...[
                hBox(5),
                Row(
                  children: [
                    Text(
                      "Required",
                      style: AppFontStyle.text_13_400(
                          AppColors.lightText,
                          family: AppFontFamily.onestRegular
                      ),
                    ),
                    Text(
                      "•",
                      style: AppFontStyle.text_13_400(
                          AppColors.lightText,
                          family: AppFontFamily.onestRegular
                      ),
                    ),
                    wBox(4),
                    Expanded(
                      child: Text(
                        "Select any 1 option",
                        style: AppFontStyle.text_12_200(
                            AppColors.lightText,
                            family: AppFontFamily.onestRegular
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],

              hBox(10),

              // Choices for this option
              ...option.choices!.asMap().entries.map((choiceEntry) {
                final choice = choiceEntry.value;
                final choiceIndex = choiceEntry.key;

                // Create unique key for internal tracking (optionId + choiceIndex)
                final String uniqueKey = '${option.optionId}_$choiceIndex';

                return Column(
                  children: [
                    // Choice Row with FIXED LAYOUT
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Choice Name - Flexible width
                        Flexible(
                          flex: 2,
                          child: Text(
                            choice.name?.capitalizeFirst ?? "",
                            // choice.name ?? "Choice ${choiceIndex + 1}",
                            style: AppFontStyle.text_16_400(
                              AppColors.black,
                              family: AppFontFamily.onestRegular,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        // Spacing
                        wBox(8),

                        // Price and Radio Button - Fixed width
                        Flexible(
                          flex: 1,
                          child: _buildToggleableRadioButton(
                            title: '\$${choice.price ?? "0.00"}',
                            isSelected: controllerToUse.isChoiceSelected(uniqueKey),
                            onTap: () {
                              // Toggle selection for this choice
                              controllerToUse.toggleChoiceSelection(
                                optionId: option.optionId,
                                optionName: option.optionName,
                                uniqueKey: uniqueKey, // For internal tracking
                                choiceIndex: choiceIndex, // To identify which choice
                                choiceName: choice.name,
                                choicePrice: choice.price,
                                isRequired: true,
                              );

                              // Update UI if setState is provided
                              if (setState != null) {
                                setState(() {});
                              }
                            },
                          ),
                        ),
                      ],
                    ),

                    // Add spacing between choices (except last one)
                    if (choiceIndex < option.choices!.length - 1) hBox(8),
                  ],
                );
              }).toList(),

              // Add spacing between options (except last one)
              if (index < controllerToUse.productData.value.product!.options!.length - 1)
                hBox(20.h),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget _buildToggleableRadioButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 100, // Limit maximum width
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Price text
            Flexible(
              child: Text(
                title,
                style: AppFontStyle.text_16_400(
                  AppColors.black,
                  family: AppFontFamily.onestSemiBold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            wBox(8),

            // Radio circle (togglable)
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.lightText,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                ),
              )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  Widget productAttributes({specific_Product_Controller? tempController}) {
    final controllerToUse = tempController ?? controller;

    if (controllerToUse.productData.value.product?.productAttributes == null ||
        controllerToUse.productData.value.product!.productAttributes!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hBox(20),
        Text(
          "Attributes",
          style: AppFontStyle.text_18_500(
            AppColors.darkText,
            family: AppFontFamily.onestSemiBold,
          ),
        ),
        hBox(10),

        // Loop through each product attribute group
        ...controllerToUse.productData.value.product!.productAttributes!.asMap().entries.map((entry) {
          final attributeGroup = entry.value; // This is ProductAttributes object
          final groupIndex = entry.key;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display group name if it exists
              if (attributeGroup.groupName != null && attributeGroup.groupName!.isNotEmpty)
                Column(
                  children: [
                    Text(
                      attributeGroup.groupName ?? "",
                      style: AppFontStyle.text_18_600(
                        AppColors.darkText,
                        family: AppFontFamily.onestMedium,
                      ),
                    ),
                    hBox(10),
                  ],
                ),

              // Loop through each attribute in this group
              ...attributeGroup.attributes!.asMap().entries.map((attrEntry) {
                final attribute = attrEntry.value; // This is Attributes object
                final attrIndex = attrEntry.key;

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Text(
                            attribute.name ?? "",
                            // attribute.name ?? "Attribute ${attrIndex + 1}",
                            style: AppFontStyle.text_16_400(
                              AppColors.black,
                              family: AppFontFamily.onestRegular,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        wBox(8),
                        Flexible(
                          flex: 1,
                          child: Container(),
                        ),
                      ],
                    ),
                    if (attrIndex < attributeGroup.attributes!.length - 1)
                      hBox(8),
                  ],
                );
              }).toList(),

              // Space between groups
              if (groupIndex < controllerToUse.productData.value.product!.productAttributes!.length - 1)
                hBox(12),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget addOn({specific_Product_Controller? tempController, StateSetter? setState, checkBoxGroupValues}) {
    final controllerToUse = tempController ?? controller;
    RxBool showAll = false.obs;

    // Get addons from API
    int totalAddons = controllerToUse.productData.value.product?.addOns?.length ?? 0;

    // Show only first 6 items initially
    int initialShowCount = 6;
    int itemsToShow = showAll.value ? totalAddons : min(totalAddons, initialShowCount);

    if (controllerToUse.productData.value.product?.addOns == null ||
        controllerToUse.productData.value.product!.addOns!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hBox(20),

        Text(
          "Add On",
          style: AppFontStyle.text_18_500(AppColors.darkText, family: AppFontFamily.onestSemiBold),
        ),
        hBox(5),
        Row(
          children: [
            Text(
              "Select any option",
              style: AppFontStyle.text_12_200(AppColors.lightText, family: AppFontFamily.onestRegular),
            ),
          ],
        ),
        hBox(10),
        Column(
          children: [
            // Show addons from API
            ...List.generate(
              itemsToShow,
                  (index) {
                final addOn = controllerToUse.productData.value.product?.addOns?[index];
                bool isSelected = controllerToUse.isAddOnSelected(addOn?.id ?? '');

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Addon name
                        Text(
                          addOn?.name ?? "Addon ${index + 1}",
                          style: AppFontStyle.text_16_400(
                            AppColors.black,
                            family: AppFontFamily.onestRegular,
                          ),
                        ),

                        // Price and checkbox
                        Row(
                          children: [
                            // Price
                            Text(
                              "\$${addOn?.price ?? "0.00"}",
                              style: AppFontStyle.text_16_600(
                                AppColors.black,
                                family: AppFontFamily.onestRegular,
                              ),
                            ),
                            wBox(10),

                            // Checkbox
                            GestureDetector(
                              onTap: () {
                                // Toggle selection using the new method
                                controllerToUse.toggleAddOnSelection(
                                  addOnId: addOn?.id ?? '',
                                  addOnName: addOn?.name ?? '',
                                  addOnPrice: addOn?.price ?? '0.00',
                                );

                                // Update UI if setState is provided
                                if (setState != null) {
                                  setState(() {});
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
                                child: isSelected
                                    ? const Center(
                                  child: Icon(
                                    Icons.check,
                                    size: 10,
                                    color: Colors.white,
                                  ),
                                )
                                    : null,
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
                  if (setState != null) {
                    setState(() {});
                  }
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
                        style: AppFontStyle.text_14_600(AppColors.primary, family: AppFontFamily.onestRegular),
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
        ),
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

  Widget moreProducts(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'More Products',
              style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.onestSemiBold),
            ),
          ],
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            childAspectRatio: 0.72,
            crossAxisSpacing: 12,
          ),
          itemCount: controller.productData.value.moreProducts?.length ?? 0,
          itemBuilder: (context, index) {
            final moreProducts = controller.productData.value.moreProducts;
            final product = moreProducts?[index];

            return buildMoreProducts(
              index,
                product?.imageUrl,
                product?.title,
                product?.restoName,
                product?.rating,
                (product?.salePrice != "0")
                    ? product?.salePrice
                    : product?.regularPrice,
                product?.isInWishlist
            );
          },
        )
      ],
    );
  }

  Widget buildMoreProducts(
      int index,
      String? image,
      String? productName,
      String? restroName,
      String? rating,
      String? price,
      bool? isInWishlist,
      ){
    final isWishlisted = (isInWishlist ?? false).obs;
    final moreProducts = controller.productData.value.moreProducts?[index];

    return InkWell(
      onTap: () {
        final moreProducts = controller.productData.value.moreProducts?[index];
        if (moreProducts == null) return;
        controller.specific_Product_Api(productId:moreProducts.id ?? "",categoryId:categoryId.toString());

        Get.off(
              () => ProductDetailsScreen(
            productId: moreProducts.id ?? "",
            categoryId: categoryId.toString(),
            categoryName: moreProducts.categoryName ?? "",
            restaurantId: moreProducts.vendorId ?? "",
          ),
          preventDuplicates: false,
        );
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: image ?? "",
                fit: BoxFit.cover,
              )
            ),

            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () {
                  // Toggle wishlist state
                  isWishlisted.value = !isWishlisted.value;

                  // Call wishlist API here
                  if (getUserDataController.userData.value.user?.userType == "guestUser") {
                    showLoginRequired(Get.context);
                  } else {
                    // Call your wishlist API
                    addWishlistController.restaurant_add_product_wishlist(
                      restaurantId: restaurantId.toString(),
                      categoryId: categoryId,
                      product_id: productId ?? '',
                      cuisineType: cuisineType,
                      priceRange: priceRange,
                      priceSort: priceSort,
                      quickFilter: quickFilter,
                    );
                  }
                },
                child: Obx(() => Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        spreadRadius: 0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      isWishlisted.value ? Icons.favorite : Icons.favorite_border,
                      color: isWishlisted.value ? Colors.black : Colors.grey[700],
                      size: 18,
                    ),
                  ),
                )),
              ),
            ),

            // ---------- Gradient Overlay at Bottom ----------
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),


            // Text Content Section (35-40% height)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8), // Reduced from 12 to 8
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Product Name and Rating Row
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            productName?.capitalize ?? "",
                            style: AppFontStyle.text_14_600(AppColors.black,family: AppFontFamily.onestMedium),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        wBox(4),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 15
                            ),
                            const SizedBox(width: 2),
                            Text(
                              double.tryParse(rating ?? "0")?.toStringAsFixed(1) ?? "0",
                              style: AppFontStyle.text_12_400(AppColors.black,family: AppFontFamily.onestMedium),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Restaurant Name
                    const SizedBox(height: 2),
                    Text(
                      restroName?.capitalize ?? '',
                      style: AppFontStyle.text_12_400(AppColors.lightText,family: AppFontFamily.onestMedium),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    hBox(4),

                    // Bottom Row (Price, Time)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Price - Made more compact
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 1),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10), // Reduced from 15
                            border: Border.all(
                              color: AppColors.primary,
                              width: 0.5,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "\$${formatPrice1(price ?? "0")}",
                              style: AppFontStyle.text_11_400(AppColors.black,family: AppFontFamily.onestRegular),
                            ),
                          ),
                        ),

                        // Delivery Time and Add Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.access_time,
                              color: AppColors.black,
                              size: 17,
                            ),
                            wBox(2.w),
                            Text(
                              moreProducts?.preparationTime ?? "",
                              style: AppFontStyle.text_12_400(AppColors.black,family: AppFontFamily.onestRegular),
                            ),
                            wBox(4),
                            GetBuilder<AddToCartController>(
                              builder: (addToCartController) {
                                return GestureDetector(
                                  onTap: () {
                                    print("cart_iddddddddddddddddddd------$cartId");
                                    print("product_iddddddddddddddddddd------${controller.productData.value.product!.id.toString()}");
                              if (getUserDataController.userData.value.user?.userType == "guestUser") {
                                      showLoginRequired(Get.context);
                                    }
                                    /*   else {
                                      addToCartController.addToCartApi(
                                          productId:  controller.productData.value.moreProducts?[index].id.toString() ?? '',
                                          productQuantity: '1',
                                          productPrice: controller.productData.value.moreProducts?[index].regularPrice.toString() ?? '',
                                          restaurantId:controller.productData.value.moreProducts?[index].vendorId.toString() ?? '',
                                          addons: [],
                                          extrasIds: [],
                                          extrasItemIds: [],
                                          extrasItemNames: [],
                                          extrasItemPrices: [],
                                          isPopUp: false
                                      );
                                    }*/
                                    // addToCartPopUp(Get.context!, moreProducts!);
                                    if(moreProducts!.addOns!.isNotEmpty || moreProducts.options!.isNotEmpty || moreProducts.productAttributes !.isNotEmpty ) {
                                      addToCartPopUp(Get.context!, moreProducts);
                                    } else {
                                      addToCartController.addToCartApi(
                                          productId:  controller.productData.value.moreProducts?[index].id.toString() ?? '',
                                          productQuantity: '1',
                                          productPrice: controller.productData.value.moreProducts?[index].regularPrice.toString() ?? '',
                                          restaurantId:controller.productData.value.moreProducts?[index].vendorId.toString() ?? '',
                                          addons: [],
                                          extrasIds: [],
                                          extrasItemIds: [],
                                          extrasItemNames: [],
                                          extrasItemPrices: [],
                                          isPopUp: false
                                      );
                                    }
                                  },
                                  child: addToCartController.isCartLoader(controller.productData.value.product!.id.toString())
                                      ? circularProgressIndicator(size: 25)
                                      : Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: AppColors.black,
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 17,
                                      color: AppColors.white,
                                    ),
                                  ),
                                );
                              }
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
