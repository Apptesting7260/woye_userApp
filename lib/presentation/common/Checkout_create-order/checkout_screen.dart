import 'dart:io';
import 'dart:math';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/common/Checkout_create-order/create_order_controller.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Payment_method/Controller/payment_method_controller.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Payment_method/View/payment_method_screen.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key});

  // static DeliveryAddressScreen deliveryAddressScreen = DeliveryAddressScreen();

  // final PaymentMethodController paymentMethodController =
  //     Get.put(PaymentMethodController());

  final CreateOrderController controller = Get.put(CreateOrderController());

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments ?? {};
    var addressId = arguments['address_id'] ?? '';
    var couponId = arguments['coupon_id'] ?? '';
    var vendorId = arguments['vendor_id'] ?? '';
    var formattedTotal = arguments['total'] ?? "0.00";
    var total = double.tryParse(formattedTotal)?.toStringAsFixed(2) ?? "0.00";
    var cartId = arguments['cart_id'] ?? "";
    var regularPrice = arguments['regular_price'] ?? "";
    var saveAmount = arguments['save_amount'] ?? "";
    var deliveryCharge = arguments['delivery_charge'] ?? "";
    var couponDiscount = arguments['coupon_discount'] ?? "";
    var cartType = arguments['cartType'] ?? "";
    var walletBalance = arguments['wallet'] ?? "";
    var imagePath = arguments['imagePath'] ?? "";
    File? imageFile;

    if (imagePath is String && imagePath.isNotEmpty) {
      imageFile = File(imagePath); // Convert file path string to File
    } else if (imagePath is File) {
      imageFile = imagePath; // If it's already a File object
    }

    if (imageFile != null) {
      // Now you can use `imageFile` in your multipart request for image upload
      print("Image file path: ${imageFile.path}");
    } else {
      print("No image provided");
    }

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
    print("imageFile: $imagePath");

    controller.payAfterWallet.value = double.parse(total.toString());

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
                    if (controller.isSelectable.value == true) {
                      controller.placeOrderApi(
                          addressId: addressId,
                          cartId: cartId,
                          vendorId: vendorId,
                          couponId: couponId,
                          paymentMethod: "wallet",
                          total: total,
                          cartType: cartType,
                          imageFile: imageFile);
                    } else if (controller.selectedIndex.value == 0) {
                      controller.placeOrderApi(
                          addressId: addressId,
                          cartId: cartId,
                          vendorId: vendorId,
                          couponId: couponId,
                          paymentMethod: "credit_card",
                          total: total,
                          cartType: cartType,
                          imageFile: imageFile);
                    } else if (controller.selectedIndex.value == 1) {
                      controller.placeOrderApi(
                          addressId: addressId,
                          cartId: cartId,
                          vendorId: vendorId,
                          couponId: couponId,
                          paymentMethod: "cash_on_delivery",
                          total: total,
                          cartType: cartType,
                          imageFile: imageFile);
                    } else {
                      Utils.showToast("Payment method not available");
                    }
                  },
                  text: controller.isSelectable.value == true
                      ? "Place Order"
                      : controller.selectedIndex.value == 1
                          ? controller.walletSelected.value == false
                              ? "\$$total Order with COD"
                              : "\$${controller.payAfterWallet.value.toStringAsFixed(2)} Order with COD"
                          : controller.selectedIndex.value == 0
                              ? controller.walletSelected.value == false
                                  ? "\$$total Pay with Card"
                                  : "\$${controller.payAfterWallet.value.toStringAsFixed(2)} Pay with Card"
                              : "Place Order",
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
          double walletBalanceDouble = double.tryParse(walletBalance) ?? 0.0;
          double totalPriceDouble = double.tryParse(totalPrice) ?? 0.0;

          controller.walletSelected.value = !controller.walletSelected.value;
          if (!controller.walletSelected.value) {
            controller.isSelectable.value = false;
          }

          if (controller.walletSelected.value) {
            if (walletBalanceDouble >= totalPriceDouble) {
              controller.payAfterWallet.value = 0.00;
              controller.walletDiscount.value = totalPriceDouble;
              controller.isSelectable.value = true;
            } else {
              controller.payAfterWallet.value =
                  totalPriceDouble - walletBalanceDouble;
              controller.walletDiscount.value = walletBalanceDouble;
            }
          } else {
            controller.payAfterWallet.value = totalPriceDouble;
            controller.walletDiscount.value = 0.00;
          }
          // controller.payAfterWallet.value =
          //     double.tryParse(controller.payAfterWallet.value.toStringAsFixed(2))!;
          // controller.walletDiscount.value =
          //     double.tryParse(controller.walletDiscount.value.toStringAsFixed(2))!;

          print(
              "Updated payAfterWallet: ${controller.payAfterWallet.value.toStringAsFixed(2)}");
          print(
              "Wallet discount: ${controller.walletDiscount.value.toStringAsFixed(2)}");
        },
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
        methodList(),
        hBox(15.h),
        PaymentMethodScreen().addNewCard()
      ],
    );
  }

  Widget methodList() {
    return GetBuilder(
      init: controller,
      builder: (controller) {
        return Obx(
          () => IgnorePointer(
            ignoring: controller.isSelectable.value ? true : false,
            child: Opacity(
              opacity: controller.isSelectable.value ? 0.3 : 1,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context, index) {
                  bool isSelected = controller.selectedIndex.value == index;
                  if (index == 0) {
                    return InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        controller.selectedIndex.value = index;
                        controller.update();
                      },
                      child: Container(
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.lightPrimary)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 9,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      "assets/svg/master-card.svg"),
                                  wBox(10.h),
                                  Text(
                                    "•••• •••• ••••",
                                    style: AppFontStyle.text_16_400(
                                        AppColors.darkText,
                                        height: 1.h),
                                  ),
                                  Text(
                                    "8888",
                                    style: AppFontStyle.text_16_400(
                                        AppColors.darkText),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                            wBox(6.h),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.only(top: 5.r),
                                height: 20.h,
                                width: 20.h,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(color: AppColors.primary)),
                                child: isSelected
                                    ? SvgPicture.asset(
                                        "assets/svg/green-check-circle.svg")
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        controller.selectedIndex.value = index;
                        controller.update();
                      },
                      child: Container(
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(
                                color: isSelected
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
                                  // SvgPicture.asset("assets/svg/cod-icon.svg"),
                                  Text(
                                    "Cash On Delivery",
                                    style: AppFontStyle.text_16_400(
                                        AppColors.darkText),
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
                                    border:
                                        Border.all(color: AppColors.primary)),
                                child: isSelected
                                    ? SvgPicture.asset(
                                        "assets/svg/green-check-circle.svg")
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
                separatorBuilder: (c, i) => hBox(15.h),
              ),
            ),
          ),
        );
      },
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
            Text(
              totalPrice.toString(),
              style: AppFontStyle.text_22_600(AppColors.primary),
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
