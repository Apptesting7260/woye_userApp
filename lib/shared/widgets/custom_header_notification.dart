import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woye_user/Core/Constant/image_constants.dart';


class CustomHeaderWithNotification extends StatelessWidget {
  final String title;
  final VoidCallback? onNotificationTap;

  const CustomHeaderWithNotification({
    super.key,
    required this.title,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 28.sp,
            fontFamily: 'Gilroy',
          ),
        ),
        InkWell(
            highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
          onTap: onNotificationTap,
          child: Container(
            padding: EdgeInsets.all(9.h),
            height: 44.h,
            width: 44.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade200, // Replace AppColors.greyBackground
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: SvgPicture.asset(
              ImageConstants.notification, // Use the provided icon
            ),
          ),
        ),
      ],
    );
  }
}
