import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Filter/modal/CategoriesFilter_modal.dart';

class RestaurantCategoriesController extends GetxController {
  @override
  void onInit() {
    restaurant_get_CategoriesFilter_Api();
    super.onInit();
  }

  RxList<String> selectedCuisines = <String>[].obs;

  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final getFilterData = CategoriesFilter_modal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void get_CategoriesFilter_Set(CategoriesFilter_modal value) =>
      getFilterData.value = value;

  void setError(String value) => error.value = value;

  restaurant_get_CategoriesFilter_Api() async {
    setRxRequestStatus(Status.LOADING);
    api.get_CategoriesFilter_Api().then((value) {
      get_CategoriesFilter_Set(value);
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
