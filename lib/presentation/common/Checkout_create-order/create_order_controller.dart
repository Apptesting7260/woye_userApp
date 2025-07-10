import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:woye_user/Core/Constant/app_urls.dart';
import 'package:woye_user/Core/Utils/sized_box.dart';
import 'package:woye_user/Core/Utils/snackbar.dart';
import 'package:woye_user/Data/Model/usermodel.dart';
import 'package:woye_user/Data/Repository/repository.dart';
import 'package:woye_user/Data/response/status.dart';
import 'package:woye_user/Data/userPrefrenceController.dart';
import 'package:woye_user/Routes/app_routes.dart';
import 'package:woye_user/Shared/theme/font_family.dart';
import 'package:woye_user/pay_stack/payment_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/modal/RestaurantCartModal.dart';
import 'package:woye_user/presentation/common/Checkout_create-order/create_order_modal.dart';
import 'package:woye_user/presentation/common/get_user_data/get_user_data.dart';
import 'package:woye_user/shared/theme/colors.dart';
import 'package:woye_user/shared/theme/font_style.dart';
import 'package:woye_user/shared/widgets/custom_elevated_button.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';

import '../../Pharmacy/Pages/Pharmacy_cart/prescription/prescription_controller.dart';

class CreateOrderController extends GetxController {
  Rx<TextEditingController> tipsController = Rx(TextEditingController());
  Rx<TextEditingController> deliveryNotesController = Rx(TextEditingController());
  Rx<TextEditingController> scheduleDeliveryController = Rx(TextEditingController());
  GlobalKey<FormState> deliveryNotesKey = GlobalKey<FormState>();
  GlobalKey<FormState> tipsKey = GlobalKey<FormState>();
  GlobalKey<FormState> deliveryTimeFormKey = GlobalKey<FormState>();
  RxBool isDeliveryNotes = false.obs;
  RxBool isDeliveryAsSoonAsPossible = false.obs;
  RxBool isDeliveryAsSoonAsPossiblePopUp = false.obs;
  RxString enteredTips = "".obs;
  RxDouble totalPriceIncludingTips = 0.00.obs;
  RxString totalPayAmount = "0".obs;
  RxDouble newPayAfterWallet = 0.00.obs;


  //------
  RxString addressId = "".obs;
  RxString couponDiscountPaymentDetails = "".obs;
  RxString formattedTotal = "".obs;
  RxString total = "".obs;
  RxString regularPrice = "".obs;
  RxString saveAmount = "".obs;
  RxString deliveryCharge = "".obs;
  RxString cartType = "".obs;
  RxString walletBalance = "".obs;
  dynamic couponDiscount;
  dynamic cartTotal;
  dynamic cartDelivery;
  dynamic couponId;
  dynamic vendorId;
  dynamic grandTotalPrice;
  dynamic cartId;
  dynamic prescription;

  //------
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
  final createOrderData = RestaurantCreateOrderModel().obs;
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

  void setCreateOrderData(RestaurantCreateOrderModel value) => createOrderData.value = value;


