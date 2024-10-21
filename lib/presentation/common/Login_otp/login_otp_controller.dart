import 'package:woye_user/core/utils/app_export.dart';

class LoginOtpController extends GetxController {
  int duration = 60;
  late Timer _timer;

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (duration == 0) {
        timer.cancel();
        update();
      } else {
        duration--;
        update();
      }
    });
    update();
  }

  void resendOtp() {
    duration = 60;
    startTimer();
    update();
  }

  PinTheme defaultPinTheme = PinTheme(
      width: 54.w,
      height: 56.h,
      textStyle: AppFontStyle.text_18_600(AppColors.darkText),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: AppColors.textFieldBorder,
        ),
      ));

  PinTheme focusedPinTheme = PinTheme(
      width: 54.w,
      height: 56.h,
      textStyle: AppFontStyle.text_18_600(AppColors.darkText),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: AppColors.darkText,
        ),
      ));
  PinTheme submittedPinTheme = PinTheme(
      width: 54.w,
      height: 56.h,
      textStyle: AppFontStyle.text_18_600(AppColors.darkText),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: AppColors.darkText,
        ),
      ));
}
