import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:woye_user/Presentation/Common/Home/home_controller.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/common/current_location/current_location.dart';
import 'package:woye_user/presentation/common/get_user_data/get_user_data.dart';
import 'package:woye_user/shared/theme/font_family.dart';

import '../../../shared/widgets/CircularProgressIndicator.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController homeController = Get.put(HomeController());
  final CurrentLocationController currentLocationController =
      Get.put(CurrentLocationController());
  final GetUserDataController getUserDataController =
      Get.put(GetUserDataController());

  void showLocationDialog() {
    if (homeController.location.value.isEmpty) {
      Future.delayed(const Duration(seconds: 0), () {
        Get.dialog(
          PopScope(
            canPop: false,
            child: AlertDialog(
              title: Image.asset(
                "assets/images/Location.png",
                height: 95.h,
              ),
              content: Padding(
                padding: REdgeInsets.all(0.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Location Permission is off",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
                    ),
                    hBox(10.h),
                    Text(
                      "Getting location permission will ensure accurate address and hassle free delivery",
                      style: AppFontStyle.text_16_400(AppColors.lightText,family: AppFontFamily.gilroyRegular),
                      maxLines: 4,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),
                    CustomElevatedButton(
                      height: 50.h,
                      color: AppColors.primary,
                      onPressed: () async {
                        Get.back();
                        await currentLocationController.getCurrentPosition(
                            back: true);
                      },
                      text: "Allow Location Access",
                      textStyle: AppFontStyle.text_14_400(AppColors.white,family: AppFontFamily.gilroySemiBold),
                    ),
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.addAddressScreen,
                            arguments: {'type': "","fromcart": false,});
                      },
                      child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.r),
                              border: Border.all(color: AppColors.primary)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/svg/pin_location.svg",
                                height: 22.h,
                              ),
                              SizedBox(width: 5.h),
                              Text(
                                "Add Address",
                                style:
                                    AppFontStyle.text_15_400(AppColors.primary,family: AppFontFamily.gilroyMedium),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    homeController.mainButtonIndex.value;
    // currentLocationController.getCurrentPosition(back: true);
    showLocationDialog();
    return Material(
      child: Column(
        children: [
          Padding(
            padding: REdgeInsets.only(
                left: 24.h, top: 10.h, right: 24.h, bottom: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  return getUserDataController
                              .userData.value.user?.imageUrl?.isEmpty ??
                          true
                      ? Container(
                          width: 50.h,
                          height: 50.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            border: Border.all(color: Colors.transparent),
                          ),
                          child: CircleAvatar(
                            backgroundColor:
                                AppColors.greyBackground.withOpacity(0.5),
                            child: Icon(
                              Icons.person,
                              size: 30.h,
                              color: AppColors.lightText.withOpacity(0.5),
                            ),
                          ),
                        )
                      : Container(
                          width: 50.h,
                          height: 50.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            border: Border.all(color: Colors.transparent),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.r),
                            child: CachedNetworkImage(
                              imageUrl: getUserDataController
                                  .userData.value.user!.imageUrl
                                  .toString(),
                              placeholder: (context, url) =>
                                  circularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(
                                Icons.person,
                                size: 40.h,
                                color: AppColors.lightText.withOpacity(0.5),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                }),
                GestureDetector(
                  onTap: () {
                   // showLocationDialog();
                    Get.toNamed(AppRoutes.notifications);
                  },
                  child: Container(
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
                ),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 24.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: Get.width * 0.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Your Location",
                            style:
                                AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyRegular),
                          ),
                          hBox(5.w),
                          Obx(
                            () => Text(
                              homeController.location.value,
                              style: AppFontStyle.text_14_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_sharp,
                      size: 20,
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
                          bool isSelected = homeController.mainButtonIndex.value == index;
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
                              title: homeController.mainButtonbar[index]["title"] ?? "",
                              image: isSelected ? homeController.mainButtonbar[index]["imageEnabled"] ?? ""
                                  : homeController.mainButtonbar[index]["imageDisabled"] ?? "",
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
      curve: Curves.easeInCubic,
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
            style: AppFontStyle.text_12_500(titleColor,family: AppFontFamily.gilroyMedium),
          )
        ],
      ),
    );
  }
}
