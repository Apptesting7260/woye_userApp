import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/Controller/restaurant_cart_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/coupon_apply/apply_coupon_modal.dart';

class ApplyCouponController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final applyCouponData = ApplyCouponModal().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setData(ApplyCouponModal value) => applyCouponData.value = value;

  final RestaurantCartController restaurantCartController =
      Get.put(RestaurantCartController());

  applyCouponApi({
    required String cartId,
    required String couponCode,
  }) async {
    setRxRequestStatus(Status.LOADING);
    var body = {
      "cart_id": cartId,
      "coupon_code": couponCode,
    };
    api.applyCouponsApi(body).then((value) {
      setData(value);
      if (applyCouponData.value.status == true) {
        restaurantCartController.getRestaurantCartApi().then((value) {
          setRxRequestStatus(Status.COMPLETED);
          Utils.showToast(applyCouponData.value.message.toString());
        });
      } else {
        Utils.showToast(applyCouponData.value.message.toString());
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