  createOrderRestaurant({
    required bool walletUsed,
    required String walletAmount,
    required String paymentMethod,
    required String paymentAmount,
    required String addressId,
    required String couponId,
    required String total,
    required String type,
    required List<String> cartIds,
    required List<Map<String,dynamic>> carts,
    required String deliveryNotes,
    required String deliverySoon,
    required String courierTip,
     String? referenceId,
     String? transactionId,

  }) async {
    var data = {
      "wallet_used": walletUsed.toString(),
      "wallet_amount": walletAmount,
      "payment_method": paymentMethod,
      "payment_amount": paymentAmount,
      "address_id": addressId,
      "coupon_id": couponId,
      "total":total,
      'sub_total' : total,
      "type": "restaurant",
      "cart_ids": jsonEncode(cartIds),
      "carts": jsonEncode(carts),
      if(deliveryNotes.isNotEmpty)
      'delivery_notes' : deliveryNotes,
      if(deliverySoon.isNotEmpty)
      'delivery_soon' : deliverySoon,
      if(courierTip.isNotEmpty)
      'courier_tip' : courierTip,
      if(referenceId != null)
      'reference_id'  :  referenceId,
      if(transactionId != null)
        'transaction_id' : transactionId,
    };
    debugPrint("dataValue  >> $data");
    setRxRequestStatus(Status.LOADING);
    api.restaurantCreateOrderApi(data).then((value) {
      setCreateOrderData(value);
      if(createOrderData.value.status == true) {
        setRxRequestStatus(Status.COMPLETED);
        Get.toNamed(AppRoutes.oderConfirm, arguments: {'type': "restaurant","order_no" :createOrderData.value.orderIds?.first.toString()});

      }else if(value.status == false){
        setRxRequestStatus(Status.ERROR);
        Utils.showToast(value.message.toString());
      }
    },
    ).onError((error, stackError) {
      setError(error.toString());
      pt(stackError);
      pt('error create order restaurant : ${error.toString()}');
      setRxRequestStatus(Status.ERROR);
    });
  }

