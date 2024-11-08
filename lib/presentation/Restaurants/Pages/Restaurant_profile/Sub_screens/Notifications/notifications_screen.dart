import 'package:woye_user/core/utils/app_export.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

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
        child: Column(
          children: [
            hBox(20),
            notificationsList(),
            hBox(50),
          ],
        ),
      ),
    );
  }

  Widget notificationsList() {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 24),
      shrinkWrap: true,
      itemCount: 20,
      itemBuilder: (context, index) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: REdgeInsets.all(9),
              decoration: BoxDecoration(
                  color: AppColors.ultraLightPrimary,
                  borderRadius: BorderRadius.circular(12.r)),
              child: SvgPicture.asset(
                "assets/svg/notification-green.svg",
                theme: SvgTheme(currentColor: AppColors.primary),
              ),
            ),
            wBox(20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order Received",
                    style: AppFontStyle.text_16_500(AppColors.darkText),
                  ),
                  hBox(5),
                  Text(
                    "Lorem Ipsum is simply dummy text of...",
                    style: AppFontStyle.text_14_400(AppColors.lightText),
                  ),
                  hBox(5),
                  Text(
                    "8 Apr 2024",
                    style: AppFontStyle.text_14_400(AppColors.lightText),
                  ),
                ],
              ),
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) => hBox(20),
    );
  }
}
