import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Shared/theme/font_family.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Settings",
          style: AppFontStyle.text_22_600(AppColors.darkText,family: AppFontFamily.onestRegular),
        ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            // hBox(15.h),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: SvgPicture.asset(
                "assets/svg/support.svg",
                color: AppColors.black,
              ),
              title: Text(
                "Support",
                style: AppFontStyle.text_18_400(AppColors.darkText,family: AppFontFamily.onestMedium),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_sharp,
                size: 20.h,
              ),
              onTap: () {
                Get.toNamed(AppRoutes.support);
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: SvgPicture.asset(
                "assets/svg/faq.svg",
                color: AppColors.black,
              ),
              title: Text(
                "FAQ",
                style: AppFontStyle.text_18_400(AppColors.darkText,family: AppFontFamily.onestMedium),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_sharp,
                size: 20.h,
              ),
              onTap: () {
                Get.toNamed(AppRoutes.faq);
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: SvgPicture.asset(
                "assets/svg/privacy-policy.svg",
                color: AppColors.black,
              ),
              title: Text(
                "Privay Policy",
                style: AppFontStyle.text_18_400(AppColors.darkText,family: AppFontFamily.onestMedium),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_sharp,
                size: 20.h,
              ),
              onTap: () {
                Get.toNamed(AppRoutes.privayPolicy);
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: SvgPicture.asset(
                "assets/svg/tnc.svg",
                color: AppColors.black,
              ),
              title: Text(
                "Terms & Conditions",
                style: AppFontStyle.text_18_400(AppColors.darkText,family: AppFontFamily.onestMedium),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_sharp,
                size: 20.h,
              ),
              onTap: () {
                Get.toNamed(AppRoutes.termsAndConditions);
              },
            ),
          ],
        ),
      ),
    );
  }
}
