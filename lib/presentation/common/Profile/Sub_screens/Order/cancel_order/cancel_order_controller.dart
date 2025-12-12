import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:woye_user/Core/Utils/snackbar.dart';
import 'package:woye_user/Data/Repository/repository.dart';
import 'package:woye_user/Data/response/status.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/cancel_order/cancel_order_modal.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/controller/order_screen_controller.dart';

class CancelOrderController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final cancelOrderData = CancelOrderModal().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setData(CancelOrderModal value) => cancelOrderData.value = value;

  final OrderScreenController orderScreenController =
      Get.put(OrderScreenController());

  cancelOrderApi({
    required String orderId,
  }) async {
    setRxRequestStatus(Status.LOADING);
    var body = {
      "order_id": orderId,
    };
    api.cancelOrderApi(body).then((value) {
      setData(value);
      if (cancelOrderData.value.status == true) {
        Get.back();
        orderScreenController.getOrdersListApi().then((value) async {
          await Future.delayed(const Duration(milliseconds: 500));
          Utils.showToast(cancelOrderData.value.message.toString());
          setRxRequestStatus(Status.COMPLETED);
        });
      } else {
        Utils.showToast(cancelOrderData.value.message.toString());
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
