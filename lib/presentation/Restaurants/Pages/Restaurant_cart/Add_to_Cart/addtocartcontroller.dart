import 'package:flutter/cupertino.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/Add_to_Cart/modal.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/controller/specific_product_controller.dart';

class AddToCartController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final addToCartData = AddToCart().obs;

  RxString error = ''.obs;

  final specific_Product_Controller specificProductController =
      Get.put(specific_Product_Controller());

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setData(AddToCart value) => addToCartData.value = value;

  void setError(String value) => error.value = value;

  addToCartApi({
    required String productId,
    required String productQuantity,
    required String productPrice,
    required String restaurantId,
    required List<dynamic> addons,
    required List<dynamic> extrasIds,
    required List<dynamic> extrasItemIds,
    required List<dynamic> extrasItemNames,
    required List<dynamic> extrasItemPrices,
  }) async {
    setRxRequestStatus(Status.LOADING);
    var body = jsonEncode({
      "product_id": productId,
      "quantity": productQuantity,
      "price": productPrice,
      "resto_id": restaurantId,
      "addon": addons,
      "title_id": extrasIds,
      "item_id": extrasItemIds,
      "item_name": extrasItemNames,
      "item_price": extrasItemPrices,
    });
    api.addToCartApi(body).then((value) {
      setData(value);
      if (addToCartData.value.status == true) {
        if (addToCartData.value.message ==
            "Making cart from another restaurant") {
          showSwitchRestaurantDialog();
        } else {
          specificProductController.goToCart.value = true;
          Utils.showToast(addToCartData.value.message.toString());
        }
      } else {
        Utils.showToast(addToCartData.value.message.toString());
      }
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      print("Error: $error");
      setError(error.toString());
      print(stackError);
      setRxRequestStatus(Status.ERROR);
    });
  }

  Future showSwitchRestaurantDialog() {
    return Get.dialog(
      AlertDialog.adaptive(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Switching Restaurants',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15.h),
            Text(
              'You are adding products from another restaurant. Do you want to continue?',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    height: 40.h,
                    color: AppColors.black,
                    onPressed: () {
                      Get.back();
                    },
                    text: "Cancel",
                    textStyle: AppFontStyle.text_14_400(AppColors.darkText),
                  ),
                ),
                wBox(15),
                Expanded(
                  child: CustomElevatedButton(
                    height: 40.h,
                    onPressed: () {
                      Get.back();
                    },
                    text: "Yes",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}
