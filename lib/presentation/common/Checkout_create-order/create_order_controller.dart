import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:woye_user/Core/Constant/app_urls.dart';
import 'package:woye_user/Core/Utils/snackbar.dart';
import 'package:woye_user/Data/Model/usermodel.dart';
import 'package:woye_user/Data/Repository/repository.dart';
import 'package:woye_user/Data/response/status.dart';
import 'package:woye_user/Data/userPrefrenceController.dart';
import 'package:woye_user/Routes/app_routes.dart';
import 'package:woye_user/presentation/common/Checkout_create-order/create_order_modal.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';

import '../../Pharmacy/Pages/Pharmacy_cart/prescription/prescription_controller.dart';

class CreateOrderController extends GetxController {

  Rx<TextEditingController> tipsController = Rx(TextEditingController());
  Rx<TextEditingController> deliveryNotesController = Rx(TextEditingController());
  GlobalKey<FormState> deliveryNotesKey = GlobalKey<FormState>();
  GlobalKey<FormState> tipsKey = GlobalKey<FormState>();
  RxBool isDeliveryNotes = false.obs;
  RxBool isDeliveryAsSoonAsPossible = false.obs;
  RxString enteredTips = "".obs;
  RxDouble totalPriceIncludingTips = 0.00.obs;
  RxString totalPayAmount = "0".obs;
  RxDouble newPayAfterWallet = 0.00.obs;

  @override
  void onInit() {
    selectedTipsIndexValue.value = -1;
    walletSelected.value = false;
    isSelectable.value = false;
    super.onInit();
  }

