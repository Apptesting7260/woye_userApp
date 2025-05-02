import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/pharma_cart_modal/PharmaCartModal.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/pharma_cart_modal/pharmacy_create_order_model.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/prescription/prescription_controller.dart';

import '../pharma_cart_modal/pharmacyCheckoutAllModel.dart';
import '../pharma_cart_modal/pharmacy_all_product_model.dart';

class PharmacyCartController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final cartData = PharmaCartModal().obs;


  PrescriptionController prescriptionController = Get.put(PrescriptionController());

  final Rx<TextEditingController> couponCodeController =     TextEditingController().obs;

  var readOnly = true.obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void cartSet(PharmaCartModal value) {
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
      'drslip' : jsonEncode(prescription),
    };
    if(kDebugMode) {
      log("data body >>> $data");
    }
    rxSetRequestStatusCreateOrder(Status.LOADING);
    api.pharmacyCreateOrderApi(data).then((value) {
      if(value.status == true) {
        rxSetRequestStatusCreateOrder(Status.COMPLETED);
        prescriptionController.imageList = RxList<Rx<File?>>([Rx<File?>(null)]);
        Utils.showToast(value.message.toString());
        Get.toNamed(AppRoutes.oderConfirm, arguments: {'type': "pharmacy"});
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


}