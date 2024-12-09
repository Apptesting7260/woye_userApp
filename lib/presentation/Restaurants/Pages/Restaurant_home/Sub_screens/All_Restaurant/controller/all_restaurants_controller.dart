import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/All_Restaurant/modal/all_restaurant_modal.dart';

class AllRestaurantController extends GetxController {
  @override
  void onInit() {
    seeall_restaurant_Api();

    super.onInit();
  }

  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final restaurantData = all_restaurant_modal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void restauran_Set(all_restaurant_modal value) =>
      restaurantData.value = value;

  void setError(String value) => error.value = value;

  seeall_restaurant_Api() async {
    api.all_Restaurant_Api().then((value) {
      restauran_Set(value);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }

  refresh_Api() async {
    setRxRequestStatus(Status.LOADING);

    api.all_Restaurant_Api().then((value) {
      restauran_Set(value);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }
}
