import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:pay_with_paystack/model/payment_data.dart';
import 'package:pay_with_paystack/pay_with_paystack.dart';
import 'package:uuid/uuid.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/Controller/grocery_cart_controller.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/Controller/pharma_cart_controller.dart';
import 'package:woye_user/presentation/common/Checkout_create-order/create_order_controller.dart';

import '../Core/Utils/app_export.dart';

class PayStackController extends GetxController {
  final CreateOrderController controller = Get.put(CreateOrderController());
  final GroceryCartController groceryCartController = Get.put(GroceryCartController());
  final PharmacyCartController pharmacyCartController = Get.put(PharmacyCartController());


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
    required BuildContext context,required String email,
    required String addressId,required String couponId,required String total,
    required List<String> cartIds,required String cartType,required List<Map<String, dynamic>> carts,
    List<dynamic>? prescription,
  }) async {
    final uniqueTransRef = const Uuid().v4();

    debugPrint("userType>>>>> $cartType\n uniqueTransRef>>> $uniqueTransRef\n Amount>>>>>>>>> ${controller.walletSelected.value ? controller.newTotalWithoutIncludingTips.value.toStringAsFixed(2) : total} \n Email >>>>>>>>> $email");

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
          debugPrint("Transaction completed successfully.... ${paymentData.status} ${paymentData.amount} ${paymentData.message}");
          final fullResponse = jsonEncode(paymentData);
          debugPrint("📦 Full Paystack Response:\n$fullResponse");
          debugPrint("Transaction completed successfully.... $response");
          Utils.showToast("Transaction completed successfully");
          if(paymentData.status == 'success'){
            if(cartType == 'restaurant'){
          controller.createOrderRestaurant(
            referenceNo: uniqueTransRef,
            walletUsed: controller.walletSelected.value,
            walletAmount: controller.walletDiscount.value.toStringAsFixed(2),
            paymentMethod: controller.isSelectable.value == true
                ? "wallet" : controller.selectedIndex.value == 1 ? "credit_card" : controller.selectedIndex.value == 2
                ? "cash_on_delivery" : "",
            // paymentAmount: controller.payAfterWallet.value.toStringAsFixed(2),
            paymentAmount: controller.walletSelected.value ? controller.newTotalWithoutIncludingTips.value.toStringAsFixed(2) : total,
            addressId: addressId,
            couponId: couponId,
            total: total,
            cartIds: cartIds,
            type: cartType,
            carts: carts,
            deliveryNotes: controller.deliveryNotesController.value.text,
            deliverySoon:  controller.isDeliveryAsSoonAsPossible.value == true && controller.isDeliveryAsSoonAsPossiblePopUp.value == true ? "as soon as possible"
                : controller.isDeliveryAsSoonAsPossible.value == true && controller.pickedTimeVal.value != '' ? controller.pickedTimeVal.value : "",
            courierTip: controller.selectedTipsIndexValue.value == 0 ? "5" :
            controller.selectedTipsIndexValue.value == 1 ? "10" :
            controller.selectedTipsIndexValue.value == 2 ? "15" :
            controller.selectedTipsIndexValue.value == 3 ? controller.tipsController.value.text : "",
          );
          }
            else if(cartType == "grocery"){
              groceryCartController.createOrderGrocery(
                walletUsed: controller.walletSelected.value,
                walletAmount: controller.walletDiscount.value.toStringAsFixed(2),
                paymentMethod: controller.isSelectable.value == true
                    ? "wallet" : controller.selectedIndex.value == 1 ?
                "credit_card" : controller.selectedIndex.value == 2
                    ? "cash_on_delivery" : "",
                // paymentAmount: controller.payAfterWallet.value.toStringAsFixed(2),
                paymentAmount: controller.walletSelected.value ? controller.newTotalWithoutIncludingTips.value.toStringAsFixed(2) : total,
                addressId: addressId,
                couponId: couponId,
                total: total,
                cartIds: cartIds,
                type: cartType,
                carts: carts,
                deliveryNotes: controller.deliveryNotesController.value.text,
                deliverySoon:  controller.isDeliveryAsSoonAsPossible.value == true && controller.isDeliveryAsSoonAsPossiblePopUp.value == true ? "as soon as possible"
                    : controller.isDeliveryAsSoonAsPossible.value == true && controller.pickedTimeVal.value != '' ? controller.pickedTimeVal.value : "",
                courierTip: controller.selectedTipsIndexValue.value == 0 ? "5" :
                controller.selectedTipsIndexValue.value == 1 ? "10" :
                controller.selectedTipsIndexValue.value == 2 ? "15" :
                controller.selectedTipsIndexValue.value == 3 ? controller.tipsController.value.text : "",
              );
            }
            else if(cartType == "pharmacy"){
              pharmacyCartController.pharmacyCreateOrder(
                isWalletUsed: controller.walletSelected.value,
                walletAmount: controller.walletDiscount.value
                    .toStringAsFixed(2),
                paymentMethod: controller.isSelectable.value == true
                    ? "wallet"
                    : controller.selectedIndex.value == 1 ?
                "credit_card" : controller.selectedIndex.value == 2
                    ? "cash_on_delivery"
                    : "",
                paymentAmount: controller.walletSelected.value ? controller.newTotalWithoutIncludingTips.value.toStringAsFixed(2) : total,
                // paymentAmount: controller.payAfterWallet.value.toStringAsFixed(2),
                addressId: addressId.toString(),
                couponId: couponId.toString(),
                totalAmount: total.toString(),
                cartIds: cartIds,
                carts: carts,
                prescription: prescription ?? [],
                deliveryNotes: controller.deliveryNotesController.value.text,
                deliverySoon:  controller.isDeliveryAsSoonAsPossible.value == true && controller.isDeliveryAsSoonAsPossiblePopUp.value == true ? "as soon as possible"
                    : controller.isDeliveryAsSoonAsPossible.value == true && controller.pickedTimeVal.value != '' ? controller.pickedTimeVal.value : "",
                courierTip: controller.selectedTipsIndexValue.value == 0 ? "5" :
                controller.selectedTipsIndexValue.value == 1 ? "10" :
                controller.selectedTipsIndexValue.value == 2 ? "15" :
                controller.selectedTipsIndexValue.value == 3 ? controller.tipsController.value.text : "",
              );
            }
         }
        },
        transactionNotCompleted: (reason) {
          debugPrint("Transaction not completed..... $reason");
          Utils.showToast("Transaction not completed");
        },
      );
    }  on PlatformException catch (e) {
      debugPrint("❗ PayStack Error: $e");
      if(context.mounted) {
        showDialog(
        context: context,
        builder: (_) => AlertDialog(
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
    }
  }
}
