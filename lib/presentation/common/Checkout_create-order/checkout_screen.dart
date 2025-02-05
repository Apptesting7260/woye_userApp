import 'dart:math';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/common/Checkout_create-order/create_order_controller.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Payment_method/Controller/payment_method_controller.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Payment_method/View/payment_method_screen.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key});

  // static DeliveryAddressScreen deliveryAddressScreen = DeliveryAddressScreen();

  final PaymentMethodController paymentMethodController =
      Get.put(PaymentMethodController());

  final CreateOrderController controller = Get.put(CreateOrderController());

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments ?? {};
    var addressId = arguments['address_id'] ?? '';
    var couponId = arguments['coupon_id'] ?? '';
    var vendorId = arguments['vendor_id'] ?? '';
    var total = arguments['total'] ?? "";
    var cartId = arguments['cart_id'] ?? "";
    var regularPrice = arguments['regular_price'] ?? "";
    var saveAmount = arguments['save_amount'] ?? "";
    var deliveryCharge = arguments['delivery_charge'] ?? "";
    var couponDiscount = arguments['coupon_discount'] ?? "";
    var cartType = arguments['cartType'] ?? "";
    var walletBalance = arguments['wallet'] ?? "";
    print("Address ID: $addressId");
    print("Coupon ID: $couponId");
    print("Vendor Id: $vendorId");
    print("Total: $total");
    print("Cart ID: $cartId");
    print("Regular Price: $regularPrice");
    print("Save Amount: $saveAmount");
    print("Delivery Charge: $deliveryCharge");
    print("Coupon Discount: $couponDiscount");
    print("wallet: $walletBalance");

    controller.totalPrice.value = int.parse(total);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          isLeading: true,
          title: Text(
            "Checkout",
            style: AppFontStyle.text_24_600(AppColors.darkText),
          ),
        ),
        body: SingleChildScrollView(
          padding: REdgeInsets.symmetric(horizontal: 24.h),
          child: Column(
            children: [
              paymentMethod(walletBalance: walletBalance, totalPrice: total),
              hBox(30.h),
              paymentDetails(
                deliveryCharge: deliveryCharge,
                regularPrice: regularPrice,
                saveAmount: saveAmount,
                couponDiscount: couponDiscount,
                totalPrice: total,
                walletBalance: walletBalance,
              ),
              hBox(30.h),
              Obx(
                () => CustomElevatedButton(
                  isLoading:
                      (controller.rxRequestStatus.value == Status.LOADING),
                  onPressed: () {
                    // if (paymentMethodController.selectedIndex == 2) {
                      controller.placeOrderApi(
                        addressId: addressId,
                        cartId: cartId,
                        vendorId: vendorId,
                        couponId: couponId,
                        paymentMethod: "cash_on_delivery",
                        total: total,
                        cartType: cartType,
                      );
                    // } else {
                    //   Utils.showToast("Payment method not available");
                    // }
                  },
                  text: "Place Order",
                ),
              ),
              hBox(50.h)
            ],
          ),
        ),
      ),
    );
  }

  Widget wallet({required String walletBalance, required String totalPrice}) {
    return Obx(
      () => InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          // Convert walletBalance and totalPrice to integers
          int walletBalanceInt =
              int.tryParse(walletBalance) ?? 0; // Default to 0 if parsing fails
          int totalPriceInt =
              int.tryParse(totalPrice) ?? 0; // Default to 0 if parsing fails

          // Toggle the wallet selection state
          controller.walletSelected.value = !controller.walletSelected.value;

          // Update the totalPrice and walletDiscount based on the wallet selection
          if (controller.walletSelected.value) {
            // If wallet is selected, deduct the wallet balance from totalPrice
            if (walletBalanceInt >= totalPriceInt) {
              controller.totalPrice.value =
                  0; // Total price becomes 0 if wallet balance is sufficient
              controller.walletDiscount.value =
                  totalPriceInt; // Full price is covered by wallet
            } else {
              controller.totalPrice.value = totalPriceInt -
                  walletBalanceInt; // Subtract wallet balance from total price
              controller.walletDiscount.value =
                  walletBalanceInt; // Wallet discount is the balance used
            }
          } else {
            // If wallet is deselected, restore the original totalPrice and reset the wallet discount
            controller.totalPrice.value = totalPriceInt;
            controller.walletDiscount.value =
                0; // Reset the wallet discount when deselected
          }

          // Print the updated totalPrice and walletDiscount for debugging
          print("Updated totalPrice: ${controller.totalPrice.value}");
          print("Wallet discount: ${controller.walletDiscount.value}");
        },
        // onTap: () {
        //   // Convert walletBalance and totalPrice to integers
        //
        //   int walletBalanceInt =
        //       int.tryParse(walletBalance) ?? 0; // Default to 0 if parsing fails
        //   int totalPriceInt =
        //       int.tryParse(totalPrice) ?? 0; // Default to 0 if parsing fails
        //
        //   // Toggle the wallet selection state
        //   controller.walletSelected.value = !controller.walletSelected.value;
        //
        //   // Update the totalPrice based on the wallet selection
        //   if (controller.walletSelected.value) {
        //     // If wallet is selected, deduct the wallet balance from totalPrice
        //     if (walletBalanceInt >= totalPriceInt) {
        //       controller.totalPrice.value =
        //           0; // Total price becomes 0 if wallet balance is sufficient
        //     } else {
        //       controller.totalPrice.value = totalPriceInt -
        //           walletBalanceInt; // Subtract wallet balance from total price
        //     }
        //   } else {
        //     // If wallet is deselected, restore the original totalPrice
        //     controller.totalPrice.value = totalPriceInt;
        //   }
        //
        //   // Print the updated totalPrice for debugging
        //   print("Updated totalPrice: ${controller.totalPrice.value}");
        // },
        child: Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(
                  color: controller.walletSelected.value
                      ? AppColors.primary
                      : AppColors.lightPrimary)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 9,
                child: Row(
                  children: [
                    SvgPicture.asset("assets/svg/wallet.svg"),
                    wBox(10),
                    Text(
                      "My Wallet (\$$walletBalance)",
                      style: AppFontStyle.text_16_400(AppColors.darkText),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              wBox(6),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(top: 5.r),
                  height: 20.h,
                  width: 20.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary)),
                  child: controller.walletSelected.value
                      ? SvgPicture.asset("assets/svg/green-check-circle.svg")
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget paymentMethod({walletBalance, totalPrice}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Method",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
        hBox(15.h),
        wallet(walletBalance: walletBalance, totalPrice: totalPrice),
        hBox(15.h),
        PaymentMethodScreen().methodList(),
        hBox(15.h),
        PaymentMethodScreen().addNewCard()
      ],
    );
  }

  Widget paymentDetails({
    regularPrice,
    saveAmount,
    deliveryCharge,
    couponDiscount,
    totalPrice,
    walletBalance,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Details",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
        hBox(20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Regular Price",
              style: AppFontStyle.text_14_400(AppColors.lightText),
            ),
            Text(
              regularPrice != ""
                  ? "\$$regularPrice"
                  : "\$${Random.secure().nextInt(100)}.00",
              style: AppFontStyle.text_14_600(AppColors.darkText),
            ),
          ],
        ),
        hBox(10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Save Amount",
              style: AppFontStyle.text_14_400(AppColors.lightText),
            ),
            Text(
              saveAmount != ""
                  ? "\$$saveAmount"
                  : "\$${Random.secure().nextInt(20)}.00",
              style: AppFontStyle.text_14_600(AppColors.darkText),
            ),
          ],
        ),
        hBox(couponDiscount != "0" ? 10.h : 0.h),
        couponDiscount != "0"
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Coupon Discount",
                    style: AppFontStyle.text_14_400(AppColors.lightText),
                  ),
                  Text(
                    couponDiscount != ""
                        ? "-\$$couponDiscount"
                        : "-\$${Random.secure().nextInt(20)}.00",
                    style: AppFontStyle.text_14_600(AppColors.darkText),
                  ),
                ],
              )
            : SizedBox(
                height: 0.h,
              ),
        hBox(10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Delivery Charge",
              style: AppFontStyle.text_14_400(AppColors.lightText),
            ),
            Text(
              deliveryCharge != ""
                  ? "\$$deliveryCharge"
                  : "\$${Random.secure().nextInt(20)}.00",
              style: AppFontStyle.text_14_600(AppColors.darkText),
            ),
          ],
        ),
        hBox(20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total Price",
              style: AppFontStyle.text_22_600(AppColors.darkText),
            ),
            Obx(
              () => Text(
                controller.totalPrice.value.toString(),
                style: AppFontStyle.text_22_600(AppColors.primary),
              ),
            ),
          ],
        ),
      ],
    );
  }

