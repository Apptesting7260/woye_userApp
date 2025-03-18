import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/banners/grocery_banner_details_modal.dart';

class GroceryBannerDetailsController extends GetxController {
  final api = Repository();

  final rxRequestStatus = Status.COMPLETED.obs;
  final bannerData = GroceryBannerModal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void bannerDataSet(GroceryBannerModal value) => bannerData.value = value;

  void setError(String value) => error.value = value;

  bannerDataApi({
    required String bannerId,
  }) async {
    setRxRequestStatus(Status.LOADING);
    Map data = {
      "banner_id": bannerId,
    };
    api.groceryBannerApi(data).then((value) {
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
