import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/Sub_screens/Order_otp/order_otp_controller.dart';

class OrderOtpScreen extends StatelessWidget {
  const OrderOtpScreen({super.key});

  static final OrderOtpController orderOtpController =
      Get.put(OrderOtpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Enter PIN",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [hBox(50), pin(), hBox(30), continueButton()],
        ),
      ),
    );
  }

  Widget pin() {
    return Column(
      children: [
        Text(
          "Please Enter Your PIN",
          style: AppFontStyle.text_16_600(AppColors.darkText),
        ),
        hBox(20),
        Pinput(
          obscureText: true,
          key: orderOtpController.orderOtpFormKey,
          controller: orderOtpController.otpTextController,
          length: 4,
          defaultPinTheme: PinTheme(
              height: 60.h,
              width: 56.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(color: AppColors.textFieldBorder))),
          focusedPinTheme: PinTheme(
              height: 60.h,
              width: 56.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(color: AppColors.darkText))),
        )
      ],
    );
  }

  Widget continueButton() {
    return CustomElevatedButton(
      onPressed: () {
        Get.toNamed(AppRoutes.oderConfirm);
      },
      text: "Continue",
    );
  }
}
