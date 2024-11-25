import 'package:woye_user/Presentation/Common/Home/home_controller.dart';
import 'package:woye_user/core/utils/app_export.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Padding(
            padding: REdgeInsets.only(left: 24, top: 30, right: 24, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  ImageConstants.profileImage,
                  height: 50.h,
                  width: 50.h,
                ),
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
          ),
          Column(
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
                          style: AppFontStyle.text_12_400(AppColors.lightText),
                        ),
                        hBox(5),
                        Text(
                          "32 Llanberis Close, Tonteg, CF38 1HR",
                          style: AppFontStyle.text_14_400(AppColors.darkText),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_sharp,
                      size: 22,
                      color: AppColors.darkText.withOpacity(0.8),
                    )
                  ],
                ),
              ),
              hBox(20),
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
                              homeController.mainButtonIndex.value == index;
                          return GestureDetector(
                            onTap: () {
                              if (index == 2) {
                                homeController.getIndex(index);
                                homeController.navigate(index);
                              } else {
                                homeController.getIndex(index);
                                homeController.navigate(index);
                              }
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
              hBox(4),
            ],
          ),
        ],
      ),
    );
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
