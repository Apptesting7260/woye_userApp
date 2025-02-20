import 'dart:math';

import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Delivery_address/view/delivery_address_screen.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Payment_method/View/payment_method_screen.dart';

class PharmacyCheckoutScreen extends StatelessWidget {
  PharmacyCheckoutScreen({super.key});

  final DeliveryAddressScreen deliveryAddressScreen = DeliveryAddressScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Checkout",
          style: AppFontStyle.text_24_600(AppColors.darkText),
        ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            deliveryAddress(),
            hBox(30),
            paymentMethod(),
            hBox(30),
            paymentDetails(),
            hBox(30),
            orderButton(),
            hBox(50)
          ],
        ),
      ),
    );
  }

  Widget deliveryAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Delivery Address",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
        hBox(15),
        // DeliveryAddressScreen()
        deliveryAddressScreen.addressList(),
        hBox(15),
        // deliveryAddressScreen.addAddress(),
      ],
    );
  }

  Widget paymentMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Method",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
        hBox(15),
         PaymentMethodScreen().methodList(),
        hBox(15),
         PaymentMethodScreen().addNewCard()
      ],
    );
  }

  Widget paymentDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Details",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
        hBox(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Regular Price",
              style: AppFontStyle.text_14_400(AppColors.lightText),
            ),
            Text(
              "\$${Random.secure().nextInt(50) + 10}.00",
              style: AppFontStyle.text_14_600(AppColors.darkText),
            ),
          ],
        ),
        hBox(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Save Amount",
              style: AppFontStyle.text_14_400(AppColors.lightText),
            ),
            Text(
              "\$${Random.secure().nextInt(20)}.00",
              style: AppFontStyle.text_14_600(AppColors.darkText),
            ),
          ],
        ),
        hBox(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Discount",
              style: AppFontStyle.text_14_400(AppColors.lightText),
            ),
            Text(
              "\$${Random.secure().nextInt(20)}.00",
              style: AppFontStyle.text_14_600(AppColors.darkText),
            ),
          ],
        ),
        hBox(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Delivery Charge",
              style: AppFontStyle.text_14_400(AppColors.lightText),
            ),
            Text(
              "\$${Random.secure().nextInt(20)}.00",
              style: AppFontStyle.text_14_600(AppColors.darkText),
            ),
          ],
        ),
        hBox(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total Price",
              style: AppFontStyle.text_22_600(AppColors.darkText),
            ),
            Text(
              "\$${Random.secure().nextInt(100)}.00",
              style: AppFontStyle.text_22_600(AppColors.primary),
            ),
          ],
        ),
      ],
    );
  }

  Widget orderButton() {
    return CustomElevatedButton(
      onPressed: () {
        Get.toNamed(AppRoutes.orderOtp);
      },
      text: "Place Order",
    );
  }
}
