import 'package:woye_user/core/app_export.dart';

class CustomElevatedButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double? height;
  final Color? color;
  final VoidCallback? onPressed;
  final Widget? child;
  final bool isLoading;
  final String text;
  final TextStyle? textStyle;

  const CustomElevatedButton({
    super.key,
    this.borderRadius,
    this.width,
    this.height,
    this.color = const Color.fromRGBO(6, 132, 75, 1),
    this.isLoading = false,
    this.text = "",
    this.textStyle,
    required this.onPressed,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(100.r);
    return Container(
      width: double.infinity,
      height: height ?? 60.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: isLoading
            ? CircularProgressIndicator.adaptive(
                backgroundColor: AppColors.white,
                strokeWidth: 1.w,
              )
            : child ??
                Text(
                  text,
                  style: textStyle ?? AppFontStyle.text_16_400(AppColors.white),
                ),
      ),
    );
  }
}
