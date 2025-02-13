import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/Controller/restaurant_cart_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/checked_unchecked/checked_unchecked_modal.dart';

class CheckedUncheckedController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final checkedUncheckedData = CheckedUncheckedModal().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setData(CheckedUncheckedModal value) =>
      checkedUncheckedData.value = value;

  final RestaurantCartController restaurantCartController =
      Get.put(RestaurantCartController());

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
    api.checkedUncheckedApi(body).then((value) {
      setData(value);
      if (checkedUncheckedData.value.status == true) {
        restaurantCartController.getRestaurantCartApi().then((value) async {
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
