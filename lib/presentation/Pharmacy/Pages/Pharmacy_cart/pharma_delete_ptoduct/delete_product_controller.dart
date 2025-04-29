import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/Controller/pharma_cart_controller.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/pharma_delete_ptoduct/delete_pharma_product_modal.dart';

class DeletePharmaProductController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final deleteProductData = DeletePharmaProductModal().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setData(DeletePharmaProductModal value) =>
      deleteProductData.value = value;

  final PharmacyCartController pharmacyCartController =     Get.put(PharmacyCartController());

  deleteProductApi({
    required String productId,
    required String countId,
    required String cartId,
    required bool isSingleCartScreen,
  }) async {
    setRxRequestStatus(Status.LOADING);
    var body = {
      "product_id": productId,
      "count_id": countId,
      "cart_id" : cartId,
    };
    api.deletePharmaProductApi(body).then((value) {
      setData(value);
      if (deleteProductData.value.status == true) {
        isSingleCartScreen == true ?
        pharmacyCartController.getPharmacyCartApi(cartId: cartId).then((value) async {
          // await Future.delayed(const Duration(milliseconds: 500));
          setRxRequestStatus(Status.COMPLETED);
        }):pharmacyCartController.getAllCartProductsForCheckout().then((value) async {
          // await Future.delayed(const Duration(milliseconds: 200));
          setRxRequestStatus(Status.COMPLETED);
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
