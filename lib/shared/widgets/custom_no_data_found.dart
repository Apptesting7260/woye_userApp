import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:woye_user/shared/theme/font_family.dart';

import '../../Core/Constant/image_constants.dart';
import '../../Core/Utils/sized_box.dart';
import '../theme/colors.dart';
import '../theme/font_style.dart';

class CustomNoDataFound extends StatelessWidget {
  final Widget? heightBox;

  const CustomNoDataFound({super.key, this.heightBox});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        heightBox ?? hBox(Get.height / 6),
        Center(
          child: SvgPicture.asset(
            ImageConstants.noData,
            height: 300.h,
            width: 200.h,
          ),
        ),
        Text(
          "We couldn't find any results",
          style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.onestRegular),
        ),
        hBox(5.h),
        Text(
          "Explore more and shortlist some items",
          style: AppFontStyle.text_16_400(AppColors.mediumText,family: AppFontFamily.onestRegular),
        ),
      ],
    );
  }
}
