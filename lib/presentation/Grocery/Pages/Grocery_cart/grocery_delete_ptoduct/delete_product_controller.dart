import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/Controller/grocery_cart_controller.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/Single_Grocery_Vendor_cart/single_vendor_controller.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/grocery_delete_ptoduct/delete_grocery_product_modal.dart';

class DeleteGroceryProductController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final deleteProductData = DeleteGroceryProductModal().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setData(DeleteGroceryProductModal value) =>
      deleteProductData.value = value;

  final GroceryCartController groceryCartController =
      Get.put(GroceryCartController());

  final SingleGroceryCartController singleGroceryCartController =
      Get.put(SingleGroceryCartController());

  deleteProductApi({
    bool? fromSingle = false,
    required String productId,
    required String countId,
    required String cartId,
  }) async {
    setRxRequestStatus(Status.LOADING);
    var body = {
      "product_id": productId,
      "count_id": countId,
      "cart_id": cartId,
    };
    api.deleteGroceryProductApi(body).then((value) {
      setData(value);
      if (deleteProductData.value.status == true) {
        print("object fromSingle $fromSingle");
        if (fromSingle == true) {
          singleGroceryCartController.getGrocerySingleVendorCartApi(cartId).then((value) async {
            singleGroceryCartController.update();
            // await Future.delayed(const Duration(milliseconds: 500));
            setRxRequestStatus(Status.COMPLETED);
            Get.back();
          });
        } else {
          groceryCartController.getGroceryAllCartApi().then((value) async {
            // await Future.delayed(const Duration(milliseconds: 500));
            setRxRequestStatus(Status.COMPLETED);
            Get.back();
          });
        }
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
