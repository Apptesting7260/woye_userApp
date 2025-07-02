import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/grocery_cart_modal/GroceryCartModal.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/show_all_grocery_carts/grocery_allCart_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/modal/grocery_order_type_model.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';

import '../Single_Grocery_Vendor_cart/single_vendor_controller.dart';
import '../grocery_cart_modal/grocery_create_order_model.dart';

class GroceryCartController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final cartData = GroceryCartModal().obs;

  final Rx<TextEditingController> couponCodeController =
      TextEditingController().obs;

  var readOnly = true.obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void cartSet(GroceryCartModal value) {
    cartData.value = value;
  }

  void setError(String value) => error.value = value;

  final GroceryShowAllCartController groceryShowAllCartController =
      Get.put(GroceryShowAllCartController());

  getGroceryAllCartApi() async {
    readOnly.value = true;
    couponCodeController.value.clear();
    api.groceryAllCartGetDataApi().then((value) {
      groceryShowAllCartController.getGroceryAllShowApi();
      cartSet(value);
      setRxRequestStatus(Status.COMPLETED);
      if (value.status == false) {
        setRxRequestStatus(Status.COMPLETED);
        pt("cartData.value.message >>>>>>>>>>>>>> ${cartData.value.message}");
      }
    }).onError((error, stackError) {
      setError(error.toString());
      pt(stackError);
      pt('error grocery cart screen >>>> ::: ${error.toString()}');
      setRxRequestStatus(Status.ERROR);
    });
  }
  refreshGetGroceryAllCartApi() async {
    readOnly.value = true;
    couponCodeController.value.clear();
    api.groceryAllCartGetDataApi().then((value) {
      groceryShowAllCartController.getGroceryAllShowApi();
      cartSet(value);
      setRxRequestStatus(Status.COMPLETED);
      if (value.status == false) {
        setRxRequestStatus(Status.COMPLETED);
        pt("cartData.value.message >>>>>>>>>>>>>> ${cartData.value.message}");
      }
    }).onError((error, stackError) {
      setError(error.toString());
      pt(stackError);
      pt('error grocery cart screen >>>> ::: ${error.toString()}');
      setRxRequestStatus(Status.ERROR);
    });
  }

  /// -------------------------------------------------------------------------------------------
  final rxCreateOrderRequestStatus = Status.COMPLETED.obs;
  void setRxCreateOrderRequestStatus(Status value) =>
      rxCreateOrderRequestStatus.value = value;
  final createOrderGApiData = GroceryCreateOrderModel().obs;

  void setOrderData(GroceryCreateOrderModel apiData) {
    createOrderGApiData.value = apiData;
  }

  createOrderGrocery({
    required bool walletUsed,
    required String walletAmount,
    required String paymentMethod,
    required String paymentAmount,
    required String addressId,
    required String couponId,
    required String total,
    required String type,
    required List<String> cartIds,
    required List<Map<String, dynamic>> carts,
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
      "total": total,
      "type": "grocery",
      "cart_ids": jsonEncode(cartIds),
      "carts": jsonEncode(carts),
      'delivery_notes': deliveryNotes,
      'delivery_soon': deliverySoon,
      'courier_tip': courierTip,
      'reference_id'  :  referenceId,
      'transaction_id' : transactionId,
    };
    debugPrint("dataValue  >> $data");
    setRxCreateOrderRequestStatus(Status.LOADING);
    api.groceryCreateOrderApi(data).then(
      (value) {
        setOrderData(value);
        if (value.status == true) {
          setRxCreateOrderRequestStatus(Status.COMPLETED);
          Get.toNamed(AppRoutes.oderConfirm, arguments: {'type': "grocery"});
        } else if (value.status == false) {
          setRxCreateOrderRequestStatus(Status.ERROR);
          Utils.showToast(value.message.toString());
        }
      },
    ).onError((error, stackError) {
      setError(error.toString());
      // print(stackError);
      print('error create order grocery : ${error.toString()}');
      setRxCreateOrderRequestStatus(Status.ERROR);
    });
  }

//----------------------groceryOrderTypeApi--------------------------------
  final rxRequestStatusOrderType = Status.COMPLETED.obs;
  void setRxRequestStatusOrderType(Status value) =>
      rxRequestStatusOrderType.value = value;
  SingleGroceryCartController singleGroceryCartController = Get.put(SingleGroceryCartController());
  final apiDataOrderType = OrderTypeModel().obs;
  void setOrderDataOrderType(OrderTypeModel value) {
    apiDataOrderType.value = value;
  }
  RxInt loadingIndex = (-1).obs;
  RxString loadingType = ''.obs;

  Future<void> groceryOrderTypeApi(
      {required int index,
      required String cartId,
      required String type,bool? isSingleCartScreen}) async {
    var data = {
      "cart_id": cartId,
      "type": type,
    };
    if(type == "self"){
      cartData.value.cart?.buckets?[index].isDelivery.value = false;
    }else if(type == 'delivery'){
      cartData.value.cart?.buckets?[index].isDelivery.value = true;
    }
    loadingIndex.value = index;
    loadingType.value = type;

    setRxRequestStatusOrderType(Status.LOADING);
    api.groceryOrderTypeApi(data).then(
      (value) {
        setOrderDataOrderType(value);
        if (apiDataOrderType.value.status == true) {
          if (type == "self") {
            cartData.value.cart?.buckets?[index].isDelivery.value = false;
          } else if (type == 'delivery') {
            cartData.value.cart?.buckets?[index].isDelivery.value = true;
          }
          isSingleCartScreen == true ?singleGroceryCartController.refreshApi(cartId) : refreshGetGroceryAllCartApi();
          setRxRequestStatusOrderType(Status.COMPLETED);
          Utils.showToast(apiDataOrderType.value.message.toString().capitalize.toString());
          loadingIndex.value = -1;
          loadingType.value = '';

        } else if (apiDataOrderType.value.status == false) {
          if (type == "self") {
            cartData.value.cart?.buckets?[index].isDelivery.value = true;
          } else if (type == 'delivery') {
            cartData.value.cart?.buckets?[index].isDelivery.value = false;
          }
          setRxRequestStatusOrderType(Status.COMPLETED);
          Utils.showToast(apiDataOrderType.value.message.toString().capitalize.toString());
          loadingIndex.value = -1;
          loadingType.value = '';
        }
      },
    ).onError(
      (error, stackTrace) {
        print("error order type G>>>>>>>>>$error");
        print("error order type G>>>>>>>>>$stackTrace");
        setRxRequestStatusOrderType(Status.ERROR);
        loadingIndex.value = -1;
        loadingType.value = '';
      },
    );
  }

//------------------------------------------------------

  refreshApi() async {
    setRxRequestStatus(Status.LOADING);
    couponCodeController.value.clear();
    readOnly.value = true;
    api.groceryAllCartGetDataApi().then((value) {
      cartSet(value);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr refreshApi ${error.toString()}');
      setRxRequestStatus(Status.ERROR);
    });
  }
}
