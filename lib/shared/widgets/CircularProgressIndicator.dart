import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../Core/Utils/app_export.dart';

Widget circularProgressIndicator() {
  return LoadingAnimationWidget.inkDrop(
    color: AppColors.primary,
    size: 30,
  );
}