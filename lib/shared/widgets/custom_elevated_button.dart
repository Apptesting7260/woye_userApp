// import 'package:woye_user/core/utils/app_export.dart';
//
// class CustomElevatedButton extends StatelessWidget {
//   final BorderRadiusGeometry? borderRadius;
//   final double? width;
//   final double? height;
//   final Color? color;
//   final VoidCallback? onPressed;
//   final Widget? child;
//   final bool isLoading;
//   final String text;
//   final TextStyle? textStyle;
//
//   const CustomElevatedButton({
//     super.key,
//     this.borderRadius,
//     this.width,
//     this.height,
//     this.color = const Color.fromRGBO(6, 132, 75, 1),
//     this.isLoading = false,
//     this.text = "",
//     this.textStyle,
//     required this.onPressed,
//     this.child,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final borderRadius = this.borderRadius ?? BorderRadius.circular(100.r);
//     return Container(
//       width: width ?? double.infinity,
//       height: height ?? 60.h,
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: borderRadius,
//       ),
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.transparent,
//           shadowColor: Colors.transparent,
//           shape: RoundedRectangleBorder(borderRadius: borderRadius),
//         ),
//         child: isLoading
//             ? CircularProgressIndicator.adaptive(
//                 backgroundColor: AppColors.white,
//                 strokeWidth: 1.w,
//               )
//             : child ??
//                 Text(
//                   text,
//                   style: textStyle ?? AppFontStyle.text_16_400(AppColors.white),
//                 ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomElevatedButton extends StatelessWidget {

  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double? height;
  final Color? color;
  final VoidCallback onPressed;
  final Widget? child;
  final bool isLoading;
  final String text;
  final TextStyle? textStyle;
  // final String title;
  // final TextStyle? style;
  // final VoidCallback onTap;
  // final double? width;
  // final double? height;
  // final EdgeInsetsGeometry? padding;
  // final Color? textColor;
  // final Color? bgColor;
  // final bool loading ;

   const CustomElevatedButton({
    Key? key,
    this.borderRadius,
    this.width,
    this.height,
    this.color = const Color.fromRGBO(6, 132, 75, 1),
    this.isLoading = false,
    this.text = "",
    this.textStyle,
    required this.onPressed,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(100.r);
    return SizedBox(
      width: width ?? 295,
      height: height ?? 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white ??
                Theme.of(context).buttonTheme.colorScheme?.onSecondary, backgroundColor: color, shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(32.0),
          ),
        ),
            alignment: Alignment.center,
            textStyle:  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        child: Center(child: isLoading==false? Text(text): LoadingAnimationWidget.inkDrop(
          color: Colors.white,
          size: 30,
        )),
      ),
    );
  }
}
