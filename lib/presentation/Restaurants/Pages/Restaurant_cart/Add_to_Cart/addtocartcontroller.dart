import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/Add_to_Cart/modal.dart';

class AddToCartController extends GetxController {
  @override
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final addToCartData = AddToCart().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setData(AddToCart value) => addToCartData.value = value;

  void setError(String value) => error.value = value;

  addToCartApi({
    required String productId,
    required String productQuantity,
    required String productPrice,
    required String restaurantId,
  }) async {
    setRxRequestStatus(Status.LOADING);
    Map data = {
      "product_id": productId,
      "quantity": productQuantity,
      "price": productPrice,
      "resto_id": restaurantId,
    };
    api.addToCartApi(data).then((value) {
      setData(value);
      print("RRRRRRRRRRRRRRRRR${addToCartData.value.message}");
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
