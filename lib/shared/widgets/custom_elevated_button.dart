import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:woye_user/Core/Utils/app_export.dart';

class CustomElevatedButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double? height;
  final Color? color;
  final VoidCallback onPressed;
  final Widget? child;
  final bool? isLoading;
  final String text;
  final TextStyle? textStyle;

  const CustomElevatedButton({
    super.key,
    this.borderRadius,
    this.width,
    this.height,
    this.color = const Color.fromRGBO(6, 132, 75, 1),
    this.isLoading,
    this.text = "",
    this.textStyle,
    required this.onPressed,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(100.r);
    return SizedBox(
      width: width ?? 295,
      height: height ?? 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.white,
            backgroundColor: color,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(32.0),
              ),
            ),
            alignment: Alignment.center,
            textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.white)),
        child: Center(
            child: isLoading != true
                ? Text(text)
                : LoadingAnimationWidget.inkDrop(
                    color: Colors.white,
                    size: 30,
                  )),
      ),
    );
  }
}
