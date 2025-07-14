import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Shared/theme/font_family.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/pharma_cart_modal/PharmaCartModal.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/pharma_cart_modal/pharmacy_create_order_model.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/prescription/prescription_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/modal/grocery_order_type_model.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';

import '../pharma_cart_modal/pharmacyCheckoutAllModel.dart';
import '../pharma_cart_modal/pharmacy_all_product_model.dart';

class PharmacyCartController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final cartData = PharmacySingleCartModel().obs;


  PrescriptionController prescriptionController = Get.put(PrescriptionController());

  final Rx<TextEditingController> couponCodeController =     TextEditingController().obs;

  var readOnly = true.obs;

  RxString error = ''.obs;
  //-----------------Get Single pharmacy cart data api

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void cartSet(PharmacySingleCartModel value) {
    cartData.value = value;
  }
  // void cartSetAll(PharmacyAllCartProductModel value) {
  //   cartDataAll.value = value;
  // }

  void setError(String value) => error.value = value;

  getPharmacyCartApi({required String cartId}) async {
    readOnly.value = true;
    couponCodeController.value.clear();
    setRxRequestStatus(Status.LOADING);
    api.pharmacyCartGetDataApi({'cart_id': cartId}).then((value) {
      cartSet(value);
      // cartSetAll(value);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr${error.toString()}');
      setRxRequestStatus(Status.ERROR);
    });
  }

  getPharmacyCartApiAfterInc({required String cartId}) async {
    readOnly.value = true;
    couponCodeController.value.clear();
    // setRxRequestStatus(Status.LOADING);
    api.pharmacyCartGetDataApi({'cart_id': cartId}).then((value) {
      cartSet(value);
      // cartSetAll(value);
      // setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr${error.toString()}');
      setRxRequestStatus(Status.ERROR);
    });
  }

  refreshApi({required String cartId}) async {
    setRxRequestStatus(Status.LOADING);
    couponCodeController.value.clear();
    readOnly.value = true;
    api.pharmacyCartGetDataApi({'cart_id': cartId}).then((value) {
      cartSet(value);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr${error.toString()}');
      setRxRequestStatus(Status.ERROR);
    });
  }

  //-----------checkout btn api

  final singleCartDataBtn = PharmacySingleCartModel().obs;
  final rxRequestStatusSingleCartBtn = Status.COMPLETED.obs;
  void singleCartSetBtn(PharmacySingleCartModel value) => singleCartDataBtn.value = value;
  void setRxRequestStatusSingleCartBtn(Status value) => rxRequestStatusSingleCartBtn.value = value;

  checkoutBtnApi(context,{required String cartId}) async {
    var data = {
      "cart_id" : cartId,
    };
    Map<String, dynamic> params = {
      "key" : "checkout",
    };
    setRxRequestStatusSingleCartBtn(Status.LOADING);
    api.pharmacyCartGetDataApi(data,params: params).then((value) {
      singleCartSetBtn(value);
      if(singleCartDataBtn.value.status == true){
        setRxRequestStatusSingleCartBtn(Status.COMPLETED);
        Get.toNamed(
          AppRoutes.prescriptionScreen,
          arguments: {
            'address_id': singleCartDataBtn.value.address?.id.toString(),
            'total': singleCartDataBtn.value.cart?.finalTotal.toString(),
            'coupon_id': singleCartDataBtn.value.cart?.raw?.couponId ?? "",
            'regular_price': singleCartDataBtn.value.cart?.raw?.regularPrice.toString(),
            'save_amount': singleCartDataBtn.value.cart?.raw?.saveAmount.toString(),
            'delivery_charge': cartData.value.cart?.deliveryCharge.toString(),
            'cart_id': cartData.value.cart?.cartId,
            'vendor_id': cartData.value.cart!.raw?.pharmaId.toString(),
            'cart_total':cartData.value.cart?.raw?.totalPrice,
            'cart_delivery': cartData.value.cart?.deliveryCharge,
            'wallet':cartData.value.wallet.toString(),
            'cartType': "pharmacy",
            'grandtotal_price' : cartData.value.cart?.finalTotal.toString(),
            'coupon_discount': cartData.value.cart?.couponDiscount.toString(),
            'coupon_discount_payment_details': cartData.value.cart?.couponDiscount.toString(),
          },
        );
      }else if(singleCartDataBtn.value.status == false){
        setRxRequestStatusSingleCartBtn(Status.COMPLETED);
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              backgroundColor: Colors.white,
              titlePadding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 8.h),
              contentPadding: REdgeInsets.symmetric(horizontal: 22,vertical: 15),
              actionsPadding: REdgeInsets.symmetric(horizontal: 25),
              insetPadding:REdgeInsets.symmetric(horizontal: 22),
              title:Icon(Icons.error_outline, color: AppColors.red, size: 24.r),
              content: Text(
                singleCartDataBtn.value.message?.toString() ?? "Something went wrong.",
                maxLines: 5,
                textAlign: TextAlign.center,
                style: AppFontStyle.text_16_500(
                  AppColors.darkText,
                  family: AppFontFamily.gilroyMedium,
                ),
              ),
              actions: <Widget>[
                CustomElevatedButton(
                  onPressed: () {
                    Get.back(); // Close dialog
                  },
                  child: Text(
                    'OK',
                    style: AppFontStyle.text_15_600(
                      AppColors.white,
                      family: AppFontFamily.gilroyMedium,
                    ),
                  ),
                ),
                hBox(20.h),
              ],
            );
          },
        );
      }
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr${error.toString()}');
      setRxRequestStatusSingleCartBtn(Status.ERROR);
    });
  }


  //-----------------Get all pharmacy cart data api (Home screen)

  final cartDataAll = PharmacyAllCartProductModel().obs;
  void setCartData(PharmacyAllCartProductModel value){
    cartDataAll.value = value;
  }

  final rxGetAllPCartData = Status.LOADING.obs;
  void rxSetGetAllPCartData(Status value) => rxGetAllPCartData.value = value;

    getAllPharmacyCartData() async {
      rxSetGetAllPCartData(Status.LOADING);
      api.getAllPharmacyCartDataApi().then((value) {
        setCartData(value);
        if(cartDataAll.value.status == true){
          rxSetGetAllPCartData(Status.COMPLETED);
        }
      },).onError((error, stackError) {
        setError(error.toString());
        print(stackError);
        print('errrrrrrrrrrrr SetGetAllPCartData : ${error.toString()}');
        rxSetGetAllPCartData(Status.ERROR);
      });
    }


