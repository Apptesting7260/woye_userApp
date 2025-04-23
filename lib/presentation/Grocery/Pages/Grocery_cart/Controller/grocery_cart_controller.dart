import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/grocery_cart_modal/GroceryCartModal.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/show_all_grocery_carts/grocery_allCart_controller.dart';

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
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr${error.toString()}');
      setRxRequestStatus(Status.ERROR);
    });
  }


  /// -------------------------------------------------------------------------------------------
  final rxCreateOrderRequestStatus = Status.COMPLETED.obs;
  void setRxCreateOrderRequestStatus(Status value)=>rxCreateOrderRequestStatus.value = value;
  final createOrderGApiData = GroceryCreateOrderModel().obs;

  void setOrderData(GroceryCreateOrderModel apiData){
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
    required List<Map<String,dynamic>> carts,
  }) async {
    var data = {
       "wallet_used": walletUsed.toString(),
       "wallet_amount": walletAmount,
       "payment_method": paymentMethod,
       "payment_amount": paymentAmount,
       "address_id": addressId,
       "coupon_id": couponId,
       "total":total,
       "type": "grocery",
       "cart_ids": jsonEncode(cartIds),
       "carts": jsonEncode(carts),
     };
    debugPrint("dataValue  >> $data");
    setRxCreateOrderRequestStatus(Status.LOADING);
    api.groceryCreateOrderApi(data).then((value) {
      setOrderData(value);
      setRxCreateOrderRequestStatus(Status.COMPLETED);
      // Utils.showToast(value.message.toString());
      Get.toNamed(AppRoutes.oderConfirm, arguments: {'type': "grocery"});
    },)
        .onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('error create order grocery : ${error.toString()}');
      setRxCreateOrderRequestStatus(Status.ERROR);
    });
  }

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