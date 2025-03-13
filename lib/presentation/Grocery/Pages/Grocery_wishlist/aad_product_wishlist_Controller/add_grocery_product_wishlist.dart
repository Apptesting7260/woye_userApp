import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_wishlist/Controller/grocery_wishlist_controller.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_wishlist/aad_product_wishlist_Controller/groceryModal.dart';

class AddGroceryProductWishlist extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final add_Wishlist = GroceryModal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void categories_Set(GroceryModal value) =>
      add_Wishlist.value = value;

  void setError(String value) => error.value = value;

  final GroceryWishlistController groceryWishlistController =
      Get.put(GroceryWishlistController());

  Future<void> pharmacy_add_product_wishlist({
    required String product_id,
    required String categoryId,
  }) async {
    setRxRequestStatus(Status.LOADING);
    Map data = {"product_id": product_id};

    await api.addGroceryProductWishlist(data).then((value) {
      categories_Set(value);
      setRxRequestStatus(Status.COMPLETED);
      if (add_Wishlist.value.status == true) {
        if (categoryId == "") {
          groceryWishlistController.pharmacy_product_wishlist_api();
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
