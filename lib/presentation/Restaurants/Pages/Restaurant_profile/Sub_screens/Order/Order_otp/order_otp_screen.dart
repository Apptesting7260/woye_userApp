import 'package:woye_user/core/utils/app_export.dart';

class OrderOtpScreen extends StatelessWidget {
  const OrderOtpScreen({super.key});

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
          children: [],
        ),
      ),
    );
  }

  Widget pin() {
    return Column(
      children: [
        Text(
          "Please Enter Your PIN",
          style: AppFontStyle.text_14_600(AppColors.darkText),
        ),
        Pinput(
          length: 4,
          defaultPinTheme: PinTheme(
          
          ),
        )
      ],
    );
  }
}
