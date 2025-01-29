import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:woye_user/Core/Utils/snackbar.dart';
import 'package:woye_user/Data/Repository/repository.dart';
import 'package:woye_user/Data/response/status.dart';
import 'package:woye_user/Routes/app_routes.dart';
import 'package:woye_user/presentation/common/Checkout_create-order/create_order_modal.dart';

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
    required String vendorId,
    required String total,
    required String cartId,
    required String cartType,
  }) async {
    setRxRequestStatus(Status.LOADING);
    var body = {
      "payment_method": paymentMethod,
      "address_id": addressId,
      "coupon_id": couponId != "" ? couponId : "",
      "vendor_id": vendorId,
      "total": total,
      "cart_id": cartId,
      "type": cartType,
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
