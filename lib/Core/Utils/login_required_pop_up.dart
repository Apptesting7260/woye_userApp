import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woye_user/Data/app_exceptions.dart';
import 'package:woye_user/Shared/theme/font_family.dart';
import 'package:woye_user/shared/theme/colors.dart';
import 'package:woye_user/shared/theme/font_style.dart';
import 'package:woye_user/shared/widgets/custom_elevated_button.dart';

import 'app_export.dart';

Future showLoginRequired(context) {
  return showCupertinoModalPopup(
    // barrierDismissible: true,/
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          content: Container(
            height: 150.h,
            width: 320.w,
            padding: REdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Login Required',
                  style: AppFontStyle.text_18_600(AppColors.darkText,family: AppFontFamily.onestRegular
                  ),
                ),
                // hBox(15),
                Text(
                  'You need to log in first',
                  style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.onestMedium),
                ),
                // hBox(15),
                Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        fontFamily: AppFontFamily.onestMedium,
                        height: 40.h,
                        color: AppColors.black,
                        onPressed: () {
                          Get.back();
                        },
                        text: "Cancel",
                        textStyle:
                        AppFontStyle.text_14_400(AppColors.darkText),
                      ),
                    ),
                    wBox(15),
                    Expanded(
                      child: CustomElevatedButton(
                        fontFamily: AppFontFamily.onestMedium,
                        height: 40.h,
                        onPressed: () {
                          userPreference.removeUser();
                          Get.offAllNamed(AppRoutes.signUp);
                        },
                        text: "Login",
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}
