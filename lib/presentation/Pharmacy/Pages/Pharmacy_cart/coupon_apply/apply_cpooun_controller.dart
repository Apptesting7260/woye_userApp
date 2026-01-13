import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/Controller/pharma_cart_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/coupon_apply/apply_coupon_modal.dart';

class ApplyCouponPharmaController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final applyCouponData = ApplyCouponModal().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setData(ApplyCouponModal value) => applyCouponData.value = value;
  final PharmacyCartController pharmacyCartController = Get.put(PharmacyCartController());


  applyCouponApi({
    bool? isSingleCartScreen,
    required List<Map<String,String>> carts,
    required String couponCode,
    String? cartId,
  }) async {
    setRxRequestStatus(Status.LOADING);
    var body = {
      "carts": jsonEncode(carts),
      "coupon_code": couponCode,
    };
    api.applyPharmaCouponsApi(body).then((value) {
      setData(value);
      if (applyCouponData.value.status == true) {
        isSingleCartScreen != true ?
        pharmacyCartController.refreshGetAllCartProductsForCheckout().then((value) async {
          setRxRequestStatus(Status.COMPLETED);
          await Future.delayed(const Duration(milliseconds: 500));
          Utils.showToast(applyCouponData.value.message.toString());
          await Future.delayed(const Duration(milliseconds: 1000));
          if(pharmacyCartController.couponCodeController.value.text.isNotEmpty) {
            pharmacyCartController.couponCodeController.value.clear();
          }
        }) :pharmacyCartController.getPharmacyCartApiAfterInc(cartId: cartId.toString()).then((value) async {
          setRxRequestStatus(Status.COMPLETED);
          await Future.delayed(const Duration(milliseconds: 500));
          Utils.showToast(applyCouponData.value.message.toString());
          await Future.delayed(const Duration(milliseconds: 1000));
          if(pharmacyCartController.couponCodeController.value.text.isNotEmpty) {
            pharmacyCartController.couponCodeController.value.clear();
          }
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
