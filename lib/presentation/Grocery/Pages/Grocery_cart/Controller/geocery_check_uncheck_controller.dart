import 'package:get/get.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/Single_Grocery_Vendor_cart/single_vendor_grocery_cart_model.dart';

import '../../../../../Core/Utils/app_export.dart';
import '../../../../../Data/response/status.dart';
import '../Single_Grocery_Vendor_cart/single_vendor_controller.dart';

class GroceryCheckUnCheckController extends GetxController {
  final api = Repository();

  final rxRequestStatusCheckUncheck = Status.COMPLETED.obs;

  void setRxRequestStatusCheckUncheck(Status value)=>rxRequestStatusCheckUncheck.value = value;

  final SingleGroceryCartController singleGroceryCartController = Get.put(SingleGroceryCartController());
  RxString error = ''.obs;
  void setError(String value) => error.value = value;

  checkUncheckGrocery({
    required String cartId,
    required String productId,
    required String countId,
    required String status,
    // required Bucket item,
  }) async {

    setRxRequestStatusCheckUncheck(Status.LOADING);
    var data = {
      "cart_id": cartId,
      "product_id": productId,
      "count_id": countId,
      "status": status,
    };
    debugPrint("dataValue  >> $data");
    print(rxRequestStatusCheckUncheck.value);

    api.groceryCheckUncheckApi(data).then((value) {
      if(value.status == true) {
        singleGroceryCartController.refreshApi(cartId);
        setRxRequestStatusCheckUncheck(Status.COMPLETED);
        // item.isSelectedLoading.value = false;
      }else if(value.status == false){
        setRxRequestStatusCheckUncheck(Status.ERROR);
        // item.isSelectedLoading.value = false;
        Utils.showToast(value.message.toString());
      }
    },
    ).onError((error, stackError) {
      // item.isSelectedLoading.value = false;
      setError(error.toString());
      print(stackError);
      print('error check uncheck grocery : ${error.toString()}');
      setRxRequestStatusCheckUncheck(Status.ERROR);
    });
  }

}