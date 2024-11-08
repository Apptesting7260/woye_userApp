import 'package:woye_user/Core/Utils/app_export.dart';

class NotificationsSettingsScreen extends StatelessWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Notifications",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            hBox(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Push Notifications",
                  style: AppFontStyle.text_16_500(AppColors.darkText),
                ),
                Switch.adaptive(value: true, onChanged: (v) {}),
              ],
            ),
            hBox(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Email Notifications",
                  style: AppFontStyle.text_16_500(AppColors.darkText),
                ),
                Switch.adaptive(value: false, onChanged: (v) {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
