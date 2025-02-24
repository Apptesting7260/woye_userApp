import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/common/email_verify/send_otp/send_otp_modal.dart';

class SendOtpEmailController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final sendOtpData = SendOtpModal().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setData(SendOtpModal value) => sendOtpData.value = value;

  sendOtpApi({required String email}) async {
    setRxRequestStatus(Status.LOADING);
    var body = {
      "email": email,
    };
    api.sendVerificationOtp(body).then((value) {
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

  void setError(String value) => error.value = value;
  final Rx<TextEditingController> otpVerifyController =
      TextEditingController().obs;

  Future showOtpVerificationRequired(email) {
    return Get.dialog(
      barrierDismissible: false,
      PopScope(
        canPop: false,
        child: AlertDialog(
          content: Container(
            height: 250.h,
            width: 320.w,
            padding: REdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'OTP Verification',
                  style: AppFontStyle.text_18_600(AppColors.darkText),
                ),
                Text(
                  "Please enter the verification code sent to '$email'",
                  maxLines: 5,
                  style: AppFontStyle.text_14_400(AppColors.lightText),
                ),
                Pinput(
                  length: 4,
                  controller: otpVerifyController.value,
                  // defaultPinTheme: otpController.defaultPinTheme,
                  // focusedPinTheme: otpController.focusedPinTheme,
                  // submittedPinTheme: otpController.submittedPinTheme,
                ),

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
                      verifyOtpApi(
                        otp: otpVerifyController.value.text.trim(),
                        email: email,
                      );
                    },
                    text: "Verify",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  final rxRequestStatus2 = Status.COMPLETED.obs;
  final verifyOtpData = SendOtpModal().obs;
  RxString error2 = ''.obs;

  void setRxRequestStatus2(Status value) => rxRequestStatus2.value = value;

  void setData2(SendOtpModal value) => verifyOtpData.value = value;

  verifyOtpApi({
    required String email,
    required String otp,
  }) async {
    setRxRequestStatus2(Status.LOADING);
    var body = {
      "email": email,
      "otp": otp,
    };
    api.verifyMailOtp(body).then((value) {
      setData2(value);
      if (verifyOtpData.value.status == true) {
        setRxRequestStatus2(Status.COMPLETED);
        api.getprofileApi().then((value) async {
          Utils.showToast(verifyOtpData.value.message.toString());
          await Future.delayed(const Duration(milliseconds: 500));
          setRxRequestStatus2(Status.COMPLETED);
          Get.back();
        });
      } else {
        Utils.showToast(verifyOtpData.value.message.toString());
        setRxRequestStatus2(Status.COMPLETED);
      }
    }).onError((error, stackError) {
      print("Error: $error");
      setError2(error.toString());
      print(stackError);
      setRxRequestStatus2(Status.ERROR);
    });
  }

  void setError2(String value) => error.value = value;
}
