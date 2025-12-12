import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../shared/theme/colors.dart';
import '../../../../../../shared/theme/font_style.dart';
import '../../../../../Core/Utils/sized_box.dart';
import '../../../../../shared/widgets/custom_app_bar.dart';
import '../../../../common/Profile/Sub_screens/Order/Sub_screens/Order_details/order_details_controller.dart';

class PrescriptionsScreen extends StatefulWidget {
  const PrescriptionsScreen({super.key});

  @override
  State<PrescriptionsScreen> createState() => _PrescriptionsScreenState();
}

class _PrescriptionsScreenState extends State<PrescriptionsScreen> {

  final OrderDetailsController controller = Get.put(OrderDetailsController());

  RxInt imagesLength = RxInt(0);
  PageController prescriptionPageController = PageController(initialPage: 0);
  RxInt currentPagePres = 0.obs;

  @override
  void initState() {
    super.initState();
    var arguments = Get.arguments;
    if (arguments != null) {
      imagesLength.value = arguments['index'] ?? 0;
    }
    currentPagePres.value = imagesLength.value;
    prescriptionPageController = PageController(initialPage: imagesLength.value);
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: appbar(),
          body: Obx(
                ()=> Container(
              color: AppColors.bgColor.withOpacity(0.2),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: prescriptionPageController,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (value) {
                        currentPagePres.value = value;
                      },
                      itemCount: controller.ordersData.value.orderDetails?.drslip?.length ?? 0,
                      itemBuilder: (context, index) {
                        return InteractiveViewer(
                          minScale: 1.0,
                          maxScale: 20.0,
                          child: Padding(
                            padding: REdgeInsets.symmetric(horizontal: 10.0),
                            child: CachedNetworkImage(
                              imageUrl:  controller.ordersData.value.orderDetails?.drslip?[index] ?? "",
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: AppColors.bgColor,
                                highlightColor: AppColors.lightText,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.gray,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                // height: 80.h,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  border: Border.all(color: AppColors.greyBackground),
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Icon(
                                  Icons.broken_image_rounded,
                                  size: 40.h,
                                  color: AppColors.lightText.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if(( controller.ordersData.value.orderDetails?.drslip  ?? []).length > 1)...[
                    Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate( controller.ordersData.value.orderDetails?.drslip?.length ?? 0, (index) {
                            return Container(
                              margin: REdgeInsets.only(left: 5),
                              height: 10.h,
                              width: 10.h,
                              decoration: BoxDecoration(
                                color: currentPagePres.value == index ? AppColors.primary : AppColors.bgColor,
                                shape: BoxShape.circle,
                              ),
                            );
                          },
                          ),
                        ),
                      ),
                    ),
                    hBox(15.h),
                  ],
                  hBox(15.h),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  CustomAppBar appbar() {
    return CustomAppBar(
      // appbarRightPadding: 0,
      title: Text(
        "Prescription",
        style: AppFontStyle.text_20_600(
          AppColors.darkText,
        ),
      ),
      // actions: [
      //   PopupMenuButton<String>(
      //     color: AppColors.white,
      //     icon: const Icon(Icons.more_vert),
      //     offset: const Offset(-30, 30),
      //     itemBuilder: (BuildContext context) {
      //       return [
      //         PopupMenuItem<String>(
      //           onTap: () {
      //             controller.downloadAndSaveImages(controller.apiData.value.order?.drslip ?? []);
      //           },
      //           value: 'Download Images',
      //           child: ListTile(
      //             contentPadding: EdgeInsets.zero,
      //             title: Text(
      //               'Download Images',
      //               style: AppFontStyle.text_16_400(AppColors.darkText,
      //                   fontFamily: AppFontFamily.gilroyMedium),
      //             ),
      //           ),
      //         ),
      //       ];
      //     },
      //   ),
      // ],
    );
  }
}
