import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Categories_details/Modal/RestaurantCategoryDetailsModal.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/Add_to_Cart/add_to_cart_modal.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/Controller/restaurant_cart_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/controller/specific_product_controller.dart';

class AddToCartController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final rxRequestStatus2 = Status.COMPLETED.obs;
  final rxRequestStatusPopUp = Status.COMPLETED.obs;
  final addToCartData = AddToCart().obs;
  final updateCartData = AddToCart().obs;
  RxString error = ''.obs;
  String token = "";

  // UserModel userModel = UserModel();
  // var pref = UserPreference();
  //
  // Future<void> initializeUser() async {
  //   userModel = await pref.getUser();
  //   token = userModel.loginType!;
  //   print("RRRRRRRRRRRRR${token}");
  // }
  // GroceryShowAllCartController groceryShowAllCartController = Get.put(GroceryShowAllCartController());

  final specific_Product_Controller specificProductController =
      Get.put(specific_Product_Controller());
  final RestaurantCartController restaurantCartController =
      Get.put(RestaurantCartController());

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setRxRequestStatus2(Status value) => rxRequestStatus2.value = value;

  void setRxRequestStatusPopUP(Status value) => rxRequestStatusPopUp.value = value;

  void setData(AddToCart value) => addToCartData.value = value;

  void setUpdateCartData(AddToCart value) => updateCartData.value = value;

  void setError(String value) => error.value = value;

  final Map<String, bool> _cartLoadingMap = {};
  final Map<String, bool> _cartLoadingMap2 = {};

  bool isCartLoading(String productId) {
    return _cartLoadingMap[productId] ?? false;
  }

  bool isCartLoader(String productId) {
    return _cartLoadingMap2[productId] ?? false;
  }

  void setCartLoading(String productId, bool loading) {
    _cartLoadingMap[productId] = loading;
    update();
  }

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
    String? cartId,
     required bool isPopUp,
    RestaurantCategoryDetailsModal? product
  }) async {
    setCartLoading(productId, true);
    if(isPopUp == false) {
      setRxRequestStatus(Status.LOADING);
    }else {
      setRxRequestStatusPopUP(Status.LOADING);
    }
    // initializeUser();
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
      setCartLoading(productId, false);
      setData(value);
      if (addToCartData.value.status == true) {
        // if (addToCartData.value.message =="Making cart from another restaurant") {
        //   setRxRequestStatus(Status.COMPLETED);
        //   showSwitchRestaurantDialog(
        //     productId: productId,
        //     productQuantity: productQuantity,
        //     productPrice: productPrice,
        //     restaurantId: restaurantId,
        //     addons: addons,
        //     extrasIds: extrasIds,
        //     extrasItemIds: extrasItemIds,
        //     extrasItemNames: extrasItemNames,
        //     extrasItemPrices: extrasItemPrices,
        //   );
        // }
        //   restaurantCartController.getRestaurantCartApi(cartId: );
        if(isPopUp == false) {
          setRxRequestStatus(Status.COMPLETED);
        }else {
          setRxRequestStatusPopUP(Status.COMPLETED);
        }
          specificProductController.goToCart.value = true;
          Utils.showToast(addToCartData.value.message.toString());
          restaurantCartController.getAllCartData();
          restaurantCartController.refreshGetAllCheckoutDataRes();

          if(cartId?.isNotEmpty ?? true){
            restaurantCartController.refreshRestaurantSingleCartApi(cartId:cartId.toString());
          }
          // groceryShowAllCartController.getGroceryAllShowApi();
      } else {
        setCartLoading(productId, false);
        Utils.showToast(addToCartData.value.message.toString());
        if(isPopUp == false) {
          setRxRequestStatus(Status.COMPLETED);
        }else{
          setRxRequestStatusPopUP(Status.COMPLETED);
        }
      }
    }).onError((error, stackError) {
      setCartLoading(productId, false);
      print("Error: $error");
      setError(error.toString());
      print(stackError);
      if(isPopUp == false) {
        setRxRequestStatus(Status.ERROR);
      }else {
        setRxRequestStatusPopUP(Status.ERROR);
      }
    });
  }



  void clearSelected(){
    specificProductController.selectedAddOn.clear();
    final addOns = specificProductController.productData.value.product?.addOns;
    if (addOns != null) {
      for (var addOn in addOns) {
        addOn.isSelected.value = false;
      }
    }

    /*final extras = specificProductController.productData.value.product?.extra;
    if (extras != null) {
      for (var extra in extras) {
        extra.selectedIndex.value = -1;
      }
    }*/
    specificProductController.extrasItemIdsId.clear();
    specificProductController.extrasItemIdsName.clear();
    specificProductController.extrasItemIdsPrice.clear();
    specificProductController.extrasTitlesIdsId.clear();
  }


  //---------------

  updateCartApi({
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
    setRxRequestStatus2(Status.LOADING);
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
    api.updateCartApi(body).then((value) {
      setUpdateCartData(value);
      if (updateCartData.value.status == true) {
        // restaurantCartController.getRestaurantCartApi();
        specificProductController.goToCart.value = true;
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

  // Future showSwitchRestaurantDialog({
  //   required String productId,
  //   required String productQuantity,
  //   required String productPrice,
  //   required String restaurantId,
  //   required List<dynamic> addons,
  //   required List<dynamic> extrasIds,
  //   required List<dynamic> extrasItemIds,
  //   required List<dynamic> extrasItemNames,
  //   required List<dynamic> extrasItemPrices,
  // }) {
  //   return Get.dialog(
  //     AlertDialog.adaptive(
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Text(
  //             'Switching Restaurants',
  //             style: TextStyle(
  //               fontSize: 18.sp,
  //               fontWeight: FontWeight.w600,
  //               color: Colors.black,
  //             ),
  //           ),
  //           SizedBox(height: 15.h),
  //           Text(
  //             'You are adding products from another restaurant. Do you want to continue?',
  //             style: TextStyle(
  //               fontSize: 14.sp,
  //               fontWeight: FontWeight.w400,
  //               color: Colors.grey,
  //             ),
  //           ),
  //           SizedBox(height: 15.h),
  //           Row(
  //             children: [
  //               Expanded(
  //                 child: CustomElevatedButton(
  //                   height: 40.h,
  //                   color: AppColors.black,
  //                   onPressed: () {
  //                     Get.back();
  //                   },
  //                   text: "Cancel",
  //                   textStyle: AppFontStyle.text_14_400(AppColors.darkText),
  //                 ),
  //               ),
  //               wBox(15),
  //               Obx(
  //                 () => Expanded(
  //                   child: CustomElevatedButton(
  //                     height: 40.h,
  //                     isLoading: rxRequestStatus2.value == (Status.LOADING),
  //                     onPressed: () {
  //                       updateCartApi(
  //                         productId: productId,
  //                         productQuantity: productQuantity,
  //                         productPrice: productPrice,
  //                         restaurantId: restaurantId,
  //                         addons: addons,
  //                         extrasIds: extrasIds,
  //                         extrasItemPrices: extrasItemPrices,
  //                         extrasItemNames: extrasItemNames,
  //                         extrasItemIds: extrasIds,
  //                       );
  //                     },
  //                     text: "Yes",
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //     barrierDismissible: false,
  //   );
  // }
}
