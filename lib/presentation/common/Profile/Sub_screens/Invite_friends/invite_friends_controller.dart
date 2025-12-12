import 'package:get/get.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Invite_friends/invite_friends_model.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';

class InviteFriendsController extends GetxController{

  Rx<TextEditingController> emailTextFieldController = TextEditingController().obs;
  final formKey = GlobalKey<FormState>();
  RxBool isRed = false.obs;

  final api = Repository();
  final apiData = InviteFriendsModel().obs;
  void setApiData(InviteFriendsModel model)=>apiData.value = model;
  final rxRequestStatus = Status.COMPLETED.obs;
  void setRxRequestStatus(Status status) => rxRequestStatus.value = status;

  RxString error = "".obs;
  void setError(String err)=>error.value=err;

  inviteFriends()async {
    var data = {
      "email": emailTextFieldController.value.text,
      "download_link" : "https://play.google.com/store/apps",
    };
    setRxRequestStatus(Status.LOADING);
    api.inviteFriendsApi(data).then((value) {
      setApiData(value);
      if(apiData.value.status == true){
        setRxRequestStatus(Status.COMPLETED);
        pt("invite friends  >>> : ${apiData.value.message}");
        isRed.value = false;
        emailTextFieldController.value.clear();
        Utils.showToast(apiData.value.message.toString());
      }else if(apiData.value.status == false){
        setRxRequestStatus(Status.ERROR);
        pt("invite friends error  >>> : ${apiData.value.message}");
        Utils.showToast(apiData.value.message.toString());
      }
    },).onError((error, stackTrace) {
      setRxRequestStatus(Status.ERROR);
      setError(error.toString());
      pt("invite friends error  >>> : $error");
    },);
  }

}