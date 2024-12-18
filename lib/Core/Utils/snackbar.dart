import 'package:fluttertoast/fluttertoast.dart';
import 'package:woye_user/core/Utils/app_export.dart';

class Utils {
  static String? showToast(String msg,
      {ToastGravity gravity = ToastGravity.BOTTOM}) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: AppColors.primary,
      gravity: gravity,
      textColor: AppColors.white,
    );
    return null;
  }

  static String? showSnackbar(
      {required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: AppColors.primary,
        duration: const Duration(seconds: 1),
        content: Center(
          child: Text(
            message,
            style: TextStyle(fontSize: 14.sp, color: Colors.white),
          ),
        )));

    return null;
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>?
      showSnackBarProgress({required BuildContext context}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: AppColors.primary,
        content: Center(
          child: SizedBox(
            height: 16.h,
            width: 16.h,
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 1.w,
              strokeCap: StrokeCap.round,
            ),
          ),
        )));
  }
}
