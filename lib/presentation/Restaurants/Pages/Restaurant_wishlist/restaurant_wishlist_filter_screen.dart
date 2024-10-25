import 'package:woye_user/Core/Utils/app_export.dart';

class RestaurantWishlistFilter extends StatefulWidget {
  const RestaurantWishlistFilter({super.key});

  @override
  State<RestaurantWishlistFilter> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<RestaurantWishlistFilter> {
  final Map<String, bool> _options = {
    "Personal Care": true,
    "Skin Care": false,
    "Digestive Care": false,
    "Fever Care": false,
    "Heart Care": false,
  };

  // Range values to keep track of the slider's start and end
  RangeValues _currentRangeValues = const RangeValues(500, 1000);

  int _selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: REdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Added SingleChildScrollView for scrollable content
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
              Text("Categories",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      fontFamily: 'Gilroy')),
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
                      side: BorderSide(width: 1, color: AppColors.darkText)),
                  activeColor: Colors.black,
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                );
              }).toList(),
              SizedBox(height: 16),

              // Price section with radio buttons
              Text("Price",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22.sp,
                      fontFamily: 'Gilroy')),
              CustomRadioCircle(
                title: "Low to high",
                value: 1,
                groupValue: _selectedValue,
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value!;
                  });
                },
              ),
              CustomRadioCircle(
                title: "High to low",
                value: 2,
                groupValue: _selectedValue,
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value!;
                  });
                },
              ),
              SizedBox(height: 16),

              // Quick Filter section with filter chips
              Text("Sort by",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Wrap(
                spacing: 8,
                children: [
                  FilterChipWidget(label: "Newest"),
                  FilterChipWidget(label: "Best sale"),
                  FilterChipWidget(label: "Popular"),
                ],
              ),
              hBox(16),

              // Price Range with slider
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Price Range",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.sp)),
                  Text("\&500 - \$1000",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: AppColors.primary)),
                ],
              ),
              hBox(6),
              Text("Average price: \$1.200",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18.sp,
                      color: AppColors.lightText)),
              hBox(6),
              // RangeSlider widget
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbColor: AppColors.primary,
                  trackHeight: 4,
                  inactiveTrackColor:
                      Colors.grey.shade300, // Inactive track color
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
                            borderRadius: BorderRadius.circular(100)),
                        child: Center(
                            child: Text("Clear",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp,
                                    fontFamily: 'Gilroy-Regular')))),
                  ),
                  wBox(10),
                  Expanded(
                    child: Container(
                        height: 60.h,
                        width: 184.w,
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(100)),
                        child: Center(
                            child: Text("Apply",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp,
                                    fontFamily: 'Gilroy-Regular')))),
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
      label: Text(label),
      selected: false,
      onSelected: (isSelected) {},
    );
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
