import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:woye_user/Core/Utils/app_export.dart';

import '../theme/font_family.dart';

class CustomElevatedButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double? height;
  final Color? color;
  final Color? forGroundColor;
  final VoidCallback onPressed;
  final Widget? child;
  final bool? isLoading;
  final String text;
  final TextStyle? textStyle;
  final String? fontFamily;
  final double? elevation;
  final BorderSide? side;
  const CustomElevatedButton({
    super.key,
    this.borderRadius,
    this.width,
    this.height,
    // this.color = const Color.fromRGBO(6, 132, 75, 1),
    this.color = const Color.fromRGBO(24, 30, 27, 1.0),
    this.isLoading,
    this.text = "",
    this.textStyle,
    required this.onPressed,
    this.child,
    this.forGroundColor,
    this.fontFamily ,
    this.elevation,
    this.side,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(100.r);
    return SizedBox(
      width: width ?? Get.width,
      height: height ?? 56.h,
      child: ElevatedButton(
        onPressed: isLoading != true ? onPressed : (){},
        style: ElevatedButton.styleFrom(
          elevation: elevation ?? 0,
          surfaceTintColor: Colors.transparent,
          foregroundColor: forGroundColor ?? AppColors.white,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            side:side ??  BorderSide.none ,
            borderRadius: BorderRadius.all(
              Radius.circular(32.0.r),
            ),
          ),
          alignment: Alignment.center,
          textStyle: textStyle ?? AppFontStyle.text_16_400(AppColors.white,family: fontFamily ?? AppFontFamily.onestMedium),
        ),
        child: child ??
            Center(
                child: isLoading != true
                    ? FittedBox(child: Text(text,style:textStyle ?? const TextStyle(height: 1),),)
                    : LoadingAnimationWidget.inkDrop(
                        color: Colors.white,
                        size: 30.h,
                      )),
      ),
    );
  }
}
