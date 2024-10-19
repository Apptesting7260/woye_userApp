import 'package:woye_user/core/app_export.dart';
import 'package:woye_user/presentation/common/otp_verification/otp_verification_controller.dart';

class OtpVerificaitonScreen extends StatefulWidget {
  const OtpVerificaitonScreen({super.key});

  @override
  State<OtpVerificaitonScreen> createState() => _OtpVerificaitonScreenState();
}

class _OtpVerificaitonScreenState extends State<OtpVerificaitonScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpVerificationController>(
        init: OtpVerificationController(),
        builder: (otpVerificationController) {
          return Scaffold();
        });
  }
}