//-----------------Get all pharmacy cart data api (My cart screen)


  final cartCheckoutData = PharmacyCheckOutAllModel().obs;
  void setCartCheckoutData(PharmacyCheckOutAllModel value){
    cartCheckoutData.value = value;
  }

  final rxGetCheckoutDataStatus = Status.LOADING.obs;
  void rxSetGetCheckoutData(Status value) => rxGetCheckoutDataStatus.value = value;

  getAllCartProductsForCheckout() async {
    rxSetGetCheckoutData(Status.LOADING);
    api.getPharmacyCheckOutAllApi().then((value) {
      setCartCheckoutData(value);
      if (value.status == true) {
        rxSetGetCheckoutData(Status.COMPLETED);
      }else if(!value.status){
        rxSetGetCheckoutData(Status.COMPLETED);
      }
    },).onError((error, stackTrace) {
      setError(error.toString());
      print(stackTrace);
      print('errrrrrrrrrrrr getPharmacyCheckOutAllApi : ${error.toString()}');
      rxSetGetCheckoutData(Status.ERROR);
    },);
  }

  //checkout btn api call
  final cartCheckoutBtnData = PharmacyCheckOutAllModel().obs;
  void setCartCheckoutBtnData(PharmacyCheckOutAllModel value){
    cartCheckoutBtnData.value = value;
  }

  final rxGetCheckoutBtnDataStatus = Status.COMPLETED.obs;
  void rxSetGetCheckoutBtnData(Status value) => rxGetCheckoutBtnDataStatus.value = value;

  checkoutBtnApiCall(context) async {
    rxSetGetCheckoutBtnData(Status.LOADING);
    var params = {
      "key" : "checkout",
    };
    api.getPharmacyCheckOutAllApi(params: params).then((value) {
      setCartCheckoutBtnData(value);
      if (value.status == true) {
        rxSetGetCheckoutBtnData(Status.COMPLETED);
        final vendorId = cartCheckoutBtnData.value.cart?.buckets
            ?.map((data) => data.pharmaId)
            .toList();
        final cartId = cartCheckoutBtnData.value.cart?.buckets
            ?.map((data) => data.cartId)
            .toList();
        final specificTotalPrice = cartCheckoutBtnData.value.cart?.buckets
            ?.map((data) => data.specificTotalPrice)
            .toList();
        final specificDeliveryCharge = cartCheckoutBtnData.value.cart?.buckets
            ?.map((data) => data.specificDeliveryCharge)
            .toList();

        final grandTotalPrice = cartCheckoutBtnData.value.cart?.buckets?.map((data) => data.grandtotalPrice).toList();
        final couponDiscount = cartCheckoutBtnData.value.cart?.buckets?.map((data) => data.couponDiscount).toList();

        print("grandTotalPrice>>> $grandTotalPrice");
        Get.toNamed(AppRoutes.prescriptionScreen, arguments: {
          'address_id': cartCheckoutBtnData.value.address?.id.toString(),
          'total': cartCheckoutBtnData.value.cart?.grandTotalPrice.toString(),
          'coupon_id': cartCheckoutBtnData.value.appliedCoupon?.id.toString(),
          'regular_price': cartCheckoutBtnData.value.cart!.regularPrice.toString(),
          'coupon_discount_payment_details': cartCheckoutBtnData.value.cart!.couponDiscount.toString(),
          'save_amount': cartCheckoutBtnData.value.cart!.saveAmount.toString(),
          'delivery_charge': cartCheckoutBtnData.value.cart!.deliveryCharge.toString(),
          'cart_id': cartId,
          'vendor_id': vendorId,
          'cart_total': specificTotalPrice,
          'cart_delivery': specificDeliveryCharge,
          'wallet': cartCheckoutBtnData.value.wallet.toString(),
          'cartType': "pharmacy",
          'prescription': cartCheckoutBtnData.value.prescription.toString(),
          // 'prescription': cartCheckoutData.value.prescription.toString(),
          'grandtotal_price' : grandTotalPrice,
          'coupon_discount': couponDiscount,
        });
      }
      else if(value.status == false){
        rxSetGetCheckoutBtnData(Status.COMPLETED);
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              backgroundColor: Colors.white,
              titlePadding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 8.h),
              contentPadding: REdgeInsets.symmetric(horizontal: 22,vertical: 15),
              actionsPadding: REdgeInsets.symmetric(horizontal: 25),
              insetPadding:REdgeInsets.symmetric(horizontal: 22),
              title:Icon(Icons.error_outline, color: AppColors.red, size: 24.r),
              content: Text(
                cartCheckoutBtnData.value.message?.toString() ?? "Something went wrong.",
                maxLines: 5,
                textAlign: TextAlign.center,
                style: AppFontStyle.text_16_500(
                  AppColors.darkText,
                  family: AppFontFamily.gilroyMedium,
                ),
              ),
              actions: <Widget>[
                CustomElevatedButton(
                  onPressed: () {
                    Get.back(); // Close dialog
                  },
                  child: Text(
                    'OK',
                    style: AppFontStyle.text_15_600(
                      AppColors.white,
                      family: AppFontFamily.gilroyMedium,
                    ),
                  ),
                ),
                hBox(20.h),
              ],
            );
          },
        );
      }else{
        rxSetGetCheckoutBtnData(Status.COMPLETED);
      }
    },).onError((error, stackTrace) {
      setError(error.toString());
      print(stackTrace);
      print('errrrrrrrrrrrr getPharmacyCheckOutAllApi : ${error.toString()}');
      rxSetGetCheckoutBtnData(Status.ERROR);
    },);
  }

    refreshGetAllCartProductsForCheckout() async {
    // rxSetGetCheckoutData(Status.LOADING);
    api.getPharmacyCheckOutAllApi().then((value) {
      setCartCheckoutData(value);
      if(value.status == true){
        rxSetGetCheckoutData(Status.COMPLETED);
      }
    },).onError((error, stackTrace) {
      setError(error.toString());
      print(stackTrace);
      print('errrrrrrrrrrrr getPharmacyCheckOutAllApi : ${error.toString()}');
      rxSetGetCheckoutData(Status.ERROR);
    },);
  }

