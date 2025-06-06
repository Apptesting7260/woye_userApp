import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/modal/specific_product_modal.dart';
import 'package:intl/intl.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/banners_screens/banner_details_modal.dart';

class BannerDetailsController extends GetxController {
  final api = Repository();

  final rxRequestStatus = Status.COMPLETED.obs;
  final bannerData = BannerModal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void bannerDataSet(BannerModal value) => bannerData.value = value;

  void setError(String value) => error.value = value;

  bannerDataApi({
    required String bannerId,
  }) async {
    setRxRequestStatus(Status.LOADING);
    Map data = {
      "banner_id": bannerId,
    };
    api.restaurantBannerApi(data).then((value) {
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

  refreshBannerDataApi({
    required String bannerId,
  }) async {
    // setRxRequestStatus(Status.LOADING);
    Map data = {
      "banner_id": bannerId,
    };
    api.restaurantBannerApi(data).then((value) {
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