  // // placeOrder btn api
  // final rxGetCheckoutBtnDataStatus = Status.COMPLETED.obs;
  // void setRxRequestStatusCheckoutBtn(Status value) => rxGetCheckoutBtnDataStatus.value = value;
  //
  // final cartCheckoutBtnData = RestaurantCartModal().obs;
  // void allCheckoutBtnDataSet(RestaurantCartModal value) => cartCheckoutBtnData.value = value;
  //
  // Future checkoutBtnApiWithParams(context)async{
  //   var params = {
  //     "key" : "checkout",
  //   };
  //   setRxRequestStatusCheckoutBtn(Status.LOADING);
  //   api.getRestaurantCheckOutApi(params:params).then((value) {
  //     allCheckoutBtnDataSet(value);
  //     if(value.status == true){
  //       setRxRequestStatusCheckoutBtn(Status.COMPLETED);
  //         List<Map<String, dynamic>> carts = [];
  //
  //         print("vendorId type :: ${vendorId.runtimeType}");
  //         if (vendorId.runtimeType != String) {
  //           for (int i = 0; i < vendorId.length; i++) {
  //             carts.add({
  //               "vendor_id": vendorId[i],
  //               "cart_id": cartId[i],
  //               "cart_total": cartTotal[i],
  //               "cart_delivery": cartDelivery[i],
  //               "coupon_discount": couponDiscount[i],
  //               "grandtotal_price": grandTotalPrice[i],
  //             },
  //             );
  //           }
  //         } else {
  //           carts.add({
  //             "vendor_id": vendorId.toString(),
  //             "cart_id":cartId.toString(),
  //             "cart_total": cartTotal.toString(),
  //             "cart_delivery": cartDelivery.toString(),
  //             "coupon_discount": couponDiscount.toString(),
  //             "grandtotal_price":grandTotalPrice.toString(),
  //           },
  //           );
  //         }
  //
  //
  //         List<String> cartIDs = [];
  //         if (vendorId.runtimeType != String) {
  //           for (int i = 0; i < cartId.length; i++) {
  //             cartIDs.add(cartId[i].toString());
  //           }
  //         } else {
  //           cartIDs.add(cartId.toString());
  //         }
  //         showDialog(
  //           context: context,
  //           barrierDismissible: true,
  //           builder: (BuildContext context) {
  //             return AlertDialog(
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(16.r),
  //               ),
  //               backgroundColor: Colors.white,
  //               titlePadding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 8.h),
  //               contentPadding: REdgeInsets.symmetric(horizontal: 22,vertical: 15),
  //               actionsPadding: REdgeInsets.symmetric(horizontal: 25),
  //               insetPadding:REdgeInsets.symmetric(horizontal: 22),
  //               title:Icon(Icons.error_outline, color: AppColors.red, size: 24.r),
  //               content: Text(
  //                 " cartCheckoutBtnData.value.message?.toString() ?? Something went wrong",
  //                 maxLines: 5,
  //                 textAlign: TextAlign.center,
  //                 style: AppFontStyle.text_16_500(
  //                   AppColors.darkText,
  //                   family: AppFontFamily.gilroyMedium,
  //                 ),
  //               ),
  //               actions: <Widget>[
  //                 CustomElevatedButton(
  //                   onPressed: () {
  //                     Get.back();
  //                     // Get.back();
  //                   },
  //                   child: Text(
  //                     'OK',
  //                     style: AppFontStyle.text_15_600(
  //                       AppColors.white,
  //                       family: AppFontFamily.gilroyMedium,
  //                     ),
  //                   ),
  //                 ),
  //                 hBox(20.h),
  //               ],
  //             );
  //           },
  //         );
  //         if (selectedIndex.value == 1) {
  //           // payStackController.makePayment(context: context,
  //           //   email: getUserDataController.userData.value.user?.email ?? "",
  //           //   addressId: addressId.value,
  //           //   couponId: couponId,
  //           //   total: newTotalIncludingTips.value.toString(),
  //           //   cartIds: cartIDs,
  //           //   cartType: cartType.value,
  //           //   carts: carts,);
  //           // debugPrint("controller.selectedIndex.value  ${selectedIndex.value }");
  //         }
  //         else {
  //           final String paymentAmount = walletSelected.value
  //               ? newPayAfterWallet.value
  //               .toStringAsFixed(2)
  //               : newTotalIncludingTips.value
  //               .toStringAsFixed(2);
  //
  //           createOrderRestaurant(
  //             walletUsed: walletSelected.value,
  //             walletAmount: walletDiscount.value
  //                 .toStringAsFixed(2),
  //             paymentMethod: isSelectable.value == true
  //                 ? "wallet" : selectedIndex.value == 1 ? "credit_card" : selectedIndex.value == 2
  //                 ? "cash_on_delivery" : "",
  //             // paymentAmount: controller.payAfterWallet.value.toStringAsFixed(2),
  //             paymentAmount: walletSelected.value ? paymentAmount : total.value,
  //             // paymentAmount: controller.walletSelected.value ? controller.newTotalWithoutIncludingTips.value.toStringAsFixed(2) : total,
  //             addressId: addressId.value,
  //             couponId: couponId,
  //             total: total.value,
  //             cartIds: cartIDs,
  //             type: cartType.value,
  //             carts: carts,
  //             deliveryNotes: deliveryNotesController.value.text,
  //             deliverySoon: isDeliveryAsSoonAsPossible.value == true && isDeliveryAsSoonAsPossiblePopUp.value == true ? "as soon as possible"
  //                 : isDeliveryAsSoonAsPossible.value == true && pickedTimeVal.value != ''
  //                 ? pickedTimeVal.value : "",
  //             courierTip: selectedTipsIndexValue.value == 0 ? "5" : selectedTipsIndexValue.value == 1 ? "10":
  //             selectedTipsIndexValue.value == 2? "15":selectedTipsIndexValue.value == 3
  //                 ? tipsController.value.text: "",
  //           );
  //           debugPrint(
  //               "controller.selectedIndex.value  ${selectedIndex.value }");
  //         }
  //
  //     }else if(value.status == false){
  //       setRxRequestStatusCheckoutBtn(Status.COMPLETED);
  //       showDialog(
  //         context: context,
  //         barrierDismissible: true,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(16.r),
  //             ),
  //             backgroundColor: Colors.white,
  //             titlePadding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 8.h),
  //             contentPadding: REdgeInsets.symmetric(horizontal: 22,vertical: 15),
  //             actionsPadding: REdgeInsets.symmetric(horizontal: 25),
  //             insetPadding:REdgeInsets.symmetric(horizontal: 22),
  //             title:Icon(Icons.error_outline, color: AppColors.red, size: 24.r),
  //             content: Text(
  //               cartCheckoutBtnData.value.message?.toString() ?? "Something went wrong.",
  //               maxLines: 5,
  //               textAlign: TextAlign.center,
  //               style: AppFontStyle.text_16_500(
  //                 AppColors.darkText,
  //                 family: AppFontFamily.gilroyMedium,
  //               ),
  //             ),
  //             actions: <Widget>[
  //               CustomElevatedButton(
  //                 onPressed: () {
  //                   Get.back();
  //                   // Get.back();
  //                 },
  //                 child: Text(
  //                   'OK',
  //                   style: AppFontStyle.text_15_600(
  //                     AppColors.white,
  //                     family: AppFontFamily.gilroyMedium,
  //                   ),
  //                 ),
  //               ),
  //               hBox(20.h),
  //             ],
  //           );
  //         },
  //       );
  //     }else{
  //       setRxRequestStatusCheckoutBtn(Status.ERROR);
  //     }
  //   },).onError((error, stackError) {
  //     setError(error.toString());
  //     pt('error restaurant checkout api >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ');
  //     pt(error);
  //     pt(stackError);
  //     setRxRequestStatusCheckoutBtn(Status.ERROR);
  //   });
  //
  // }


