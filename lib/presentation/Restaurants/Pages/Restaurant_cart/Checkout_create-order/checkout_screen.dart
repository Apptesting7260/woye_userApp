import 'dart:math';

import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/Checkout_create-order/create_order_controller.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Delivery_address/view/delivery_address_screen.dart';
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
    var restaurantId = arguments['restaurant_id'] ?? '';
    var total = arguments['total'] ?? "";
    var cartId = arguments['cart_id'] ?? "";
    var regularPrice = arguments['regular_price'] ?? "";
    var saveAmount = arguments['save_amount'] ?? "";
    var deliveryCharge = arguments['delivery_charge'] ?? "";
    var couponDiscount = arguments['coupon_discount'] ?? "";
    print("Address ID: $addressId");
    print("Coupon ID: $couponId");
    print("Restaurant ID: $restaurantId");
    print("Total: $total");
    print("Cart ID: $cartId");
    print("Regular Price: $regularPrice");
    print("Save Amount: $saveAmount");
    print("Delivery Charge: $deliveryCharge");
    print("Coupon Discount: $couponDiscount");

    return Scaffold(
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
            paymentMethod(),
            hBox(30.h),
            paymentDetails(
              deliveryCharge: deliveryCharge,
              regularPrice: regularPrice,
              saveAmount: saveAmount,
              couponDiscount: couponDiscount,
              totalPrice: total,
            ),
            hBox(30.h),
            Obx(
              () => CustomElevatedButton(
                isLoading: (controller.rxRequestStatus.value == Status.LOADING),
                onPressed: () {
                  if (paymentMethodController.selectedIndex == 2) {
                    controller.placeOrderApi(
                      addressId: addressId,
                      cartId: cartId,
                      restaurantId: restaurantId,
                      couponId: couponId,
                      paymentMethod: "Cash On Delivery",
                      total: total,
                    );
                  } else {
                    Utils.showToast("Payment method not available");
                  }
                },
                text: "Place Order",
              ),
            ),
            hBox(50.h)
          ],
        ),
      ),
    );
  }

  // Widget deliveryAddress() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         "Delivery Address",
  //         style: AppFontStyle.text_22_600(AppColors.darkText),
  //       ),
  //       hBox(15.h),
  //       // DeliveryAddressScreen()
  //       // deliveryAddressScreen.addressList(),
  //       // hBox(15),
  //       // deliveryAddressScreen.addAddress(),
  //       // Container(
  //       //   padding: REdgeInsetsDirectional.all(15),
  //       //   height: 60.h,
  //       //   decoration: BoxDecoration(
  //       //       borderRadius: BorderRadius.circular(20.r),
  //       //       border: Border.all(color: AppColors.primary)),
  //       //   child: Row(
  //       //     children: [
  //       //       SvgPicture.asset("assets/svg/pin_location.svg"),
  //       //       wBox(10),
  //       //       Text(
  //       //         "Add Address",
  //       //         style: AppFontStyle.text_16_400(AppColors.primary),
  //       //       ),
  //       //       const Spacer(),
  //       //       Icon(Icons.arrow_forward_ios_sharp)
  //       //     ],
  //       //   ),
  //       // )
  //     ],
  //   );
  // }

  Widget paymentMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Method",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
        hBox(15.h),
        PaymentMethodScreen().methodList(),
        hBox(15.h),
        PaymentMethodScreen().addNewCard()
      ],
    );
  }

  Widget paymentDetails(
      {regularPrice, saveAmount, deliveryCharge, couponDiscount, totalPrice}) {
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
              totalPrice != ""
                  ? "\$$totalPrice"
                  : "\$${Random.secure().nextInt(100)}.00",
              style: AppFontStyle.text_22_600(AppColors.primary),
            ),
          ],
        ),
      ],
    );
  }
}
