import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Shared/Widgets/custom_radio_button_reverse.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/controller/specific_product_controller.dart';
import 'package:woye_user/shared/widgets/CircularProgressIndicator.dart';

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

  final specific_Product_Controller controller =
      Get.put(specific_Product_Controller());

  @override
  Widget build(BuildContext context) {
    // String mainBanner = image;
    // String title = this.title;

    // List sizeData = [
    //   {"title": "Small", "price": "\$18.00"},
    //   {"title": "Medium", "price": "\$22.00"},
    //   {"title": "Large", "price": "\$28.00"},
    // ];
    RxInt baseSectionValue = 1.obs;
    List baseSectionData = [
      {"title": "White Base", "price": "\$5.00"},
      {"title": "Cheese Burst", "price": "\$7.00"},
      {"title": "Cheese Burst", "price": "\$8.00"},
    ];
    RxInt addOnValue = 1.obs;
    List addOnData = [
      {"title": "Capsicum", "price": "\$1.00"},
      {"title": "Tomato", "price": "\$2.00"},
      {"title": "Onion", "price": "\$3.00"},
      {"title": "Extra Cheese", "price": "\$4.00"},
      {"title": "Golden Corn", "price": "\$5.00"},
      {"title": "Red Paprika", "price": "\$6.00"},
      {"title": "Capsicum", "price": "\$1.00"},
      {"title": "Tomato", "price": "\$2.00"},
      {"title": "Onion", "price": "\$3.00"},
    ];

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
                            jsonData: addOnData),
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
    // RxBool isSelected = false.obs;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: CachedNetworkImage(
            imageUrl:
                controller.product_Data.value.product!.urlImage.toString(),
            fit: BoxFit.cover,
            height: 340.h,
            errorWidget: (context, url, error) => const Icon(Icons.error),
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
        hBox(10),
        Text(
          category_name,
          style: AppFontStyle.text_16_400(AppColors.primary),
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
                        if (cartCount.value != 0) cartCount.value--;
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
            )
          ],
        )
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

  // Widget extra({context}) {
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     itemCount: controller.product_Data.value.product!.extra?.length ?? 0,
  //     itemBuilder: (context, index) {
  //       var extra = controller.product_Data.value.product!.extra![index];
  //       return Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             extra.title.toString(),
  //             style: AppFontStyle.text_20_600(AppColors.darkText),
  //           ),
  //           hBox(5),
  //           Row(
  //             children: [
  //               Text(
  //                 "Required",
  //                 style: AppFontStyle.text_16_300(AppColors.lightText),
  //               ),
  //               Text(
  //                 "•",
  //                 style: AppFontStyle.text_16_300(AppColors.lightText),
  //               ),
  //               wBox(4),
  //               Text(
  //                 "Select any 1 option",
  //                 style: AppFontStyle.text_16_300(AppColors.lightText),
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
  //                 groupValue: item.Selcted,
  //                 onChanged: (value) {
  //                   print("$value");
  //                   item.Selcted.value = value!;
  //                 },
  //                 priceValue: item.price.toString(),
  //               );
  //             },
  //             separatorBuilder: (context, itemIndex) => hBox(8),
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

  Widget addOn({context, checkBoxGroupValues, jsonData}) {
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
            itemCount: 2,
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
                      product_id: '',
                      category_id: '',
                      category_name: '',
                    ));
                  },
                  child: CustomItemBanner(index: index));
            })
      ],
    );
  }

// Widget baseSection({context, radioGroupValue, jsonData}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         "Base Bread Section",
//         style: AppFontStyle.text_20_600(AppColors.darkText),
//       ),
//       hBox(10),
//       Row(
//         children: [
//           Text(
//             "Required",
//             style: AppFontStyle.text_16_300(AppColors.lightText),
//           ),
//           Text(
//             "•",
//             style: AppFontStyle.text_16_300(AppColors.lightText),
//           ),
//           wBox(4),
//           Text(
//             "Select any 1 option",
//             style: AppFontStyle.text_16_300(AppColors.lightText),
//           ),
//         ],
//       ),
//       hBox(10),
//       ListView.separated(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: jsonData.length,
//         itemBuilder: (context, index) {
//           final data = jsonData[index];
//           return CustomTitleRadioButton(
//               title: data["title"],
//               value: index.obs,
//               groupValue: radioGroupValue,
//               onChanged: (value) {
//                 radioGroupValue.value = value!;
//               },
//               priceValue: data["price"]);
//         },
//         separatorBuilder: (context, inxex) => hBox(8),
//       ),
//     ],
//   );
// }

// Widget addOn({context, radioGroupValue, jsonData}) {
//   RxBool showAll = false.obs;
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         "Base Bread Section",
//         style: AppFontStyle.text_20_600(AppColors.darkText),
//       ),
//       hBox(10),
//       Row(
//         children: [
//           Text(
//             "Required",
//             style: AppFontStyle.text_16_300(AppColors.lightText),
//           ),
//           Text(
//             "•",
//             style: AppFontStyle.text_16_300(AppColors.lightText),
//           ),
//           wBox(4),
//           Text(
//             "Select any 1 option",
//             style: AppFontStyle.text_16_300(AppColors.lightText),
//           ),
//         ],
//       ),
//       hBox(10),
//       Obx(
//         () => ListView.separated(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: showAll.value ? jsonData.length : 5,
//           itemBuilder: (context, index) {
//             final data = jsonData[index];
//             return CustomTitleRadioButton(
//                 title: data["title"],
//                 value: index.obs,
//                 groupValue: radioGroupValue,
//                 onChanged: (value) {
//                   radioGroupValue.value = value!;
//                 },
//                 priceValue: data["price"]);
//           },
//           separatorBuilder: (context, inxex) => hBox(8),
//         ),
//       ),
//       hBox(10),
//       Obx(
//         () => InkWell(
//           splashColor: Colors.transparent,
//           highlightColor: Colors.transparent,
//           onTap: () {
//             showAll.value = !showAll.value;
//           },
//           child: showAll.value
//               ? Row(
//                   children: [
//                     Text(
//                       "Hide",
//                       style: AppFontStyle.text_16_600(AppColors.primary),
//                     ),
//                     Icon(
//                       Icons.keyboard_arrow_up_sharp,
//                       color: AppColors.primary,
//                       size: 30.h,
//                     )
//                   ],
//                 )
//               : Row(
//                   children: [
//                     // Text(
//                     //   "+",
//                     //   style: AppFontStyle.text_18_600(AppColors.primary),
//                     // ),
//                     Text(
//                       "Show More",
//                       style: AppFontStyle.text_16_600(AppColors.primary),
//                     ),
//                     Icon(
//                       Icons.keyboard_arrow_down_sharp,
//                       color: AppColors.primary,
//                       size: 30.h,
//                     )
//                   ],
//                 ),
//         ),
//       )
//     ],
//   );
// }
}
