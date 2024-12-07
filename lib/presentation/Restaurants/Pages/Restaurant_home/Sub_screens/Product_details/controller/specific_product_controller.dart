import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/modal/specific_product_modal.dart';

class specific_Product_Controller extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final product_Data = specificProduct().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void productdata_Set(specificProduct value) => product_Data.value = value;

  void setError(String value) => error.value = value;

  specific_Product_Api({
    required String product_id,
    required String category_id,
  }) async {
    setRxRequestStatus(Status.LOADING);

    Map data = {
      "product_id": product_id,
      "category_id": category_id,
    };

    api.specific_Product_Api(data).then((value) {
      productdata_Set(value);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }
}
