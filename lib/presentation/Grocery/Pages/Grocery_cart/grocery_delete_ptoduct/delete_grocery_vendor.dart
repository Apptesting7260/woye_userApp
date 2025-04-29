import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/Controller/grocery_cart_controller.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/grocery_delete_ptoduct/delete_grocery_product_modal.dart';

import '../show_all_grocery_carts/grocery_allCart_controller.dart';

class DeleteGroceryVendorController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final deleteProductData = DeleteGroceryProductModal().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setData(DeleteGroceryProductModal value) =>
      deleteProductData.value = value;

  final GroceryCartController groceryCartController = Get.put(GroceryCartController());
  final GroceryShowAllCartController groceryShowAllCartController = Get.put(GroceryShowAllCartController());

  deleteProductApi({
    required String cartId,
  }) async {
    setRxRequestStatus(Status.LOADING);
    var body = {
      "cart_id": cartId,
    };
    api.deleteGroceryVendorApi(body).then((value) {
      setData(value);
      if (deleteProductData.value.status == true) {
        groceryCartController.getGroceryAllCartApi().then((value) async {
          await Future.delayed(const Duration(milliseconds: 500));
          setRxRequestStatus(Status.COMPLETED);
          groceryShowAllCartController.refreshApi();
        });
      } else {
        Utils.showToast(deleteProductData.value.message.toString());
        setRxRequestStatus(Status.COMPLETED);
      }
    }).onError((error, stackError) {
      print("Error: $error");
      setError(error.toString());
      print(stackError);
      setRxRequestStatus(Status.ERROR);
    });
  }

  void setError(String value) => error.value = value;
}
