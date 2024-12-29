import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/Controller/restaurant_cart_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/delete_ptoduct/delete_product_modal.dart';

class DeleteProductController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final deleteProductData = DeleteProductModal().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setData(DeleteProductModal value) => deleteProductData.value = value;

  final RestaurantCartController restaurantCartController =
  Get.put(RestaurantCartController());

  deleteProductApi({
    required String productId,
  }) async {
    setRxRequestStatus(Status.LOADING);
    var body = {
      "product_id": productId,
    };
    api.deleteProductApi(body).then((value) {
      setData(value);
      if (deleteProductData.value.status == true) {
        restaurantCartController.getRestaurantCartApi();
        Future.delayed(const Duration(seconds: 1), () {
          setRxRequestStatus(Status.COMPLETED);
        });
      } else {
        Utils.showToast(deleteProductData.value.message.toString());
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
