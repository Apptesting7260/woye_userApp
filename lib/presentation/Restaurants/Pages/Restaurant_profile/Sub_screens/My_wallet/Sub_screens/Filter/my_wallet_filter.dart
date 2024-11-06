import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Shared/Widgets/custom_radio_button.dart';

class MyWalletFilter extends StatelessWidget {
  const MyWalletFilter({super.key});

  static RxInt typeRadioValue = 0.obs;

  static RxInt dateRangeRadioValue = 3.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "Filters",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hBox(30),
              type(),
              hBox(30),
              dateRange(),
              hBox(20),
              buttons(),
              hBox(50)
            ],
          ),
        ),
      ),
    );
  }

  Widget type() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Type",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
        CustomRadioButton(
          title: "Orders",
          value: 1.obs,
          groupValue: typeRadioValue,
          onChanged: (value) {
            typeRadioValue.value = value!;
          },
        ),
        CustomRadioButton(
          title: "Refund",
          value: 2.obs,
          groupValue: typeRadioValue,
          onChanged: (value) {
            typeRadioValue.value = value!;
          },
        ),
      ],
    );
  }

  Widget dateRange() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Date Range",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
        CustomRadioButton(
          title: "Last 10 transactions",
          value: 1.obs,
          groupValue: dateRangeRadioValue,
          onChanged: (value) {
            dateRangeRadioValue.value = value!;
          },
        ),
        CustomRadioButton(
          title: "View last week",
          value: 2.obs,
          groupValue: dateRangeRadioValue,
          onChanged: (value) {
            dateRangeRadioValue.value = value!;
          },
        ),
        CustomRadioButton(
          title: "View last month",
          value: 3.obs,
          groupValue: dateRangeRadioValue,
          onChanged: (value) {
            dateRangeRadioValue.value = value!;
          },
        ),
        CustomRadioButton(
          title: "All",
          value: 4.obs,
          groupValue: dateRangeRadioValue,
          onChanged: (value) {
            dateRangeRadioValue.value = value!;
          },
        ),
      ],
    );
  }

  Widget buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
            child: CustomElevatedButton(
                height: 50.h,
                text: "Clear",
                color: AppColors.black,
                onPressed: () {
                  Get.back();
                })),
        wBox(10),
        Expanded(
            child: CustomElevatedButton(
                height: 50.h,
                text: "Apply",
                onPressed: () {
                  Get.back();
                }))
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