/*-------------------------------------------Pharmacy Create Order----------------------------------------------------------*/
  Future<void> deleteTips()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('saved_tip_restaurant') ?? '';
    var removed =  await prefs.remove('saved_tip_restaurant');
    pt("tips removed>>>>>>>>>>>>>>>>>>>>>>>>>> getAllCartData $removed");
  }


  final rxRequestStatusCreateOrder = Status.COMPLETED.obs;
  void rxSetRequestStatusCreateOrder(Status val) => rxRequestStatusCreateOrder.value = val;
  final createOrderApiData =  PharmacyCreateOrderModel().obs;
  void setApiData(PharmacyCreateOrderModel val)=> createOrderApiData.value = val;

  pharmacyCreateOrder({
    required bool isWalletUsed,
    required String walletAmount,
    required String paymentMethod,
    required String paymentAmount,
    required String addressId,
    required String couponId,
    required String totalAmount,
    required List<String> cartIds,
    required List<Map<String,dynamic>> carts,
    required List<dynamic> prescription,
    required String deliveryNotes,
    required String deliverySoon,
    required String courierTip,
    String? referenceId,
    String? transactionId,
  }) async {
    var data = {
      "wallet_used": isWalletUsed.toString(),
      "wallet_amount": walletAmount.toString(),
      "payment_method": paymentMethod.toString(),
      "payment_amount": paymentAmount.toString(),
      "address_id": addressId.toString(),
      "coupon_id": couponId.toString(),
      "total": totalAmount.toString(),
      'sub_total' : totalAmount.toString(),
      "type": "pharmacy",
      "cart_ids": jsonEncode(cartIds),
      "carts": jsonEncode(carts),
      if(deliveryNotes.isNotEmpty)
      'delivery_notes' : deliveryNotes,
      if(deliverySoon.isNotEmpty)
        'delivery_soon' : deliverySoon,
      if(courierTip.isNotEmpty)
        'courier_tip' : courierTip,
      if(prescription.isNotEmpty)
      'drslip' : jsonEncode(prescription),
      if (referenceId != null && referenceId.isNotEmpty)
        'reference_id'  :  referenceId,
      if (transactionId != null && transactionId.isNotEmpty)
        'transaction_id' : transactionId,
    };
    if(kDebugMode) {
      log("data body >>>:: $data");
    }
    rxSetRequestStatusCreateOrder(Status.LOADING);
    api.pharmacyCreateOrderApi(data).then((value) {
      if(value.status == true) {
        rxSetRequestStatusCreateOrder(Status.COMPLETED);
        prescriptionController.imageList = RxList<Rx<File?>>([Rx<File?>(null)]);
        prescriptionController.base64ImageList = <String>[].obs;
        Utils.showToast(value.message.toString());
        Get.toNamed(AppRoutes.oderConfirm, arguments: {'type': "pharmacy"});
        getAllPharmacyCartData();
        deleteTips();
      }if(value.status == false){
        rxSetRequestStatusCreateOrder(Status.ERROR);
        Utils.showToast(value.message.toString());
      }
    },).onError((error, stackTrace) {
      print("Error create order $error");
      setError(error.toString());
      rxSetRequestStatusCreateOrder(Status.COMPLETED);
    },);
  }


