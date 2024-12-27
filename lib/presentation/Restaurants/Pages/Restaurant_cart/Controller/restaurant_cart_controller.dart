import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/modal/RestaurantCartModal.dart';

class RestaurantCartController extends GetxController {
  RxBool isSelected = false.obs;

  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final cartData = RestaurantCartModal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void cartSet(RestaurantCartModal value) {
    cartData.value = value;
  }

  void setError(String value) => error.value = value;

  getRestaurantCartApi() async {
    api.restaurantCartGetDataApi().then((value) {
      cartSet(value);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      setRxRequestStatus(Status.ERROR);
    });
  }

  refreshApi() async {
    setRxRequestStatus(Status.LOADING);
    api.restaurantCartGetDataApi().then((value) {
      cartSet(value);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      setRxRequestStatus(Status.ERROR);
    });
  }
}
