import 'package:flutter/cupertino.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/Controller/grocery_cart_controller.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/grocery_Add_to_Cart/add_to_cart_modal.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/Product_details/controller/grocery_specific_product_controller.dart';

import '../Single_Grocery_Vendor_cart/single_vendor_controller.dart';

class GroceryAddToCarController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final rxRequestStatus2 = Status.COMPLETED.obs;
  final addToCartData = GroceryAddToCart().obs;
  final updateCartData = GroceryAddToCart().obs;
  RxString error = ''.obs;
  String token = "";

  final GrocerySpecificProductController grocerySpecificProductController =
      Get.put(GrocerySpecificProductController());
  final SingleGroceryCartController singleGroceryCartController = Get.put(SingleGroceryCartController());

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setRxRequestStatus2(Status value) => rxRequestStatus2.value = value;

  void setData(GroceryAddToCart value) => addToCartData.value = value;

  void setUpdateCartData(GroceryAddToCart value) => updateCartData.value = value;
  final GroceryCartController groceryCartController =
      Get.put(GroceryCartController());

  void setError(String value) => error.value = value;

  groceryAddToCartApi({
    required String productId,
    required String productQuantity,
    required String productPrice,
    required String groceryId,
    // required List<dynamic> extrasIds,
    // required List<dynamic> extrasItemIds,
    // required List<dynamic> extrasItemNames,
    // required List<dynamic> extrasItemPrices,
  }) async {
    setRxRequestStatus(Status.LOADING);
    // initializeUser();

    var body = jsonEncode({
      "product_id": productId,
      "quantity": productQuantity,
      "price": productPrice,
      "grocery_id": groceryId,
      // "title_id": extrasIds,
      // "item_id": extrasItemIds,
      // "item_name": extrasItemNames,
      // "item_price": extrasItemPrices,
    });
    api.groceryAddToCartApi(body).then((value) {
      setData(value);
      if (addToCartData.value.status == true) {
        // if (addToCartData.value.message ==
        //     "Making cart from another pharmacy") {
        //   setRxRequestStatus(Status.COMPLETED);
        //   showSwitchPharmacyDialog(
        //     productId: productId,
        //     productQuantity: productQuantity,
        //     productPrice: productPrice,
        //     restaurantId: pharmaId,
        //     // addons: addons,
        //     // extrasIds: extrasIds,
        //     // extrasItemIds: extrasItemIds,
        //     // extrasItemNames: extrasItemNames,
        //     // extrasItemPrices: extrasItemPrices,
        //   );
        // } else {
        setRxRequestStatus(Status.COMPLETED);
        groceryCartController.getGroceryAllCartApi();
          grocerySpecificProductController.goToCart.value = true;
          Utils.showToast(addToCartData.value.message.toString());
        // }
      } else {
        Utils.showToast(addToCartData.value.message.toString());
        setRxRequestStatus(Status.COMPLETED);
      }
    }).onError((error, stackError) {
      print("Error: $error");
      setError(error.toString());
      print(stackError);
      setRxRequestStatus(Status.ERROR);
    });
  }

  pharmaUpdateCartApi({
    required String productId,
    required String productQuantity,
    required String productPrice,
    required String restaurantId,
    // required List<dynamic> extrasIds,
    // required List<dynamic> extrasItemIds,
    // required List<dynamic> extrasItemNames,
    // required List<dynamic> extrasItemPrices,
  }) async {
    setRxRequestStatus2(Status.LOADING);
    var body = jsonEncode({
      "product_id": productId,
      "quantity": productQuantity,
      "price": productPrice,
      "pharma_id": restaurantId,
      // "title_id": extrasIds,
      // "item_id": extrasItemIds,
      // "item_name": extrasItemNames,
      // "item_price": extrasItemPrices,
    });
    api.pharmaUpdateCartApi(body).then((value) {
      setUpdateCartData(value);
      if (updateCartData.value.status == true) {
        grocerySpecificProductController.goToCart.value = true;
        groceryCartController.getGroceryAllCartApi();
        Utils.showToast(updateCartData.value.message.toString());
        setRxRequestStatus2(Status.COMPLETED);
        Get.back();
      } else {
        Utils.showToast(updateCartData.value.message.toString());
        setRxRequestStatus2(Status.COMPLETED);
        Get.back();
      }
    }).onError((error, stackError) {
      print("Error: $error");
      setError(error.toString());
      print(stackError);
      setRxRequestStatus2(Status.ERROR);
    });
  }

  Future showSwitchPharmacyDialog({
    required String productId,
    required String productQuantity,
    required String productPrice,
    required String restaurantId,
    // required List<dynamic> extrasIds,
    // required List<dynamic> extrasItemIds,
    // required List<dynamic> extrasItemNames,
    // required List<dynamic> extrasItemPrices,
  }) {
    return Get.dialog(
      AlertDialog.adaptive(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Switching Pharmacy',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15.h),
            Text(
              'You are adding products from another Pharmacy. Do you want to continue?',
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
                Obx(
                  () => Expanded(
                    child: CustomElevatedButton(
                      height: 40.h,
                      isLoading: rxRequestStatus2.value == (Status.LOADING),
                      onPressed: () {
                        pharmaUpdateCartApi(
                          productId: productId,
                          productQuantity: productQuantity,
                          productPrice: productPrice,
                          restaurantId: restaurantId,
                          // extrasIds: extrasIds,
                          // extrasItemPrices: extrasItemPrices,
                          // extrasItemNames: extrasItemNames,
                          // extrasItemIds: extrasIds,
                        );
                      },
                      text: "Yes",
                    ),
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
