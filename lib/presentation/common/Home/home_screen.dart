import 'package:cached_network_image/cached_network_image.dart';
import 'package:woye_user/Presentation/Common/Home/home_controller.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/common/current_location/current_location.dart';

import '../../../shared/widgets/CircularProgressIndicator.dart';

class HomeScreen extends StatelessWidget {
  final String? profileImage;

  HomeScreen({super.key, this.profileImage});

  final HomeController homeController = Get.put(HomeController());
  final CurrentLocationController currentLocationController =
      Get.put(CurrentLocationController());

  void showLocationDialog() {
    if (homeController.location.value.isEmpty) {
      Future.delayed(const Duration(seconds: 0), () {
        Get.dialog(
          PopScope(
            canPop: false,
            child: AlertDialog(
              title: Image.asset(
                "assets/images/Location.png",
                height: 100.h,
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
                      style: AppFontStyle.text_22_600(AppColors.darkText),
                    ),
                    hBox(10.h),
                    Text(
                      "Getting location permission will ensure accurate address and hassle free delivery",
                      style: AppFontStyle.text_16_400(AppColors.lightText),
                      maxLines: 4,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),
                    CustomElevatedButton(
                      height: 50.h,
                      color: AppColors.primary,
                      onPressed: () async {
                        await currentLocationController.getCurrentPosition(
                            back: true);
                      },
                      text: "Allow Location Access",
                      textStyle: AppFontStyle.text_14_400(AppColors.white),
                    ),
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.addAddressScreen,
                            arguments: {'cartKey': ""});
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
                                    AppFontStyle.text_16_400(AppColors.primary),
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
    showLocationDialog();
    return Material(
      child: Column(
        children: [
          Padding(
            padding: REdgeInsets.only(left: 24, top: 30, right: 24, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Image.asset(
                //   ImageConstants.profileImage,
                //   height: 50.h,
                //   width: 50.h,
                // ),
                profileImage?.isEmpty ?? true
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

                          // radius: 20.h,
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
                            imageUrl: profileImage.toString(),
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
                      ),
                GestureDetector(
                  onTap: () {
                    showLocationDialog();
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
                                AppFontStyle.text_12_400(AppColors.lightText),
                          ),
                          hBox(5.w),
                          Obx(
                            () => Text(
                              homeController.location.value,
                              style:
                                  AppFontStyle.text_14_400(AppColors.darkText),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
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

// Future showDeleteAddressDialog({
//   required String addressId,
// }) {
//   return Get.dialog(
//     AlertDialog.adaptive(
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             'Delete Address', // Updated text
//             style: TextStyle(
//               fontSize: 18.sp,
//               fontWeight: FontWeight.w600,
//               color: Colors.black,
//             ),
//           ),
//           SizedBox(height: 15.h),
//           Text(
//             'Are you sure you want to delete this address?',
//             // Updated message
//             style: TextStyle(
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w400,
//               color: Colors.grey,
//             ),
//           ),
//           SizedBox(height: 15.h),
//           Row(
//             children: [
//               Expanded(
//                 child: CustomElevatedButton(
//                   height: 40.h,
//                   color: AppColors.black,
//                   onPressed: () {
//                     Get.back();
//                   },
//                   text: "Cancel",
//                   textStyle: AppFontStyle.text_14_400(AppColors.darkText),
//                 ),
//               ),
//               wBox(15),
//               Obx(
//                     () => Expanded(
//                   child: CustomElevatedButton(
//                     height: 40.h,
//                     isLoading:
//                     deleteAddressController.rxRequestStatus.value ==
//                         (Status.LOADING),
//                     onPressed: () {
//                       deleteAddressController.deleteAddressApi(
//                           addressId: addressId);
//                     },
//                     text: "Yes",
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//     barrierDismissible: false,
//   );
// }
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
