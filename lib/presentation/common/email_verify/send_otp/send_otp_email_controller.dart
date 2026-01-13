import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Shared/theme/font_family.dart';
import 'package:woye_user/presentation/common/Update_profile/controller/Update_profile_controller.dart';
import 'package:woye_user/presentation/common/email_verify/send_otp/send_otp_modal.dart';

class SendOtpEmailController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final rxRequestStatus1 = Status.COMPLETED.obs;
  final sendOtpData = SendOtpModal().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setRxRequestStatus1(Status value) => rxRequestStatus1.value = value;

  void setData(SendOtpModal value) => sendOtpData.value = value;

  Future sendOtpApi({required String email}) async {
    setRxRequestStatus(Status.LOADING);
    var body = {
      "email": email,
    };
    await api.sendVerificationOtp(body).then((value) {
      setData(value);
      if (sendOtpData.value.status == true) {
        setRxRequestStatus(Status.COMPLETED);
        showOtpVerificationRequired(email);
      } else {
        setRxRequestStatus(Status.COMPLETED);
        Utils.showToast(sendOtpData.value.message.toString());
      }
    }).onError((error, stackError) {
      print("Error: $error");
      setError(error.toString());
      print(stackError);
      setRxRequestStatus(Status.ERROR);
    });
  }

  Future resendSendOtpApi({required String email}) async {
    setRxRequestStatus1(Status.LOADING);
    var body = {
      "email": email,
    };
    await api.sendVerificationOtp(body).then((value) {
      setData(value);
      if (sendOtpData.value.status == true) {
        setRxRequestStatus1(Status.COMPLETED);
        otpVerifyController.value.clear();
        Get.back();
        startTimer();
        showOtpVerificationRequired(email);
      } else {
        setRxRequestStatus1(Status.COMPLETED);
        Utils.showToast(sendOtpData.value.message.toString());
        otpVerifyController.value.clear();
      }
    }).onError((error, stackError) {
      print("Error: $error");
      setError(error.toString());
      print(stackError);
      setRxRequestStatus1(Status.ERROR);
    });
  }

  void setError(String value) => error.value = value;
  final Rx<TextEditingController> otpVerifyController =
      TextEditingController().obs;

  RxBool isResendEnabled = true.obs;
  RxInt remainingTime = 60.obs;
  late Timer timer1;

  void startTimer() {
    isResendEnabled.value = false;
    remainingTime.value = 60;
    // if(timer1.isActive){
    //   timer1.cancel();
    // }
    timer1 = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        isResendEnabled.value = true;
        if(timer1.isActive){
          timer1.cancel();
        }

      }
    });
  }

  Future showOtpVerificationRequired(email) {
    return showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) {
          return PopScope(
            canPop: false,
            child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              insetPadding: EdgeInsets.zero,
              content: Container(
                height: 310.h,
                width: 320.w,
                padding: REdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Padding(
                  padding: REdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'OTP Verification',
                        style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
                      ),
                      hBox(10.h),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: "Please enter the verification code sent to",
                          style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
                        ),
                        TextSpan(
                            text: "\n$email",
                            style: AppFontStyle.text_14_400(AppColors.primary,family: AppFontFamily.gilroyRegular)),
                      ])),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: () {
                                if(timer1.isActive){
                                  timer1.cancel();
                                }
                                isResendEnabled.value = false;
                                remainingTime.value = 60;
                                otpVerifyController.value.text = "";
                                print(remainingTime.value);
                                Get.back();
                              },
                              child: Text("Wrong email?",
                                  style: AppFontStyle.text_14_400(height: 1.5,
                                      AppColors.primary,family: AppFontFamily.gilroyRegular)))
                        ],
                      ),
                      // hBox(10.h),
                      Pinput(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        length: 4,
                        controller: otpVerifyController.value,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        submittedPinTheme: submittedPinTheme,
                        onTapOutside: (event){
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        // defaultPinTheme: otpController.defaultPinTheme,
                        // focusedPinTheme: otpController.focusedPinTheme,
                        // submittedPinTheme: otpController.submittedPinTheme,
                      ),
                      hBox(10.h),

                      // Container(
                      //   width: double.infinity,
                      //   padding: REdgeInsets.symmetric(horizontal: 20),
                      //   child: TextField(
                      //     controller: otpVerifyController.value,
                      //     decoration: InputDecoration(
                      //       hintText: 'Enter OTP',
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10.r),
                      //       ),
                      //       filled: true,
                      //       fillColor: AppColors.lightText.withOpacity(0.1),
                      //     ),
                      //     keyboardType: TextInputType.number,
                      //     textAlign: TextAlign.center,
                      //   ),
                      // ),
                      // hBox(15),
                      Obx(
                        () => CustomElevatedButton(
                          isLoading: (rxRequestStatus2.value == Status.LOADING),
                          height: 50.h,
                          width: Get.width / 3,
                          onPressed: () {
                            if(otpVerifyController.value.text != "" && otpVerifyController.value.text.isNotEmpty && otpVerifyController.value.text.length == 4){
                              verifyOtpApi(
                                otp: otpVerifyController.value.text.trim(),
                                email: email,
                              );
                            }
                            else{
                              Utils.showToast("Please enter otp");
                            }
                          },
                          text: "Verify",
                        ),
                      ),
                      Obx(
                        () => TextButton(
                          onPressed: isResendEnabled.value
                              ? () {
                                  debugPrint('Resending OTP');

                                  resendSendOtpApi(email: email);
                                }
                              : null,
                          child: (rxRequestStatus1.value == Status.LOADING)
                              ? LoadingAnimationWidget.inkDrop(
                                  color: AppColors.primary,
                                  size: 15.h,
                                )
                              : Text(
                                  isResendEnabled.value
                                      ? 'Resend code'
                                      : 'Resend code in ${remainingTime.value} sec',
                                  style: TextStyle(
                                    color: AppColors.darkText,
                                    decoration: isResendEnabled.value
                                        ? TextDecoration.underline
                                        : TextDecoration.none,
                                    fontSize: 16.sp,
                                  )
                                  // style: AppFontStyle.text_16_400(
                                  //    AppColors.darkText,
                                  //   fontFamily: AppFontFamily.gilroyRegular,
                                  //   decoration: TextDecoration.underline,
                                  // ),
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  final rxRequestStatus2 = Status.COMPLETED.obs;
  final verifyOtpData = SendOtpModal().obs;
  RxString error2 = ''.obs;

  void setRxRequestStatus2(Status value) => rxRequestStatus2.value = value;

  void setData2(SendOtpModal value) => verifyOtpData.value = value;

  final SignUpForm_editProfileController signUpForm_editProfileController =
      Get.put(SignUpForm_editProfileController());

  verifyOtpApi({
    required String email,
    required String otp,
  }) async {
    setRxRequestStatus2(Status.LOADING);
    var body = {
      "email": email,
      "otp": otp,
    };
    await api.verifyMailOtp(body).then((value) async {
      setData2(value);
      if (verifyOtpData.value.status == true) {
        setRxRequestStatus2(Status.COMPLETED);
        if(timer1.isActive){
          timer1.cancel();
        }
        debugPrint(remainingTime.value.toString());
        signUpForm_editProfileController.getprofileApi().then((value) async {
          Utils.showToast(verifyOtpData.value.message.toString());
          await Future.delayed(const Duration(milliseconds: 500));
          Get.back();
          setRxRequestStatus2(Status.COMPLETED);
          otpVerifyController.value.clear();
        });
      } else {
        Utils.showToast(verifyOtpData.value.message.toString());
        setRxRequestStatus2(Status.COMPLETED);
        otpVerifyController.value.clear();
      }
    }).onError((error, stackError) {
      print("Error: $error");
      setError2(error.toString());
      print(stackError);
      setRxRequestStatus2(Status.ERROR);
    });
  }

  void setError2(String value) => error.value = value;

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

  @override
  void dispose() {
    if(timer1.isActive){
      timer1.cancel();
    }
    super.dispose();
  }
}
