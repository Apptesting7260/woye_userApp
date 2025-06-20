import 'package:fluttertoast/fluttertoast.dart';
import 'package:woye_user/core/Utils/app_export.dart';

import '../../Shared/theme/font_family.dart';

class Utils {
  static String? showToast(
    String msg, {
    Toast? toastLength,
    ToastGravity gravity = ToastGravity.TOP,
  }) {
    Fluttertoast.showToast(
        msg: msg,
        backgroundColor: AppColors.black,
        gravity: gravity,
        textColor: AppColors.white,
        toastLength: toastLength);
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
            style: TextStyle(fontSize: 14.sp, color: Colors.white,fontFamily: AppFontFamily.gilroyMedium),
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

  static snackBar1(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.white54,
      colorText: Colors.black,
      titleText: Text(
        title,
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold), // Title text color
      ),
      messageText: Text(
        message,
        style: TextStyle(color: Colors.black), // Message text color
      ),
      icon: Image.asset(
        'assets/images/app_icon.png',
        scale: 8,
      ),
      borderRadius: 20,
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.only(left: 10, right: 10),
      padding: EdgeInsets.symmetric(vertical: 8),
      duration: Duration(seconds: 1),
    );
  }
}
