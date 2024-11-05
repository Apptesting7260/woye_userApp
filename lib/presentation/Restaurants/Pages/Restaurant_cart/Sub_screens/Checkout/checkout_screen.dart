import 'dart:math';

import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_profile/Sub_screens/Delivery_address/view/delivery_address_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_profile/Sub_screens/Payment_method/View/payment_method_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});
  static DeliveryAddressScreen deliveryAddressScreen = DeliveryAddressScreen();
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
            CustomElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.oderConfirm);
              },
              text: "Place Order",
            ),
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
        deliveryAddressScreen.addAddress(),
        // Container(
        //   padding: REdgeInsetsDirectional.all(15),
        //   height: 60.h,
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(20.r),
        //       border: Border.all(color: AppColors.primary)),
        //   child: Row(
        //     children: [
        //       SvgPicture.asset("assets/svg/pin_location.svg"),
        //       wBox(10),
        //       Text(
        //         "Add Address",
        //         style: AppFontStyle.text_16_400(AppColors.primary),
        //       ),
        //       const Spacer(),
        //       Icon(Icons.arrow_forward_ios_sharp)
        //     ],
        //   ),
        // )
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
}
