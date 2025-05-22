import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_wishlist/Controller/aad_product_wishlist_Controller/pharmaModal.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_wishlist/Controller/pharmacy_wishlist_controller.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';

import '../../../Pharmacy_categories/Sub_screens/Categories_details/controller/PharmacyCategoriesDetailsController.dart';
import '../../../Pharmacy_home/Sub_screens/Vendor_details/PharmacyDetailsController.dart';

class AddPharmaProductWishlistController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final add_Wishlist = pharmacy_add_product_wishlist_modal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void categories_Set(pharmacy_add_product_wishlist_modal value) =>
      add_Wishlist.value = value;

  void setError(String value) => error.value = value;

  final PharmacyWishlistController pharmacyWishlistController = Get.put(PharmacyWishlistController());
  final PharmacyCategoriesDetailsController pharmacyCategoriesDetailsController = Get.put(PharmacyCategoriesDetailsController());
  final PharmacyDetailsController pharmacyDetailsController = Get.put(PharmacyDetailsController());

  Future<void> pharmacy_add_product_wishlist({
    required bool isRefresh,
    required String product_id,
    required String categoryId,
    String? pharmacyId,
  }) async {
    setRxRequestStatus(Status.LOADING);
    Map data = {"product_id": product_id};

    pt("iddddd>>>>>>>>>>>> ${categoryId}");


    await api.addPharmaProductWishlist(data).then((value) {

      categories_Set(value);
      setRxRequestStatus(Status.COMPLETED);
      if (add_Wishlist.value.status == true) {
        if (categoryId == "") {
          pharmacyWishlistController.pharmacy_product_wishlist_api();
        }

        if(categoryId != ""){
          pharmacyCategoriesDetailsController.refresh_pharmacy_Categories_Details_Api(id: categoryId.toString());
      }

        pharmacyWishlistController.pharmacy_product_wishlist_api();

        if((isRefresh == true && pharmacyId != null) || (pharmacyDetailsController.pharma_Data.value.pharmaShop?.id != null)) {
          pharmacyDetailsController.refresh_restaurant_Details_Api(id:pharmacyDetailsController.pharma_Data.value.pharmaShop?.id.toString() ?? pharmacyId.toString());
        }

        Utils.showToast(add_Wishlist.value.message.toString());
      } else {
        Utils.showToast(add_Wishlist.value.message.toString());
      }
    }).onError((error, stackError) {
      setError(error.toString());
      pt(stackError);
      pt('errrrrrrrrrrrr wishlist pharma');
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }
}
