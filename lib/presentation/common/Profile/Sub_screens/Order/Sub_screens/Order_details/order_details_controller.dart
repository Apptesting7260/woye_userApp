import 'package:get/get.dart';
import 'package:woye_user/Core/Utils/snackbar.dart';
import 'package:woye_user/Data/Repository/repository.dart';
import 'package:woye_user/Data/response/status.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/Sub_screens/Order_details/order_details_modal.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';

class OrderDetailsController extends GetxController {
  final api = Repository();

  RxString error = ''.obs;
  void setError(String value) => error.value = value;

  final rxRequestStatus = Status.COMPLETED.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  final ordersData = OrderDetailsModal().obs;
  void setData(OrderDetailsModal value) => ordersData.value = value;

  orderDetailsApi({
    required String orderId,
    bool? isShowLoading = true
  }) async {
    if(isShowLoading == true) {
      setRxRequestStatus(Status.LOADING);
    }
    var body = {
      "order_id": orderId,
    };
    api.orderDetailsApi(body).then((value) {
      setData(value);
      if (ordersData.value.status == true) {
        setRxRequestStatus(Status.COMPLETED);
      } else {
        setRxRequestStatus(Status.COMPLETED);
      }
    }).onError((error, stackError) {
      pt("Error: $error");
      setError(error.toString());
      pt(stackError);
      setRxRequestStatus(Status.ERROR);
    });
  }

}