  // void setCreateOrderData(CreateOrder value) => createOrderData.value = value;

  // placeOrderApi({
  //   required String paymentMethod,
  //   required String addressId,
  //   required String couponId,
  //   required String vendorId,
  //   required String total,
  //   required String cartId,
  //   required String cartType,
  //   required List<File?> imageFiles,
  // }) async {
  //   await initializeUser();
  //   setRxRequestStatus(Status.LOADING);
  //   String url = AppUrls.createOrder;
  //   var request = http.MultipartRequest('POST', Uri.parse(url));
  //   request.headers['Authorization'] = 'Bearer $userToken';
  //   pt("Authorization Header: Bearer $userToken");
  //   request.fields['wallet_used'] = walletSelected.value.toString();
  //   request.fields['wallet_amount'] = walletDiscount.value.toStringAsFixed(2);
  //   // request.fields['wallet_amount'] = walletDiscount.value.toStringAsFixed(2);
  //   request.fields['payment_method'] = paymentMethod;
  //   request.fields['payment_amount'] = walletSelected.value ? newTotalWithoutIncludingTips.value.toStringAsFixed(2) : total;
  //       // ? (payAfterWallet.value - (double.tryParse(enteredTips.value.replaceAll(",", "")) ?? 0.0)).toStringAsFixed(2)
  //       // : total.toString();
  //   // request.fields['payment_amount'] = walletSelected.value ? payAfterWallet.value.toStringAsFixed(2) : totalPriceIncludingTips.toStringAsFixed(2);
  //   request.fields['address_id'] = addressId;
  //   request.fields['coupon_id'] = couponId.isNotEmpty ? couponId : "";
  //   request.fields['vendor_id'] = vendorId;
  //   request.fields['total'] = total;
  //   request.fields['cart_id'] = cartId;
  //   request.fields['type'] = cartType;
  //   request.fields['delivery_notes'] = deliveryNotesController.value.text ?? "";
  //   request.fields['delivery_soon'] = isDeliveryAsSoonAsPossible.value == true && isDeliveryAsSoonAsPossiblePopUp.value == true ? "as soon as possible"
  //                                     : isDeliveryAsSoonAsPossible.value == true && pickedTimeVal.value != '' ? pickedTimeVal.value : "";
  //   request.fields['courier_tip'] = selectedTipsIndexValue.value == 0 ? "5" :
  //                                   selectedTipsIndexValue.value == 1 ? "10" :
  //                                   selectedTipsIndexValue.value == 2 ? "15" :
  //                                   selectedTipsIndexValue.value == 3 ? tipsController.value.text : "";
  //
  //   for (var imageFile in imageFiles) {
  //     if (imageFile?.path != null && imageFile?.path != "") {
  //       var pic = await http.MultipartFile.fromPath("drslip[]", imageFile!.path);
  //       print("Adding image with path: ${imageFile.path}");
  //       request.files.add(pic);
  //     }
  //   }
  //
  //   print(request.fields);
  //   print(request.files);
  //   try {
  //     var response = await request.send();
  //
  //     final responseData = await http.Response.fromStream(response);
  //     print("statusCode ${response.statusCode}");
  //
  //     if (response.statusCode == 200) {
  //       var responseBody = responseData.body;
  //       var decodedData = json.decode(responseBody);
  //       CreateOrder data = CreateOrder.fromJson(decodedData);
  //       setCreateOrderData(data);
  //
  //       if (createOrderData.value.status == true) {
  //         setRxRequestStatus(Status.COMPLETED);
  //         // selectedIndex.value = -1;
  //         tipsController.value.clear();
  //         deliveryNotesController.value.clear();
  //         isDeliveryAsSoonAsPossible.value = false;
  //         isDeliveryNotes.value = false;
  //         PrescriptionController prescriptionController = Get.put(PrescriptionController());
  //         prescriptionController.imageList = RxList<Rx<File?>>([Rx<File?>(null)]);
  //         Get.toNamed(AppRoutes.oderConfirm, arguments: {'type': cartType,"order_no" :createOrderData.value.orderNo.toString()});
  //
  //       } else {
  //         Utils.showToast(createOrderData.value.message.toString());
  //         print("Error: $responseBody");
  //         setRxRequestStatus(Status.COMPLETED);
  //       }
  //     } else {
  //       final responseMap = jsonDecode(responseData.body);
  //       Utils.showToast("${responseMap['message']}");
  //       print("Error: ${responseData.body}");
  //       setRxRequestStatus(Status.COMPLETED);
  //     }
  //   } catch (e) {
  //     print("Error1: $e");
  //     setError(e.toString());
  //     setRxRequestStatus(Status.ERROR);
  //   }
  // }

