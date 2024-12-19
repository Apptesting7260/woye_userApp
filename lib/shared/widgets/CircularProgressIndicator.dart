import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../Core/Utils/app_export.dart';

Widget circularProgressIndicator({double size = 30.0}) {
  return LoadingAnimationWidget.inkDrop(
    color: AppColors.primary,
    size: size,
  );
}

Widget circularProgressIndicator2({double size = 30.0}) {
  return LoadingAnimationWidget.fourRotatingDots(
    color: AppColors.primary,
    size: size,
  );

  // return LoadingAnimationWidget.waveDots(
  //   color: AppColors.primary,
  //   size: size,
  // );
}
