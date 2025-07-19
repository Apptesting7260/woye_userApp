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
            hBox( Get.height *0.2),
            Image.asset("assets/images/maintenance_mode.png"),
            Text("We're making some improvements.\nWe'll be back soon — thanks for your patience!",
              maxLines: 3,
              textAlign: TextAlign.center,
              style: AppFontStyle.text_18_500(AppColors.black,family: AppFontFamily.gilroyMedium),
            ),
          ],
        ),
      ),
    );
  }
}
