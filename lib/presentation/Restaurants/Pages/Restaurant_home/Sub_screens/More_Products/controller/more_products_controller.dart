import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/More_Products/modal/see_all_products_modal.dart';

class seeAll_Product_Controller extends GetxController {
  final api = Repository();

  RxString selectedImageUrl = ''.obs;
  var pageController = PageController();

  final rxRequestStatus = Status.COMPLETED.obs;
  final seeAll_Data = seeAllProductsModal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void seeAlldata_Set(seeAllProductsModal value) => seeAll_Data.value = value;

  void setError(String value) => error.value = value;

  seeAll_Product_Api({
    required String restaurant_id,
    required String category_id,
  }) async {
    setRxRequestStatus(Status.LOADING);
    Map data = {
      "restaurant_id": restaurant_id,
      "category_id": category_id,
    };
    api.seeAllProductApi(data).then((value) {
      seeAlldata_Set(value);
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

  refresh_seeAll_Product_Api({
    required String restaurant_id,
    required String category_id,
  }) async {
    // setRxRequestStatus(Status.LOADING);
    Map data = {
      "restaurant_id": restaurant_id,
      "category_id": category_id,
    };
    api.seeAllProductApi(data).then((value) {
      seeAlldata_Set(value);
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