  @override
  void onClose() {
    walletSelected.value = false;
    isSelectable.value = false;
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void dispose() {
    walletSelected.value = false;
    isSelectable.value = false;
    // TODO: implement dispose
    super.dispose();
  }

  RxInt selectedTipsIndexValue = 0.obs;
  RxList<String> priceList = ["5","10","15","Others"].obs;

  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final createOrderData = CreateOrder().obs;
  RxInt selectedIndex = 0.obs;
  RxString error = ''.obs;
  var payAfterWallet = (0.0).obs;
  var walletDiscount = (0.0).obs;
  RxBool walletSelected = false.obs;
  var isSelectable = false.obs;
  UserModel userModel = UserModel();
  var pref = UserPreference();
  var userToken = "";



  Future<void> initializeUser() async {
    userModel = await pref.getUser();
    userToken = userModel.token!;
    print("initializeUser: Bearer $userToken");
  }

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setCreateOrderData(CreateOrder value) => createOrderData.value = value;

  placeOrderApi({
    required String paymentMethod,
    required String addressId,
    required String couponId,
    required String vendorId,
    required String total,
    required String cartId,
    required String cartType,
    required List<File?> imageFiles,
  }) async {
    await initializeUser();
    setRxRequestStatus(Status.LOADING);
    String url = AppUrls.createOrder;
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Authorization'] = 'Bearer $userToken';
    pt("Authorization Header: Bearer $userToken");
    request.fields['wallet_used'] = walletSelected.value.toString();
    request.fields['wallet_amount'] = walletDiscount.value.toStringAsFixed(2);
    // request.fields['wallet_amount'] = walletDiscount.value.toStringAsFixed(2);
    request.fields['payment_method'] = paymentMethod;
    request.fields['payment_amount'] = walletSelected.value ? newTotalWithoutIncludingTips.value.toStringAsFixed(2) : total;
        // ? (payAfterWallet.value - (double.tryParse(enteredTips.value.replaceAll(",", "")) ?? 0.0)).toStringAsFixed(2)
        // : total.toString();
    // request.fields['payment_amount'] = walletSelected.value ? payAfterWallet.value.toStringAsFixed(2) : totalPriceIncludingTips.toStringAsFixed(2);
    request.fields['address_id'] = addressId;
    request.fields['coupon_id'] = couponId.isNotEmpty ? couponId : "";
    request.fields['vendor_id'] = vendorId;
    request.fields['total'] = total;
    request.fields['cart_id'] = cartId;
    request.fields['type'] = cartType;
    request.fields['delivery_notes'] = deliveryNotesController.value.text ?? "";
    request.fields['delivery_soon'] = isDeliveryAsSoonAsPossible.value == true ? "true" : "false";
    request.fields['courier_tip'] = selectedTipsIndexValue.value == 0 ? "5" :
                                    selectedTipsIndexValue.value == 1 ? "10" :
                                    selectedTipsIndexValue.value == 2 ? "15" :
                                    selectedTipsIndexValue.value == 3 ? tipsController.value.text : "";

    for (var imageFile in imageFiles) {
      if (imageFile?.path != null && imageFile?.path != "") {
        var pic = await http.MultipartFile.fromPath("drslip[]", imageFile!.path);
        print("Adding image with path: ${imageFile.path}");
        request.files.add(pic);
      }
    }

    print(request.fields);
    print(request.files);
    try {
      var response = await request.send();

      final responseData = await http.Response.fromStream(response);
      print("statusCode ${response.statusCode}");

      if (response.statusCode == 200) {
        var responseBody = responseData.body;
        var decodedData = json.decode(responseBody);
        CreateOrder data = CreateOrder.fromJson(decodedData);
        setCreateOrderData(data);

        if (createOrderData.value.status == true) {
          setRxRequestStatus(Status.COMPLETED);
          // selectedIndex.value = -1;
          tipsController.value.clear();
          deliveryNotesController.value.clear();
          isDeliveryAsSoonAsPossible.value = false;
          isDeliveryNotes.value = false;
          PrescriptionController prescriptionController = Get.put(PrescriptionController());
          prescriptionController.imageList = RxList<Rx<File?>>([Rx<File?>(null)]);
          Get.toNamed(AppRoutes.oderConfirm, arguments: {'type': cartType,"order_no" :createOrderData.value.orderNo.toString()});

        } else {
          Utils.showToast(createOrderData.value.message.toString());
          print("Error: $responseBody");
          setRxRequestStatus(Status.COMPLETED);
        }
      } else {
        final responseMap = jsonDecode(responseData.body);
        Utils.showToast("${responseMap['message']}");
        print("Error: ${responseData.body}");
        setRxRequestStatus(Status.COMPLETED);
      }
    } catch (e) {
      print("Error1: $e");
      setError(e.toString());
      setRxRequestStatus(Status.ERROR);
    }
  }

  void setError(String value) => error.value = value;

  void initializeWallet(String walletBalanceStr, String totalPriceStr) {
    final walletBalance = double.tryParse(walletBalanceStr.replaceAll(",", "")) ?? 0.0;
    final totalPrice = double.tryParse(totalPriceStr.replaceAll(",", "")) ?? 0.0;

    walletSelected.value = walletBalance > 0.0;

    if (walletBalance >= totalPrice ) {
      // Full payment via wallet
      walletDiscount.value = totalPrice;
      payAfterWallet.value = 0.0;
      isSelectable.value = true;
      selectedIndex.value = 0; // Wallet only
      update();
    } else if (walletBalance > 0.0) {
      // Partial wallet, remaining with another method
      walletDiscount.value = walletBalance;
      payAfterWallet.value = totalPrice - walletBalance;
      isSelectable.value = false;
      selectedIndex.value = -1; // ❗ Do not pre-select any method
      update();

    } else {
      // No wallet used
      walletSelected.value = false;
      walletDiscount.value = 0.0;
      payAfterWallet.value = totalPrice;
      isSelectable.value = false;
      selectedIndex.value = -1; // ❗ Do not pre-select any method
      update();

    }
  }

  RxDouble newTotalIncludingTips = 0.00.obs;
  RxDouble newTotalWithoutIncludingTips = 0.00.obs;

  void updateBalanceAfterTips({
    required String totalPrice,
    required String walletBalance,
  }) {
    // Step 1: Calculate tipsAmount based on selected tip
    double tipsAmount = 0.00;

    if (selectedTipsIndexValue.value == 0) {
      tipsAmount = 5.00;
    } else if (selectedTipsIndexValue.value == 1) {
      tipsAmount = 10.00;
    } else if (selectedTipsIndexValue.value == 2) {
      tipsAmount = 15.00;
    } else if (selectedTipsIndexValue.value == 3 && enteredTips.value.isNotEmpty) {
      tipsAmount = double.tryParse(enteredTips.value) ?? 0.00;
    }

    // Step 2: Parse inputs after removing commas
    final double totalPriceDouble = double.tryParse(totalPrice.replaceAll(',', '')) ?? 0.00;
    final double walletBalDouble = double.tryParse(walletBalance.replaceAll(',', '')) ?? 0.00;

    // Step 3: Calculate total including tips
    final double totalWithTips = totalPriceDouble + tipsAmount;

    // Step 4: Store totalWithoutIncludingTips (for display logic)
    newTotalWithoutIncludingTips.value =
        (totalPriceDouble - walletBalDouble).clamp(0.00, double.infinity);

    // Step 5: Wallet logic
    if (walletSelected.value && walletBalDouble > 0) {
      if (walletBalDouble >= totalPriceDouble) {
        // Wallet can fully cover base price, user only pays tips
        walletDiscount.value = totalPriceDouble;
        newPayAfterWallet.value = tipsAmount;
        isSelectable.value = true;
        selectedIndex.value = 0;
      } else {
        // Wallet partially covers base price, user pays the rest + full tips
        walletDiscount.value = walletBalDouble;
        double remainingBase = totalPriceDouble - walletBalDouble;
        newPayAfterWallet.value = remainingBase + tipsAmount;
        isSelectable.value = false;
      }

      newTotalIncludingTips.value = totalWithTips;
    } else {
      // Wallet not selected or balance is 0
      walletDiscount.value = 0.0;
      newPayAfterWallet.value = totalWithTips;
      newTotalIncludingTips.value = totalWithTips;
      isSelectable.value = false;
    }

    print("Tips Amount: $tipsAmount");
    print("Total Without Tips: ${newTotalWithoutIncludingTips.value}");
    print("Total With Tips: ${newTotalIncludingTips.value}");
    print("Pay After Wallet: ${newPayAfterWallet.value}");

    update();
  }

  // void updateBalanceAfterTips({required String totalPrice,required String walletBalance}){
//   totalPriceIncludingTips.value = double.parse(totalPrice) + double.parse(selectedTipsIndexValue.value == 0 ? "5" :
//   selectedTipsIndexValue.value == 1 ? "10" :
//   selectedTipsIndexValue.value == 2 ? "15" :
//   selectedTipsIndexValue.value == 3 ?
//   (enteredTips.value.isNotEmpty? enteredTips.value : "0") : "0");
//   if(walletSelected.value && double.parse(totalPrice.toString()) > double.parse(walletBalance.toString())){
//     payAfterWallet.value = totalPriceIncludingTips.value  - double.parse(walletSelected.value ? walletBalance.toString() : "0.00");;
//   }
//
//   final walletBalDouble = double.parse(walletBalance);
//
//   if (walletSelected.value) {
//     if (walletBalDouble >= totalPriceIncludingTips.value) {
//       // Wallet covers full amount
//       walletDiscount.value = totalPriceIncludingTips.value;
//       payAfterWallet.value = 0.0;
//       isSelectable.value = true;
//       selectedIndex.value = 0;
//     } else {
//       // Wallet partially covers
//       walletDiscount.value = walletBalDouble;
//       // payAfterWallet.value = totalPriceIncludingTips.value - walletBalDouble;
//       isSelectable.value = false;
//     }
//   } else {
//     // Wallet not selected
//     walletDiscount.value = 0.0;
//     // payAfterWallet.value = totalPriceIncludingTips.value;
//     isSelectable.value = false;
//   }
//
//   update();
// }

// void updateBalanceAfterTips({
//   required String totalPrice,
//   required String walletBalance,
// }) {
//   // Step 1: Calculate tipsAmount based on selected tip
//   double tipsAmount = 0.0;
//
//   if (selectedTipsIndexValue.value == 0) {
//     tipsAmount = 5.0;
//   } else if (selectedTipsIndexValue.value == 1) {
//     tipsAmount = 10.0;
//   } else if (selectedTipsIndexValue.value == 2) {
//     tipsAmount = 15.0;
//   } else if (selectedTipsIndexValue.value == 3 && enteredTips.value.isNotEmpty) {
//     tipsAmount = double.tryParse(enteredTips.value) ?? 0.0;
//   }
//
//   // Step 2: Parse main inputs
//   final totalPriceDouble = double.parse(totalPrice);
//   final walletBalDouble = double.parse(walletBalance);
//
//   // Step 3: Compute new local values
//   final double newTotalIncludingTips = totalPriceDouble + tipsAmount;
//
//
//   if (walletSelected.value && totalPriceDouble > walletBalDouble) {
//     newPayAfterWallet.value = newTotalIncludingTips - walletBalDouble;
//   }
//
//   // Step 4: Wallet logic
//   if (walletSelected.value) {
//     if (walletBalDouble >= newTotalIncludingTips) {
//       // Wallet covers everything
//       walletDiscount.value = newTotalIncludingTips;
//       newPayAfterWallet.value = 0.0;
//       isSelectable.value = true;
//       selectedIndex.value = 0;
//     } else {
//       // Partial wallet use
//       walletDiscount.value = walletBalDouble;
//       newPayAfterWallet.value = newTotalIncludingTips - walletBalDouble;
//       isSelectable.value = false;
//     }
//   } else {
//     // Wallet not used
//     walletDiscount.value = 0.0;
//     newPayAfterWallet.value = newTotalIncludingTips;
//     isSelectable.value = false;
//   }
//
//   // Step 5: Print or assign for debugging or later use
//   print("Tips Amount: $tipsAmount");
//   print("Total with Tips: $newTotalIncludingTips");
//   print("Pay After Wallet: $newPayAfterWallet");
//
//   update();
// }
// void updateBalanceAfterTips({
  //   required String totalPrice,
  //   required String walletBalance,
  // }) {
  //   // Step 1: Calculate tipsAmount based on selected tip
  //   double tipsAmount = 0.00;
  //
  //   if (selectedTipsIndexValue.value == 0) {
  //     tipsAmount = 5.00;
  //   } else if (selectedTipsIndexValue.value == 1) {
  //     tipsAmount = 10.00;
  //   } else if (selectedTipsIndexValue.value == 2) {
  //     tipsAmount = 15.00;
  //   } else if (selectedTipsIndexValue.value == 3 && enteredTips.value.isNotEmpty) {
  //     tipsAmount = double.tryParse(enteredTips.value) ?? 0.00;
  //   }
  //
  //   // Step 2: Parse inputs
  //   final double totalPriceDouble = double.tryParse(totalPrice) ?? 0.00;
  //   final double walletBalDouble = double.tryParse(walletBalance) ?? 0.00;
  //
  //   // Step 3: Calculate total including tips
  //   final double totalWithTips = totalPriceDouble + tipsAmount;
  //
  //   // Step 4: Store totalWithoutIncludingTips (for display logic)
  //   newTotalWithoutIncludingTips.value =
  //       (totalPriceDouble - walletBalDouble).clamp(0.00, double.infinity);
  //
  //   // Step 5: Wallet logic
  //   if (walletSelected.value && walletBalDouble > 0) {
  //     if (walletBalDouble >= totalWithTips) {
  //       walletDiscount.value = totalWithTips;
  //       newPayAfterWallet.value = 0.00;
  //       isSelectable.value = true;
  //       selectedIndex.value = 0;
  //     } else {
  //       walletDiscount.value = walletBalDouble;
  //       newPayAfterWallet.value = totalWithTips - walletBalDouble;
  //       isSelectable.value = false;
  //     }
  //
  //     newTotalIncludingTips.value = totalWithTips;
  //   } else {
  //     // Wallet not selected or balance is 0
  //     walletDiscount.value = 0.0;
  //     newPayAfterWallet.value = totalWithTips;
  //     newTotalIncludingTips.value = totalWithTips;
  //     isSelectable.value = false;
  //   }
  //
  //   print("Tips Amount: $tipsAmount");
  //   print("Total Without Tips: ${newTotalWithoutIncludingTips.value}");
  //   print("Total With Tips: ${newTotalIncludingTips.value}");
  //   print("Pay After Wallet: ${newPayAfterWallet.value}");
  //
  //   update();
  // }

//Working if wallet is not empty
// void updateBalanceAfterTips({
  //   required String totalPrice,
  //   required String walletBalance,
  // }) {
  //   // Step 1: Calculate tipsAmount based on selected tip
  //   RxDouble tipsAmount = 0.0.obs;
  //
  //   if (selectedTipsIndexValue.value == 0) {
  //     tipsAmount.value = 5.0;
  //   } else if (selectedTipsIndexValue.value == 1) {
  //     tipsAmount.value = 10.0;
  //   } else if (selectedTipsIndexValue.value == 2) {
  //     tipsAmount.value = 15.0;
  //   } else if (selectedTipsIndexValue.value == 3 && enteredTips.value.isNotEmpty) {
  //     tipsAmount.value = double.tryParse(enteredTips.value) ?? 0.0;
  //   }
  //
  //   // Step 2: Parse inputs
  //   final totalPriceDouble = double.parse(totalPrice);
  //   final walletBalDouble = double.parse(walletBalance);
  //
  //   // ✅ Step 3: Save base price before tips
  //   // newTotalWithoutIncludingTips.value = totalPriceDouble;
  //   newTotalWithoutIncludingTips.value = (totalPriceDouble - walletBalDouble).clamp(0.0, double.infinity);
  //
  //   // ✅ Step 4: Compute total including tips
  //   newTotalIncludingTips.value = totalPriceDouble + tipsAmount.value;
  //
  //   // Step 5: Wallet logic
  //   if (walletSelected.value) {
  //     if (walletBalDouble >= newTotalIncludingTips.value) {
  //       walletDiscount.value = newTotalIncludingTips.value;
  //       newPayAfterWallet.value = 0.0;
  //       isSelectable.value = true;
  //       selectedIndex.value = 0;
  //     } else {
  //       walletDiscount.value = walletBalDouble;
  //       newPayAfterWallet.value = newTotalIncludingTips.value - walletBalDouble;
  //       isSelectable.value = false;
  //     }
  //   } else {
  //     walletDiscount.value = 0.0;
  //     newPayAfterWallet.value = totalPriceDouble;
  //     newTotalIncludingTips.value = 0;
  //     isSelectable.value = false;
  //   }
  //
  //   print("Tips Amount: ${tipsAmount.value}");
  //   print("Total Without Tips: ${newTotalWithoutIncludingTips.value}");
  //   print("Total With Tips: ${newTotalIncludingTips.value}");
  //   print("Pay After Wallet: ${newPayAfterWallet.value}");
  //
  //   update();
  // }
  // void updateBalanceAfterTips({
  //   required String totalPrice,
  //   required String walletBalance,
  // }) {
  //   // Step 1: Calculate tipsAmount based on selected tip
  //   RxDouble tipsAmount = 0.0.obs;
  //
  //   if (selectedTipsIndexValue.value == 0) {
  //     tipsAmount.value = 5.0;
  //   } else if (selectedTipsIndexValue.value == 1) {
  //     tipsAmount.value = 10.0;
  //   } else if (selectedTipsIndexValue.value == 2) {
  //     tipsAmount.value = 15.0;
  //   } else if (selectedTipsIndexValue.value == 3 && enteredTips.value.isNotEmpty) {
  //     tipsAmount.value = double.tryParse(enteredTips.value) ?? 0.0;
  //   }
  //
  //   // Step 2: Parse inputs
  //   final totalPriceDouble = double.parse(totalPrice);
  //   final walletBalDouble = double.parse(walletBalance);
  //
  //   // Step 3: Compute total including tips
  //   newTotalIncludingTips.value = totalPriceDouble + tipsAmount.value;
  //
  //   // Step 4: Wallet logic
  //   if (walletSelected.value) {
  //     if (walletBalDouble >= newTotalIncludingTips.value) {
  //       // Wallet covers full amount
  //       walletDiscount.value = newTotalIncludingTips.value;
  //       newPayAfterWallet.value = 0.0;
  //       isSelectable.value = true;
  //       selectedIndex.value = 0;
  //     }
  //     else {
  //       // Wallet partially covers
  //       walletDiscount.value = walletBalDouble;
  //       newPayAfterWallet.value = newTotalIncludingTips.value - walletBalDouble;
  //       isSelectable.value = false;
  //     }
  //   } else {
  //     // Wallet not selected
  //     walletDiscount.value = 0.0;
  //     newPayAfterWallet.value = totalPriceDouble; // ✅ fixed here
  //     isSelectable.value = false;
  //   }
  //
  //   print("Tips Amount: $tipsAmount");
  //   print("Total with Tips: $newTotalIncludingTips");
  //   print("Pay After Wallet: ${newPayAfterWallet.value}");
  //
  //   update();
  // }
}
