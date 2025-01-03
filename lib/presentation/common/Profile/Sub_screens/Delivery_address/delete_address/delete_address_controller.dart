import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Delivery_address/controller/delivery_address_controller.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Delivery_address/delete_address/delete_product_modal.dart';

class DeleteAddressController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final deleteAddressData = DeleteAddressModal().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setData(DeleteAddressModal value) => deleteAddressData.value = value;
  final DeliveryAddressController deliveryAddressController =
  Get.put(DeliveryAddressController());
  deleteAddressApi({
    required String addressId,
  }) async {
    setRxRequestStatus(Status.LOADING);
    var body = {
      "address_id": addressId,
    };
    api.deleteAddressApi(body).then((value) {
      setData(value);
      deliveryAddressController.getDeliveryAddressApi().then((value) {
        Utils.showToast(deleteAddressData.value.message.toString());
        setRxRequestStatus(Status.COMPLETED);
        Get.back();
        return;
      });
    }).onError((error, stackError) {
      print("Error: $error");
      setError(error.toString());
      print(stackError);
      setRxRequestStatus(Status.ERROR);
    });
  }

  void setError(String value) => error.value = value;
}
