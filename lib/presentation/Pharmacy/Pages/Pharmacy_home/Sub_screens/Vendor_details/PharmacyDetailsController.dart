import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Vendor_details/pharmacy_details_modal.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/modal/singal_restaurant_modal.dart';


class PharmacyDetailsController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final restaurant_Data = SpecificPharmacyModal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void restaurant_Set(SpecificPharmacyModal value) =>
      restaurant_Data.value = value;

  void setError(String value) => error.value = value;

  restaurant_Details_Api({
    required String id,
  }) async {
    setRxRequestStatus(Status.LOADING);

    Map data = {"pharma_id": id};

    api.specificPharmaShopApi(data).then((value) {
      restaurant_Set(value);
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