  void setError(String value) => error.value = value;

/*10-07
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
*/

  RxDouble newTotalIncludingTips = 0.00.obs;
  RxDouble newTotalWithoutIncludingTips = 0.00.obs;

  // void initializeWallet(String walletBalanceStr, String totalPriceStr, {bool preserveSelectedIndex = false}) {
  //   final walletBalance = double.tryParse(walletBalanceStr.replaceAll(",", "")) ?? 0.0;
  //   final totalPrice = double.tryParse(totalPriceStr.replaceAll(",", "")) ?? 0.0;
  //
  //   walletSelected.value = walletBalance > 0.0;
  //
  //   if (walletBalance >= totalPrice) {
  //     // Full payment via wallet
  //     walletDiscount.value = totalPrice;
  //     payAfterWallet.value = 0.0;
  //     isSelectable.value = true;
  //     if (!preserveSelectedIndex || selectedIndex.value == -1) {
  //       selectedIndex.value = 0; // ✅ Only select if not preserving previous selection
  //     }
  //     update();
  //   } else if (walletBalance > 0.0) {
  //     // Partial wallet, remaining with another method
  //     walletDiscount.value = walletBalance;
  //     payAfterWallet.value = totalPrice - walletBalance;
  //     isSelectable.value = false;
  //     if (!preserveSelectedIndex || selectedIndex.value == -1) {
  //       selectedIndex.value = -1; // Don't select anything
  //     }
  //     update();
  //   } else {
  //     // No wallet used
  //     walletSelected.value = false;
  //     walletDiscount.value = 0.0;
  //     payAfterWallet.value = totalPrice;
  //     isSelectable.value = false;
  //     if (!preserveSelectedIndex || selectedIndex.value == -1) {
  //       selectedIndex.value = -1;
  //     }
  //     update();
  //   }
  // }

