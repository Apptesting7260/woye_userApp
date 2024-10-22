import 'package:woye_user/Presentation/Restaurants/Pages/Home/home_controller.dart';
import 'package:woye_user/Shared/Widgets/custom_app_bar.dart';
import 'package:woye_user/core/utils/app_export.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (homeController) {
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
                            style:
                                AppFontStyle.text_12_400(AppColors.lightText),
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
                  SizedBox(
                    height: 42.h,
                    child: Row(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return MainButtonBar();
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return wBox(10);
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class MainButtonBar extends StatelessWidget {
  final String? title;
  final String? image;
  const MainButtonBar({
    super.key,
    this.title,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.h,
      // width: 100.w,
      width: Get.width * 0.27,
      decoration: BoxDecoration(
          color: AppColors.primary, borderRadius: BorderRadius.circular(10.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image!,
            // scale: 1,
            height: 16.h,
            width: 16.h,
          ),
          wBox(6),
          Text(
            title!,
            style: AppFontStyle.text_12_400(AppColors.white),
          )
        ],
      ),
    );
  }
}
