import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:woye_user/Core/Utils/app_export.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final Map<String, bool> options = {
    "Veg": true,
    "Non-veg": false,
    "Jain": false,
    "Healthy": false,
    "Vegan": false,
  };

  final Map<String, bool> price = {
    "Veg": true,
    "Non-veg": false,
  };

  final Map<String, bool> size = {
    "Veg": true,
    "Non-veg": false,
  };

  final Map<String, bool> tops = {
    "Veg": true,
    "Non-veg": false,
  };

  double _lowerValue = 500;
  double _upperValue = 1000;
  int groupValue = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
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
                  wBox(44),
                ],
              ),
              hBox(20),

              // Brand section with ListView.builder
              Text("Brand", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
              Container(
                height: 150.h, // Adjust height based on content
                child: ListView.separated(
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    String key = options.keys.elementAt(index);
                    bool isSelected = options[key] ?? false;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          options[key] = !isSelected; // Toggle selection state
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 20.h,
                            width: 20.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: isSelected ? Colors.black : Colors.white,
                              border: Border.all(
                                width: 1.w,
                              ),
                            ),
                            child: Icon(
                              Icons.check,
                              color: isSelected ? Colors.white : Colors.white,
                              size: 16.h,
                            ),
                          ),
                          wBox(10),
                          Text(
                            'title',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              fontFamily: 'Gilroy-Regular',
                            ),
                          ),
                        ],
                      ),
                    );
                  }, separatorBuilder: (BuildContext context, int index) {
                    return hBox(5);
                },
                ),
              ),


              hBox(25),

              // Price section with radio buttons
              Text("Price", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
              Container(
                height: 150.h, // Adjust height based on content
                child: ListView.separated(
                  itemCount: price.length,
                  itemBuilder: (context, index) {
                    String key = price.keys.elementAt(index);
                    bool isPrice = price[key] ?? false;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          price[key] = !isPrice; // Toggle selection state
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 20.h,
                            width: 20.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isPrice ? Colors.black : Colors.white,
                              border: Border.all(
                                width: 1.w,
                              ),
                            ),
                            child: Icon(
                              Icons.check,
                              color: isPrice ? Colors.white : Colors.white,
                              size: 16.h,
                            ),
                          ),
                          wBox(10),
                          Text(
                            'title',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              fontFamily: 'Gilroy-Regular',
                            ),
                          ),
                        ],
                      ),
                    );
                  }, separatorBuilder: (BuildContext context, int index) {
                  return hBox(5);
                },
                ),
              ),

              hBox(25),

              Text("Quick Filter", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
              hBox(10),
              Container(
                height: 150.h,
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2.5,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 43.h,
                      child: Center(child: Text('Near and Fast')),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.darkText,width: 1),
                        borderRadius: BorderRadius.circular(100.r)
                      ),
                    );
                  },
                ),
              ),

              hBox(15),
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
              FlutterSlider(
                values: [_lowerValue, _upperValue],
                max: 1000,
                min: 100,
                rangeSlider: true,
                handlerHeight: 24,
                handler: FlutterSliderHandler(
                  child: Image.asset("assets/images/slider-image.png"),
                ),
                rightHandler: FlutterSliderHandler(
                  child: Image.asset("assets/images/slider-image.png"),
                ),
                trackBar: FlutterSliderTrackBar(
                  activeTrackBarHeight: 8,
                  inactiveTrackBarHeight: 8,
                  activeTrackBar: BoxDecoration(
                    color: AppColors.primary, // Active color
                    borderRadius: BorderRadius.circular(4),
                  ),
                  inactiveTrackBar: BoxDecoration(
                    color: AppColors.lightText.withOpacity(.3)  , // Inactive color
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onDragging: (handlerIndex, lowerValue, upperValue) {
                  setState(() {
                    _lowerValue = lowerValue;
                    _upperValue = upperValue;
                  });
                },
              ),
              hBox(16),


              hBox(25),

              Text("Size", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
              Container(
                height: 150.h, // Adjust height based on content
                child: ListView.separated(
                  itemCount: size.length,
                  itemBuilder: (context, index) {
                    String key = size.keys.elementAt(index);
                    bool isSize = size[key] ?? false;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          size[key] = !isSize; // Toggle selection state
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 20.h,
                            width: 20.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSize ? Colors.black : Colors.white,
                              border: Border.all(
                                width: 1.w,
                              ),
                            ),
                            child: Icon(
                              Icons.check,
                              color: isSize ? Colors.white : Colors.white,
                              size: 16.h,
                            ),
                          ),
                          wBox(10),
                          Text(
                            'title',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              fontFamily: 'Gilroy-Regular',
                            ),
                          ),
                        ],
                      ),
                    );
                  }, separatorBuilder: (BuildContext context, int index) {
                  return hBox(5);
                },
                ),
              ),

              hBox(25),

              Text("Toppings", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
              Container(
                height: 150.h, // Adjust height based on content
                child: ListView.separated(
                  itemCount: tops.length,
                  itemBuilder: (context, index) {
                    String key = tops.keys.elementAt(index);
                    bool isTop = tops[key] ?? false;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          tops[key] = !isTop; // Toggle selection state
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 20.h,
                            width: 20.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isTop ? Colors.black : Colors.white,
                              border: Border.all(
                                width: 1.w,
                              ),
                            ),
                            child: Icon(
                              Icons.check,
                              color: isTop ? Colors.white : Colors.white,
                              size: 16.h,
                            ),
                          ),
                          wBox(10),
                          Text(
                            'title',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              fontFamily: 'Gilroy-Regular',
                            ),
                          ),
                        ],
                      ),
                    );
                  }, separatorBuilder: (BuildContext context, int index) {
                  return hBox(5);
                },
                ),
              ),

              hBox(25),

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
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Center(
                        child: Text(
                          "Clear",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                            fontFamily: 'Gilroy-Regular',
                          ),
                        ),
                      ),
                    ),
                  ),
                  wBox(10),
                  Expanded(
                    child: Container(
                      height: 60.h,
                      width: 184.w,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Center(
                        child: Text(
                          "Apply",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                            fontFamily: 'Gilroy-Regular',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              hBox(50),
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

class CustomRadioCircle extends StatelessWidget {
  final String title;
  final int value;
  final int groupValue;
  final ValueChanged<int?> onChanged;

  CustomRadioCircle({
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = value == groupValue;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: Row(
        children: [
          Container(
            height: 20.h,
            width: 20.h,
            margin: EdgeInsets.symmetric(vertical: 8.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 1.w,
              ),
            ),
          ),
          wBox(10),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
              fontFamily: 'Gilroy-Regular',
            ),
          ),
        ],
      ),
    );
  }
}



