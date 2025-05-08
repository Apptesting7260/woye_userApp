import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_wishlist/Controller/grocery_Modal.dart';

class GroceryWishlistController extends GetxController {
  TextEditingController searchController = TextEditingController();

  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final wishlistData = GroceryProductWishlistModal().obs;

  RxString error = ''.obs;
  RxList<WishlistProduct> filteredWishlistData = RxList<WishlistProduct>();

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void wishlist_Set(GroceryProductWishlistModal value) =>
      wishlistData.value = value;

  void setError(String value) => error.value = value;

  void filterWishlistData(String query) {
    if (query.isEmpty) {
      filteredWishlistData.value = wishlistData.value.allWishlist ?? [];
    } else {
      filteredWishlistData.value = wishlistData.value.allWishlist
          ?.where((product) =>
          product.title!.toLowerCase().contains(query.toLowerCase()))
          .toList() ??
          [];
    }
  }

  pharmacy_product_wishlist_api() async {
    searchController.clear();
    api.groceryAllProductWishlistApi().then((value) {
      wishlist_Set(value);
      filterWishlistData(searchController.text);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print("error ${error.toString()}");
      setRxRequestStatus(Status.ERROR);
    });
  }

  pharmacyProductWishlistRefreshApi() async {
    searchController.clear();
    // setRxRequestStatus(Status.LOADING);
    api.groceryAllProductWishlistApi().then((value) {
      wishlist_Set(value);
      filterWishlistData(searchController.text);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print("error ${error.toString()}");
      setRxRequestStatus(Status.ERROR);
    });
  }
}
