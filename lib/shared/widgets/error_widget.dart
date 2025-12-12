import '../../core/Utils/app_export.dart';

class ImageErrorWidget extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double? height;
  const ImageErrorWidget({super.key, this.borderRadius, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width:width ?? Get.width,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textFieldBorder),
        borderRadius:borderRadius ?? BorderRadius.circular(20.r),
      ),
      child: Icon(Icons.broken_image_rounded,color: AppColors.textFieldBorder),
    );
  }
}
