import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Product_details/modal/pharma_specific_products_modal.dart';
import 'package:intl/intl.dart';

class PharmaSpecificProductController extends GetxController {
  final api = Repository();

  RxString selectedImageUrl = ''.obs;
  RxInt isSelected = (-1).obs;
  RxBool isLoading = false.obs;
  RxInt cartCount = 1.obs;
  var productPrice = 0;

  RxBool goToCart = false.obs;

  final rxRequestStatus = Status.COMPLETED.obs;
  final productData = PharmaSpecificProductModal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void productdata_Set(PharmaSpecificProductModal value) =>
      productData.value = value;

  void setError(String value) => error.value = value;

  pharmaSpecificProductApi({
    required String productId,
    required String categoryId,
  }) async {
    setRxRequestStatus(Status.LOADING);
    Map data = {
      "product_id": productId,
      "category_id": categoryId,
    };
    api.pharmacySpecificProductApi(data).then((value) {
      goToCart.value = false;
      isSelected = (-1).obs;
      productdata_Set(value);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }

  String formatDate(String? dateString) {
    if (dateString == null) {
      return "";
    }
    try {
      DateTime date = DateTime.parse(dateString);
      String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(date);
      print("Formatted Date: $formattedDate");
      return formattedDate;
    } catch (e) {
      print("Error formatting date: $e");
      return "";
    }
  }

// ----------------- add to cart data -----------------
// RxList selectedAddOn = [].obs;
  RxList variantTitlesIdsId = [].obs;
  RxList variantItemIdsId = [].obs;
  RxList variantItemIdsName = [].obs;
  RxList variantItemIdsPrice = [].obs;

  void productPriceFun() {
    int count = cartCount.value;
    int? price = int.parse(productData.value.product!.salePrice);

    int totalPrice = count * price;
    productPrice = totalPrice;
    print("Total Price: $totalPrice");
  }
}