// Widget paymentDetails(
//     {regularPrice,
//     saveAmount,
//     deliveryCharge,
//     couponDiscount,
//     totalPrice,
//     walletBalance}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         "Payment Details",
//         style: AppFontStyle.text_22_600(AppColors.darkText),
//       ),
//       hBox(20.h),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             "Regular Price",
//             style: AppFontStyle.text_14_400(AppColors.lightText),
//           ),
//           Text(
//             regularPrice != ""
//                 ? "\$$regularPrice"
//                 : "\$${Random.secure().nextInt(100)}.00",
//             style: AppFontStyle.text_14_600(AppColors.darkText),
//           ),
//         ],
//       ),
//       hBox(10.h),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             "Save Amount",
//             style: AppFontStyle.text_14_400(AppColors.lightText),
//           ),
//           Text(
//             saveAmount != ""
//                 ? "\$$saveAmount"
//                 : "\$${Random.secure().nextInt(20)}.00",
//             style: AppFontStyle.text_14_600(AppColors.darkText),
//           ),
//         ],
//       ),
//       hBox(couponDiscount != "0" ? 10.h : 0.h),
//       couponDiscount != "0"
//           ? Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Coupon Discount",
//                   style: AppFontStyle.text_14_400(AppColors.lightText),
//                 ),
//                 Text(
//                   couponDiscount != ""
//                       ? "-\$$couponDiscount"
//                       : "-\$${Random.secure().nextInt(20)}.00",
//                   style: AppFontStyle.text_14_600(AppColors.darkText),
//                 ),
//               ],
//             )
//           : SizedBox(
//               height: 0.h,
//             ),
//       hBox(10.h),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             "Delivery Charge",
//             style: AppFontStyle.text_14_400(AppColors.lightText),
//           ),
//           Text(
//             deliveryCharge != ""
//                 ? "\$$deliveryCharge"
//                 : "\$${Random.secure().nextInt(20)}.00",
//             style: AppFontStyle.text_14_600(AppColors.darkText),
//           ),
//         ],
//       ),
//       hBox(20.h),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             "Total Price",
//             style: AppFontStyle.text_22_600(AppColors.darkText),
//           ),
//           Text(
//             totalPrice != ""
//                 ? "\$$totalPrice"
//                 : "\$${Random.secure().nextInt(100)}.00",
//             style: AppFontStyle.text_22_600(AppColors.primary),
//           ),
//         ],
//       ),
//     ],
//   );
// }
}
