import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Categories_details/controller/RestaurantCategoriesDetailsController.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/Shared/Widgets/custom_radio_button.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Filter/controller/CategoriesFilter_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Filter/modal/CategoriesFilter_modal.dart';

import '../../../../../../../Shared/theme/font_family.dart';

final Categories_FilterController controller =Get.put(Categories_FilterController());

final RestaurantCategoriesDetailsController restaurantCategoriesDetailsController = Get.put(RestaurantCategoriesDetailsController());

class RestaurantCategoriesFilter extends StatelessWidget {
  const RestaurantCategoriesFilter({super.key});


  @override
  Widget build(BuildContext context) {
    var categoryId = Get.arguments['categoryId'] ?? "";
    // WidgetsBinding.instance.add
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // appBar: CustomAppBar(
        //   title: Text(
        //     "Filter",
        //     style: AppFontStyle.text_22_600(AppColors.darkText),
        //   ),
        // ),
        body: Obx(() {
          switch (controller.rxRequestStatus.value) {
            case Status.LOADING:
              return Center(child: circularProgressIndicator());
            case Status.ERROR:
              if (controller.error.value == 'No internet'|| controller.error.value == "InternetExceptionWidget") {
                return InternetExceptionWidget(
                  onPress: () {
                    controller.Refresh_Api();
                  },
                );
              } else {
                return GeneralExceptionWidget(
                  onPress: () {
                    controller.Refresh_Api();
                  },
                );
              }
            case Status.COMPLETED:
              return RefreshIndicator(
                onRefresh: () async {
                  controller.Refresh_Api();
                },
                child: Column(
                  children: [
                    appbar(),
                    Padding(
                      padding: REdgeInsets.symmetric(horizontal: 24.0),
                      child: TabBar(
                        labelPadding: EdgeInsets.zero,
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: AppColors.gray,
                        dividerHeight: 0.5,
                        labelStyle:
                            AppFontStyle.text_18_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
                        tabs: const [
                          Tab(text: "Filter"),
                          Tab(text: "Sort"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          filterWidget(categoryId),
                          sortWidget(categoryId),
                        ],
                      ),
                    ),
                  ],
                ),
                // child: Padding(
                //   padding: REdgeInsets.symmetric(horizontal: 24.0),
                //   child: SingleChildScrollView(
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         if (controller
                //             .getFilterData.value.cuisineType!.isNotEmpty)
                //           Cuisines(),
                //         if (controller
                //             .getFilterData.value.cuisineType!.isNotEmpty)
                //           hBox(30),
                //         price(),
                //         hBox(30),
                //         quickFilter(),
                //         hBox(30),
                //         priceRange(),
                //         hBox(20),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //           children: [
                //             Expanded(
                //                 child: CustomElevatedButton(
                //                     height: 55.h,
                //                     text: "Clear",
                //                     color: AppColors.black,
                //                     onPressed: () {
                //                       controller.selectedCuisines.clear();
                //                       controller.selectedQuickFilters.clear();
                //                       controller.priceRadioValue.value = 0;
                //                       controller.lowerValue.value = controller
                //                           .getFilterData.value.minPrice!
                //                           .toDouble();
                //                       controller.upperValue.value = controller
                //                           .getFilterData.value.maxPrice!
                //                           .toDouble();
                //                       for (var cuisine in controller
                //                           .getFilterData.value.cuisineType!) {
                //                         cuisine.isSelected.value = false;
                //                       }
                //                     })),
                //             wBox(10),
                //             Expanded(
                //                 child: CustomElevatedButton(
                //                     height: 55.h,
                //                     text: "Apply",
                //                     onPressed: () {
                //                       Get.back();
                //                       restaurantCategoriesDetailsController
                //                           .restaurant_Categories_Details_filter_Api(
                //                         id: categoryId.toString(),
                //                         cuisine_type: controller
                //                             .selectedCuisines
                //                             .join(', '),
                //                         price_sort:
                //                             controller.priceRadioValue.value ==
                //                                     0
                //                                 ? ""
                //                                 : controller.priceRadioValue
                //                                             .value ==
                //                                         1
                //                                     ? "low to high"
                //                                     : "high to low",
                //                         quick_filter: controller
                //                             .selectedQuickFilters
                //                             .toString(),
                //                         price_range:
                //                             "${controller.lowerValue.value},${controller.upperValue.value}",
                //                       );
                //                     }))
                //           ],
                //         ),
                //         hBox(50)
                //       ],
                //     ),
                //   ),
                // ),
              );
          }
        }),
      ),
    );
  }

