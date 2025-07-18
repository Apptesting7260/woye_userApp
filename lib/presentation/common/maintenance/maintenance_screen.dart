import 'package:flutter/material.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Shared/theme/font_family.dart';

class MaintenanceModeScreen extends StatelessWidget {
  const MaintenanceModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            hBox(40.h),
            Image.asset("assets/images/maintenance_mode.png",height: Get.height *0.6,),
            Text("Improving your experience. Please check back in a little while.",
            maxLines: 3,
            textAlign: TextAlign.center,
            style: AppFontStyle.text_18_500(AppColors.black,family: AppFontFamily.gilroyRegular),
            ),
          ],
        ),
      ),
    );
  }
}
