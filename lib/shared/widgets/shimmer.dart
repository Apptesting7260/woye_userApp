import 'package:shimmer/shimmer.dart';

import '../../Core/Utils/app_export.dart';

class ShimmerWidget extends StatelessWidget {
  final Color? baseClr;
  final Color? highlightColor;
  final Color? shimmerClr;
  final BorderRadius? borderRadius;
  final BoxBorder? border;

  const ShimmerWidget({super.key,  this.baseClr,  this.highlightColor,  this.shimmerClr,  this.borderRadius,  this.border});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor:baseClr ?? AppColors.gray,
      highlightColor: highlightColor ?? AppColors.lightText,
      child: Container(
        width: double.maxFinite,
        height: 220.h,
        decoration: BoxDecoration(
          border: border,
          color: shimmerClr ?? AppColors.gray.withOpacity(0.4),
          borderRadius: borderRadius ?? BorderRadius.circular(20.r),
        ),
      ),
    );
  }
}
