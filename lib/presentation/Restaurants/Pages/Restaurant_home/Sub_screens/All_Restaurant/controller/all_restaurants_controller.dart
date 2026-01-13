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

  TextEditingController searchController = TextEditingController();

  RxList<Restaurants> filteredWishlistData = RxList<Restaurants>();

  void restauran_Set(all_restaurant_modal value) {
    restaurantData.value = value;
    filteredWishlistData.value = List.from(value.restaurants!);
  }

  void setError(String value) => error.value = value;

  void filterCategories(String query) {
    if (query.isEmpty) {
      filteredWishlistData.value = List.from(restaurantData.value.restaurants!);
    } else {
      filteredWishlistData.value = restaurantData.value.restaurants!
          .where((shop) =>
              shop.shopName!.toLowerCase().contains(query.toLowerCase()))
          .toList(); // Filter categories
    }
  }

  seeall_restaurant_Api() async {
    api.all_Restaurant_Api().then((value) {
      restauran_Set(value);
      filterCategories(searchController.text);
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
      filterCategories(searchController.text);
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
