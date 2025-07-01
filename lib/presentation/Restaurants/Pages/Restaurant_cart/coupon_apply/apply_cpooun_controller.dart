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
    required List<dynamic> cartIds,
    required String couponCode,
    required String grandTotal,
    bool? isSingleCartScreen,
  }) async {
    setRxRequestStatus(Status.LOADING);
    var body = {
      "cart_ids": jsonEncode(cartIds),
      "coupon_code": couponCode,
      "grand_total": grandTotal,
    };
    api.applyCouponsApi(body).then((value) {
      setData(value);
      if (applyCouponData.value.status == true) {
        if(isSingleCartScreen == true){
          restaurantCartController.refreshRestaurantSingleCartApi(cartId: cartIds.join(',')).then((value) async {
            await Future.delayed(const Duration(milliseconds: 500));
            setRxRequestStatus(Status.COMPLETED);
            if(restaurantCartController.couponCodeController.value.text.isNotEmpty) {
              restaurantCartController.couponCodeController.value.clear();
            }
            Utils.showToast(applyCouponData.value.message.toString());
          });
        }else {
          restaurantCartController.refreshGetAllCheckoutDataRes().then((
              value) async {
            await Future.delayed(const Duration(milliseconds: 500));
            setRxRequestStatus(Status.COMPLETED);
            if (restaurantCartController.couponCodeController.value.text
                .isNotEmpty) {
              restaurantCartController.couponCodeController.value.clear();
            }
            Utils.showToast(applyCouponData.value.message.toString());
          });
        }
      } else {
        Utils.showToast(applyCouponData.value.message.toString());
        setRxRequestStatus(Status.COMPLETED);
      }
    }).onError((error, stackError) {
      print("Error: $error");
      setError(error.toString());
      if(error == 'InternetExceptionWidget'){
      Utils.showToast("No internet");
    };
      print(stackError);
      setRxRequestStatus(Status.ERROR);
    });
  }

  void setError(String value) => error.value = value;
}
