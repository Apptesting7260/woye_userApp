import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_wishlist/Controller/Modal.dart';

class RestaurantWishlistController extends GetxController {
  // @override
  // void onInit() {
  //   restaurant_product_wishlist_api();
  //   super.onInit();
  // }

  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final wishlistData = restaurant_product_wishlist_modal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void wishlist_Set(restaurant_product_wishlist_modal value) =>
      wishlistData.value = value;

  void setError(String value) => error.value = value;

  restaurant_product_wishlist_api() async {
    // setRxRequestStatus(Status.LOADING);
    api.Restaurant_All_product_wishlist_Api().then((value) {
      wishlist_Set(value);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }

  restaurant_product_wishlist_api1() async {
    api.Restaurant_All_product_wishlist_Api().then((value) {
      wishlist_Set(value);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }
}
