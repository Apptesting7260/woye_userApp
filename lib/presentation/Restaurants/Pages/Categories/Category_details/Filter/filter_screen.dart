import 'package:flutter/material.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/core/Utils/sized_box.dart';

class FilterScreen extends StatefulWidget {
  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  final Map<String, bool> _options = {
    "Veg": true,
    "Non-veg": false,
    "Jain": false,
    "Healthy": false,
    "Vegan": false,
  };

  // Range values to keep track of the slider's start and end
  RangeValues _currentRangeValues = const RangeValues(500, 1000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: REdgeInsets.all(12.0),
        child: SingleChildScrollView(  // Added SingleChildScrollView for scrollable content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              hBox(20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 44.h,
                      height: 44.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade200,
                      ),
                      child: Center(
                        child: Image.asset("assets/images/back.png", scale: 4),
                      ),
                    ),
                  ),
                  Text(
                    "Filters",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  wBox(44) // Empty space to balance the layout
                ],
              ),

              hBox(20),

              // Brand section with checkboxes
              Text("Brand", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp,fontFamily: 'Gilroy')),
              ..._options.keys.map((String key) {
                return CheckboxListTile(
                  title: Text(
                    key,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18.sp,
                      fontFamily: 'Gilroy-Regular',
                    ),
                  ),
                  value: _options[key],
                  onChanged: (bool? value) {
                    setState(() {
                      _options[key] = value!;
                    });
                  },
                  checkboxShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r),
                    side: BorderSide(width: 1,color: AppColors.darkText)
                  ),
                  activeColor: Colors.black,
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                );
              }).toList(),
              SizedBox(height: 16),

              // Price section with radio buttons
              Text("Price", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              RadioListTile(
                title: Text("Low to high", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.sp,fontFamily: 'Gilroy-Regular')),
                value: 1,
                groupValue: 1,
                onChanged: (value) {},
              ),
              RadioListTile(
                title: Text("High to low", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.sp,fontFamily: 'Gilroy-Regular')),
                value: 2,
                groupValue: 1,
                onChanged: (value) {},
              ),
              hBox(16),

              // Quick Filter section with filter chips
              Text("Quick Filter", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              hBox(16),
              Wrap(
                spacing: 4,
                children: [
                  FilterChipWidget(label: "Near & Fast"),
                  FilterChipWidget(label: "Rating 4.5"),
                  FilterChipWidget(label: "Pure Veg"),
                ],
              ),
              hBox(16),

              // Price Range with slider
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Price Range", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
                  Text("\&500 - \$1000", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp,color: AppColors.primary)),
                ],
              ),
              hBox(6),
              Text("Average price: \$1.200", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.sp,color: AppColors.lightText)),
              hBox(6),
              // RangeSlider widget
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbColor: AppColors.primary,
                  trackHeight: 4,
                  inactiveTrackColor: Colors.grey.shade300, // Inactive track color
                ),
                child: RangeSlider(
                  values: _currentRangeValues,
                  min: 500,
                  max: 1000,
                  divisions: 100,
                  labels: RangeLabels(
                    _currentRangeValues.start.round().toString(),
                    _currentRangeValues.end.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _currentRangeValues = values;
                    });
                    },
                ),
              ),
              hBox(16),

              // Size section with radio buttons
              Text("Size", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              RadioListTile(
                title: Text("Small", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.sp,fontFamily: 'Gilroy-Regular')),
                value: 1,
                groupValue: 1,
                onChanged: (value) {},
              ),
              RadioListTile(
                title: Text("Medium", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.sp,fontFamily: 'Gilroy-Regular')),
                value: 2,
                groupValue: 1,
                onChanged: (value) {},
              ),
              RadioListTile(
                title: Text("Large", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.sp,fontFamily: 'Gilroy-Regular')),
                value: 3,
                groupValue: 1,
                onChanged: (value) {},
              ),
              SizedBox(height: 16),

              // Toppings section with radio buttons
              Text("Toppings", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              RadioListTile(
                title: Text("All", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.sp,fontFamily: 'Gilroy-Regular')),
                value: 1,
                groupValue: 1,
                onChanged: (value) {},
              ),
              RadioListTile(
                title: Text("Vegetables", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.sp,fontFamily: 'Gilroy-Regular')),
                value: 2,
                groupValue: 1,
                onChanged: (value) {},
              ),
              RadioListTile(
                title: Text("Chicken", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.sp,fontFamily: 'Gilroy-Regular')),
                value: 3,
                groupValue: 1,
                onChanged: (value) {},
              ),
              RadioListTile(
                title: Text("Paneer", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.sp,fontFamily: 'Gilroy-Regular')),
                value: 4,
                groupValue: 1,
                onChanged: (value) {},
              ),
              RadioListTile(
                title: Text("Non Veg", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.sp,fontFamily: 'Gilroy-Regular')),
                value: 5,
                groupValue: 1,
                onChanged: (value) {},
              ),
              RadioListTile(
                title: Text("Sauces And Spices", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.sp,fontFamily: 'Gilroy-Regular')),
                value: 6,
                groupValue: 1,
                onChanged: (value) {},
              ),
              RadioListTile(
                title: Text("Others", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.sp,fontFamily: 'Gilroy-Regular')),
                value: 7,
                groupValue: 1,
                onChanged: (value) {},
              ),

              // Empty space to allow scrollability
              SizedBox(height: 20),

              // Clear and Apply buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                        height: 60.h,
                        width: 184.w,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(100)
                        ),
                        child: Center(
                            child: Text(
                                "Clear",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp,
                                    fontFamily: 'Gilroy-Regular'
                                )
                            )
                        )
                    ),
                  ),
                  wBox(10),
                  Expanded(
                    child: Container(
                        height: 60.h,
                        width: 184.w,
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: Center(
                            child: Text(
                                "Apply",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp,
                                    fontFamily: 'Gilroy-Regular'
                                )
                            )
                        )
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterChipWidget extends StatelessWidget {
  final String label;

  const FilterChipWidget({required this.label});

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
        side: BorderSide(color: AppColors.hintText)
      ),
      label: Text(
        label,
        style: TextStyle(
            fontFamily: 'Gilroy-Regular',
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: AppColors.darkText
        ),
      ),
      selected: false,
      onSelected: (isSelected) {},
    );
  }
}

class TwoToneCircleSliderThumb extends SliderComponentShape {
  final Color innerColor;
  final Color outerColor;

  TwoToneCircleSliderThumb({required this.innerColor, required this.outerColor});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(20, 20); // Define size of the thumb
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

