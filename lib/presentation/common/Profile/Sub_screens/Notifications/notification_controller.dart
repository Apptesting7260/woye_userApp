import 'package:get/get.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Data/network/base_api_services.dart';
import 'package:woye_user/Data/network/network_api_services.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Notifications/notification_model.dart';

class NotificationController extends GetxController{
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  void setRxRequestStatus(Status val) => rxRequestStatus.value = val;
  Rx<NotificationModel> apiData = NotificationModel().obs;
  RxString error = "".obs;
  void setError(String val) => error.value = val;
  void setApiData(NotificationModel val) => apiData.value = val;


  Future<void> getNotifications()async{
    setRxRequestStatus(Status.LOADING);
    api.notifications().then((value) {
      setApiData(value);
      if(apiData.value.status == true){
        setRxRequestStatus(Status.COMPLETED);
      }else if(apiData.value.status== false){
        setRxRequestStatus(Status.ERROR);
      }
    },).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }

  Future<void> refreshNotifications()async{
    // setRxRequestStatus(Status.LOADING);
    api.notifications().then((value) {
      setApiData(value);
      if(apiData.value.status == true){
        setRxRequestStatus(Status.COMPLETED);
      }else if(apiData.value.status== false){
        setRxRequestStatus(Status.ERROR);
      }
    },).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }


}