  // void updateBalanceAfterTips({
  //   required String totalPrice,
  //   required String walletBalance,
  //   bool preserveSelectedIndex = false, // ✅ new param
  // }) {
  //   // Calculate tips
  //   double tipsAmount = 0.00;
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
  //   final double totalPriceDouble = double.tryParse(totalPrice.replaceAll(',', '')) ?? 0.00;
  //   final double walletBalDouble = double.tryParse(walletBalance.replaceAll(',', '')) ?? 0.00;
  //   final double totalWithTips = totalPriceDouble + tipsAmount;
  //
  //   if (walletSelected.value && walletBalDouble > 0) {
  //     double walletCoverage = min(walletBalDouble, totalWithTips);
  //
  //     walletDiscount.value = walletCoverage;
  //     newPayAfterWallet.value = totalWithTips - walletCoverage;
  //     newTotalWithoutIncludingTips.value = max(0, totalPriceDouble - walletCoverage);
  //
  //     isSelectable.value = walletBalDouble >= totalWithTips;
  //
  //     // ✅ Only auto-select wallet if preserveSelectedIndex is false and nothing selected
  //     if (!preserveSelectedIndex && isSelectable.value && selectedIndex.value == -1) {
  //       selectedIndex.value = 0;
  //     }
  //   } else {
  //     walletDiscount.value = 0.0;
  //     newPayAfterWallet.value = totalWithTips;
  //     newTotalWithoutIncludingTips.value = totalPriceDouble;
  //     isSelectable.value = false;
  //   }
  //
  //   newTotalIncludingTips.value = totalWithTips;
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
  //   // Step 2: Parse inputs after removing commas
  //   final double totalPriceDouble = double.tryParse(totalPrice.replaceAll(',', '')) ?? 0.00;
  //   final double walletBalDouble = double.tryParse(walletBalance.replaceAll(',', '')) ?? 0.00;
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
  //     if (walletBalDouble >= totalPriceDouble) {
  //       // Wallet can fully cover base price, user only pays tips
  //       walletDiscount.value = totalPriceDouble;
  //       newPayAfterWallet.value = tipsAmount;
  //       isSelectable.value = true;
  //       selectedIndex.value = 0;
  //     } else {
  //       // Wallet partially covers base price, user pays the rest + full tips
  //       walletDiscount.value = walletBalDouble;
  //       double remainingBase = totalPriceDouble - walletBalDouble;
  //       newPayAfterWallet.value = remainingBase + tipsAmount;
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
    void initializeWallet(String walletBalanceStr, String totalPriceStr) {
      final walletBalance = double.tryParse(walletBalanceStr.replaceAll(",", "")) ?? 0.0;
      final totalPrice = double.tryParse(totalPriceStr.replaceAll(",", "")) ?? 0.0;

      walletSelected.value = walletBalance > 0.0;

      if (walletBalance >= totalPrice) {
        // Full wallet payment is possible
        walletDiscount.value = totalPrice;
        payAfterWallet.value = 0.0;
        isSelectable.value = true;

        // ❌ Don't auto-select wallet
        // selectedIndex.value = 0;

        update();
      } else if (walletBalance > 0.0) {
        // Partial wallet + another method
        walletDiscount.value = walletBalance;
        payAfterWallet.value = totalPrice - walletBalance;
        isSelectable.value = false;

        // ❌ No pre-selection
        // selectedIndex.value = -1;

        update();
      } else {
        // No wallet usage
        walletSelected.value = false;
        walletDiscount.value = 0.0;
        payAfterWallet.value = totalPrice;
        isSelectable.value = false;

        // ❌ No pre-selection
        // selectedIndex.value = -1;

        update();
      }
    }


/*
  void updateBalanceAfterTips({
    required String totalPrice,
    required String walletBalance,
  }) {
    // 1. Calculate tips amount
    double tipsAmount = 0.0;
    if (selectedTipsIndexValue.value == 0) tipsAmount = 5.0;
    else if (selectedTipsIndexValue.value == 1) tipsAmount = 10.0;
    else if (selectedTipsIndexValue.value == 2) tipsAmount = 15.0;
    else if (selectedTipsIndexValue.value == 3) tipsAmount = double.tryParse(enteredTips.value) ?? 0.0;

    // 2. Parse amounts
    final double total = double.tryParse(totalPrice.replaceAll(',', '')) ?? 0.0;
    final double walletBal = double.tryParse(walletBalance.replaceAll(',', '')) ?? 0.0;
    final double totalWithTips = total + tipsAmount;

    // 3. Update totals
    totalPriceIncludingTips.value = totalWithTips;

    // 4. Handle wallet logic
    if (walletSelected.value) {
      if (walletBal >= totalWithTips) {
        // Case 1: Wallet covers full amount
        walletDiscount.value = totalWithTips;
        payAfterWallet.value = 0.0;
        isSelectable.value = true;

        // Keep wallet selected but allow manual unselect
      } else {
        // Case 2: Wallet covers partial amount
        walletDiscount.value = walletBal;
        payAfterWallet.value = totalWithTips - walletBal;
        isSelectable.value = false;

        // Auto-unselect wallet if balance becomes 0
        if (walletBal <= 0) {
          walletSelected.value = false;
        }
      }
    } else {
      // Case 3: Wallet not selected
      walletDiscount.value = 0.0;
      payAfterWallet.value = totalWithTips;
      isSelectable.value = false;

      // Auto-select wallet if it can cover full amount (optional)
      // if (walletBal >= totalWithTips) {
      //   walletSelected.value = true;
      // }
    }

    // 5. Update UI
    newPayAfterWallet.value = payAfterWallet.value;
    newTotalIncludingTips.value = totalPriceIncludingTips.value;
    update();
  }
*/

