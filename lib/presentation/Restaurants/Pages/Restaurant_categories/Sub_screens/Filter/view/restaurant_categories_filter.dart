/*
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
                            AppFontStyle.text_18_600(AppColors.darkText,family: AppFontFamily.onestRegular),
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
                        fontFamily: AppFontFamily.onestMedium,
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
                      fontFamily: AppFontFamily.onestMedium,
                        height: 55.h,
                        text: "Apply",
                        onPressed: () {
                          Get.back();
                          controller.priceRadioValue.value = 0;
                          final selectedQuickFilter = controller.selectedQuickFilters.toString();
                          restaurantCategoriesDetailsController.restaurant_Categories_Details_filter_Api(
                            id: categoryId.toString(),
                            cuisine_type: controller.selectedCuisines.join(', '),
                            // price_sort: controller.priceRadioValue.value == 0
                            //     ? ""
                            //     : controller.priceRadioValue.value == 1
                            //         ? "low to high"
                            //         : "high to low",
                            quick_filter:selectedQuickFilter != [].toString() ? selectedQuickFilter : "" ,
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
                      fontFamily: AppFontFamily.onestMedium,
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
                      fontFamily: AppFontFamily.onestMedium,
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
            fontFamily: AppFontFamily.onestMedium,
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
                                    fontFamily:AppFontFamily.onestMedium,
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
                        fontFamily: AppFontFamily.onestMedium,
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
                        fontFamily: AppFontFamily.onestMedium,
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp,fontFamily: AppFontFamily.onestMedium)),
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp,fontFamily: AppFontFamily.onestMedium)),
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp,fontFamily: AppFontFamily.onestMedium)),
            Obx(() {
              return Text(
                  "\$${controller.lowerValue.value} - \$${controller.upperValue.value}",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: AppColors.primary,fontFamily: AppFontFamily.onestMedium));
            }),
          ],
        ),
        hBox(8),
        Text("Average price: \$1.200",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: AppColors.lightText,fontFamily: AppFontFamily.onestRegular)),
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
            fontFamily: AppFontFamily.onestMedium,
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
*/




/////////////////////////


