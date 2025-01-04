import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Categories_details/controller/RestaurantCategoriesDetailsController.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_wishlist/Controller/aad_product_wishlist_Controller/Modal.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_wishlist/Controller/restaurant_wishlist_controller.dart';

class add_Product_Wishlist_Controller extends GetxController {
  final RestaurantCategoriesDetailsController
      restaurantCategoriesDetailsController =
      Get.put(RestaurantCategoriesDetailsController());

  final RestaurantWishlistController restaurantWishlistController =
      Get.put(RestaurantWishlistController());

  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final add_Wishlist = restaurant_add_product_wishlist_modal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void categories_Set(restaurant_add_product_wishlist_modal value) =>
      add_Wishlist.value = value;

  void setError(String value) => error.value = value;

  Future<void> restaurant_add_product_wishlist({
    required String categoryId,
    required String product_id,
  }) async {
    setRxRequestStatus(Status.LOADING);
    Map data = {"product_id": product_id};

    await api.add_Product_Wishlist(data).then((value) {
      categories_Set(value);
      setRxRequestStatus(Status.COMPLETED);
      if (add_Wishlist.value.status == true) {
        if (categoryId == "") {
          restaurantWishlistController.restaurant_product_wishlist_api();
        }
        Utils.showToast(add_Wishlist.value.message.toString());
      } else {
        Utils.showToast(add_Wishlist.value.message.toString());
      }
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