  void updateBalanceAfterTips({
    required String totalPrice,
    required String walletBalance,
  }) {
    // Calculate tips amount
    double tipsAmount = 0.0;
    if (selectedTipsIndexValue.value == 0) {
      tipsAmount = 5.0;
    } else if (selectedTipsIndexValue.value == 1) {
      tipsAmount = 10.0;
    } else if (selectedTipsIndexValue.value == 2) {
      tipsAmount = 15.0;
    } else if (selectedTipsIndexValue.value == 3) {
      tipsAmount = double.tryParse(enteredTips.value) ?? 0.0;
    }

    final double totalPriceDouble = double.tryParse(totalPrice.replaceAll(',', '')) ?? 0.0;
    final double walletBalDouble = double.tryParse(walletBalance.replaceAll(',', '')) ?? 0.0;
    final double totalWithTips = totalPriceDouble + tipsAmount;

    // Update totals
    totalPriceIncludingTips.value = totalWithTips;

    if (walletSelected.value) {
      // Only calculate wallet impact if wallet is manually selected
      if (walletBalDouble >= totalWithTips) {
        walletDiscount.value = totalWithTips;
        payAfterWallet.value = 0.0;
        isSelectable.value = true;
      } else {
        walletDiscount.value = walletBalDouble;
        payAfterWallet.value = totalWithTips - walletBalDouble;
        isSelectable.value = false;
      }
    } else {
      // Wallet not selected - just show full amount
      walletDiscount.value = 0.0;
      payAfterWallet.value = totalWithTips;
      isSelectable.value = false;
    }

    newPayAfterWallet.value = payAfterWallet.value;
    newTotalIncludingTips.value = totalPriceIncludingTips.value;

    update();
  }

/*10/017
  void updateBalanceAfterTips({
    required String totalPrice,
    required String walletBalance,
  }) {
    // Calculate tips
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

    // Parse total and wallet balance
    final double totalPriceDouble = double.tryParse(totalPrice.replaceAll(',', '')) ?? 0.00;
    final double walletBalDouble = double.tryParse(walletBalance.replaceAll(',', '')) ?? 0.00;
    final double totalWithTips = totalPriceDouble + tipsAmount;

    // Wallet logic
    if (walletSelected.value && walletBalDouble > 0) {
      double walletCoverage = min(walletBalDouble, totalWithTips);

      walletDiscount.value = walletCoverage;
      newPayAfterWallet.value = totalWithTips - walletCoverage; // 💰 amount to pay after wallet
      newTotalWithoutIncludingTips.value = max(0, totalPriceDouble - walletCoverage);

      isSelectable.value = walletBalDouble >= totalWithTips;

      // If wallet covers everything, auto select wallet
      if (isSelectable.value) {
        selectedIndex.value = 0; // wallet
      }
    } else {
      // No wallet used
      walletDiscount.value = 0.0;
      newPayAfterWallet.value = totalWithTips;
      newTotalWithoutIncludingTips.value = totalPriceDouble;
      isSelectable.value = false;
    }

    newTotalIncludingTips.value = totalWithTips;
    update();
  }
*/