/*import 'package:woye_user/Core/Utils/app_export.dart';
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
                    controller.Refresh_Api(categoryId);
                  },
                );
              } else {
                return GeneralExceptionWidget(
                  onPress: () {
                    controller.Refresh_Api(categoryId);
                  },
                );
              }
            case Status.COMPLETED:
              return RefreshIndicator(
                onRefresh: () async {
                  controller.Refresh_Api(categoryId);
                },
                child: Column(
                  children: [
                    appbar(),
                    Padding(
                      padding: REdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        children: [
                          filterWidget(categoryId),
                        ],
                      ),
                      *//*child: TabBar(
                        labelPadding: EdgeInsets.zero,
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: AppColors.gray,
                        dividerHeight: 0.5,
                        labelStyle:
                        AppFontStyle.text_18_600(AppColors.darkText,family: AppFontFamily.onestRegular),
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
                      ),*//*
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
            if (controller.getFilterData.value.cuisineId?.isNotEmpty ?? false)
              Cuisines(),
            if (controller.getFilterData.value.cuisineId?.isNotEmpty ?? false)
              hBox(20.h),
            price(),
            hBox(30),
            quickFilter(),
            hBox(30),
            priceRange(),
            hBox(30),
            _buildSectionTitle("Food Preferences"),
            hBox(10.h),
            _buildCheckboxListSection([
              'Vegetarian',
              'Vegan',
              'Gluten Free',
              'Nut Free',
              'Dairy Free',
              'Halal',
              'Spicy',
              'Extra Spicy',
              'Low Salt',
              'Organic'
            ]),
            hBox(20.h),

            // Add-ons Section
            _buildSectionTitle("Add-ons"),
            hBox(10.h),
            _buildCheckboxListSection([
              'Show items with add-ons only'
            ]),
            hBox(20.h),

            // Options Section
            _buildSectionTitle("Options"),
            hBox(10.h),
            _buildCheckboxListSection([
              'Has size options',
              'Extra toppings available',
              'Customizable items'
            ]),
            hBox(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: CustomElevatedButton(
                        fontFamily: AppFontFamily.onestMedium,
                        height: 55.h,
                        text: "Clear",
                        color: AppColors.black,
                        onPressed: () {
                          controller.selectedCuisines.clear();
                          controller.selectedQuickFilters.clear();
                          // controller.priceRadioValue.value = 0;
                          controller.lowerValue.value = controller.getFilterData.value.minPrice!.toDouble();
                          controller.upperValue.value = controller.getFilterData.value.maxPrice!.toDouble();
                          for (var cuisine in controller.getFilterData.value.cuisineId!) {
                            cuisine.isSelected.value = false;
                          }
                        })),
                wBox(10),
                Expanded(
                    child: CustomElevatedButton(
                        fontFamily: AppFontFamily.onestMedium,
                        height: 55.h,
                        text: "Apply",
                        onPressed: () {
                          Get.back();
                          controller.priceRadioValue.value = 0;
                          final selectedQuickFilter = controller.selectedQuickFilters.toString();
                          restaurantCategoriesDetailsController.restaurant_Categories_Details_filter_Api(
                            id: categoryId.toString(),
                            cuisine_type: controller.selectedCuisines.join(', '),
                            // price_sort: controller.priceRadioValue.value == 0
                            //     ? ""
                            //     : controller.priceRadioValue.value == 1
                            //         ? "low to high"
                            //         : "high to low",
                            quick_filter:selectedQuickFilter != [].toString() ? selectedQuickFilter : "" ,
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppFontStyle.text_18_600(AppColors.darkText,
          family: AppFontFamily.onestRegular),
    );
  }

  Widget _buildCheckboxListSection(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return _buildCheckboxItem(item);
      }).toList(),
    );
  }

  Widget _buildCheckboxItem(String label) {
    return Padding(
      padding: REdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          SizedBox(
            width: 24.w,
            height: 24.h,
            child: Checkbox(
              value: false, // Set your state management value here
              onChanged: (value) {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
              side: BorderSide(
                color: Colors.grey[400]!,
                width: 1.5,
              ),
              activeColor: AppColors.primary,
            ),
          ),
          wBox(12.w),
          Expanded(
            child: Text(
              label,
              style: AppFontStyle.text_16_400(AppColors.darkText,
                  family: AppFontFamily.onestRegular),
            ),
          ),
        ],
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
                      fontFamily: AppFontFamily.onestMedium,
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
                      fontFamily: AppFontFamily.onestMedium,
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
                        in controller.getFilterData.value.cuisineId!) {
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
            fontFamily: AppFontFamily.onestMedium,
          ),
        ),
        Obx(() {
          List<CuisineId> cuisineTypes =controller.getFilterData.value.cuisineId ?? [];
          List<List<CuisineId>> columns = [];
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
                                    fontFamily:AppFontFamily.onestMedium,
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
          if (controller.getFilterData.value.cuisineId!.length > 20) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (visibleItemCount.value <
                    controller.getFilterData.value.cuisineId!.length)
                  TextButton(
                    onPressed: () {
                      visibleItemCount.value += 10;
                    },
                    child: Text(
                      "See More",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFontFamily.onestMedium,
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
                          controller.getFilterData.value.cuisineId
                              ?.length ??
                              20);
                    },
                    child: Text(
                      "Show Less",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFontFamily.onestMedium,
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp,fontFamily: AppFontFamily.onestMedium)),
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp,fontFamily: AppFontFamily.onestMedium)),
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp,fontFamily: AppFontFamily.onestMedium)),
            Obx(() {
              return Text(
                  "\$${controller.lowerValue.value} - \$${controller.upperValue.value}",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: AppColors.primary,fontFamily: AppFontFamily.onestMedium));
            }),
          ],
        ),
        hBox(8),
        Text("Average price: \$1.200",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: AppColors.lightText,fontFamily: AppFontFamily.onestRegular)),
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
            fontFamily: AppFontFamily.onestMedium,
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
// }*/


import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Categories_details/controller/RestaurantCategoriesDetailsController.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/Shared/Widgets/custom_radio_button.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Filter/controller/CategoriesFilter_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Filter/modal/CategoriesFilter_modal.dart';

import '../../../../../../../Shared/theme/font_family.dart';

final Categories_FilterController controller = Get.put(Categories_FilterController());
final RestaurantCategoriesDetailsController restaurantCategoriesDetailsController = Get.put(RestaurantCategoriesDetailsController());

class RestaurantCategoriesFilter extends StatelessWidget {
  const RestaurantCategoriesFilter({super.key});

