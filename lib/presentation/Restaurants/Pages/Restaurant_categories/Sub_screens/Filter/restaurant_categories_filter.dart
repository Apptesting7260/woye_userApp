import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Shared/Widgets/custom_radio_button.dart';

class RestaurantCategoriesFilter extends StatelessWidget {
  RestaurantCategoriesFilter({super.key});

  final RxMap<String, dynamic> _options = {
    "Veg": true.obs,
    "Non-veg": false.obs,
    "Jain": false.obs,
    "Healthy": false.obs,
    "Vegan": false.obs,
  }.obs;

  final RxDouble _lowerValue = 20.0.obs;

  final RxDouble _upperValue = 600.0.obs;

  RxInt priceRadioValue = 1.obs;

  RxInt sizeRadioValue = 1.obs;

  RxInt toppingsRadioValue = 1.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "Filter",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              brand(),
              hBox(30),
              price(),
              hBox(30),
              quickFilter(),
              hBox(30),
              priceRange(),
              hBox(30),
              size(),
              hBox(30),
              toppings(),
              hBox(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: CustomElevatedButton(
                          height: 55.h,
                          text: "Clear",
                          color: AppColors.black,
                          onPressed: () {
                            Get.back();
                          })),
                  wBox(10),
                  Expanded(
                      child: CustomElevatedButton(
                          height: 55.h,
                          text: "Apply",
                          onPressed: () {
                            Get.back();
                          }))
                ],
              ),
              hBox(50)
            ],
          ),
        ),
      ),
    );
  }

  Widget brand() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Brand",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                fontFamily: 'Gilroy')),
        ..._options.keys.map((String key) {
          return Obx(
            () => Transform.translate(
              offset: Offset(-10.w, 0),
              child: SizedBox(
                height: 35.h,
                child: CheckboxListTile(
                  title: Transform.translate(
                    offset: Offset(-15.w, 0),
                    child: Text(
                      key,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18.sp,
                        fontFamily: 'Gilroy-Regular',
                      ),
                    ),
                  ),
                  value: _options[key].value,
                  onChanged: (value) {
                    _options[key].value = value!;
                  },
                  checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.r),
                      side: BorderSide(width: 1, color: AppColors.darkText)),
                  activeColor: Colors.black,
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget price() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Price",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
        CustomRadioButton(
          title: "Low to high",
          value: 1.obs,
          groupValue: priceRadioValue,
          onChanged: (value) {
            priceRadioValue.value = value!;
          },
        ),
        CustomRadioButton(
          title: "High to low",
          value: 2.obs,
          groupValue: priceRadioValue,
          onChanged: (value) {
            priceRadioValue.value = value!;
          },
        ),
      ],
    );
  }

  Widget quickFilter() {
    List isSelected = [false.obs, false.obs, false.obs];
    List labels = ["Near & fast", "Rating 4.5", "Pure Veg"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Quick Filter",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
        hBox(10),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            ...List.generate(3, (index) {
              return FilterChipWidget(
                label: labels[index],
                isSelect: isSelected[index],
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
            Obx(() {
              return Text("\$${_lowerValue.value} - \$${_upperValue.value}",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: AppColors.primary));
            }),
          ],
        ),
        hBox(8),
        Text("Average price: \$1.200",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: AppColors.lightText)),
        hBox(4),
        Obx(() {
          return FlutterSlider(
            values: [_lowerValue.value, _upperValue.value],
            max: 1000,
            min: 10,
            rangeSlider: true,
            handlerHeight: 24.h,
            handler: FlutterSliderHandler(
                child: SvgPicture.asset(
              "assets/svg/slider.svg",
              height: 26.h,
            )
                //  SvgPicture.asset("assets/svg/slider.svg"),
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
              _lowerValue.value = lowerValue;
              _upperValue.value = upperValue;
            },
          );
        }),
      ],
    );
  }

  Widget size() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Size",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
        CustomRadioButton(
          title: "Small",
          value: 1.obs,
          groupValue: sizeRadioValue,
          onChanged: (value) {
            sizeRadioValue.value = value!;
          },
        ),
        CustomRadioButton(
          title: "Medium",
          value: 2.obs,
          groupValue: sizeRadioValue,
          onChanged: (value) {
            sizeRadioValue.value = value!;
          },
        ),
        CustomRadioButton(
          title: "Large",
          value: 3.obs,
          groupValue: sizeRadioValue,
          onChanged: (value) {
            sizeRadioValue.value = value!;
          },
        ),
      ],
    );
  }

  Widget toppings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Toppings",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
        CustomRadioButton(
          title: "All",
          value: 1.obs,
          groupValue: toppingsRadioValue,
          onChanged: (value) {
            toppingsRadioValue.value = value!;
          },
        ),
        CustomRadioButton(
          title: "Vegetables",
          value: 2.obs,
          groupValue: toppingsRadioValue,
          onChanged: (value) {
            toppingsRadioValue.value = value!;
          },
        ),
        CustomRadioButton(
          title: "Chicken",
          value: 3.obs,
          groupValue: toppingsRadioValue,
          onChanged: (value) {
            toppingsRadioValue.value = value!;
          },
        ),
        CustomRadioButton(
          title: "Paneer",
          value: 4.obs,
          groupValue: toppingsRadioValue,
          onChanged: (value) {
            toppingsRadioValue.value = value!;
          },
        ),
        CustomRadioButton(
          title: "Non Veg",
          value: 5.obs,
          groupValue: toppingsRadioValue,
          onChanged: (value) {
            toppingsRadioValue.value = value!;
          },
        ),
        CustomRadioButton(
          title: "Sauces And Spices",
          value: 6.obs,
          groupValue: toppingsRadioValue,
          onChanged: (value) {
            toppingsRadioValue.value = value!;
          },
        ),
        CustomRadioButton(
          title: "Others",
          value: 7.obs,
          groupValue: toppingsRadioValue,
          onChanged: (value) {
            toppingsRadioValue.value = value!;
          },
        ),
      ],
    );
  }
}

class FilterChipWidget extends StatelessWidget {
  final String label;
  final RxBool isSelect; // Declare isSelect as a field

  FilterChipWidget({
    super.key,
    required this.label,
    required this.isSelect, // Pass it as a parameter
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
            fontFamily: 'Gilroy-Regular',
            fontWeight: FontWeight.w400,
            fontSize: 18.sp,
            color: isSelect.value ? AppColors.white : AppColors.darkText,
          ),
        ),
        selected: isSelect.value, // Use isSelect's value
        onSelected: (isSelected) {
          isSelect.value = isSelected; // Update isSelect's value
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