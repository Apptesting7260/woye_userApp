import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_wishlist/Controller/Modal.dart';

class RestaurantWishlistController extends GetxController {
  TextEditingController searchController = TextEditingController();

  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final wishlistData = restaurant_product_wishlist_modal().obs;

  RxString error = ''.obs;
  RxList<CategoryProduct> filteredWishlistData = RxList<CategoryProduct>();

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void wishlist_Set(restaurant_product_wishlist_modal value) =>
      wishlistData.value = value;

  void setError(String value) => error.value = value;

  void filterWishlistData(String query) {
    if (query.isEmpty) {
      filteredWishlistData.value = wishlistData.value.categoryProduct ?? [];
    } else {
      filteredWishlistData.value = wishlistData.value.categoryProduct
              ?.where((product) =>
                  product.title!.toLowerCase().contains(query.toLowerCase()))
              .toList() ??
          [];
    }
  }

  restaurant_product_wishlist_api() async {
    searchController.clear();
    api.Restaurant_All_product_wishlist_Api().then((value) {
      wishlist_Set(value);
      filterWishlistData(searchController.text);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  restaurantProductWishlistRefreshApi() async {
    searchController.clear();
    setRxRequestStatus(Status.LOADING);
    api.Restaurant_All_product_wishlist_Api().then((value) {
      wishlist_Set(value);
      filterWishlistData(searchController.text);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }
}
