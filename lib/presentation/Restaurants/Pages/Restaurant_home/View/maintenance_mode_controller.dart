import 'package:get/get.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/View/model/maintenance_mode_model.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';

class MaintenanceModeController extends GetxController{

  final api = Repository();


  final  apiData = MaintenanceModel().obs;

  void setApiData(MaintenanceModel value) => apiData.value = value;


  Future<void> maintenanceModeApi()async{
    api.maintenanceApi().then((value) {
      setApiData(value);
      if(apiData.value.status == true){
        // Utils.showToast(apiData.value.message ?? "");
        pt("maintenance data>>>>>>>>  ${apiData.value.message ?? ""}");
        if(apiData.value.maintenance.toString() == "1"){
          Get.offAllNamed(AppRoutes.maintenance);
        }
      }else{
        pt("maintenance data else >>>>>>>>  ${apiData.value.message ?? ""}");
      }
    },).onError((error, stackTrace) {
      pt('>>>>>>>>>>>>maintenance $error');
      pt('>>>>>>>>>>>>maintenance $stackTrace');
    },);
  }


}