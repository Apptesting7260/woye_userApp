import 'package:woye_user/core/app_export.dart';

class OtpVerificationController extends GetxController {
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
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      print("print timer===========> ${timer.tick}");
      if (duration == 0) {
        startTimer();
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
      height: 60.h,
      textStyle: AppFontStyle.text_18_600(AppColors.darkText),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: AppColors.textFieldBorder,
        ),
      ));

  PinTheme focusedPinTheme = PinTheme(
      width: 54.w,
      height: 60.h,
      textStyle: AppFontStyle.text_18_600(AppColors.darkText),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: AppColors.darkText,
        ),
      ));
  PinTheme submittedPinTheme = PinTheme(
      width: 54.w,
      height: 60.h,
      textStyle: AppFontStyle.text_18_600(AppColors.darkText),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: AppColors.darkText,
        ),
      ));
}
