import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar1 extends StatelessWidget {
  final String title;
  final bool showBackButton;

  const CustomAppBar1({
    super.key,
    required this.title,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (showBackButton)
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
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
                child: SvgPicture.asset(
                    "assets/svg/back.svg"
                ),
              ),
            ),
          ),
        Text(
          title,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 44), // Empty space to balance the layout
      ],
    );
  }
}
