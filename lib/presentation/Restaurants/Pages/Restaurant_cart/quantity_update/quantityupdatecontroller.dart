import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/Controller/restaurant_cart_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/quantity_update/modal.dart';

class QuantityController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final quantityData = UpdateQuantityModal().obs;
  RxString error = ''.obs;
  String token = "";

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setData(UpdateQuantityModal value) => quantityData.value = value;

  final RestaurantCartController restaurantCartController =
      Get.put(RestaurantCartController());

  updateQuantityApi({
    required String productId,
    required String productQuantity,
    required String countId,

  }) async {
    setRxRequestStatus(Status.LOADING);
    var body = {
      "product_id": productId,
      "quantity": productQuantity,
      "count_id": countId,

    };
    api.updateQuantityApi(body).then((value) {
      setData(value);
      if (quantityData.value.status == true) {
        restaurantCartController.getRestaurantCartApi(cartId: "").then((value) async {
          await Future.delayed(const Duration(milliseconds: 500));
          setRxRequestStatus(Status.COMPLETED);
          Utils.showToast(quantityData.value.message.toString());
        });
      } else {
        Utils.showToast(quantityData.value.message.toString());
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