    // void updateBalanceAfterTips({
    //   required String totalPrice,
    //   required String walletBalance,
    // }) {
    //   double tipsAmount = 0.00;
    //   if (selectedTipsIndexValue.value == 0) {
    //     tipsAmount = 5.00;
    //   } else if (selectedTipsIndexValue.value == 1) {
    //     tipsAmount = 10.00;
    //   } else if (selectedTipsIndexValue.value == 2) {
    //     tipsAmount = 15.00;
    //   } else if (selectedTipsIndexValue.value == 3 && enteredTips.value.isNotEmpty) {
    //     tipsAmount = double.tryParse(enteredTips.value) ?? 0.00;
    //   }
    //   final double totalPriceDouble = double.tryParse(totalPrice.replaceAll(',', '')) ?? 0.00;
    //   final double walletBalDouble = double.tryParse(walletBalance.replaceAll(',', '')) ?? 0.00;
    //   final double totalWithTips = totalPriceDouble + tipsAmount;
    //
    //   newTotalWithoutIncludingTips.value =   (totalPriceDouble - walletBalDouble).clamp(0.00, double.infinity);
    //
    //   if (walletSelected.value && walletBalDouble > 0) {
    //     if (walletBalDouble >= totalPriceDouble) {
    //       walletDiscount.value = totalPriceDouble;
    //       newPayAfterWallet.value = tipsAmount;
    //       isSelectable.value = true;
    //       selectedIndex.value = 0;
    //     } else {
    //       walletDiscount.value = walletBalDouble;
    //       double remainingBase = totalPriceDouble - walletBalDouble;
    //       newPayAfterWallet.value = remainingBase + tipsAmount;
    //       isSelectable.value = false;
    //     }
    //
    //     newTotalIncludingTips.value = totalWithTips;
    //   } else {
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

  ////////-----------------------------------------------------------------------

  Rx<DateTime> parseTime1 = DateTime.now().obs;
  RxString pickedTimeVal = "".obs;
  RxString formattedTime = "".obs;

  void selectTime(BuildContext context) async {

    DateFormat dateFormat = DateFormat("hh:mm a");
    DateTime parsedTime = dateFormat.parse(scheduleDeliveryController.value.text != '' ? scheduleDeliveryController.value.text : _formatTime(TimeOfDay.now(), context));
    TimeOfDay initialTime = TimeOfDay(hour: parsedTime.hour, minute: parsedTime.minute);

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (pickedTime != null) {
       formattedTime.value = _formatTime(pickedTime, context);
      scheduleDeliveryController.value.text = formattedTime.value;
      pickedTimeVal.value =  formattedTime.value;
      final now = DateTime.now();
      pt("time ${scheduleDeliveryController.value.text}");
      parseTime1.value = DateTime(now.year,now.month,now.day,pickedTime.hour,pickedTime.minute,);
    } else {
      // String formattedTime = _formatTime(initialTime, context);
      // timeController.text = formattedTime;
      // log("Current time set: ${timeController.text}");
    }
    update();
  }

  String _formatTime(TimeOfDay time, BuildContext context) {
    final hour12 = time.hourOfPeriod < 10 ? '0${time.hourOfPeriod}' : '${time.hourOfPeriod}';
    final minutes = time.minute < 10 ? '0${time.minute}' : '${time.minute}';
    final amPm = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour12:$minutes $amPm';
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
