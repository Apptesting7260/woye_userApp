import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/modal/specific_product_modal.dart';
import 'package:intl/intl.dart';

class specific_Product_Controller extends GetxController {
  final api = Repository();

  RxString selectedImageUrl = ''.obs;
  RxInt isSelected = 0.obs;
  RxBool isLoading = false.obs;
  RxInt cartCount = 1.obs;
  var productPrice = 0;

  RxBool goToCart = false.obs;

  final rxRequestStatus = Status.COMPLETED.obs;
  final productData = specificProduct().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void productdata_Set(specificProduct value) => productData.value = value;

  void setError(String value) => error.value = value;

  specific_Product_Api({
    required String productId,
    required String categoryId,
  }) async {
    goToCart.value = false;
    selectedAddOn.clear();
    extrasTitlesIdsId.clear();
    extrasItemIdsId.clear();
    extrasItemIdsName.clear();
    extrasItemIdsPrice.clear();
    selectedImageUrl.value = "";
    cartCount.value = 1;
    setRxRequestStatus(Status.LOADING);
    Map data = {
      "product_id": productId,
      "category_id": categoryId,
    };
    api.specific_Product_Api(data).then((value) {
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
  RxList selectedAddOn = [].obs;
  RxList extrasTitlesIdsId = [].obs;
  RxList extrasItemIdsId = [].obs;
  RxList extrasItemIdsName = [].obs;
  RxList extrasItemIdsPrice = [].obs;

  void productPriceFun() {
    int count = cartCount.value;
    if(productData.value.product!.salePrice != null) {
      int? price = productData.value.product!.salePrice;
      if (price != null) {
        int totalPrice = count * price;
        productPrice = totalPrice;
        print("Total Price: $totalPrice");
      } else {
        print("Error: Price is not a valid number");
      }
    } else {

      int? price = productData.value.product!.regularPrice;
      if (price != null) {
        int totalPrice = count * price;
        productPrice = totalPrice;
        print("Total Price: $totalPrice");
      } else {
        print("Error: Price is not a valid number");
      }


    }
    // productPrice = totalPrice;
    // print("Total Price: $totalPrice");
  }
}