  Widget filterWidget(categoryId) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            hBox(15.h),
            if (controller.getFilterData.value.cuisineType?.isNotEmpty ?? false)
              Cuisines(),
            if (controller.getFilterData.value.cuisineType?.isNotEmpty ?? false)
              hBox(20.h),
            // price(),
            // hBox(30),
            quickFilter(),
            hBox(30),
            priceRange(),
            hBox(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: CustomElevatedButton(
                        fontFamily: AppFontFamily.gilroyMedium,
                        height: 55.h,
                        text: "Clear",
                        color: AppColors.black,
                        onPressed: () {
                          controller.selectedCuisines.clear();
                          controller.selectedQuickFilters.clear();
                          // controller.priceRadioValue.value = 0;
                          controller.lowerValue.value = controller
                              .getFilterData.value.minPrice!
                              .toDouble();
                          controller.upperValue.value = controller
                              .getFilterData.value.maxPrice!
                              .toDouble();
                          for (var cuisine
                              in controller.getFilterData.value.cuisineType!) {
                            cuisine.isSelected.value = false;
                          }
                        })),
                wBox(10),
                Expanded(
                    child: CustomElevatedButton(
                      fontFamily: AppFontFamily.gilroyMedium,
                        height: 55.h,
                        text: "Apply",
                        onPressed: () {
                          Get.back();
                          controller.priceRadioValue.value = 0;
                          restaurantCategoriesDetailsController.restaurant_Categories_Details_filter_Api(
                            id: categoryId.toString(),
                            cuisine_type: controller.selectedCuisines.join(', '),
                            // price_sort: controller.priceRadioValue.value == 0
                            //     ? ""
                            //     : controller.priceRadioValue.value == 1
                            //         ? "low to high"
                            //         : "high to low",
                            quick_filter: controller.selectedQuickFilters.toString(),
                            price_range:"${controller.lowerValue.value},${controller.upperValue.value}",
                          );
                        }))
              ],
            ),
            hBox(50)
          ],
        ),
      ),
    );
  }

  Widget sortWidget(categoryId) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 24.0,vertical: 20),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                price(),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  child: CustomElevatedButton(
                      fontFamily: AppFontFamily.gilroyMedium,
                      height: 55.h,
                      text: "Clear",
                      color: AppColors.black,
                      onPressed: () {
                        // controller.selectedCuisines.clear();
                        // controller.selectedQuickFilters.clear();
                        controller.priceRadioValue.value = 0;
                        // controller.lowerValue.value =
                        //     controller.getFilterData.value.minPrice!.toDouble();
                        // controller.upperValue.value =
                        //     controller.getFilterData.value.maxPrice!.toDouble();
                        // for (var cuisine
                        // in controller.getFilterData.value.cuisineType!) {
                        //   cuisine.isSelected.value = false;
                        // }
                      })),
              wBox(10),
              Expanded(
                  child: CustomElevatedButton(
                      fontFamily: AppFontFamily.gilroyMedium,
                      height: 55.h,
                      text: "Apply",
                      onPressed: () {
                        Get.back();
                        controller.selectedCuisines.clear();
                        controller.selectedQuickFilters.clear();
                        // controller.priceRadioValue.value = 0;
                        controller.lowerValue.value = controller
                            .getFilterData.value.minPrice!
                            .toDouble();
                        controller.upperValue.value = controller
                            .getFilterData.value.maxPrice!
                            .toDouble();
                        for (var cuisine
                        in controller.getFilterData.value.cuisineType!) {
                          cuisine.isSelected.value = false;
                        }
                        restaurantCategoriesDetailsController.restaurant_Categories_Details_filter_Api(
                          id: categoryId.toString(),
                          // cuisine_type:
                          // controller.selectedCuisines.join(', '),
                          price_sort: controller.priceRadioValue.value == 0
                            ? ""
                            : controller.priceRadioValue.value == 1
                            ? "low to high"
                            : "high to low",
                          // quick_filter:
                          // controller.selectedQuickFilters.toString(),
                          // price_range:
                          // "${controller.lowerValue.value},${controller.upperValue.value}",
                        );
                      }))
            ],
          ),
        ],
      ),
    );
  }

  Padding appbar() {
    return Padding(
      padding: REdgeInsets.only(left: 24, top: 18),
      child: AppBar(
        leadingWidth: 44.w,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            width: 44.h,
            height: 44.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade200,
            ),
            child: Center(
              child: SvgPicture.asset("assets/svg/back.svg"),
            ),
          ),
        ),
      ),
    );
  }

  Widget Cuisines() {
    Rx<int> visibleItemCount = 20.obs;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cuisines",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            fontFamily: AppFontFamily.gilroyMedium,
          ),
        ),
        Obx(() {
          List<CuisineType> cuisineTypes =controller.getFilterData.value.cuisineType ?? [];
          List<List<CuisineType>> columns = [];
          for (int i = 0;i < visibleItemCount.value && i < cuisineTypes.length;i += 2) {
            columns.add(cuisineTypes.sublist(i,
              (i + 2) > cuisineTypes.length ? cuisineTypes.length : (i + 2),
            ));
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: columns.map((column) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: column.map((cuisine) {
                  return SizedBox(
                    width: Get.width / 2.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Transform.translate(
                            offset: Offset(-10.w, 0),
                            child: CheckboxListTile(
                              title: Transform.translate(
                                offset: Offset(-15.w, 0),
                                child: Text(
                                  cuisine.name.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp,
                                    fontFamily:AppFontFamily.gilroyMedium,
                                  ),
                                ),
                              ),
                              value: controller.selectedCuisines.contains(cuisine.id.toString()),
                              // value: cuisine.isSelected.value,
                              onChanged: (value) {
                                cuisine.isSelected.value = value!;
                                if (value) {
                                  controller.selectedCuisines.add(cuisine.id.toString());
                                } else {
                                  controller.selectedCuisines.remove(cuisine.id.toString());
                                }
                              },
                              checkboxShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r),
                                side: const BorderSide(
                                    width: 1, color: Colors.black),
                              ),
                              activeColor: Colors.black,
                              controlAffinity: ListTileControlAffinity.leading,
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            }).toList(),
          );
        }),
        Obx(() {
          if (controller.getFilterData.value.cuisineType!.length > 20) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (visibleItemCount.value <
                    controller.getFilterData.value.cuisineType!.length)
                  TextButton(
                    onPressed: () {
                      visibleItemCount.value += 10;
                    },
                    child: Text(
                      "See More",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFontFamily.gilroyMedium,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                // "Show Less" button to reduce visible items
                if (visibleItemCount.value > 20)
                  TextButton(
                    onPressed: () {
                      visibleItemCount.value = (visibleItemCount.value - 10)
                          .clamp(
                              20,
                              controller.getFilterData.value.cuisineType
                                      ?.length ??
                                  20);
                    },
                    child: Text(
                      "Show Less",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFontFamily.gilroyMedium,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
              ],
            );
          } else {
            return SizedBox(); // Empty space if no need for buttons
          }
        }),
      ],
    );
  }

  Widget price() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Price",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp,fontFamily: AppFontFamily.gilroyMedium)),
        CustomRadioButton(
          title: "Low to high",
          value: 1.obs,
          groupValue: controller.priceRadioValue,
          onChanged: (value) {
            controller.priceRadioValue.value = value!;
            controller.update();
          },
        ),
        CustomRadioButton(
          title: "High to low",
          value: 2.obs,
          groupValue: controller.priceRadioValue,
          onChanged: (value) {
            controller.priceRadioValue.value = value!;
          },
        ),
      ],
    );
  }

  Widget quickFilter() {
    List isSelected = [
      controller.selectedQuickFilters.contains("Near & fast").obs,
      controller.selectedQuickFilters.contains("Rating 4.5").obs,
      controller.selectedQuickFilters.contains("Pure Veg").obs,
    ];
    List labels = ["Near & fast", "Rating 4.5", "Pure Veg"];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Quick Filter",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp,fontFamily: AppFontFamily.gilroyMedium)),
        hBox(10),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            ...List.generate(3, (index) {
              return FilterChipWidget(
                label: labels[index],
                isSelect: isSelected[index],
                onSelected: (isSelected) {
                  if (isSelected) {
                    if (!controller.selectedQuickFilters.contains(labels[index])) {
                      controller.selectedQuickFilters.add(labels[index]);
                    }
                  } else {
                    controller.selectedQuickFilters.remove(labels[index]);
                  }
                },
              );
            }),
          ],
        ),
      ],
    );
  }

  Widget priceRange() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Price Range",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp,fontFamily: AppFontFamily.gilroyMedium)),
            Obx(() {
              return Text(
                  "\$${controller.lowerValue.value} - \$${controller.upperValue.value}",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: AppColors.primary,fontFamily: AppFontFamily.gilroyMedium));
            }),
          ],
        ),
        hBox(8),
        Text("Average price: \$1.200",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: AppColors.lightText,fontFamily: AppFontFamily.gilroyRegular)),
        hBox(4),
        Obx(() {
          double minPrice = controller.getFilterData.value.minPrice!.toDouble();
          double maxPrice = controller.getFilterData.value.maxPrice!.toDouble();

          double lowerValue = controller.lowerValue.value < minPrice
              ? minPrice
              : controller.lowerValue.value;
          double upperValue = controller.upperValue.value > maxPrice
              ? maxPrice
              : controller.upperValue.value;
          return FlutterSlider(
            values: [lowerValue, upperValue],
            min: minPrice,
            max: maxPrice,
            rangeSlider: true,
            handlerHeight: 24.h,
            handler: FlutterSliderHandler(
              child: SvgPicture.asset(
                "assets/svg/slider.svg",
                height: 26.h,
              ),
            ),
            rightHandler: FlutterSliderHandler(
              child: SvgPicture.asset(
                "assets/svg/slider.svg",
                height: 26.h,
              ),
            ),
            trackBar: FlutterSliderTrackBar(
              activeTrackBarHeight: 8,
              inactiveTrackBarHeight: 8,
              activeTrackBar: BoxDecoration(
                color: AppColors.primary, // Active color
                borderRadius: BorderRadius.circular(4),
              ),
              inactiveTrackBar: BoxDecoration(
                color: AppColors.lightText.withOpacity(.3), // Inactive color
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            onDragging: (handlerIndex, lowerValue, upperValue) {
              controller.lowerValue.value = lowerValue;
              controller.upperValue.value = upperValue;
            },
          );
        }),
      ],
    );
  }
}

