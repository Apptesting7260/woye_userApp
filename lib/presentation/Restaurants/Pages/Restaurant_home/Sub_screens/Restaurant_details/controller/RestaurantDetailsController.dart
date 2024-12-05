import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Categories_details/Modal/singal_restaurant_modal.dart';


class RestaurantDetailsController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final restaurant_Data = SpecificRestaurantModal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void restaurant_Set(SpecificRestaurantModal value) =>
      restaurant_Data.value = value;

  void setError(String value) => error.value = value;

  restaurant_Details_Api({
    required String id,
  }) async {
    setRxRequestStatus(Status.LOADING);

    Map data = {"restaurant_id": id};

    api.specific_Restaurant_Api(data).then((value) {
      restaurant_Set(value);
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
