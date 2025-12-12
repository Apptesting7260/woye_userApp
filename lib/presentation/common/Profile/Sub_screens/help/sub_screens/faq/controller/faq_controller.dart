import 'package:get/get.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/help/sub_screens/faq/model/faq_model.dart';

class FaqController extends GetxController{
  final _api = Repository();


  @override
  void onInit() {
    getFaq();
    super.onInit();
  }

  final rxRequestStatus = Status.LOADING.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  final error = "".obs;
  void setError(String value) => error.value = value;

  Rx<FAQModel> apiData = FAQModel().obs;
  void setApiData(FAQModel value) => apiData.value = value;

  Future<void> getFaq()async{
    setRxRequestStatus(Status.LOADING);
    _api.faqApi().then((value) {
      setApiData(value);
      if(apiData.value.status == true){
        setRxRequestStatus(Status.COMPLETED);
      }else{
        setRxRequestStatus(Status.ERROR);
        }
      },
    ).onError((error, stackTrace) {
      setError(error.toString());
      print("error gar faq>>>>>>>>> $error");
      print("error gar faq>>>>>>>>> $stackTrace");
      setRxRequestStatus(Status.ERROR);
      },
    );
  }

}