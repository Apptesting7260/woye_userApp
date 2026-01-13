import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/Controller/restaurant_cart_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/modal/RestaurantCartModal.dart';
import 'package:woye_user/presentation/common/Checkout_create-order/create_order_modal.dart';
import 'package:woye_user/presentation/common/get_user_data/get_user_data.dart';
import 'package:woye_user/shared/theme/colors.dart';
import 'package:woye_user/shared/theme/font_style.dart';
import 'package:woye_user/shared/widgets/custom_elevated_button.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';

import '../../Pharmacy/Pages/Pharmacy_cart/prescription/prescription_controller.dart';
import '../Profile/Sub_screens/Delivery_address/delivery_address_modal/delivery_address_modal.dart';

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
  final RestaurantCartController restaurantCartController = Get.put(RestaurantCartController());

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
    // loadSavedTip();
    // clearSavedTip();
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

  void setDefaultAddress(List<Data> dataList) {
    if (addressId.value.isNotEmpty) return;

    final defaultAddress = dataList.firstWhereOrNull(
          (e) => e.isDefault == true,
    );

    if (defaultAddress != null) {
      addressId.value = defaultAddress.id.toString();
    }
  }



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
    api.restaurantCreateOrderApi(data).then((value)async{
      setCreateOrderData(value);
      if(createOrderData.value.status == true) {
        setRxRequestStatus(Status.COMPLETED);
        Get.toNamed(AppRoutes.oderConfirm, arguments: {'type': "restaurant","order_no" :createOrderData.value.orderIds?.first.toString()});
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.getString('saved_tip_${cartType.value}') ?? '';
        var removed =  await prefs.remove('saved_tip_${cartType.value}');
        pt("tips removed>>>>>>>>>>>>>>>>>>>>>>>>>> getAllCartData $removed");
      }
      else if(value.status == false){
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

  void setError(String value) => error.value = value;

  RxDouble newTotalIncludingTips = 0.00.obs;
  RxDouble newTotalWithoutIncludingTips = 0.00.obs;

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

//------------------------------------------14-7-25--------------------------------------------------------------------------------
  void updateBalanceAfterTips({
    required String totalPrice,
    required String walletBalance,
    bool loadFromPrefs = false,
  }) async{

    if (loadFromPrefs) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String savedTip = prefs.getString('saved_tip_${cartType.value}') ?? '';


      enteredTips.value = savedTip;
      tipsController.value.text = savedTip;

      pt("[$cartType] Save tips and update wallet balance: ${enteredTips.value}");

      if (savedTip == '5') {
        selectedTipsIndexValue.value = 0;
      } else if (savedTip == '10') {
        selectedTipsIndexValue.value = 1;
      } else if (savedTip == '15') {
        selectedTipsIndexValue.value = 2;
      } else if (savedTip.isNotEmpty) {
        selectedTipsIndexValue.value = 3;
      } else {
        selectedTipsIndexValue.value = -1;
      }
    }
    double tipsAmount = 0.0;
    if (selectedTipsIndexValue.value == 0) {
      tipsAmount = 5.0;
    }
    else if (selectedTipsIndexValue.value == 1) {
      tipsAmount = 10.0;
    }
    else if (selectedTipsIndexValue.value == 2) {
      tipsAmount = 15.0;
    }
    else if (selectedTipsIndexValue.value == 3) {
      tipsAmount = double.tryParse(enteredTips.value) ?? 0.0;
    }

    final double totalPriceDouble = double.tryParse(totalPrice.replaceAll(',', '')) ?? 0.0;
    final double walletBalDouble = double.tryParse(walletBalance.replaceAll(',', '')) ?? 0.0;
    final double totalWithTips = totalPriceDouble + tipsAmount;

    totalPriceIncludingTips.value = totalWithTips;

    if (walletSelected.value) {
      if (walletBalDouble >= totalWithTips) {
        walletDiscount.value = totalWithTips;
        payAfterWallet.value = 0.0;
        isSelectable.value = true;
      }
      else {
        walletDiscount.value = walletBalDouble;
        payAfterWallet.value = totalWithTips - walletBalDouble;
        isSelectable.value = false;
      }
    }
    else {
      walletDiscount.value = 0.0;
      payAfterWallet.value = totalWithTips;
      isSelectable.value = false;
    }

    newPayAfterWallet.value = payAfterWallet.value;
    newTotalIncludingTips.value = totalPriceIncludingTips.value;

    if (walletSelected.value && walletBalDouble >= totalWithTips) {
      selectedIndex.value = 0;
      isSelectable.value = true;
    }
    update();
  }


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

}