//----------------------pharmacy OrderType Api--------------------------------
  final rxRequestStatusOrderType = Status.COMPLETED.obs;
  void setRxRequestStatusOrderType(Status value)=>rxRequestStatusOrderType.value = value;

  final apiDataOrderType = OrderTypeModel().obs;
  void setOrderDataOrderType(OrderTypeModel value){
    apiDataOrderType.value = value;
  }

  RxInt loadingIndex = (-1).obs;
  RxString loadingType = ''.obs;

  Future<void> pharmacyOrderTypeApi({required int index,required String cartId,required String type,bool? isSingleCartScreen})async{
    var data = {
      "cart_id": cartId,
      "type": type,
    };
    // if(type == "self"){
    //   cartCheckoutData.value.cart?.buckets?[index].isDelivery.value = false;
    // }else if(type == 'delivery'){
    //   cartCheckoutData.value.cart?.buckets?[index].isDelivery.value = true;
    // }

    loadingIndex.value = index;
    loadingType.value = type;

    setRxRequestStatusOrderType(Status.LOADING);
    api.orderTypePharmacyApi(data).then((value) {
      setOrderDataOrderType(value);
      if(apiDataOrderType.value.status == true){
        // if(type == "self"){
        //   cartCheckoutData.value.cart?.buckets?[index].isDelivery.value = false;
        // }else if(type == 'delivery'){
        //   cartCheckoutData.value.cart?.buckets?[index].isDelivery.value = true;
        // }
        isSingleCartScreen == true ? getPharmacyCartApiAfterInc(cartId: cartId) : refreshGetAllCartProductsForCheckout();
        setRxRequestStatusOrderType(Status.COMPLETED);
        loadingIndex.value = -1;
        loadingType.value = '';
        Utils.showToast(apiDataOrderType.value.message.toString().capitalize.toString());
      }else if(apiDataOrderType.value.status == false){
        if(type == "self"){
          cartCheckoutData.value.cart?.buckets?[index].isDelivery.value = true;
        }else if(type == 'delivery'){
          cartCheckoutData.value.cart?.buckets?[index].isDelivery.value = false;
        }
        setRxRequestStatusOrderType(Status.COMPLETED);
        loadingIndex.value = -1;
        loadingType.value = '';
        Utils.showToast(apiDataOrderType.value.message.toString().capitalize.toString());
      }
    },).onError((error, stackTrace) {
      print("error order type pharma>>>>>>>>>$error");
      print("error order type pharma>>>>>>>>>$stackTrace");
      setRxRequestStatusOrderType(Status.ERROR);
      loadingIndex.value = -1;
      loadingType.value = '';
    },);
  }

}