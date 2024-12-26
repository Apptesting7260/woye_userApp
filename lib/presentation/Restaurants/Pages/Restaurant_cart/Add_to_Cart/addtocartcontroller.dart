import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/Add_to_Cart/modal.dart';

class AddToCartController extends GetxController {
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
    required List<dynamic> addons,
    required List<dynamic> extrasIds,
    required List<dynamic> extrasItemIds,
    required List<dynamic> extrasItemNames,
    required List<dynamic> extrasItemPrices,
  }) async {
    setRxRequestStatus(Status.LOADING);
    var body = jsonEncode({
      "product_id": productId,
      "quantity": productQuantity,
      "price": productPrice,
      "resto_id": restaurantId,
      "addon": addons,
      "title_id": extrasIds,
      "item_id": extrasItemIds,
      "item_name": extrasItemNames,
      "item_price": extrasItemPrices,
    });
    api.addToCartApi(body).then((value) {
      setData(value);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      print("Error: $error");
      setError(error.toString());
      print(stackError);
      setRxRequestStatus(Status.ERROR);
    });
  }
}