class FilterChipWidget extends StatelessWidget {
  final String label;
  final RxBool isSelect;
  final Function(bool) onSelected;

  const FilterChipWidget({
    super.key,
    required this.label,
    required this.isSelect,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return FilterChip(
        showCheckmark: false,
        selectedColor: AppColors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide(color: AppColors.hintText),
        ),
        label: Text(
          label,
          style: TextStyle(
            fontFamily: AppFontFamily.gilroyMedium,
            fontWeight: FontWeight.w400,
            fontSize: 17.sp,
            color: isSelect.value ? AppColors.white : AppColors.darkText,
          ),
        ),
        selected: isSelect.value,
        onSelected: (isSelected) {
          isSelect.value = isSelected;
          onSelected(isSelected);
        },
      );
    });
  }
}

class TwoToneCircleSliderThumb extends SliderComponentShape {
  final Color innerColor;
  final Color outerColor;

  TwoToneCircleSliderThumb(
      {required this.innerColor, required this.outerColor});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(20, 20); // Define size of the thumb
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Paint outerPaint = Paint()..color = outerColor;
    final Paint innerPaint = Paint()..color = innerColor;
    final double radius = sizeWithOverflow.shortestSide / 2;

    context.canvas.drawCircle(center, radius, outerPaint);
    context.canvas.drawCircle(center, radius * 0.8, innerPaint);
  }
}
// Widget Cuisines() {
//   List<List<CuisineType>> columns = [];
//   for (int i = 0;
//       i < controller.getFilterData.value.cuisineType!.length;
//       i += 7) {
//     columns.add(controller.getFilterData.value.cuisineType!.sublist(
//       i,
//       (i + 7) > controller.getFilterData.value.cuisineType!.length
//           ? controller.getFilterData.value.cuisineType!.length
//           : (i + 7),
//     ));
//   }
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         "Cuisines",
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 18.sp,
//           fontFamily: 'Gilroy',
//         ),
//       ),
//       SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: columns.map((column) {
//             return Container(
//               width: 140.w,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: column.map((cuisine) {
//                   return Obx(
//                     () => Container(
//                       margin: EdgeInsets.all(5),
//                       height: 60.h,
//                       child: CheckboxListTile(
//                         title: Transform.translate(
//                           offset: Offset(-15.w, 0),
//                           child: Text(
//                             cuisine.name.toString(),
//                             style: TextStyle(
//                               fontWeight: FontWeight.w400,
//                               fontSize: 18.sp,
//                               fontFamily: 'Gilroy-Regular',
//                             ),
//                           ),
//                         ),
//                         value: cuisine.isSelected.value,
//                         onChanged: (value) {
//                           cuisine.isSelected.value = value!;
//                         },
//                         checkboxShape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5.r),
//                           side:
//                               BorderSide(width: 1, color: AppColors.darkText),
//                         ),
//                         activeColor: Colors.black,
//                         controlAffinity: ListTileControlAffinity.leading,
//                         contentPadding: EdgeInsets.zero,
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     ],
//   );
// }
