import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/Checkout_create-order/create_order_modal.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/Controller/restaurant_cart_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/delete_ptoduct/delete_product_modal.dart';

class CreateOrderController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final createOrderData = CreateOrder().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setCreateOrderData(CreateOrder value) => createOrderData.value = value;

  placeOrderApi({
    required String paymentMethod,
    required String addressId,
    required String couponId,
    required String restaurantId,
    required String total,
    required String cartId,
  }) async {
    setRxRequestStatus(Status.LOADING);
    var body = {
      "payment_method": paymentMethod,
      "address_id": addressId,
      "coupon_id": couponId != "" ? couponId : "",
      "restaurant_id": restaurantId,
      "total": total,
      "cart_id": cartId,
    };

    api.createOrderApi(body).then((value) {
      setCreateOrderData(value);
      if (createOrderData.value.status == true) {
        // Utils.showToast(createOrderData.value.message.toString());
        setRxRequestStatus(Status.COMPLETED);
        Get.toNamed(AppRoutes.oderConfirm);
      } else {
        Utils.showToast(createOrderData.value.message.toString());
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
