import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/main.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/Sub_screens/Track_order/model/track_order_model.dart';

class TrackOrderController extends GetxController{
  RxString orderId = "".obs;
  @override
  void onInit() {
    final arguments = Get.arguments ?? {};
    orderId.value  = arguments['id'] ?? "";
    trackOrder(orderNo: orderId.value);
    super.onInit();
  }

  final api = Repository();
  Rx<TrackOrderRestaurantModel> apiData = TrackOrderRestaurantModel().obs;
  void setApiData(TrackOrderRestaurantModel val)=> apiData.value = val;

  final rxRequestStatus = Status.COMPLETED.obs;
  void setRxRequestStatus(Status status) => rxRequestStatus.value  = status;

  RxString error = ''.obs;
  void setError(String err)=>error.value = err;

  trackOrder({required String orderNo})async{
    var data = {
      "id" : orderNo
    };

    setRxRequestStatus(Status.LOADING);
    api.trackOrderRestaurant(data).then((value) {
      setApiData(value);
      if(value.status == true){
        setRxRequestStatus(Status.COMPLETED);
      }else if(value.status == false){
        setRxRequestStatus(Status.ERROR);
        Utils.showToast(apiData.value.message.toString());
      }
    },).onError((error, stackTrace) {
      print("error track orderrr $error");
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    },);
  }

  String convertToTime(String createdAt) {
    try {
      if (createdAt.isEmpty) return '';
      DateTime dateTime = DateTime.parse(createdAt).toLocal();
      return DateFormat('hh:mm a').format(dateTime);
    } catch (e) {
      debugPrint('Invalid date format: $createdAt');
      return '';
    }
  }

}