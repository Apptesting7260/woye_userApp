import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/Controller/grocery_cart_controller.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/Single_Grocery_Vendor_cart/single_vendor_controller.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/grocery_quantity_update/grocery_quantity_update_modal.dart';

class GroceryQuantityController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final quantityData = GroceryQuantityUpdateModal().obs;
  RxString error = ''.obs;
  String token = "";

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setData(GroceryQuantityUpdateModal value) => quantityData.value = value;

  final GroceryCartController groceryCartController =
      Get.put(GroceryCartController());
  final SingleGroceryCartController singleGroceryCartController =
  Get.put(SingleGroceryCartController());

  updateQuantityApi({
    bool? fromSingle = false,
    required String cartId,
    required String productId,
    required String productQuantity,
    required String countId,
  }) async {
    setRxRequestStatus(Status.LOADING);
    var body = {
      "cart_id": cartId,
      "product_id": productId,
      "quantity": productQuantity,
      "count_id": countId,
    };
    api.groceryUpdateQuantityApi(body).then((value) {
      setData(value);
      if (quantityData.value.status == true) {
        if (fromSingle == true) {
          singleGroceryCartController.refreshApi(cartId).then((value) async {
            await Future.delayed(const Duration(milliseconds: 500));
            setRxRequestStatus(Status.COMPLETED);
            Utils.showToast(quantityData.value.message.toString());
          });
        } else {
          groceryCartController.refreshGetGroceryAllCartApi().then((value) async {
            await Future.delayed(const Duration(milliseconds: 500));
            setRxRequestStatus(Status.COMPLETED);
            Utils.showToast(quantityData.value.message.toString());
          });
        }
      } else if(quantityData.value.status == false) {
        Utils.showToast(quantityData.value.message.toString());
        setRxRequestStatus(Status.COMPLETED);
      } else {
        Utils.showToast(quantityData.value.message.toString());
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
