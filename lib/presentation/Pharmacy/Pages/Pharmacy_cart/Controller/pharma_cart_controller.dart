import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/pharma_cart_modal/PharmaCartModal.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/pharma_cart_modal/pharmacy_create_order_model.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/prescription/prescription_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/modal/grocery_order_type_model.dart';

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
      "type": "pharmacy",
      "cart_ids": jsonEncode(cartIds),
      "carts": jsonEncode(carts),
      'delivery_notes' : deliveryNotes,
      'delivery_soon' : deliverySoon,
      'courier_tip' : courierTip,
      if(prescription.isNotEmpty)
      'drslip' : jsonEncode(prescription),
      'reference_id'  :  referenceId,
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