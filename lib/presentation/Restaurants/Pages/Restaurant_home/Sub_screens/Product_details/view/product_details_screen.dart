import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Shared/Widgets/custom_radio_button_reverse.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/controller/specific_product_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_wishlist/Controller/aad_product_wishlist_Controller/add_product_wishlist.dart';
import 'package:woye_user/shared/widgets/CircularProgressIndicator.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String product_id;
  final String category_id;
  final String category_name;

  ProductDetailsScreen({
    super.key,
    required this.product_id,
    required this.category_id,
    required this.category_name,
  });

  final add_Product_Wishlist_Controller add_Wishlist_Controller =
      Get.put(add_Product_Wishlist_Controller());

  final specific_Product_Controller controller =
      Get.put(specific_Product_Controller());

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
                controller.product_Data.value.product?.isInWishlist =
                    !controller.product_Data.value.product!.isInWishlist!;
                await add_Wishlist_Controller.restaurant_add_product_wishlist(
                  categoryId: category_id,
                  product_id: product_id.toString(),
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
                        controller.product_Data.value.product?.isInWishlist !=
                                true
                            ? Icons.favorite_outline_sharp
                            : Icons.favorite_outlined,
                        size: 24.w,
                      ),
              ),
            );
          }),
          wBox(8),
          Container(
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
                      product_id: product_id,
                      category_id: category_id.toString());
                },
              );
            } else {
              return GeneralExceptionWidget(
                onPress: () {
                  controller.specific_Product_Api(
                      product_id: product_id,
                      category_id: category_id.toString());
                },
              );
            }
          case Status.COMPLETED:
            return RefreshIndicator(
                onRefresh: () async {
                  controller.specific_Product_Api(
                      product_id: product_id,
                      category_id: category_id.toString());
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
                      extra(context: context),
                      if (controller.product_Data.value.product!.extra != null)
                        hBox(20),
                      if (controller.product_Data.value.product!.addOn != null)
                        addOn(
                          context: context,
                          checkBoxGroupValues: true.obs,
                        ),
                      if (controller.product_Data.value.product!.addOn != null)
                        hBox(30),
                      CustomElevatedButton(
                          // height: 50.h,
                          width: Get.width,
                          color: AppColors.darkText,
                          text: "Add to Cart",
                          onPressed: () {}),
                      hBox(30),
                      productReviews(),
                      hBox(8),
                      const Divider(),
                      hBox(30),
                      reviews(),
                      hBox(30),
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
    RxInt cartCount = 1.obs;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: CachedNetworkImage(
              imageUrl: controller.selectedImageUrl.value.isEmpty
                  ? controller.product_Data.value.product!.urlImage.toString()
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
        hBox(10),
        SizedBox(
          height: 100.h,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount:
                controller.product_Data.value.product?.urlAddimg!.length ?? 0,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Obx(
                () => GestureDetector(
                  onTap: () {
                    controller.isSelected.value = index;

                    controller.selectedImageUrl.value = controller
                        .product_Data.value.product!.urlAddimg![index];
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
                            .product_Data.value.product!.urlAddimg![index],
                        fit: BoxFit.cover,
                        height: 90.h,
                        width: 100.h,
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

        // Obx(
        //   () => Column(
        //     children: [
        //       // PageView to allow sliding between images
        //       SizedBox(
        //         height: 340.h,
        //         child: PageView.builder(
        //           controller: controller.pageController,
        //           // Optional: For programmatic control
        //           itemCount: controller
        //                   .product_Data.value.product?.urlAddimg?.length ??
        //               0,
        //           onPageChanged: (index) {
        //             // Update selected image URL when sliding
        //             controller.selectedImageUrl.value = controller
        //                 .product_Data.value.product!.urlAddimg![index];
        //           },
        //           itemBuilder: (context, index) {
        //             String imageUrl = controller
        //                 .product_Data.value.product!.urlAddimg![index];
        //             return ClipRRect(
        //               borderRadius: BorderRadius.circular(20.r),
        //               child: CachedNetworkImage(
        //                 imageUrl: imageUrl,
        //                 fit: BoxFit.cover,
        //                 height: 340.h,
        //                 errorWidget: (context, url, error) =>
        //                     const Center(child: Icon(Icons.error)),
        //                 placeholder: (context, url) => Shimmer.fromColors(
        //                   baseColor: AppColors.gray,
        //                   highlightColor: AppColors.lightText,
        //                   child: Container(
        //                     decoration: BoxDecoration(
        //                       color: AppColors.gray,
        //                       borderRadius: BorderRadius.circular(20.r),
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //             );
        //           },
        //         ),
        //       ),
        //
        //       hBox(10),
        //
        //       // Image thumbnails for selection
        //       SizedBox(
        //         height: 100.h,
        //         child: ListView.separated(
        //           shrinkWrap: true,
        //           itemCount: controller
        //                   .product_Data.value.product?.urlAddimg?.length ??
        //               0,
        //           scrollDirection: Axis.horizontal,
        //           itemBuilder: (context, index) {
        //             bool isSelected = controller.selectedImageUrl.value ==
        //                 controller
        //                     .product_Data.value.product!.urlAddimg![index];
        //
        //             return GestureDetector(
        //               onTap: () {
        //                 // Update selected image URL and move the PageView to the selected image
        //                 controller.selectedImageUrl.value = controller
        //                     .product_Data.value.product!.urlAddimg![index];
        //                 controller.pageController.jumpToPage(
        //                     index); // Move the PageView to the selected image
        //               },
        //               child: Container(
        //                 decoration: BoxDecoration(
        //                   border: isSelected
        //                       ? Border.all(
        //                           color: AppColors.primary,
        //                           width: 2) // Change border color when selected
        //                       : null,
        //                   borderRadius: BorderRadius.circular(18.r),
        //                 ),
        //                 child: ClipRRect(
        //                   borderRadius: BorderRadius.circular(15.r),
        //                   child: CachedNetworkImage(
        //                     imageUrl: controller
        //                         .product_Data.value.product!.urlAddimg![index],
        //                     fit: BoxFit.cover,
        //                     height: 90.h,
        //                     width: 100.h,
        //                     errorWidget: (context, url, error) =>
        //                         const Center(child: Icon(Icons.error)),
        //                     placeholder: (context, url) => Shimmer.fromColors(
        //                       baseColor: AppColors.gray,
        //                       highlightColor: AppColors.lightText,
        //                       child: Container(
        //                         decoration: BoxDecoration(
        //                           color: AppColors.gray,
        //                           borderRadius: BorderRadius.circular(20.r),
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //             );
        //           },
        //           separatorBuilder: (context, itemIndex) => wBox(10.w),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),

        hBox(10),
        Text(
          category_name,
          style: AppFontStyle.text_16_400(AppColors.primary,
              fontWeight: FontWeight.bold),
        ),
        hBox(10),
        Text(
          controller.product_Data.value.product!.title.toString(),
          style: AppFontStyle.text_20_400(AppColors.darkText),
        ),
        hBox(10),
        Row(
          children: [
            SvgPicture.asset("assets/svg/star-yellow.svg"),
            wBox(4),
            Text(
              "${controller.product_Data.value.product!.rating.toString()}/5",
              style: AppFontStyle.text_14_400(AppColors.lightText),
            ),
          ],
        ),
        hBox(10),
        Row(
          children: [
            Text(
              "\$${controller.product_Data.value.product!.salePrice.toString()}",
              style: AppFontStyle.text_16_600(AppColors.primary),
            ),
            wBox(8),
            Text(
              "\$${controller.product_Data.value.product!.regularPrice.toString()}",
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
                        // if (cartCount.value != 0) cartCount.value--;
                        if (cartCount.value > 1) cartCount.value--;
                      },
                      child: Icon(
                        Icons.remove,
                        size: 16.w,
                      ),
                    ),
                    Text(
                      "${cartCount.value}",
                      style: AppFontStyle.text_14_400(AppColors.darkText),
                    ),
                    GestureDetector(
                      onTap: () {
                        cartCount.value++;
                      },
                      child: Icon(
                        Icons.add,
                        size: 16.w,
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
          controller.product_Data.value.product!.description.toString(),
          style: AppFontStyle.text_16_400(AppColors.lightText, height: 1.4),
          maxLines: 4,
        ),
      ],
    );
  }

  Widget extra({context}) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.product_Data.value.product!.extra?.length ?? 0,
      itemBuilder: (context, index) {
        var extra = controller.product_Data.value.product!.extra![index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              extra.title.toString(),
              style: AppFontStyle.text_20_600(AppColors.darkText),
            ),
            hBox(5),
            Row(
              children: [
                Text(
                  "Required",
                  style: AppFontStyle.text_16_300(AppColors.lightText),
                ),
                Text(
                  "•",
                  style: AppFontStyle.text_16_300(AppColors.lightText),
                ),
                wBox(4),
                Text(
                  "Select any 1 option",
                  style: AppFontStyle.text_16_300(AppColors.lightText),
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
                      .product_Data.value.product!.extra![index].selectedIndex,
                  onChanged: (value) {
                    controller.product_Data.value.product!.extra![index]
                        .selectedIndex.value = value!;
                  },
                  priceValue: item.price.toString(),
                );
              },
              separatorBuilder: (context, itemIndex) => hBox(8),
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
              "Select up to ${controller.product_Data.value.product!.addOn!.length} option",
              style: AppFontStyle.text_16_300(AppColors.lightText),
            ),
          ],
        ),
        hBox(10),
        Obx(
          () {
            var addOnListLength =
                controller.product_Data.value.product!.addOn?.length ?? 0;

            int itemCount = addOnListLength > 6
                ? (showAll.value ? addOnListLength : 6)
                : addOnListLength;

            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: itemCount,
              itemBuilder: (context, index) {
                var addOn =
                    controller.product_Data.value.product!.addOn![index];
                return CustomTitleCheckbox(
                  title: addOn.name.toString(),
                  groupValue: checkBoxGroupValues,
                  onChanged: (value) {
                    addOn.isChecked.value = value;
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
                controller.product_Data.value.product!.addOn?.length ?? 0;
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

  Widget productReviews() {
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
              initialRating: controller.product_Data.value.product!.rating!,
              maxRating: 5,
              size: 20.h,
            ),
            wBox(8),
            Text(
              "${controller.product_Data.value.product!.rating.toString()}/5",
              style: AppFontStyle.text_16_400(AppColors.darkText),
            ),
            wBox(8),
            Text(
              "(${controller.product_Data.value.product!.productreview_count.toString()} reviews)",
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
                  controller.product_Data.value.product!.productreview!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50.r),
                          child: CachedNetworkImage(
                            imageUrl: controller.product_Data.value.product!
                                .productreview![index].user!.imageUrl
                                .toString(),
                            fit: BoxFit.cover,
                            height: 50.h,
                            width: 50.h,
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
                        wBox(15),
                        Flexible(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.product_Data.value.product!
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
                                initialRating: controller.product_Data.value
                                    .product!.productreview![index].rating!,
                                maxRating: 5,
                                size: 20.h,
                              ),
                              hBox(10),
                              Text(
                                controller.product_Data.value.product!
                                    .productreview![index].message
                                    .toString(),
                                style: AppFontStyle.text_16_400(
                                    AppColors.darkText),
                                maxLines: 2,
                              ),
                              hBox(10),
                              Row(
                                children: [
                                  Text(
                                    controller.formatDate(controller
                                        .product_Data
                                        .value
                                        .product!
                                        .productreview![index]
                                        .updatedAt
                                        .toString()),
                                    style: AppFontStyle.text_16_400(
                                        AppColors.lightText),
                                  ),
                                ],
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
                );
              },
            ),
          ],
        ),
        hBox(10),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Get.toNamed(AppRoutes.productReviews);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "See All (20)",
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
    );
  }

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
                Get.toNamed(AppRoutes.moreProducts);
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
            itemCount: controller.product_Data.value.moreProducts!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6.h,
              crossAxisSpacing: 14.w,
              mainAxisSpacing: 5.h,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Get.to(ProductDetailsScreen(
                      product_id: controller
                          .product_Data.value.moreProducts![index].id
                          .toString(),
                      category_id: category_id,
                      category_name: category_name,
                    ));

                    controller.specific_Product_Api(
                        product_id: controller
                            .product_Data.value.moreProducts![index].id
                            .toString(),
                        category_id: category_id.toString());
                  },
                  child: CustomItemBanner(
                    index: index,
                    product_id: controller
                        .product_Data.value.moreProducts![index].id
                        .toString(),
                    categoryId: category_id,
                    image: controller
                        .product_Data.value.moreProducts![index].urlImage,
                    title: controller
                        .product_Data.value.moreProducts![index].title,
                    rating: controller
                        .product_Data.value.moreProducts![index].rating
                        .toString(),
                    is_in_wishlist: controller
                        .product_Data.value.moreProducts![index].isInWishlist,
                    isLoading: controller
                        .product_Data.value.moreProducts![index].isLoading,
                    sale_price: controller
                        .product_Data.value.moreProducts![index].salePrice
                        .toString(),
                    regular_price: controller
                        .product_Data.value.moreProducts![index].regularPrice
                        .toString(),
                    resto_name: controller
                        .product_Data.value.moreProducts![index].restoName
                        .toString(),
                  ));
            })
      ],
    );
  }
}
