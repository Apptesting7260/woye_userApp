import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/Controller/pharma_cart_controller.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/checked_unchecked_pharma/checked_unchecked_modal.dart';

class PharmaCheckedUncheckedController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final checkedUncheckedData = PharmaCheckedUncheckedModal().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setData(PharmaCheckedUncheckedModal value) =>
      checkedUncheckedData.value = value;

  final PharmacyCartController pharmacyCartController =
      Get.put(PharmacyCartController());

  checkedUncheckedApi({
    required String cartId,
    required String productId,
    required String status,
    required String countId,
  }) async {
    setRxRequestStatus(Status.LOADING);
    var body = {
      "cart_id": cartId,
      "product_id": productId,
      "status": status,
      "count_id": countId,
    };
    api.pharmaCheckedUncheckedApi(body).then((value) {
      setData(value);
      if (checkedUncheckedData.value.status == true) {
        pharmacyCartController.getPharmacyCartApi().then((value) async {
          await Future.delayed(const Duration(milliseconds: 800));
          Utils.showToast(checkedUncheckedData.value.message.toString());
          setRxRequestStatus(Status.COMPLETED);
        });
      } else {
        Utils.showToast(checkedUncheckedData.value.message.toString());
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
