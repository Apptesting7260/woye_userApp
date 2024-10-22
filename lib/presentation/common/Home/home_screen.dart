import 'package:woye_user/Presentation/Common/Home/home_controller.dart';
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
            body: Column(
              children: [
                Padding(
                  padding: REdgeInsets.symmetric(horizontal: 24),
                  child: Row(
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
                ),
                hBox(30),
                Padding(
                  padding: REdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    height: 42.h,
                    child: Row(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: homeController.mainButtonbar.length,
                          itemBuilder: (context, index) {
                            bool isSelected =
                                homeController.mainButtonIndex == index;
                            return GestureDetector(
                              onTap: () {
                                homeController.getIndex(index);
                              },
                              child: MainButtonBar(
                                title: homeController.mainButtonbar[index]
                                        ["title"] ??
                                    "",
                                image: isSelected
                                    ? homeController.mainButtonbar[index]
                                            ["imageEnabled"] ??
                                        ""
                                    : homeController.mainButtonbar[index]
                                            ["imageDisabled"] ??
                                        "",
                                backgroundColor: isSelected
                                    ? AppColors.primary
                                    : Colors.transparent,
                                titleColor: isSelected
                                    ? AppColors.white
                                    : AppColors.black,
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return wBox(10);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                hBox(20),
                SingleChildScrollView(
                  child: SizedBox(
                    width: Get.width,
                    height: 600,
                    child: IndexedStack(
                      index: homeController.mainButtonIndex,
                      children: homeController.homeWidgets,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}

class MainButtonBar extends StatelessWidget {
  final String image;
  final String title;
  final Color backgroundColor;
  final Color titleColor;
  const MainButtonBar({
    super.key,
    required this.image,
    required this.title,
    required this.backgroundColor,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      height: 42.h,
      width: Get.width * 0.27,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary.withOpacity(0.2)),
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 16.h,
            width: 16.h,
          ),
          wBox(6),
          Text(
            title,
            style: AppFontStyle.text_12_400(titleColor),
          )
        ],
      ),
    );
  }
}
