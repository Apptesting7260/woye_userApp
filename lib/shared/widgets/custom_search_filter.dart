import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchBarWithFilter extends StatelessWidget {
  final String hintText;
  final VoidCallback onFilterTap;

  const SearchBarWithFilter({
    Key? key,
    this.hintText = "Search",
    required this.onFilterTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Opacity(
            opacity: .3,
            child: Container(
              height: 60.h,
              child: TextField(
                decoration: InputDecoration(
                  hintText: hintText,
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: BorderSide(width: 1.w, color: Colors.grey), // Replace AppColors.hintText with a color
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8.h), // Use SizedBox instead of wBox
        Opacity(
          opacity: .3,
          child: InkWell(
            onTap: onFilterTap,
            child: Container(
              width: 60.h,
              height: 60.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(width: 1.w, color: Colors.grey), // Replace AppColors.hintText with a color
              ),
              child: Center(
                child: Image.asset("assets/images/filter.png", scale: 4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
