import 'package:get/get.dart';
import 'package:woye_user/Core/Utils/snackbar.dart';
import 'package:woye_user/Data/Repository/repository.dart';
import 'package:woye_user/Data/response/status.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/Sub_screens/Order_details/order_details_modal.dart';

class OrderDetailsController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final ordersData = OrderDetailsModal().obs;
  RxString error = ''.obs;


  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

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
        // Utils.showToast(postReviewData.value.message.toString());
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
