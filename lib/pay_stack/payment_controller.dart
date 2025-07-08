import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:pay_with_paystack/model/payment_data.dart';
import 'package:pay_with_paystack/pay_with_paystack.dart';
import 'package:uuid/uuid.dart';
import 'package:woye_user/Shared/theme/font_family.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/Controller/grocery_cart_controller.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/Controller/pharma_cart_controller.dart';
import 'package:woye_user/presentation/common/Checkout_create-order/create_order_controller.dart';

import '../Core/Utils/app_export.dart';

class PayStackController extends GetxController {
  final CreateOrderController controller = Get.put(CreateOrderController());
  final GroceryCartController groceryCartController = Get.put(
      GroceryCartController());
  final PharmacyCartController pharmacyCartController = Get.put(
      PharmacyCartController());


  String secretKey = "";
  String publicKey = "";

  @override
  void onInit() {
    secretKey = dotenv.env['secretKeyTest'] ?? "";
    // secretKey = dotenv.env['secretKeyTest1'] ?? "";
    publicKey = dotenv.env['publicKeyTest'] ?? "";
    debugPrint("🔐 Loaded Paystack Key: $secretKey");
    super.onInit();
  }

  final _payStack = PayWithPayStack();
  var response;

  makePayment({
    required BuildContext context, required String email,
    required String addressId, required String couponId, required String total,
    required List<String> cartIds, required String cartType, required List<
        Map<String, dynamic>> carts,
    List<dynamic>? prescription,
  }) async {

    debugPrint(
        "userType>>>>> $cartType \n Amount>>>>>>>>> ${controller
            .walletSelected.value ? controller.newTotalWithoutIncludingTips
            .value.toStringAsFixed(2) : total} \n Email >>>>>>>>> $email");

    final amount = controller.walletSelected.value
        ? controller.newTotalWithoutIncludingTips.value
        : double.tryParse(total) ?? 0;

    const maxAmount = 100000000; // in kobo (100000000 kobo = 1,000,000 GHS)

    if (amount > maxAmount) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Center(
              child: Text("Payment Error",
                style: AppFontStyle.text_18_400(AppColors.black,family: AppFontFamily.gilroyMedium),
              ),
            ),
            content: Text("The payment amount exceeds the maximum ($maxAmount) allowed limit.",
              style: AppFontStyle.text_15_400(AppColors.black,family: AppFontFamily.gilroyRegular),
              maxLines: 5,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK",
                  style: AppFontStyle.text_18_400(AppColors.black,family: AppFontFamily.gilroyMedium),
                ),
              ),
            ],
          ),
        );
      }
      return;
    }
    if (amount <= 0) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Center(
              child: Text("Payment Error",
                style: AppFontStyle.text_18_400(AppColors.black,family: AppFontFamily.gilroyMedium),
              ),
            ),
            content: Text("The payment amount must be greater then 0",
              style: AppFontStyle.text_15_400(AppColors.black,family: AppFontFamily.gilroyRegular),
              maxLines: 5,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK",
                  style: AppFontStyle.text_18_400(AppColors.black,family: AppFontFamily.gilroyMedium),
                ),
              ),
            ],
          ),
        );
      }
      return;
    }


    final uniqueTransRef = const Uuid().v4();

    debugPrint("userType>>>>> $cartType\n uniqueTransRef>>> $uniqueTransRef\n Amount>>>>>>>>> ${controller
            .walletSelected.value ? controller.newTotalWithoutIncludingTips
            .value.toStringAsFixed(2) : total} \n Email >>>>>>>>> $email");

    try {
      response = await _payStack.now(
        context: context,
        secretKey: secretKey,
        customerEmail: email,
        reference: uniqueTransRef,
        currency: "GHS",
        paymentChannel: ['card'],
        amount: controller.walletSelected.value
            ? controller.newTotalWithoutIncludingTips.value.ceilToDouble()
            : double.parse(total).ceilToDouble(),
        callbackUrl: "https://google.com",
        transactionCompleted: (paymentData) {
          debugPrint("Transaction completed successfully.... ${paymentData
              .status} ${paymentData.amount} ${paymentData.message}");
          final fullResponse = jsonEncode(paymentData);
          debugPrint("📦 Full Paystack Response:\n$fullResponse");
          debugPrint("Transaction completed successfully.... $response");
          Utils.showToast("Transaction completed successfully");
          if (paymentData.status == 'success') {
            if (cartType == 'restaurant') {
              controller.createOrderRestaurant(
                referenceId: paymentData.reference.toString(),
                transactionId: paymentData.id.toString(),
                walletUsed: controller.walletSelected.value,
                walletAmount: controller.walletDiscount.value.toStringAsFixed(
                    2),
                paymentMethod: controller.isSelectable.value == true
                    ? "wallet" : controller.selectedIndex.value == 1
                    ? "credit_card"
                    : controller.selectedIndex.value == 2
                    ? "cash_on_delivery" : "",
                // paymentAmount: controller.walletSelected.value
                //     ? controller.newTotalWithoutIncludingTips.value
                //     .toStringAsFixed(2)
                //     : total,
                paymentAmount: controller.walletSelected.value ? controller.newTotalWithoutIncludingTips.value.toStringAsFixed(2) : total,
                addressId: addressId,
                couponId: couponId,
                total: total,
                cartIds: cartIds,
                type: cartType,
                carts: carts,
                deliveryNotes: controller.deliveryNotesController.value.text,
                deliverySoon: controller.isDeliveryAsSoonAsPossible.value ==
                    true &&
                    controller.isDeliveryAsSoonAsPossiblePopUp.value == true
                    ? "as soon as possible"
                    : controller.isDeliveryAsSoonAsPossible.value == true &&
                    controller.pickedTimeVal.value != '' ? controller
                    .pickedTimeVal.value : "",
                courierTip: controller.selectedTipsIndexValue.value == 0 ? "5" :
                controller.selectedTipsIndexValue.value == 1 ? "10" :
                controller.selectedTipsIndexValue.value == 2 ? "15" :
                controller.selectedTipsIndexValue.value == 3 ? controller
                    .tipsController.value.text : "",
              );
            }
            else if (cartType == "grocery") {
              groceryCartController.createOrderGrocery(
                referenceId: paymentData.reference.toString(),
                transactionId: paymentData.id.toString(),
                walletUsed: controller.walletSelected.value,
                walletAmount: controller.walletDiscount.value.toStringAsFixed(
                    2),
                paymentMethod: controller.isSelectable.value == true
                    ? "wallet" : controller.selectedIndex.value == 1 ?
                "credit_card" : controller.selectedIndex.value == 2
                    ? "cash_on_delivery" : "",
                // paymentAmount: controller.payAfterWallet.value.toStringAsFixed(2),
                paymentAmount: controller.walletSelected.value
                    ? controller.newTotalWithoutIncludingTips.value
                    .toStringAsFixed(2)
                    : total,
                addressId: addressId,
                couponId: couponId,
                total: total,
                cartIds: cartIds,
                type: cartType,
                carts: carts,
                deliveryNotes: controller.deliveryNotesController.value.text,
                deliverySoon: controller.isDeliveryAsSoonAsPossible.value ==
                    true &&
                    controller.isDeliveryAsSoonAsPossiblePopUp.value == true
                    ? "as soon as possible"
                    : controller.isDeliveryAsSoonAsPossible.value == true &&
                    controller.pickedTimeVal.value != '' ? controller
                    .pickedTimeVal.value : "",
                courierTip: controller.selectedTipsIndexValue.value == 0 ? "5" :
                controller.selectedTipsIndexValue.value == 1 ? "10" :
                controller.selectedTipsIndexValue.value == 2 ? "15" :
                controller.selectedTipsIndexValue.value == 3 ? controller
                    .tipsController.value.text : "",
              );
            }
            else if (cartType == "pharmacy") {
              pharmacyCartController.pharmacyCreateOrder(
                transactionId: paymentData.id.toString(),
                referenceId: paymentData.reference.toString(),
                isWalletUsed: controller.walletSelected.value,
                walletAmount: controller.walletDiscount.value
                    .toStringAsFixed(2),
                paymentMethod: controller.isSelectable.value == true
                    ? "wallet"
                    : controller.selectedIndex.value == 1 ?
                "credit_card" : controller.selectedIndex.value == 2
                    ? "cash_on_delivery"
                    : "",
                paymentAmount: controller.walletSelected.value
                    ? controller.newTotalWithoutIncludingTips.value
                    .toStringAsFixed(2)
                    : total,
                // paymentAmount: controller.payAfterWallet.value.toStringAsFixed(2),
                addressId: addressId.toString(),
                couponId: couponId.toString(),
                totalAmount: total.toString(),
                cartIds: cartIds,
                carts: carts,
                prescription: prescription ?? [],
                deliveryNotes: controller.deliveryNotesController.value.text,
                deliverySoon: controller.isDeliveryAsSoonAsPossible.value ==
                    true &&
                    controller.isDeliveryAsSoonAsPossiblePopUp.value == true
                    ? "as soon as possible"
                    : controller.isDeliveryAsSoonAsPossible.value == true &&
                    controller.pickedTimeVal.value != '' ? controller
                    .pickedTimeVal.value : "",
                courierTip: controller.selectedTipsIndexValue.value == 0 ? "5" :
                controller.selectedTipsIndexValue.value == 1 ? "10" :
                controller.selectedTipsIndexValue.value == 2 ? "15" :
                controller.selectedTipsIndexValue.value == 3 ? controller
                    .tipsController.value.text : "",
              );
            }
          }
        },
        transactionNotCompleted: (reason) {
          debugPrint("Transaction not completed..... $reason");
          Utils.showToast("Transaction not completed");
        },

      );
    }  on FormatException {
      Utils.showToast("Invalid amount format. Please enter a valid number.");
    }on PlatformException catch (e) {
      debugPrint("❗ PayStack Error: $e");
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(
                title: const Text("Payment Error"),
                content: Text(e.toString()),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("OK"),
                  ),
                ],
              ),
        );
      }
    } catch (e) {
      // Catch any other unexpected errors
      debugPrint("❗ Unexpected Error: $e");
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(
                title: const Text("Payment Error"),
                content: const Text(
                    "An unexpected error occurred during payment processing."),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("OK"),
                  ),
                ],
              ),
        );
      }
    }
  }
}