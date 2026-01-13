import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:woye_user/Core/Utils/snackbar.dart';
import 'package:woye_user/Data/Repository/repository.dart';
import 'package:woye_user/Data/response/status.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/Sub_screens/Order_details/order_details_controller.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/Sub_screens/Rate_and_review_product/post_review_modal.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/controller/order_screen_controller.dart';

class PostReviewController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final postReviewData = PostReviewModal().obs;
  RxString error = ''.obs;

  var rating = 0.0.obs;

  final Rx<TextEditingController> reviewController =
      TextEditingController().obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setData(PostReviewModal value) => postReviewData.value = value;

  final OrderDetailsController orderDetailsController =
      Get.put(OrderDetailsController());

  final OrderScreenController orderScreenController =
      Get.put(OrderScreenController());

  postOrderReviewApi({
    required String orderId,
    required var rating,
    required String review,
    required String vendorId,
    required String type,
    required String from,
  }) async {
    setRxRequestStatus(Status.LOADING);
    var body = {
      "order_id": orderId,
      "rating": rating.toString(),
      "review": review,
      "vendor_id": vendorId,
      "type": type,
    };
    api.postVendorReviewApi(body).then((value) async {
      setData(value);
      if (postReviewData.value.status == true) {
        if (from == "details") {
          orderDetailsController
              .orderDetailsApi(orderId: orderId)
              .then((value) {
            Get.back();
            Utils.showToast(postReviewData.value.message.toString());
            setRxRequestStatus(Status.COMPLETED);
          });
        } else {
          orderScreenController.getOrdersListApi().then((value) {
            Utils.showToast(postReviewData.value.message.toString());
            Get.back();
            setRxRequestStatus(Status.COMPLETED);
          });
        }
      } else {
        Utils.showToast(postReviewData.value.message.toString());
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
