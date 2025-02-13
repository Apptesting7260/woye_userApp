import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/Controller/pharma_cart_controller.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/pharma_quantity_update/pharma_quantity_update_modal.dart';

class PharmaQuantityController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final quantityData = PharmaQuantityUpdateModal().obs;
  RxString error = ''.obs;
  String token = "";

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setData(PharmaQuantityUpdateModal value) => quantityData.value = value;

  final PharmacyCartController pharmacyCartController =
      Get.put(PharmacyCartController());

  updateQuantityApi({
    required String productId,
    required String productQuantity,
    required String countId,
  }) async {
    setRxRequestStatus(Status.LOADING);
    var body = {
      "product_id": productId,
      "quantity": productQuantity,
      "count_id": countId,
    };
    api.pharmacyUpdateQuantityApi(body).then((value) {
      setData(value);
      if (quantityData.value.status == true) {
        pharmacyCartController.getPharmacyCartApi().then((value) async {
          await Future.delayed(const Duration(milliseconds: 500));
          setRxRequestStatus(Status.COMPLETED);
          Utils.showToast(quantityData.value.message.toString());
        });
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
