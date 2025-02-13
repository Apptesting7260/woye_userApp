import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Data/app_exceptions.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_cart/View/restaurant_cart_screen.dart';
import 'package:woye_user/Shared/Widgets/custom_radio_button_reverse.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/Add_to_Cart/addtocartcontroller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/More_Products/controller/more_products_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/controller/specific_product_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_wishlist/Controller/aad_product_wishlist_Controller/add_product_wishlist.dart';
import 'package:woye_user/presentation/common/get_user_data/get_user_data.dart';
import 'package:woye_user/shared/widgets/CircularProgressIndicator.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;
  final String categoryId;
  final String categoryName;

  ProductDetailsScreen({
    super.key,
    required this.productId,
    required this.categoryId,
    required this.categoryName,
  });

  // final RestaurantHomeController restaurantHomeController =
  // Get.put(RestaurantHomeController());

  final AddProductWishlistController add_Wishlist_Controller =
      Get.put(AddProductWishlistController());

  final specific_Product_Controller controller =
      Get.put(specific_Product_Controller());

  final AddToCartController addToCartController =
      Get.put(AddToCartController());

  final seeAll_Product_Controller seeallproductcontroller =
      Get.put(seeAll_Product_Controller());

  final GetUserDataController getUserDataController =
      Get.put(GetUserDataController());

  // final SeeAllProductReviewController seeAllProductReviewController =
  //     Get.put(SeeAllProductReviewController());

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
          wBox(8),
          Obx(() {
            return GestureDetector(
              onTap: () async {
                controller.isLoading.value = true;
                controller.productData.value.product?.isInWishlist =
                    !controller.productData.value.product!.isInWishlist!;
                await add_Wishlist_Controller.restaurant_add_product_wishlist(
                  categoryId: categoryId,
                  product_id: productId.toString(),
                );
                controller.isLoading.value = false;
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
            return RefreshIndicator(
                onRefresh: () async {
                  controller.specific_Product_Api(
                      productId: productId, categoryId: categoryId.toString());
                },
                child: SingleChildScrollView(
                  padding: REdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      mainContainer(),
                      hBox(30),
                      description(),
                      hBox(30),
                      if (controller.productData.value.product!.extra != null)
                        extra(context: context),
                      if (controller.productData.value.product!.extra != null)
                        hBox(20),
                      if (controller
                          .productData.value.product!.addOn!.isNotEmpty)
                        addOn(
                          context: context,
                          checkBoxGroupValues: true.obs,
                        ),
                      if (controller.productData.value.product!.addOn != null)
                        hBox(30),
                      Obx(
                        () => controller.goToCart.value == true
                            ? CustomElevatedButton(
                                width: Get.width,
                                color: AppColors.primary,
                                isLoading:
                                    addToCartController.rxRequestStatus.value ==
                                        (Status.LOADING),
                                text: "Go to Cart",
                                onPressed: () {
                                  Get.to(
                                      const RestaurantCartScreen(isBack: true));
                                  controller.goToCart.value = false;
                                  controller.cartCount.value = 1;
                                })
                            : CustomElevatedButton(
                                width: Get.width,
                                color: AppColors.darkText,
                                isLoading:
                                    addToCartController.rxRequestStatus.value ==
                                        (Status.LOADING),
                                text: "Add to Cart",
                                onPressed: () {
                                  if (getUserDataController
                                          .userData.value.user?.userType ==
                                      "guestUser") {
                                    showLoginRequired(context);
                                  } else {
                                    // ---------- add to cart api -----------
                                    controller.productPriceFun();
                                    addToCartController.addToCartApi(
                                      productId: controller
                                          .productData.value.product!.id
                                          .toString(),
                                      productPrice: controller.productData.value
                                                  .product!.salePrice !=
                                              null
                                          ? controller.productData.value
                                              .product!.salePrice
                                              .toString()
                                          : controller.productData.value
                                              .product!.regularPrice
                                              .toString(),
                                      productQuantity:
                                          controller.cartCount.toString(),
                                      restaurantId: controller.productData.value
                                          .product!.restaurantId
                                          .toString(),
                                      addons: controller.selectedAddOn.toList(),
                                      extrasIds: controller.extrasTitlesIdsId,
                                      extrasItemIds:
                                          controller.extrasItemIdsId.toList(),
                                      extrasItemNames:
                                          controller.extrasItemIdsName.toList(),
                                      extrasItemPrices: controller
                                          .extrasItemIdsPrice
                                          .toList(),
                                    );
                                    print(
                                        "object ${controller.extrasItemIdsName}");
                                  }
                                }),
                      ),
                      hBox(30),
                      // productReviews(),
                      // hBox(8),
                      const Divider(),
                      if (controller
                          .productData.value.product!.productreview!.isNotEmpty)
                        hBox(30),
                      // if (controller
                      //     .productData.value.product!.productreview!.isNotEmpty)
                      //   reviews(),
                      if (controller.productData.value.moreProducts!.isNotEmpty)
                        hBox(30),
                      if (controller.productData.value.moreProducts!.isNotEmpty)
                        moreProducts(),
                      hBox(20),
                    ],
                  ),
                ));
        }
      }),
    );
  }

  Widget mainContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: CachedNetworkImage(
              imageUrl: controller.selectedImageUrl.value.isEmpty
                  ? controller.productData.value.product!.urlImage.toString()
                  : controller.selectedImageUrl.value,
              // Display selected image if available
              fit: BoxFit.cover,
              height: 340.h,
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
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
        if (controller.productData.value.product!.urlAddimg!.isNotEmpty)
          hBox(10),
        if (controller.productData.value.product!.urlAddimg!.isNotEmpty)
          SizedBox(
            height: 75.h,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount:
                  controller.productData.value.product?.urlAddimg!.length ?? 0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Obx(
                  () => GestureDetector(
                    onTap: () {
                      controller.isSelected.value = index;

                      controller.selectedImageUrl.value = controller
                          .productData.value.product!.urlAddimg![index];
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
                          imageUrl: controller
                              .productData.value.product!.urlAddimg![index],
                          fit: BoxFit.cover,
                          width: 75.h,
                          errorWidget: (context, url, error) =>
                              const Center(child: Icon(Icons.error)),
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
        hBox(10),
        Text(
          categoryName,
          style: AppFontStyle.text_16_400(AppColors.primary,
              fontWeight: FontWeight.bold),
        ),
        hBox(10),
        Text(
          controller.productData.value.product!.title.toString(),
          style: AppFontStyle.text_20_400(AppColors.darkText),
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
        Row(
          children: [
            controller.productData.value.product!.salePrice != null
                ? Text(
                    "\$${controller.productData.value.product!.salePrice.toString()}",
                    style: AppFontStyle.text_16_600(AppColors.primary),
                  )
                : Text(
                    "\$${controller.productData.value.product!.regularPrice.toString()}",
                    style: AppFontStyle.text_16_600(AppColors.primary),
                  ),
            wBox(8),
            if (controller.productData.value.product!.salePrice != null)
              Text(
                "\$${controller.productData.value.product!.regularPrice.toString()}",
                style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.mediumText,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: AppColors.mediumText),
              ),
            const Spacer(),
            Container(
              height: 40.h,
              width: 100.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
                border: Border.all(width: 0.8.w, color: AppColors.primary),
              ),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (controller.cartCount.value > 1) {
                          controller.cartCount.value--;
                        }
                      },
                      child: Icon(
                        Icons.remove,
                        size: 20.w,
                      ),
                    ),
                    Text(
                      "${controller.cartCount.value}",
                      style: AppFontStyle.text_14_400(AppColors.darkText),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.cartCount.value++;
                      },
                      child: Icon(
                        Icons.add,
                        size: 20.w,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
          controller.productData.value.product!.description.toString(),
          style: AppFontStyle.text_16_400(AppColors.lightText, height: 1.4),
          maxLines: 20,
        ),
      ],
    );
  }

  // Widget extra({context}) {
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     itemCount: controller.productData.value.product!.extra?.length,
  //     itemBuilder: (context, index) {
  //       var extra = controller.productData.value.product!.extra![index];
  //       if (!controller.extrasTitlesIdsId.contains(extra.titleid)) {
  //         controller.extrasTitlesIdsId.add(extra.titleid);
  //         print("itemIdsIds ${controller.extrasTitlesIdsId}");
  //       }
  //
  //       if (controller.extrasItemIdsName.isEmpty) {
  //         controller.productData.value.product!.extra?.forEach((extra) {
  //           if (extra.item?.isNotEmpty ?? false) {
  //             controller.extrasItemIdsId.add(extra.item![0].id.toString());
  //             controller.extrasItemIdsName.add(extra.item![0].name.toString());
  //             controller.extrasItemIdsPrice
  //                 .add(extra.item![0].price.toString());
  //           }
  //         });
  //         print("Final List of IDs: ${controller.extrasItemIdsId}");
  //         print("Final List of Names: ${controller.extrasItemIdsName}");
  //         print("Final List of Prices: ${controller.extrasItemIdsPrice}");
  //       }
  //       return Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             extra.title.toString(),
  //             style: AppFontStyle.text_20_600(AppColors.darkText),
  //           ),
  //           hBox(1.h),
  //           Row(
  //             children: [
  //               Text(
  //                 "Required",
  //                 style: AppFontStyle.text_12_200(AppColors.lightText),
  //               ),
  //               Text(
  //                 "•",
  //                 style: AppFontStyle.text_12_200(AppColors.lightText),
  //               ),
  //               wBox(4),
  //               Text(
  //                 "Select any 1 option",
  //                 style: AppFontStyle.text_12_200(AppColors.lightText),
  //               ),
  //             ],
  //           ),
  //           hBox(5),
  //           ListView.separated(
  //             shrinkWrap: true,
  //             physics: const NeverScrollableScrollPhysics(),
  //             itemCount: extra.item?.length ?? 0,
  //             itemBuilder: (context, itemIndex) {
  //               var item = extra.item![itemIndex];
  //               return CustomTitleRadioButton(
  //                 title: item.name.toString(),
  //                 value: itemIndex.obs,
  //                 groupValue: controller
  //                     .productData.value.product!.extra![index].selectedIndex,
  //                 onChanged: (value) {
  //                   controller.productData.value.product!.extra![index]
  //                       .selectedIndex.value = value!;
  //
  //                   // if (controller.extrasItemIdsName.length > index) {
  //                   //   controller.extrasItemIdsName[index] =
  //                   //       item.name.toString();
  //                   // } else {
  //                   //   controller.extrasItemIdsName.add(item.name.toString());
  //                   // }
  //                   // print(
  //                   //     "Updated selected names: ${controller.extrasItemIdsName}");
  //                   if (controller.extrasItemIdsName.length > index) {
  //                     controller.extrasItemIdsName[index] =
  //                         item.name.toString();
  //                     controller.extrasItemIdsId[index] = item.id.toString();
  //                     controller.extrasItemIdsPrice[index] =
  //                         item.price.toString();
  //                   } else {
  //                     controller.extrasItemIdsName.add(item.name.toString());
  //                     controller.extrasItemIdsId.add(item.id.toString());
  //                     controller.extrasItemIdsPrice.add(item.price.toString());
  //                   }
  //
  //                   print(
  //                       "Updated selected names: ${controller.extrasItemIdsName}");
  //                   print(
  //                       "Updated selected IDs: ${controller.extrasItemIdsId}");
  //                   print(
  //                       "Updated selected prices: ${controller.extrasItemIdsPrice}");
  //                 },
  //                 priceValue: item.price.toString(),
  //               );
  //             },
  //             separatorBuilder: (context, itemIndex) => hBox(10.h),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Widget extra({context}) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.productData.value.product!.extra?.length,
      itemBuilder: (context, index) {
        var extra = controller.productData.value.product!.extra![index];
        // if (!controller.extrasTitlesIdsId.contains(extra.titleid)) {
        //   controller.extrasTitlesIdsId.add(extra.titleid);
        //   print("itemIdsIds ${controller.extrasTitlesIdsId}");
        // }
        //
        // if (controller.extrasItemIdsName.isEmpty) {
        //   controller.productData.value.product!.extra?.forEach((extra) {
        //     if (extra.item?.isNotEmpty ?? false) {
        //       controller.extrasItemIdsId.add(extra.item![0].id.toString());
        //       controller.extrasItemIdsName.add(extra.item![0].name.toString());
        //       controller.extrasItemIdsPrice
        //           .add(extra.item![0].price.toString());
        //     }
        //   });
        //   print("Final List of IDs: ${controller.extrasItemIdsId}");
        //   print("Final List of Names: ${controller.extrasItemIdsName}");
        //   print("Final List of Prices: ${controller.extrasItemIdsPrice}");
        // }

        print("Final List of IDs: ${controller.extrasItemIdsId}");
        print("Final List of Names: ${controller.extrasItemIdsName}");
        print("Final List of Prices: ${controller.extrasItemIdsPrice}");
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              extra.title.toString(),
              style: AppFontStyle.text_20_600(AppColors.darkText),
            ),
            hBox(1.h),
            Row(
              children: [
                Text(
                  "Required",
                  style: AppFontStyle.text_12_200(AppColors.lightText),
                ),
                Text(
                  "•",
                  style: AppFontStyle.text_12_200(AppColors.lightText),
                ),
                wBox(4),
                Text(
                  "Select any 1 option",
                  style: AppFontStyle.text_12_200(AppColors.lightText),
                ),
              ],
            ),
            hBox(5),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: extra.item?.length ?? 0,
              itemBuilder: (context, itemIndex) {
                var item = extra.item![itemIndex];
                return CustomTitleRadioButton(
                  title: item.name.toString(),
                  value: itemIndex.obs,
                  groupValue: controller
                      .productData.value.product!.extra![index].selectedIndex,
                  onChanged: (value) {
                    var currentExtra =
                        controller.productData.value.product!.extra![index];
                    if (currentExtra.selectedIndex.value == value) {
                      currentExtra.selectedIndex.value = -1;

                      if (controller.extrasItemIdsName.length > index) {
                        controller.extrasItemIdsName[index] = '';
                        controller.extrasItemIdsId[index] = '';
                        controller.extrasItemIdsPrice[index] = '';
                        controller.extrasTitlesIdsId[index] = '';
                      }
                    } else {
                      currentExtra.selectedIndex.value = value!;

                      if (controller.extrasItemIdsName.length > index) {
                        controller.extrasItemIdsName[index] =
                            item.name.toString();
                        controller.extrasItemIdsId[index] = item.id.toString();
                        controller.extrasItemIdsPrice[index] =
                            item.price.toString();
                        controller.extrasTitlesIdsId[index] = controller
                            .productData.value.product!.extra![index].titleid
                            .toString();
                      } else {
                        controller.extrasItemIdsName.add(item.name.toString());
                        controller.extrasItemIdsId.add(item.id.toString());
                        controller.extrasItemIdsPrice
                            .add(item.price.toString());

                        controller.extrasTitlesIdsId.add(controller
                            .productData.value.product!.extra![index].titleid
                            .toString());
                      }
                    }

                    controller.extrasTitlesIdsId.assignAll(controller
                        .extrasTitlesIdsId
                        .where((item) => item.isNotEmpty)
                        .toList());
                    controller.extrasItemIdsName.assignAll(controller
                        .extrasItemIdsName
                        .where((item) => item.isNotEmpty)
                        .toList());
                    controller.extrasItemIdsId.assignAll(controller
                        .extrasItemIdsId
                        .where((item) => item.isNotEmpty)
                        .toList());
                    controller.extrasItemIdsPrice.assignAll(controller
                        .extrasItemIdsPrice
                        .where((item) => item.isNotEmpty)
                        .toList());

                    print(
                        "Updated selected extrasTitlesIdsId: ${controller.extrasTitlesIdsId}");
                    print(
                        "Updated selected names: ${controller.extrasItemIdsName}");
                    print(
                        "Updated selected IDs: ${controller.extrasItemIdsId}");
                    print(
                        "Updated selected prices: ${controller.extrasItemIdsPrice}");
                  },
                  //     onChanged: (value) {
                  //   controller.productData.value.product!.extra![index]
                  //       .selectedIndex.value = value!;
                  //
                  //   if (controller.extrasItemIdsName.length > index) {
                  //     controller.extrasItemIdsName[index] =
                  //         item.name.toString();
                  //     controller.extrasItemIdsId[index] = item.id.toString();
                  //     controller.extrasItemIdsPrice[index] =
                  //         item.price.toString();
                  //   } else {
                  //     controller.extrasItemIdsName.add(item.name.toString());
                  //     controller.extrasItemIdsId.add(item.id.toString());
                  //     controller.extrasItemIdsPrice.add(item.price.toString());
                  //   }
                  //
                  //   print(
                  //       "Updated selected names: ${controller.extrasItemIdsName}");
                  //   print(
                  //       "Updated selected IDs: ${controller.extrasItemIdsId}");
                  //   print(
                  //       "Updated selected prices: ${controller.extrasItemIdsPrice}");
                  // },
                  priceValue: item.price.toString(),
                );
              },
              separatorBuilder: (context, itemIndex) => hBox(10.h),
            ),
          ],
        );
      },
    );
  }

  Widget addOn({
    context,
    checkBoxGroupValues,
  }) {
    RxBool showAll = false.obs;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Add On",
          style: AppFontStyle.text_20_600(AppColors.darkText),
        ),
        hBox(10),
        Row(
          children: [
            Text(
              "Select up to ${controller.productData.value.product!.addOn!.length} option",
              style: AppFontStyle.text_16_300(AppColors.lightText),
            ),
          ],
        ),
        hBox(10),
        Obx(
          () {
            var addOnListLength =
                controller.productData.value.product!.addOn?.length ?? 0;

            int itemCount = addOnListLength > 6
                ? (showAll.value ? addOnListLength : 6)
                : addOnListLength;

            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: itemCount,
              itemBuilder: (context, index) {
                var addOn = controller.productData.value.product!.addOn![index];
                return CustomTitleCheckbox(
                  title: addOn.name.toString(),
                  groupValue: checkBoxGroupValues,
                  onChanged: (value) {
                    addOn.isChecked.value = value;
                    if (value) {
                      controller.selectedAddOn.add({
                        "id": addOn.id.toString(),
                        "price": addOn.price.toString(),
                        "name": addOn.name.toString(),
                      });
                    } else {
                      controller.selectedAddOn.removeWhere((element) =>
                          element['id'] == addOn.id.toString() &&
                          element['price'] == addOn.price.toString() &&
                          element['name'] == addOn.name.toString());
                    }
                    print("selected AddOn${controller.selectedAddOn}");
                  },
                  priceValue: addOn.price.toString(),
                  isChecked: addOn.isChecked,
                );
              },
              separatorBuilder: (context, index) => hBox(8),
            );
          },
        ),
        hBox(10),
        Obx(
          () {
            var addOnListLength =
                controller.productData.value.product!.addOn?.length ?? 0;
            if (addOnListLength <= 6) {
              return const SizedBox.shrink();
            }

            return InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                showAll.value = !showAll.value; // Toggle showAll value
              },
              child: showAll.value
                  ? Row(
                      children: [
                        Text(
                          "Hide",
                          style: AppFontStyle.text_16_600(AppColors.primary),
                        ),
                        Icon(
                          Icons.keyboard_arrow_up_sharp,
                          color: AppColors.primary,
                          size: 30.h,
                        )
                      ],
                    )
                  : Row(
                      children: [
                        Text(
                          "Show More",
                          style: AppFontStyle.text_16_600(AppColors.primary),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: AppColors.primary,
                          size: 30.h,
                        )
                      ],
                    ),
            );
          },
        ),
      ],
    );
  }

  // Widget productReviews() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         "Product Reviews",
  //         style: AppFontStyle.text_20_600(AppColors.darkText),
  //       ),
  //       hBox(10),
  //       Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           RatingBar.readOnly(
  //             filledIcon: Icons.star,
  //             emptyIcon: Icons.star,
  //             filledColor: AppColors.goldStar,
  //             emptyColor: AppColors.normalStar,
  //             initialRating: controller.productData.value.product!.rating!,
  //             maxRating: 5,
  //             size: 20.h,
  //           ),
  //           wBox(8),
  //           Text(
  //             "${controller.productData.value.product!.rating.toString()}/5",
  //             style: AppFontStyle.text_16_400(AppColors.darkText),
  //           ),
  //           wBox(8),
  //           Text(
  //             "(${controller.productData.value.product!.productreview_count.toString()} reviews)",
  //             style: AppFontStyle.text_14_400(AppColors.lightText),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget reviews() {
  //   return Column(
  //     children: [
  //       Column(
  //         children: [
  //           ListView.builder(
  //             shrinkWrap: true,
  //             physics: const NeverScrollableScrollPhysics(),
  //             itemCount:
  //                 controller.productData.value.product!.productreview!.length,
  //             itemBuilder: (context, index) {
  //               return controller.productData.value.product!
  //                           .productreview![index].user !=
  //                       null
  //                   ? Column(
  //                       children: [
  //                         Row(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             ClipRRect(
  //                               borderRadius: BorderRadius.circular(50.r),
  //                               child: CachedNetworkImage(
  //                                 imageUrl: controller
  //                                     .productData
  //                                     .value
  //                                     .product!
  //                                     .productreview![index]
  //                                     .user!
  //                                     .imageUrl
  //                                     .toString(),
  //                                 fit: BoxFit.cover,
  //                                 height: 50.h,
  //                                 width: 50.h,
  //                                 errorWidget: (context, url, error) => Center(
  //                                     child: Container(
  //                                   height: 50.h,
  //                                   width: 50.h,
  //                                   color: AppColors.gray.withOpacity(.2),
  //                                   child: Icon(
  //                                     Icons.person,
  //                                     color: AppColors.gray,
  //                                   ),
  //                                 )),
  //                                 placeholder: (context, url) =>
  //                                     Shimmer.fromColors(
  //                                   baseColor: AppColors.gray,
  //                                   highlightColor: AppColors.lightText,
  //                                   child: Container(
  //                                     decoration: BoxDecoration(
  //                                       color: AppColors.gray,
  //                                       borderRadius:
  //                                           BorderRadius.circular(20.r),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                             wBox(15),
  //                             Flexible(
  //                               flex: 4,
  //                               child: Column(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   Text(
  //                                     controller.productData.value.product!
  //                                         .productreview![index].user!.firstName
  //                                         .toString(),
  //                                     style: AppFontStyle.text_16_400(
  //                                         AppColors.darkText),
  //                                   ),
  //                                   hBox(5),
  //                                   RatingBar.readOnly(
  //                                     filledIcon: Icons.star,
  //                                     emptyIcon: Icons.star,
  //                                     filledColor: AppColors.goldStar,
  //                                     emptyColor: AppColors.normalStar,
  //                                     initialRating: controller
  //                                         .productData
  //                                         .value
  //                                         .product!
  //                                         .productreview![index]
  //                                         .rating!,
  //                                     maxRating: 5,
  //                                     size: 20.h,
  //                                   ),
  //                                   hBox(10),
  //                                   Text(
  //                                     controller.productData.value.product!
  //                                         .productreview![index].message
  //                                         .toString(),
  //                                     style: AppFontStyle.text_16_400(
  //                                         AppColors.darkText),
  //                                     maxLines: 2,
  //                                   ),
  //                                   hBox(10),
  //                                   Text(
  //                                     controller.formatDate(controller
  //                                         .productData
  //                                         .value
  //                                         .product!
  //                                         .productreview![index]
  //                                         .updatedAt
  //                                         .toString()),
  //                                     style: AppFontStyle.text_16_400(
  //                                         AppColors.lightText),
  //                                   )
  //                                 ],
  //                               ),
  //                             )
  //                           ],
  //                         ),
  //                         Padding(
  //                           padding: REdgeInsets.symmetric(vertical: 10),
  //                           child: const Divider(),
  //                         ),
  //                       ],
  //                     )
  //                   : const SizedBox();
  //             },
  //           ),
  //         ],
  //       ),
  //       controller.productData.value.product!.productreview_count!.toInt() > 0
  //           ? Column(
  //               children: [
  //                 hBox(10),
  //                 InkWell(
  //                   splashColor: Colors.transparent,
  //                   highlightColor: Colors.transparent,
  //                   onTap: () {
  //                     Get.toNamed(
  //                       AppRoutes.productReviews,
  //                       arguments: {
  //                         'product_id': productId.toString(),
  //                         'product_review':
  //                             controller.productData.value.product!.rating,
  //                         'review_count': controller
  //                             .productData.value.product!.productreview_count
  //                             .toString(),
  //                       },
  //                     );
  //                     seeAllProductReviewController.seeAllProductReviewApi(
  //                         productId: productId.toString());
  //                   },
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Text(
  //                         "See All (${controller.productData.value.product!.productreview_count.toString()})",
  //                         style: AppFontStyle.text_14_600(AppColors.primary),
  //                       ),
  //                       Icon(
  //                         Icons.arrow_forward,
  //                         color: AppColors.primary,
  //                         size: 20.h,
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             )
  //           : SizedBox(),
  //     ],
  //   );
  // }

  Widget moreProducts() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "More Products",
              style: AppFontStyle.text_20_600(AppColors.darkText),
            ),
            InkWell(
              onTap: () {
                seeallproductcontroller.seeAll_Product_Api(
                    restaurant_id: '', category_id: categoryId.toString());
                Get.toNamed(AppRoutes.moreProducts, arguments: {
                  'restaurant_id': '',
                  'category_id': categoryId.toString()
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
        hBox(10),
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
                    Get.to(ProductDetailsScreen(
                      productId: controller
                          .productData.value.moreProducts![index].id
                          .toString(),
                      categoryId: categoryId,
                      categoryName: categoryName,
                    ));

                    controller.specific_Product_Api(
                        productId: controller
                            .productData.value.moreProducts![index].id
                            .toString(),
                        categoryId: categoryId.toString());
                  },
                  child: CustomItemBanner(
                    index: index,
                    product_id: controller
                        .productData.value.moreProducts![index].id
                        .toString(),
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
                  ));
            })
      ],
    );
  }

  Future showLoginRequired(context) {
    return showCupertinoModalPopup(
        // barrierDismissible: true,/
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            content: Container(
              height: 150.h,
              width: 320.w,
              padding: REdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Login Required',
                    style: AppFontStyle.text_18_600(AppColors.darkText),
                  ),
                  // hBox(15),
                  Text(
                    'You need to log in first',
                    style: AppFontStyle.text_14_400(AppColors.lightText),
                  ),
                  // hBox(15),
                  Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          height: 40.h,
                          color: AppColors.black,
                          onPressed: () {
                            Get.back();
                          },
                          text: "Cancel",
                          textStyle:
                              AppFontStyle.text_14_400(AppColors.darkText),
                        ),
                      ),
                      wBox(15),
                      Expanded(
                        child: CustomElevatedButton(
                          height: 40.h,
                          onPressed: () {
                            userPreference.removeUser();
                            Get.offAllNamed(AppRoutes.signUp);
                          },
                          text: "Login",
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
