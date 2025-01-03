import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Delivery_address/delivery_address_modal/delivery_address_modal.dart';

class DeliveryAddressController extends GetxController {
  @override
  void onInit() {
    getDeliveryAddressApi();
    // TODO: implement onInit
    super.onInit();
  }

  var selectedAddressIndex = 0.obs;

  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final deliveryAddressData = DeliveryAddressModal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setDeliveryAddress(DeliveryAddressModal value) {
    deliveryAddressData.value = value;
  }

  void setError(String value) => error.value = value;

  getDeliveryAddressApi() async {
    api.getAddressApi().then((value) {
      setDeliveryAddress(value);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('Error fetching delivery address');
      setRxRequestStatus(Status.ERROR);
    });
  }

  refreshDeliveryAddressApi() async {
    setRxRequestStatus(Status.LOADING);
    api.getAddressApi().then((value) {
      setDeliveryAddress(value);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('Error refreshing delivery address');
      setRxRequestStatus(Status.ERROR);
    });
  }
}
