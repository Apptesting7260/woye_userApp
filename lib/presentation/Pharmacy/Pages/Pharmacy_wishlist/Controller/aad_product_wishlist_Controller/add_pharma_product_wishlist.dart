import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_wishlist/Controller/aad_product_wishlist_Controller/pharmaModal.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_wishlist/Controller/pharmacy_wishlist_controller.dart';

class AddPharmaProductWishlistController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final add_Wishlist = pharmacy_add_product_wishlist_modal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void categories_Set(pharmacy_add_product_wishlist_modal value) =>
      add_Wishlist.value = value;

  void setError(String value) => error.value = value;

  final PharmacyWishlistController pharmacyWishlistController =
      Get.put(PharmacyWishlistController());

  Future<void> pharmacy_add_product_wishlist({
    required String product_id,
    required String categoryId,
  }) async {
    setRxRequestStatus(Status.LOADING);
    Map data = {"product_id": product_id};

    await api.addPharmaProductWishlist(data).then((value) {
      categories_Set(value);
      setRxRequestStatus(Status.COMPLETED);
      if (add_Wishlist.value.status == true) {
        if (categoryId == "") {
          pharmacyWishlistController.pharmacy_product_wishlist_api();
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
