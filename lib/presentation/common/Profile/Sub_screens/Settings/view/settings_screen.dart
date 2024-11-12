import 'package:woye_user/Core/Utils/app_export.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Settings",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            hBox(20),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: SvgPicture.asset(
                "assets/svg/notification-green.svg",
                color: AppColors.black,
              ),
              title: Text(
                "Notifications",
                style: AppFontStyle.text_16_500(AppColors.darkText),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_sharp,
                size: 18.h,
              ),
              onTap: () {
                Get.toNamed(AppRoutes.notificationsSettings);
              },
            ),
          ],
        ),
      ),
    );
  }
}
