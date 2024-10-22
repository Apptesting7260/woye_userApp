import 'package:woye_user/Shared/Widgets/custom_app_bar.dart';
import 'package:woye_user/core/utils/app_export.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: Image.asset(
          ImageConstants.profileImage,
          height: 50.h,
          width: 50.h,
        ),
        actions: [
          Container(
            padding: REdgeInsets.all(9),
            height: 44.h,
            width: 44.h,
            decoration: BoxDecoration(
                color: AppColors.greyBackground,
                borderRadius: BorderRadius.circular(12.r)),
            child: SvgPicture.asset(
              ImageConstants.notification,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Location",
                      style: AppFontStyle.text_12_400(AppColors.lightText),
                    ),
                    hBox(10),
                    Text(
                      "32 Llanberis Close, Tonteg, CF38 1HR",
                      style: AppFontStyle.text_14_400(AppColors.darkText),
                    ),
                  ],
                ),
                Icon(
                  Icons.keyboard_arrow_right_rounded,
                  size: 32,
                  color: AppColors.darkText,
                )
              ],
            ),
            hBox(30),
            Row(
              children: [
                Container(
                  height: 42.h,
                  width: 120.h,
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(ImageConstants.restaurantWhite),
                      wBox(6),
                      Text(
                        "Restaurant",
                        style: AppFontStyle.text_12_400(AppColors.white),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
