import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_wishlist/Controller/grocery_wishlist_controller.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_wishlist/aad_product_wishlist_Controller/groceryModal.dart';

import '../../Grocery_categories/Sub_screens/Categories_details/controller/GroceryCategoriesDetailsController.dart';
import '../../Grocery_home/Sub_screens/Vendor_details/GroceryDetailsController.dart';

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
  final Grocerycategoriesdetailscontroller grocerycategoriesdetailscontroller = Get.put(Grocerycategoriesdetailscontroller());
  final GroceryDetailsController groceryDetailsController =  Get.put(GroceryDetailsController());

  Future<void> pharmacy_add_product_wishlist({
    String? groceryId,
    bool? isWishListScreen,
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
        if(categoryId != ""){
          grocerycategoriesdetailscontroller.refreshGroceryCategoriesDetailsApi(id: categoryId.toString());
        }
        if(groceryId != null && groceryId != ""){
          groceryDetailsController.refresh_restaurant_Details_Api(id: groceryId);
        }
        if(isWishListScreen  == true){
          groceryWishlistController.pharmacyProductWishlistRefreshApi();
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