  @override
  Widget build(BuildContext context) {
    var categoryId = Get.arguments['categoryId'] ?? "";

    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Filter",
          style: AppFontStyle.text_23_600(AppColors.darkText,family: AppFontFamily.onestRegular),
        ),
      ),
      body: Obx(() {
        switch (controller.rxRequestStatus.value) {
          case Status.LOADING:
            return Center(child: circularProgressIndicator());
          case Status.ERROR:
            if (controller.error.value == 'No internet' || controller.error.value == "InternetExceptionWidget") {
              return InternetExceptionWidget(
                onPress: () {
                  controller.Refresh_Api(categoryId);
                },
              );
            } else {
              return GeneralExceptionWidget(
                onPress: () {
                  controller.Refresh_Api(categoryId);
                },
              );
            }
          case Status.COMPLETED:
            return _buildFilterScreen(categoryId);
        }
      }),
    );
  }

  Widget _buildFilterScreen(String categoryId) {
    return Column(
      children: [
        // Main Content - Use Expanded to take available space
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              controller.Refresh_Api(categoryId);
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cuisines Section
                    if (controller.getFilterData.value.cuisineId?.isNotEmpty ?? false)
                      _buildCuisinesSection(),

                    if (controller.getFilterData.value.cuisineId?.isNotEmpty ?? false)
                      hBox(20.h),

                    // Price Sort Section
                    _buildPriceSortSection(),
                    hBox(20.h),

                    // Quick Filter Section
                    _buildQuickFilterSection(),
                    hBox(20.h),

                    // Price Range Section
                    _buildPriceRangeSection(),
                    hBox(20.h),

                    // Food Preferences Section
                    _buildFoodPreferencesSection(),
                    hBox(20.h),

                    // Add-ons Section
                    _buildAddonsSection(),
                    hBox(20.h),

                    // Options Section
                    _buildOptionsSection(),
                    hBox(30.h),

                    // Apply/Clear Buttons
                    _buildActionButtons(categoryId),
                    hBox(20.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCuisinesSection() {
    Rx<int> visibleItemCount = 20.obs;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cuisines",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            fontFamily: AppFontFamily.onestMedium,
          ),
        ),
        hBox(10.h),
        Obx(() {
          List<CuisineId> cuisineTypes = controller.getFilterData.value.cuisineId ?? [];
          int itemCount = visibleItemCount.value < cuisineTypes.length
              ? visibleItemCount.value
              : cuisineTypes.length;

          // Take only visible items
          List<CuisineId> visibleItems = cuisineTypes.sublist(0, itemCount);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: visibleItems.map((cuisine) {
              return Padding(
                padding: REdgeInsets.only(bottom: 12.h),
                child: Row(
                  children: [
                    SizedBox(
                      width: 24.w,
                      height: 24.h,
                      child: Obx(() => Checkbox(
                        value: cuisine.isSelected.value,
                        onChanged: (value) {
                          cuisine.isSelected.value = value!;
                          if (value) {
                            controller.selectedCuisines.add(cuisine.id.toString());
                          } else {
                            controller.selectedCuisines.remove(cuisine.id.toString());
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        side: BorderSide(
                          color: Colors.grey[400]!,
                          width: 1.5,
                        ),
                        activeColor: AppColors.black,
                      )),
                    ),
                    wBox(12.w),
                    Expanded(
                      child: Text(
                        cuisine.name ?? "",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFontFamily.onestRegular,
                          color: AppColors.darkText,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        }),

        // See More/Show Less Buttons
        if ((controller.getFilterData.value.cuisineId?.length ?? 0) > 20)
          Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (visibleItemCount.value < (controller.getFilterData.value.cuisineId?.length ?? 0))
                TextButton(
                  onPressed: () {
                    visibleItemCount.value += 10;
                  },
                  child: Text(
                    "See More",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppFontFamily.onestMedium,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              if (visibleItemCount.value > 20)
                TextButton(
                  onPressed: () {
                    visibleItemCount.value = (visibleItemCount.value - 10).clamp(
                      20,
                      controller.getFilterData.value.cuisineId?.length ?? 20,
                    );
                  },
                  child: Text(
                    "Show Less",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppFontFamily.onestMedium,
                      color: AppColors.primary,
                    ),
                  ),
                ),
            ],
          )),
      ],
    );
  }

  Widget _buildPriceSortSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sort by Price",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            fontFamily: AppFontFamily.onestMedium,
          ),
        ),
        hBox(10.h),
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

  Widget _buildQuickFilterSection() {
    List isSelected = [
      controller.selectedQuickFilters.contains("Near & fast").obs,
      controller.selectedQuickFilters.contains("Rating 4.5").obs,
      controller.selectedQuickFilters.contains("Pure Veg").obs,
    ];
    List labels = ["Near & fast", "Rating 4.5", "Pure Veg"];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Filter",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            fontFamily: AppFontFamily.onestMedium,
          ),
        ),
        hBox(10.h),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: List.generate(3, (index) {
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
        ),
      ],
    );
  }

  Widget _buildPriceRangeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Price Range",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                fontFamily: AppFontFamily.onestMedium,
              ),
            ),
            Obx(() {
              return Text(
                "\$${controller.lowerValue.value.toStringAsFixed(0)} - \$${controller.upperValue.value.toStringAsFixed(0)}",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  color: AppColors.primary,
                  fontFamily: AppFontFamily.onestMedium,
                ),
              );
            }),
          ],
        ),
        hBox(8.h),
        Text(
          "Average price: \$1.200",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: AppColors.lightText,
            fontFamily: AppFontFamily.onestRegular,
          ),
        ),
        hBox(10.h),
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
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(4),
              ),
              inactiveTrackBar: BoxDecoration(
                color: AppColors.lightText.withOpacity(.3),
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

  Widget _buildFoodPreferencesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Food Preferences",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            fontFamily: AppFontFamily.onestMedium,
          ),
        ),
        hBox(10.h),
        ...(controller.getFilterData.value.attributeIds ?? []).map((attribute) =>
            _buildCheckboxItem(
              label: attribute.name.toString(),
              isSelected: attribute.isSelected.value,
              onChanged: (value) {
                attribute.isSelected.value = value!;
                if (value) {
                  controller.selectedAttributes.add(attribute.id.toString());
                } else {
                  controller.selectedAttributes.remove(attribute.id.toString());
                }
              },
            )
        ).toList(),
      ],
    );
  }

  Widget _buildAddonsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Add-ons",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            fontFamily: AppFontFamily.onestMedium,
          ),
        ),
        hBox(10.h),
        ...(controller.getFilterData.value.addons ?? []).map((addon) =>
            _buildCheckboxItem(
              label: addon.name.toString(),
              isSelected: addon.isSelected.value,
              onChanged: (value) {
                addon.isSelected.value = value!;
                if (value) {
                  controller.selectedAddons.add(addon.id.toString());
                } else {
                  controller.selectedAddons.remove(addon.id.toString());
                }
              },
            )
        ).toList(),
      ],
    );
  }

  Widget _buildOptionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Options",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            fontFamily: AppFontFamily.onestMedium,
          ),
        ),
        hBox(10.h),
        ...(controller.getFilterData.value.options ?? []).map((options) =>
            _buildCheckboxItem(
              label: options.name.toString(),
              isSelected: options.isSelected.value,
              onChanged: (value) {
                options.isSelected.value = value!;
                if (value) {
                  controller.selectedOptions.add(options.id.toString());
                } else {
                  controller.selectedOptions.remove(options.id.toString());
                }
              },
            )
        ).toList(),
      ],
    );
  }

  Widget _buildCheckboxItem({
    required String label,
    required bool isSelected,
    required Function(bool?) onChanged,
  }) {
    return Padding(
      padding: REdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          SizedBox(
            width: 24.w,
            height: 24.h,
            child: Checkbox(
              value: isSelected,
              onChanged: onChanged,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
              side: BorderSide(
                color: Colors.grey[400]!,
                width: 1.5,
              ),
              activeColor: AppColors.black,
            ),
          ),
          wBox(12.w),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                fontFamily: AppFontFamily.onestRegular,
                color: AppColors.darkText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(String categoryId) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomElevatedButton(
            fontFamily: AppFontFamily.onestMedium,
            height: 55.h,
            text: "Clear",
            color: AppColors.black,
            onPressed: () {
              controller.selectedCuisines.clear();
              controller.selectedQuickFilters.clear();
              controller.selectedOptions.clear();
              controller.selectedAddons.clear();
              controller.selectedAttributes.clear();
              controller.priceRadioValue.value = 0;
              if (controller.getFilterData.value.minPrice != null) {
                controller.lowerValue.value = controller.getFilterData.value.minPrice!.toDouble();
              }
              if (controller.getFilterData.value.maxPrice != null) {
                controller.upperValue.value = controller.getFilterData.value.maxPrice!.toDouble();
              }
              if (controller.getFilterData.value.cuisineId != null) {
                for (var cuisine in controller.getFilterData.value.cuisineId!) {
                  cuisine.isSelected.value = false;
                }
              }
            },
          ),
        ),
        wBox(10.w),
        Expanded(
          child: CustomElevatedButton(
            fontFamily: AppFontFamily.onestMedium,
            height: 55.h,
            text: "Apply",
            color: AppColors.primary,
            onPressed: () {
              Get.back();
              controller.priceRadioValue.value = 0;
              final selectedQuickFilter = controller.selectedQuickFilters.toString();
              restaurantCategoriesDetailsController.restaurant_Categories_Details_filter_Api(
                id: categoryId.toString(),
                cuisine_type: controller.selectedCuisines.join(', '),
                quick_filter: selectedQuickFilter != [].toString() ? selectedQuickFilter : "",
                price_range: "${controller.lowerValue.value},${controller.upperValue.value}",
                attribute_ids: controller.selectedAttributes.join(', '),
                addons: controller.selectedAddons.join(', '),
                options: controller.selectedOptions.join(', '),
              );
            },
          ),
        ),
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
            fontFamily: AppFontFamily.onestMedium,
            fontWeight: FontWeight.w400,
            fontSize: 15.sp,
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