import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/banner_screens/pharma_banner_details_modal.dart';

class PharmaBannerDetailsControllerController extends GetxController {
  final api = Repository();

  final rxRequestStatus = Status.COMPLETED.obs;
  final bannerData = PharmaBannerModal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void bannerDataSet(PharmaBannerModal value) => bannerData.value = value;

  void setError(String value) => error.value = value;

  bannerDataApi({
    required String bannerId,
  }) async {
    setRxRequestStatus(Status.LOADING);
    Map data = {
      "banner_id": bannerId,
    };
    api.pharmacyBannerApi(data).then((value) {
      bannerDataSet(value);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }
}
