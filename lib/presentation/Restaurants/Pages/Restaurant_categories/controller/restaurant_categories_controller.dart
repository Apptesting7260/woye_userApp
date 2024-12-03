import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_categories/Modal/restaurant_categories_modal.dart';


class RestaurantCategoriesController extends GetxController {
  @override
  // void onInit() {
  //   restaurant_Categories_Api();
  //   // TODO: implement onInit
  //   super.onInit();
  // }

  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final categoriesData = restaurant_Categories_Modal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void categories_Set(restaurant_Categories_Modal value) =>
      categoriesData.value = value;

  void setError(String value) => error.value = value;

  restaurant_Categories_Api() async {

    setRxRequestStatus(Status.LOADING);

    api.restaurant_Categories_Api().then((value) {
      categories_Set(value);
      setRxRequestStatus(Status.COMPLETED);
      print("categoriesData.value.status${categoriesData.value.status}");
      // if (categoriesData.value.status == true) {
      //
      // }
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
