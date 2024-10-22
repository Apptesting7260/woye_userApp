

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: REdgeInsets.all(16.0),
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
              SizedBox(height: 16),

              // Quick Filter section with filter chips
              Text("Quick Filter", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Wrap(
                spacing: 8,
                children: [
                  FilterChipWidget(label: "Near & Fast"),
                  FilterChipWidget(label: "Rating 4.5"),
                  FilterChipWidget(label: "Pure Veg"),
                ],
              ),
              SizedBox(height: 16),

              // Price Range with slider
              Text("Price Range", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("\$500"),
                  Text("\$1000"),
                ],
              ),
              Slider(
                value: 700,
                min: 500,
                max: 1000,
                onChanged: (value) {},
              ),
              SizedBox(height: 16),

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
      label: Text(label),
      selected: false,
      onSelected: (isSelected) {},
    );
  }
}
