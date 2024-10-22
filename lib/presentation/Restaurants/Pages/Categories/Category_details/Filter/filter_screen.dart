import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woye_user/Core/Utils/sized_box.dart';

class FilterScreen extends StatefulWidget {
  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: REdgeInsets.all(16.0),
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
            Text("Brand", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
            CheckboxListTile(
              title: Text("Veg"),
              value: true,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: Text("Non-veg"),
              value: false,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: Text("Jain"),
              value: false,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: Text("Healthy"),
              value: false,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: Text("Vegan"),
              value: false,
              onChanged: (value) {},
            ),
            SizedBox(height: 16),

            // Price section with radio buttons
            Text("Price", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            RadioListTile(
              title: Text("Low to high"),
              value: 1,
              groupValue: 1,
              onChanged: (value) {},
            ),
            RadioListTile(
              title: Text("High to low"),
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
              title: Text("Small"),
              value: 1,
              groupValue: 1,
              onChanged: (value) {},
            ),
            RadioListTile(
              title: Text("Medium"),
              value: 2,
              groupValue: 1,
              onChanged: (value) {},
            ),
            RadioListTile(
              title: Text("Large"),
              value: 3,
              groupValue: 1,
              onChanged: (value) {},
            ),
            SizedBox(height: 16),

            // Toppings section with radio buttons
            Text("Toppings", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            RadioListTile(
              title: Text("All"),
              value: 1,
              groupValue: 1,
              onChanged: (value) {},
            ),
            RadioListTile(
              title: Text("Vegetables"),
              value: 2,
              groupValue: 1,
              onChanged: (value) {},
            ),
            RadioListTile(
              title: Text("Chicken"),
              value: 3,
              groupValue: 1,
              onChanged: (value) {},
            ),
            RadioListTile(
              title: Text("Paneer"),
              value: 4,
              groupValue: 1,
              onChanged: (value) {},
            ),
            RadioListTile(
              title: Text("Non Veg"),
              value: 5,
              groupValue: 1,
              onChanged: (value) {},
            ),
            RadioListTile(
              title: Text("Sauces And Spices"),
              value: 6,
              groupValue: 1,
              onChanged: (value) {},
            ),
            RadioListTile(
              title: Text("Others"),
              value: 7,
              groupValue: 1,
              onChanged: (value) {},
            ),
            Spacer(),

            // Clear and Apply buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Clear filters
                  },
                  child: Text("Clear"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Apply filters
                    Navigator.pop(context);
                  },
                  child: Text("Apply"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
              ],
            ),
          ],
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
