import 'package:flutter/cupertino.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/Controller/pharma_cart_controller.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/pharma_Add_to_Cart/add_to_cart_modal.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Product_details/controller/pharma_specific_product_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/controller/specific_product_controller.dart';

class PharmacyAddToCarController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final rxRequestStatus2 = Status.COMPLETED.obs;
  final addToCartData = PharmaAddToCart().obs;
  final updateCartData = PharmaAddToCart().obs;
  RxString error = ''.obs;
  String token = "";

  final PharmaSpecificProductController pharmaSpecificProductController =
      Get.put(PharmaSpecificProductController());

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setRxRequestStatus2(Status value) => rxRequestStatus2.value = value;

  void setData(PharmaAddToCart value) => addToCartData.value = value;

  void setUpdateCartData(PharmaAddToCart value) => updateCartData.value = value;
  final PharmacyCartController pharmacyCartController =
      Get.put(PharmacyCartController());

  void setError(String value) => error.value = value;

  pharmaAddToCartApi({
    required String productId,
    required String productQuantity,
    required String productPrice,
    required String pharmaId,
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
      "pharma_id": pharmaId,
      // "title_id": extrasIds,
      // "item_id": extrasItemIds,
      // "item_name": extrasItemNames,
      // "item_price": extrasItemPrices,
    });
    api.pharmaAddToCartApi(body).then((value) {
      setData(value);
      if (addToCartData.value.status == true) {
        if (addToCartData.value.message ==
            "Making cart from another pharmacy") {
          setRxRequestStatus(Status.COMPLETED);
          showSwitchPharmacyDialog(
            productId: productId,
            productQuantity: productQuantity,
            productPrice: productPrice,
            restaurantId: pharmaId,
            // addons: addons,
            // extrasIds: extrasIds,
            // extrasItemIds: extrasItemIds,
            // extrasItemNames: extrasItemNames,
            // extrasItemPrices: extrasItemPrices,
          );
        } else {
          pharmacyCartController.getPharmacyCartApi();
          setRxRequestStatus(Status.COMPLETED);
          pharmaSpecificProductController.goToCart.value = true;
          Utils.showToast(addToCartData.value.message.toString());
        }
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
        pharmaSpecificProductController.goToCart.value = true;
        pharmacyCartController.getPharmacyCartApi();
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
