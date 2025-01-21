import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Product_details/controller/pharma_specific_product_controller.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Vendor_details/pharmacy_vendor_details_screen.dart';
import 'package:woye_user/shared/widgets/custom_expansion_tile.dart';
import 'package:woye_user/shared/widgets/custom_grid_view.dart';

class PharmacyProductDetailsScreen extends StatelessWidget {
  final String productId;
  final String categoryId;
  final String categoryName;

  PharmacyProductDetailsScreen(
      {super.key,
      required this.productId,
      required this.categoryId,
      required this.categoryName});

  final PharmaSpecificProductController controller =
      Get.put(PharmaSpecificProductController());

  @override
  Widget build(BuildContext context) {
    RxInt selectedIndex = 0.obs;
    // String mainBannerImage = image;
    // String title = this.title;

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
          Container(
              padding: REdgeInsets.all(9),
              height: 44.h,
              width: 44.h,
              decoration: BoxDecoration(
                  color: AppColors.greyBackground,
                  borderRadius: BorderRadius.circular(12.r)),
              child: Icon(
                Icons.favorite_outline_sharp,
                size: 24.w,
              )),
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
                  controller.pharmaSpecificProductApi(
                      productId: productId, categoryId: categoryId.toString());
                },
              );
            } else {
              return GeneralExceptionWidget(
                onPress: () {
                  controller.pharmaSpecificProductApi(
                      productId: productId, categoryId: categoryId.toString());
                },
              );
            }
          case Status.COMPLETED:
            return RefreshIndicator(
                onRefresh: () async {
                  controller.pharmaSpecificProductApi(
                      productId: productId, categoryId: categoryId.toString());
                },
                child: SingleChildScrollView(
                  padding: REdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      mainBanner(),
                      hBox(10),
                      //
                      titleAndDetails(),
                      hBox(30),
                      //
                      description(),
                      hBox(30),
                      //
                      shopCard(),
                      hBox(20),
                      //
                      buttons(),
                      hBox(30),
                      //
                      dropdownsSection(),
                      hBox(30),
                      //
                      productReviews(),
                      hBox(8),
                      //
                      const Divider(),
                      hBox(30),
                      //
                      reviews(),
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

  Widget mainBanner() {
    // RxBool isSelected = false.obs;
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
      ],
    );
  }

  Widget titleAndDetails() {
    var product = controller.productData.value.product;
    // RxInt cartCount = 1.obs;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        categoryName,
        style: AppFontStyle.text_16_400(AppColors.primary),
      ),
      hBox(10),
      Text(
        product!.title.toString(),
        overflow: TextOverflow.visible,
        style: AppFontStyle.text_18_600(
          AppColors.darkText,
        ),
      ),
      hBox(10),
      Row(
        children: [
          Text(
            product.packagingValue.toString(),
            // "Strip of 10 tablets",
            style: AppFontStyle.text_14_400(AppColors.lightText),
          ),
          Text(
            " • ",
            style: AppFontStyle.text_14_400(AppColors.lightText),
          ),
          SvgPicture.asset("assets/svg/star-yellow.svg"),
          wBox(4),
          Text(
            "4.5/5",
            style: AppFontStyle.text_14_400(AppColors.lightText),
          ),
        ],
      ),
      hBox(10),
      Row(
        children: [
          Text(
            "Provided by",
            style: AppFontStyle.text_12_400(AppColors.lightText),
          ),
          wBox(5),
          ClipRRect(
            borderRadius: BorderRadius.circular(50.r),
            child: Image.asset(
              "assets/images/tablet-rounded.png",
              height: 20.h,
              width: 20.h,
              fit: BoxFit.cover,
            ),
          ),
          wBox(5),
          Text(
            product.pharmaName.toString(),
            style: AppFontStyle.text_14_600(AppColors.darkText),
          ),
        ],
      ),
      Row(
        children: [
          Text(
            "\$${product.salePrice.toString()}",
            style: AppFontStyle.text_16_600(AppColors.primary),
          ),
          wBox(8),
          Text(
            "\$${product.regularPrice.toString()}",
            style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.mediumText,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.lineThrough,
                decorationColor: AppColors.mediumText),
          ),
          const Spacer(),
          product.quanInStock.toString() != "0"
              ? Container(
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
                            int stockQuantity =
                                int.tryParse(product.quanInStock ?? '0') ?? 0;

                            if (controller.cartCount.value < stockQuantity) {
                              controller.cartCount.value++;
                            } else {
                              Utils.showToast(
                                  "Quantity is limited. Only $stockQuantity items available.");
                            }
                          },
                          child: Icon(
                            Icons.add,
                            size: 20.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Opacity(
                  opacity: 0.5,
                  child: GestureDetector(
                    onTap: () {
                      Utils.showToast("Product not available at the moment.");
                    },
                    child: Container(
                      height: 40.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        border:
                            Border.all(width: 0.8.w, color: AppColors.primary),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.remove,
                              size: 20.w,
                            ),
                          ),
                          Text(
                            "${0}",
                            style: AppFontStyle.text_14_400(AppColors.darkText),
                          ),
                          GestureDetector(
                            child: Icon(
                              Icons.add,
                              size: 20.w,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
        ],
      ),
      hBox(20),
      Text(
        "Consume Type",
        style: AppFontStyle.text_16_400(AppColors.darkText),
      ),
      hBox(5),
      Text(
        "ORAL",
        style: AppFontStyle.text_14_400(AppColors.lightText),
      ),
      hBox(20),
      Text(
        "Expires Date",
        style: AppFontStyle.text_16_400(AppColors.darkText),
      ),
      hBox(5),
      Text(
        product.expire.toString(),
        style: AppFontStyle.text_14_400(AppColors.lightText),
      ),
    ]);
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
          overflow: TextOverflow.visible,
          style: AppFontStyle.text_16_400(AppColors.lightText, height: 1.4),
        ),
      ],
    );
  }

  Widget shopCard() {
    return InkWell(
      // onTap: () {
      //   Get.to(PharmacyVendorDetailsScreen(
      //       title: "Micro Labs Ltd",
      //       image: "assets/images/tablet-rounded.png"));
      // },
      child: Container(
        padding: REdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.greyBackground.withOpacity(0.4),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(
                "assets/images/tablet-rounded.png",
                height: 50.h,
              ),
            ),
            wBox(10),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.productData.value.product!.pharmaName.toString(),
                    style: AppFontStyle.text_16_600(AppColors.darkText),
                  ),
                  hBox(5),
                  Row(
                    children: [
                      SvgPicture.asset("assets/svg/star-yellow.svg"),
                      wBox(4),
                      Text(
                        "4.5/5",
                        style: AppFontStyle.text_14_400(AppColors.lightText),
                      ),
                      wBox(4),
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.pharmacyVendorReview);
                        },
                        child: Text(
                          "(120 Reviews)",
                          style: AppFontStyle.text_12_400(AppColors.lightText),
                        ),
                      ),
                    ],
                  ),
                  hBox(10),
                  CustomOutlinedButton(
                      height: 40.h,
                      onPressed: () {},
                      child: const Text("Favorite Shop"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttons() {
    return Row(
      children: [
        Expanded(
          child: CustomElevatedButton(
              height: 50.h,
              width: Get.width,
              color: AppColors.darkText,
              text: "Add to Cart",
              onPressed: () {}),
        ),
        wBox(10),
        Expanded(
          child: CustomElevatedButton(
              height: 50.h,
              width: Get.width,
              text: "Buy now",
              onPressed: () {}),
        ),
      ],
    );
  }

  Widget dropdownsSection() {
    List dropdownTitles = [
      "How to Use?",
      "Usage, Direction and Dosage",
      "Interactions",
      "Side Effects",
      "Expert advice and Concern",
      "When not to use?",
      "General Instructions & Warnings",
      "Other Details"
    ];
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          itemCount: 8,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, i) {
            RxBool isExpanded = false.obs;

            return Obx(
              () => Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                          color: isExpanded.value == false
                              ? AppColors.textFieldBorder
                              : AppColors.darkText)),
                  child: CustomExpansionTile(
                      onExpansionChanged: (value) {
                        isExpanded.value = value;
                      },
                      title: dropdownTitles[i],
                      titleTextStyle:
                          AppFontStyle.text_16_600(AppColors.darkText),
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                "•",
                                style: AppFontStyle.text_14_600(
                                    AppColors.darkText),
                              ),
                            ),
                            wBox(10),
                            Expanded(
                              flex: 39,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Missed Dose",
                                    style: AppFontStyle.text_14_600(
                                        AppColors.darkText),
                                  ),
                                  hBox(10),
                                  Text(
                                    "Lorem Ipsum has been the industry's text ever since the 1500s, when an unknown printer took a galley of type and  it to make a type specimen book.",
                                    overflow: TextOverflow.visible,
                                    style: AppFontStyle.text_14_400(
                                        AppColors.lightText),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        hBox(20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                "•",
                                style: AppFontStyle.text_14_600(
                                    AppColors.darkText),
                              ),
                            ),
                            wBox(10),
                            Expanded(
                              flex: 39,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Overdose",
                                    style: AppFontStyle.text_14_600(
                                        AppColors.darkText),
                                  ),
                                  hBox(10),
                                  Text(
                                    "Lorem Ipsum has been the industry's text ever since the 1500s, when an unknown printer took a galley of type and  it to make a type specimen book.",
                                    overflow: TextOverflow.visible,
                                    style: AppFontStyle.text_14_400(
                                        AppColors.lightText),
                                  ),
                                  hBox(10)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ])),
            );
          },
          separatorBuilder: (context, index) => hBox(20),
        )
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
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              "assets/svg/star-yellow.svg",
              width: 15.w,
            ),
            SvgPicture.asset(
              "assets/svg/star-yellow.svg",
              width: 15.w,
            ),
            SvgPicture.asset(
              "assets/svg/star-yellow.svg",
              width: 15.w,
            ),
            SvgPicture.asset(
              "assets/svg/star-yellow.svg",
              fit: BoxFit.cover,
              width: 15.w,
            ),
            SvgPicture.asset(
              "assets/svg/star-white.svg",
            ),
            wBox(8),
            Text(
              "4.5/5",
              style: AppFontStyle.text_16_400(AppColors.darkText),
            ),
            wBox(8),
            Text(
              "(120 reviews)",
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
              itemCount: 2,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.r),
                            child: Image.asset(
                              "assets/images/profile-review.png",
                              height: 50.h,
                              width: 50.h,
                              fit: BoxFit.cover,
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
                                "Ronald Richards",
                                style: AppFontStyle.text_16_400(
                                    AppColors.darkText),
                              ),
                              hBox(5),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/star-yellow.svg",
                                    width: 15.w,
                                  ),
                                  SvgPicture.asset(
                                    "assets/svg/star-yellow.svg",
                                    width: 15.w,
                                  ),
                                  SvgPicture.asset(
                                    "assets/svg/star-yellow.svg",
                                    width: 15.w,
                                  ),
                                  SvgPicture.asset(
                                    "assets/svg/star-yellow.svg",
                                    fit: BoxFit.cover,
                                    width: 15.w,
                                  ),
                                  SvgPicture.asset(
                                    "assets/svg/star-white.svg",
                                  ),
                                ],
                              ),
                              hBox(10),
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                overflow: TextOverflow.visible,
                                style: AppFontStyle.text_16_400(
                                    AppColors.darkText),
                              ),
                              hBox(10),
                              Row(
                                children: [
                                  Text(
                                    "01-09-2024",
                                    style: AppFontStyle.text_16_400(
                                        AppColors.lightText),
                                  ),
                                  wBox(10),
                                  Text(
                                    "12:20",
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
              // separatorBuilder: (context, inxex) => Padding(
              //   padding: REdgeInsets.symmetric(vertical: 10),
              //   child: const Divider(),
              // ),
            ),
          ],
        ),
        hBox(10),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Get.toNamed(AppRoutes.pharmacyProductReviews);
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
    var moreProducts = controller.productData.value.moreProducts;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Similar Products",
              style: AppFontStyle.text_20_600(AppColors.darkText),
            ),
            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.pharmacyMoreProduct);
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "See All",
                    style: AppFontStyle.text_14_600(AppColors.primary),
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
        hBox(20.h),
        GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: moreProducts!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65.h,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 5.h,
            ),
            itemBuilder: (context, index) {
              return CustomBanner(
                image: moreProducts[index].urlImage.toString(),
                sale_price: moreProducts[index].salePrice.toString(),
                regular_price: moreProducts[index].regularPrice.toString(),
                title: moreProducts[index].title.toString(),
                quantity: moreProducts[index].packagingValue.toString(),
                categoryId: moreProducts[index].categoryId.toString(),
                product_id: moreProducts[index].id.toString(),
                shop_name: moreProducts[index].shopName.toString(),
                is_in_wishlist: moreProducts[index].isInWishlist,
                isLoading: moreProducts[index].isLoading,
                categoryName: moreProducts[index].categoryName.toString(),
              );
            })
      ],
    );
  }
}
