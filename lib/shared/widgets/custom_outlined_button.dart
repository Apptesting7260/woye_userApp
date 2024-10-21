import 'package:woye_user/core/utils/app_export.dart';

class CustomOutlinedButton extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final VoidCallback? onPressed;
  final Widget? child;
  final bool isLoading;

  const CustomOutlinedButton(
      {super.key,
      this.width,
      this.height,
      this.borderRadius,
      this.isLoading = false,
      required this.onPressed,
      required this.child});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 60.h,
      width: double.maxFinite,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.textFieldBorder),
              shape: RoundedRectangleBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(100.r))),
          onPressed: onPressed,
          child: isLoading
              ? CircularProgressIndicator.adaptive(
                  backgroundColor: AppColors.white,
                  strokeWidth: 1.w,
                )
              : child),
    );
  }
}
