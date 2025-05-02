import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/Single_Grocery_Vendor_cart/single_vendor_grocery_cart_model.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/show_all_grocery_carts/grocery_allCart_controller.dart';

class SingleGroceryCartController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final cartData = SingleVendorGroceryCart().obs;

  final Rx<TextEditingController> couponCodeController =
      TextEditingController().obs;



  var readOnly = true.obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void cartSet(SingleVendorGroceryCart value) {
    cartData.value = value;
  }

  void setError(String value) => error.value = value;


  final GroceryShowAllCartController groceryShowAllCartController =
  Get.put(GroceryShowAllCartController());
  getGrocerySingleVendorCartApi(var cartId) async {
    readOnly.value = true;
    couponCodeController.value.clear();
    Map data = {"cart_id": cartId};
    api.grocerySingleVendorCartApi(data).then((value) {
      cartSet(value);
      if(cartData.value.cart == null){
        Get.back();
      }
      groceryShowAllCartController.getGroceryAllShowApi();
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr${error.toString()}');
      setRxRequestStatus(Status.ERROR);
    });
  }

  refreshApi(var cartId) async {
    // setRxRequestStatus(Status.LOADING);
    couponCodeController.value.clear();
    readOnly.value = true;
    Map data = {"cart_id": cartId};
    api.grocerySingleVendorCartApi(data).then((value) {
      cartSet(value);
      if(cartData.value.cart == null){
        Get.back();
      }
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr${error.toString()}');
      setRxRequestStatus(Status.ERROR);
    });
  }
}