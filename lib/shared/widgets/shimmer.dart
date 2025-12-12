

import 'package:shimmer/shimmer.dart';
import '../../Core/Utils/app_export.dart';

class ShimmerWidget extends StatelessWidget {
  final Color? baseClr;
  final Color? highlightColor;
  final Color? shimmerClr;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final bool isRestaurantCard;

  const ShimmerWidget({
    super.key,
    this.baseClr,
    this.highlightColor,
    this.shimmerClr,
    this.borderRadius,
    this.border,
    this.isRestaurantCard = false,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseClr ?? AppColors.gray.withOpacity(0.4),
      highlightColor: highlightColor ?? AppColors.lightText,
      child: isRestaurantCard ? restaurantCardShimmer() : simpleSimmer(),
    );
  }

  Widget simpleSimmer() {
    return Container(
      width: double.maxFinite,
      height: 220.h,
      decoration: BoxDecoration(
        border: border,
        color: shimmerClr ?? AppColors.gray.withOpacity(0.4),
        borderRadius: borderRadius ?? BorderRadius.circular(20.r),
      ),
    );
  }

  Widget restaurantCardShimmer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(20.r),
        border: border,
      ),
      padding: REdgeInsets.only(bottom: 50),
      width: Get.width * 0.78,
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     hBox(225.h),
      //     // Container(
      //     //   height: 160.h,
      //     //   width: double.infinity,
      //     //   decoration: BoxDecoration(
      //     //     color: shimmerClr ?? AppColors.gray.withOpacity(0.4),
      //     //     borderRadius: BorderRadius.circular(20.r),
      //     //   ),
      //     // ),
      //     Container(
      //       height: 13.h,
      //       width: Get.width * 0.7 .w,
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(1.r),
      //         color: shimmerClr ?? AppColors.gray.withOpacity(0.4),
      //       ),
      //
      //     ),
      //     hBox(8.h),
      //     // Category text
      //     Row(
      //       children: [
      //         Container(
      //           height: 12.h,
      //           width: 120.w,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(1.r),
      //             color: shimmerClr ?? AppColors.gray.withOpacity(0.4),
      //           ),
      //         ),
      //         wBox(10.w),
      //         Container(
      //           height: 12.h,
      //           width: 120.w,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(1.r),
      //             color: shimmerClr ?? AppColors.gray.withOpacity(0.4),
      //           ),
      //         ),
      //       ],
      //     ),
      //     hBox(12.h),
      //     Row(
      //       children: [
      //         Container(
      //           height: 10.h,
      //           width: Get.width * 0.22.w,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(1.r),
      //             color: shimmerClr ?? AppColors.gray.withOpacity(0.4),
      //           ),
      //         ),
      //         wBox(10.w),
      //         Container(
      //           height: 10.h,
      //           width: Get.width * 0.22.w,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(1.r),
      //             color: shimmerClr ?? AppColors.gray.withOpacity(0.4),
      //           ),
      //         ),
      //         wBox(10.w),
      //         Container(
      //           height: 10.h,
      //           width: Get.width * 0.22.w,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(1.r),
      //             color: shimmerClr ?? AppColors.gray.withOpacity(0.4),
      //           ),
      //         ),
      //       ],
      //     )
      //   ],
      // ),
    );
  }
}


class ShimmerWidgetHomeScreen extends StatelessWidget {
  final Color? baseClr;
  final Color? highlightColor;
  final Color? shimmerClr;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final bool isRestaurantCard;

  const ShimmerWidgetHomeScreen({
    super.key,
    this.baseClr,
    this.highlightColor,
    this.shimmerClr,
    this.borderRadius,
    this.border,
    this.isRestaurantCard = false,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseClr ?? AppColors.gray.withOpacity(0.2),
      highlightColor: highlightColor ?? AppColors.lightText,
      child : SizedBox(/*height: 315.h,*/
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 210.h, width: Get.width*0.78,decoration: BoxDecoration(color: AppColors.primary,borderRadius: BorderRadius.circular(20.r)),),
            hBox(10.h),
            Container(height: 20.h, width: Get.width*0.78,decoration: BoxDecoration(color: AppColors.primary,borderRadius: BorderRadius.circular(15.r)),),
            hBox(10.h),
            Container(height: 20.h, width: Get.width*0.50,decoration: BoxDecoration(color: AppColors.primary,borderRadius: BorderRadius.circular(15.r)),),
            hBox(10.h),
            Container(height: 20.h, width: Get.width*0.30,decoration: BoxDecoration(color: AppColors.primary,borderRadius: BorderRadius.circular(15.r)),),
          ],
        ),
      ),
    );
  }

}
